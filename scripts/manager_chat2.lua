SPECIAL_MSGTYPE_DICE = "dice";
SPECIAL_MSGTYPE_ACTION = "action";
SPECIAL_MSGTYPE_CHARACTERISTIC = "characteristic";
SPECIAL_MSGTYPE_SKILL = "skill";
SPECIAL_MSGTYPE_SPECIALISATION = "specialisation";

-- Used to pass rolled initiative to the InitiativeManager script using the Special Message functionality so the GM can act on the player's roll
SPECIAL_MSGTYPE_UPDATEACTORINIT = "updateactorinit";

--
--
-- INITIALIZATION
--
--

function onInit()
	-- register the comm handlers
	Comm.onReceiveOOBMessage = processSpecialMessage;

	registerAutocompleteHandler(autocompleteIdentityName);
-- JOHN
-- JOHN	-- register dice handlers
-- JOHN	registerDiceHandler(SPECIAL_MSGTYPE_DICE, processDiceLanded);
-- JOHN	registerDiceHandler(SPECIAL_MSGTYPE_ACTION, processDiceLanded);
-- JOHN	registerDiceHandler(SPECIAL_MSGTYPE_CHARACTERISTIC, processDiceLanded);
-- JOHN	registerDiceHandler(SPECIAL_MSGTYPE_SKILL, processDiceLanded);
-- JOHN	registerDiceHandler(SPECIAL_MSGTYPE_SPECIALISATION, processDiceLanded);
-- ChatManagerGenesys.registerSpecialMessageHandler(SPECIAL_MSGTYPE_UPDATEACTORINIT, handleUpdateActorInit);

end

function registerEntryControl(ctrl)
	entrycontrol = ctrl;
end

function deliverMessage(msg)
	Comm.deliverChatMessage(msg);
end

function addMessage(msg)
	Comm.addChatMessage(msg);
end

--
--
-- SLASH COMMANDS HANDLING
--
--

function registerSlashHandler(command, callback)
	Comm.registerSlashHandler(command, callback);
end

--
--
-- SPECIAL MESSAGE COMMANDS HANDLING
--
--

SPECIAL_MSG_TAG = "[SPECIAL]";
SPECIAL_MSG_SEP = "|||";

specialmessagehandlers = {};

function registerSpecialMessageHandler(msgtype, callback)

	if not specialmessagehandlers[msgtype] then
		specialmessagehandlers[msgtype] = {};
	end
	table.insert(specialmessagehandlers[msgtype], callback);
end

function unregisterSpecialMessageHandler(msgtype, callback)
	Debug.console("ChatManagerGenesys.lua: unregisterSpecialMessageHandler. msgtype = " .. msgtype .. ", function = " .. string.dump(callback));
	if specialmessagehandlers[msgtype] then
		--Debug.console("ChatManagerGenesys.lua: unregisterSpecialMessageHandler.  Before delete - specialmessagehandlers table = " .. table.concat(specialmessagehandlers[msgtype], ", "));
		for k, v in pairs(specialmessagehandlers[msgtype]) do
			if v == callback then
				Debug.console("ChatManagerGenesys.lua: unregisterSpecialMessageHandler.  Handler deleted. ");
				specialmessagehandlers[msgtype][k] = nil;
			end
		end
		--Debug.console("ChatManagerGenesys.lua: unregisterSpecialMessageHandler.  After delete - specialmessagehandlers table = " .. table.concat(specialmessagehandlers[msgtype], ", "));
	end
end

function sendSpecialMessage(msgtype, msgparams)

	Debug.console("ChatManagerGenesys.lua: sendSpecialMessage - msgtype = " .. msgtype);

	-- Build the special message to send
	local msg = {};

	-- type
	msg.type = msgtype;

	-- username
	msg.username = User.getUsername();

	-- identity
	if User.isHost() then
		local gmid, isgm = GmIdentityManager.getCurrent();
		msg.identity = gmid;
	else
		msg.identity = User.getIdentityLabel();
		if not msg.identity then
			msg.identity = "";
		end
	end

	-- message parameters
	msg.params = "";
	if msgparams then
		for k, v in ipairs(msgparams) do
			msg.params = msg.params .. v .. SPECIAL_MSG_SEP;
		end
	end

	-- deliver the message
	if User.isLocal() then
		processSpecialMessage(msg);
	else
		Comm.deliverOOBMessage(msg);
	end
end

function processSpecialMessage(msg)
	-- get the message details
	local msgtype = msg.type;
	local msguser = msg.username;
	local msgidentity = msg.identity;

	-- parse out the special message parameters
	local msgparams = {};
	local msg_clause;
	local clause_match = "(.-)" .. SPECIAL_MSG_SEP;
	if msg.params then
		for msg_clause in string.gmatch(msg.params, clause_match) do
			table.insert(msgparams, msg_clause);
		end
	else
		return true;
	end
	-- Handle the special message
	return handleSpecialMessage(msgtype, msguser, msgidentity, msgparams);
end

function handleSpecialMessage(msgtype, msguser, msgidentity, msgparams)
	if specialmessagehandlers[msgtype] then
		for k, v in pairs(specialmessagehandlers[msgtype]) do
			--Debug.console("ChatManagerGenesys.lua: handleSpecialMessage.  Calling function with msguser = " .. msguser .. ", msgidentity = " .. msgidentity);
			v(msguser, msgidentity, msgparams);
		end
		return true;
	end
	return false;
end

--
--
-- DICE HANDLERS
--
--

dicehandlers = {};

function registerDiceHandler(droptype, callback)
	dicehandlers[droptype] = callback;
end

function unregisterDiceHandler(droptype, callback)
	dicehandlers[droptype] = nil;
end

function getDiceHandler(draginfo)
	for droptype, handler in pairs(dicehandlers) do
		if draginfo.isType(droptype) then
			return handler;
		end
	end

	return nil;
end

--
--
-- AUTOCOMPLETE HANDLERS
--
--

autocompletehandlers = {}

function resetAutocompleteHandlers()
	autocompletehandlers = {};
end

function registerAutocompleteHandler(callback)
	table.insert(autocompletehandlers, callback);
end

function unregisterAutocompleteHandler(callback)
	for k, v in pairs(autocompletehandlers) do
		if v == callback then
			autocompletehandlers[k] = nil;
		end
	end
end

--
--
-- AUTOCOMPLETE
--
--

function doAutocomplete()
	local buffer = entrycontrol.getValue();
	local spacepos = string.find(string.reverse(buffer), " ", 1, true);

	local search = "";
	local remainder = buffer;

	if spacepos then
		search = string.sub(buffer, #buffer - spacepos + 2);
		remainder = string.sub(buffer, 1, #buffer - spacepos + 1);
	else
		search = buffer;
		remainder = "";
	end

	-- Call handlers
	for k, v in pairs(autocompletehandlers) do
		if v then
			local result = v(search);
			if type(result) == "string" then
				local replacement = remainder .. result;
				entrycontrol.setValue(replacement);
				entrycontrol.setCursorPosition(#replacement + 1);
				entrycontrol.setSelectionPosition(#replacement + 1);
				return;
			end
		end
	end

end

function autocompleteIdentityName(search)
	-- Check identities
	for k, v in ipairs(User.getAllActiveIdentities()) do
		local label = User.getIdentityLabel(v);
		if label and string.find(string.lower(label), string.lower(search), 1, true) == 1 then
			return label;
		end
	end
end

--
--
-- WHISPER
--
--

function processWhisper(command, params)
	if User.isHost() then
		local msg = {};
		msg.font = "msgfont";

		local spacepos = string.find(params, " ", 1, true);
		if spacepos then
			local recipient = string.sub(params, 1, spacepos-1);
			local originalrecipient = recipient;
			local message = string.sub(params, spacepos+1);

			-- Find user
			local user = nil;

			for k, v in ipairs(User.getAllActiveIdentities()) do
				local label = User.getIdentityLabel(v);
				if string.lower(label) == string.lower(originalrecipient) then
					-- Direct match
					user = User.getIdentityOwner(v);
					if user then
						recipient = label;
						break;
					end
				elseif not user and string.find(string.lower(label), string.lower(recipient), 1, true) == 1 then
					-- Partial match
					user = User.getIdentityOwner(v);
					if user then
						recipient = label;
					end
				end
			end

			if user then
				Debug.console("User for whisper = " .. user);
				msg.text = message;

				msg.sender = "<heard whisper>";
				Comm.deliverChatMessage(msg, user);

				msg.sender = "-> " .. recipient;
				addMessage(msg);

				return;
			end

			msg.font = "systemfont";
			msg.text = "Whisper recipient not found";
			addMessage(msg);

			return;
		end

		msg.font = "systemfont";
		msg.text = "Usage: /whisper [recipient] [message]";
		addMessage(msg);
	else
		-- Disable any form of player whisper.
		local msg = {};
		msg.font = "systemfont";
		msg.text = "I'm sorry, whispers from players currently doesn't work.  Only GMs can whisper to players at present.  This feature will become available at a future time when this ruleset is layered on top of CoreRPG.";
		addMessage(msg);
		--local msg = {};
		--msg.font = "msgfont";
		--msg.text = params;

		--msg.sender = User.getIdentityLabel();
		--deliverMessage(msg, "");

		--msg.sender = "<sent whisper>";
		--addMessage(msg);
	end
end

--
--
-- MODULE ACTIVATION
--
--

function moduleActivationRequested(module)
	local msg = {};
	msg.text = "Players have requested permission to load '" .. module .. "'";
	msg.font = "systemfont";
	msg.icon = "indicator_moduleloaded";
	addMessage(msg);
end

function moduleUnloadedReference(module)
	local msg = {};
	msg.text = "Could not open sheet with data from unloaded module '" .. module .. "'";
	msg.font = "systemfont";
	addMessage(msg);
end

--
--
-- DICE
--
--

local revealalldice = true;

-- Added to allow the diebox.lua script to determine if the /die reveal or /die hide slash commands are active
function gmDieHide()
	return not revealalldice;
end

-- Added to allow the setting dice reveal state
function gmRevealDieRolls(reveal)
	revealalldice = reveal;
end

function processDiceLanded(draginfo)
	ModifierStack.applyModifierStackToRoll(draginfo);
	return processDice(draginfo);
end
