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

--	-- register the comm handlers
--  Comm.onReceiveOOBMessage = processSpecialMessage;
--	-- register slash handlers
--	registerSlashHandler("whisper", processWhisper);
--	registerSlashHandler("die", processDie);
--
--	-- register autocomplete handlers
--	registerAutocompleteHandler(autocompleteIdentityName);
--
--	-- register dice handlers
--	registerDiceHandler(SPECIAL_MSGTYPE_DICE, processDiceLanded);
--	registerDiceHandler(SPECIAL_MSGTYPE_ACTION, processDiceLanded);
--	registerDiceHandler(SPECIAL_MSGTYPE_CHARACTERISTIC, processDiceLanded);
--	registerDiceHandler(SPECIAL_MSGTYPE_SKILL, processDiceLanded);
--	registerDiceHandler(SPECIAL_MSGTYPE_SPECIALISATION, processDiceLanded);

  ChatManagerGenesys.registerSpecialMessageHandler(SPECIAL_MSGTYPE_UPDATEACTORINIT, handleUpdateActorInit);
	OOBManager.registerOOBMsgHandler(SPECIAL_MSGTYPE_UPDATEACTORINIT, ProcessNothing);

  ActionsManager.registerResultHandler("dicegen", onDice);
  ActionsManager.registerResultHandler("skill", onDice);
  ActionsManager.registerResultHandler("characteristic", onDice);
  ActionsManager.registerResultHandler("critical", processDiceCriticalPersonal);
  ActionsManager.registerResultHandler("critical_vehicle", processDiceCriticalVehicle);

	Comm.registerSlashHandler("diegen", processDiegen);

  -- ActionsManager.registerModHandler("dice", modDice);
end

function throwDice(dragtype, dice, modifier, description, customdata)
	Comm.throwDice(dragtype, dice, modifier, description, customdata);
end

function ProcessNothing()
	local nada = "";
end


function onDice(rSource, rTarget, rRoll)
  local rNada = processDice(rRoll, rSource, rTarget);
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
-- DICE
--
--

local revealalldice = true;

-- Added to allow the dieboxgen.lua script to determine if the /die reveal or /die hide slash commands are active
function gmDieHide()
	return not revealalldice;
end

-- Added to allow the setting dice reveal state
function gmRevealDieRolls(reveal)
	revealalldice = reveal;
end

function processDie(command, params)
	if User.isHost() then
		if params == "reveal" then
			revealalldice = true;

			local msg = {};
			msg.font = "systemfont";
			msg.text = "Revealing all die rolls";
			Comm.addChatMessage(msg);

			return;
		end
		if params == "hide" then
			revealalldice = false;

			local msg = {};
			msg.font = "systemfont";
			msg.text = "Hiding all die rolls";
			Comm.addChatMessage(msg);

			return;
		end
	end

	local diestring, descriptionstring = string.match(params, "%s*(%S+)%s*(.*)");

	if not diestring then
		local msg = {};
		msg.font = "systemfont";
		msg.text = "Usage: /die [dice] [description]";
		Comm.addChatMessage(msg);
		return;
	end

	local dice = {};
	local modifier = 0;

	for s, m, d in string.gmatch(diestring, "([%+%-]?)(%d*)(%w*)") do
		if m == "" and d == "" then
			break;
		end

		if d ~= "" then
			for i = 1, tonumber(m) or 1 do
				table.insert(dice, d);
				if d == "d100" then
					table.insert(dice, "d10");
				end
			end
		else
			if s == "-" then
				modifier = modifier - m;
			else
				modifier = modifier + m;
			end
		end
	end

	if #dice == 0 then
		local msg = {};

		msg.font = "systemfont";
		msg.text = descriptionstring;
		msg.dice = {};
		msg.diemodifier = modifier;
		msg.dicesecret = false;

		if User.isHost() then
			msg.sender = GmIdentityManager.getCurrent();
		else
			msg.sender = User.getIdentityLabel();
		end

		Comm.deliverChatMessage(msg);
	else
		throwDice("dice", dice, modifier, descriptionstring);
	end
end

function processDiceLanded(draginfo)
	ModifierStack.applyModifierStackToRoll(draginfo);
	return processDice(draginfo);
end

function processDice(rSource, rTarget, rRoll)
  local ThrowDiceInfo = StringManager.split(rSource.sDesc, "<>", true);
	-- get the message details
	local type = rSource.sType;
	local description = ThrowDiceInfo[1];
  if description == nil then
    description = "";
  end
	local modifier = rSource.nMod;
	--local sourcenode = '';   --TODO_john: find rTarget.node? rSource.getDatabaseNode();
	local gmonly = false;
  if ThrowDiceInfo[4] == "hide" then
    gmonly = true;
  end


	-- Used to track success and advantages for initiative in the form of <successes>.<advantages>
	local initiativecount = 0;

	-- get the identity
	local identity = ThrowDiceInfo[3];
  local characternode = ThrowDiceInfo[2];
  local sActorType, nodeActor = ActorManager.getTypeAndNode(characternode);
--	if not identity then
--		identity = User.getUsername();
--	end
--	if User.isHost() then
--		local gmid, isgm = GmIdentityManager.getCurrent();
--		identity = gmid;
--	end



	-- get the custom data
--	local customdata = rSource.getCustomData();
--	if customdata then
--		if customdata[1] then
--			local sourcenodename = customdata[1];
--			sourcenode = DB.findNode(sourcenodename);
--		end
--		if customdata[2] then
--			identity = customdata[2];
--		end
--		if customdata[3] then
--			gmonly = customdata[3];
--		end
--	end

	-- build the result dice table
	local dice = rSource;
	local resultdice = {};
	for cnt=1, #rSource.aDice do
    local newDie = {};
    newDie.type = rSource.aDice[cnt].type .. "x" .. rSource.aDice[cnt].result;
    newDie.result = rSource.aDice[cnt].result;
    table.insert(resultdice, newDie);
	--processResultDie(resultdice, die);
  end


--  -- Replace Automatic Success/Failure/Advantage/Disadvantages added to the diebox, so we can calculate later.
--  for cnt=1, #rSource.aDice do
--    if rSource.aDice[cnt].type == "mSuccess" then
--      rSource.aDice[cnt].type = "dAbility";
--      rSource.aDice[cnt].result = 2;
--    end
--  end


	-- determine if a dice summary should be displayed
	--local showsummary = OptionsManager.getOption("interface_showdiceresultsummary");
	-- Removed preference as ruleset automation relies on getting roll summary data (init rolls, damage calc, etc.).
	local showsummary = true;
	-- space the message
  local spacerMsg = {};
	spacerMsg.font = "narratorfont";
	spacerMsg.text = "";
	spacerMsg.dicesecret = gmonly;
	if User.isHost() and (gmonly or not revealalldice) then
		Comm.addChatMessage(spacerMsg);
	else
    -- TODO_john: find out how CoreRPG is hidding rolls
		Comm.deliverChatMessage(spacerMsg);
	end

	-- build the header message
	if identity ~= "" then
		-- build the header message
		local headerMsg = {};

    -- Add portrait
    if sActorType == "pc" then
      headerMsg.icon = "portrait_" .. nodeActor.getName() .. "_chat";
    else
      local sIdentity = User.getCurrentIdentity();
      if sIdentity then
        headerMsg.icon = "portrait_" .. User.getCurrentIdentity() .. "_chat";
      else
        if User.isHost() then
          headerMsg.icon = "portrait_gm_token";
        end
      end
    end



		headerMsg.font = "narratorfont";
		headerMsg.sender = identity;
    headerMsg.text = description;
		headerMsg.dicesecret = gmonly;
		if User.isHost() and (gmonly or not revealalldice) then
			Comm.addChatMessage(headerMsg);
		else
			Comm.deliverChatMessage(headerMsg);
		end

	end

	-- build our dice result message
	local resultMsg = {};
  resultMsg.dicedisplay = 0;
	if showsummary then
		resultMsg.text = "Result:";
	end


	-- Crit rolls are just d100 rolls, no need to show the special dice summary.  Plus show total of the roll.
	if string.find(description, "CRITICAL") or string.find(description, "CRITVEHICLE") then
		showsummary = false;
		resultMsg.dicedisplay = 1;
	end
	-- resultMsg.font = "chatitalicfont";
	resultMsg.dice = resultdice;
	resultMsg.diemodifier = modifier;
	resultMsg.dicesecret = gmonly;
	if User.isHost() and (gmonly or not revealalldice) then
		Comm.addChatMessage(resultMsg);
	else
		Comm.deliverChatMessage(resultMsg);
	end



	-- determine if we need to show the summary details
	if showsummary then

		-- build our summary results
		local resultSummary = {};
		resultSummary.success = 0;
		resultSummary.boon = 0;
		resultSummary.chaos = 0;
		resultSummary.delay = 0;
		resultSummary.exertion = 0;
		resultSummary.comet = 0;
		for k,v in ipairs(resultdice) do
			processSummaryDie(resultSummary, v);
		end

		-- build the success dice table
		local successDice = {};
		if resultSummary.success ~= 0 then
			for n = 1, math.abs(resultSummary.success) do
				local successDie = {};
				if resultSummary.success > 0 then
					successDie.type = "dSummaryx7";
				else
					successDie.type = "dSummaryx2";
				end
				successDie.result = 0;
				table.insert(successDice, successDie);
			end
		end

		-- build the success message
		local successMsg = {};
    successMsg.dicedisplay = 0;
		if resultSummary.success > 0 then
			successMsg.text = "Success:";
		else
			successMsg.text = "Failure:";
		end
		if resultSummary.success ~= 0 then
			successMsg.dice = successDice;
		end
		-- successMsg.font = "chatitalicfont";
		successMsg.dicesecret = gmonly;
		if User.isHost() and (gmonly or not revealalldice) then
			Comm.addChatMessage(successMsg);
		else
			Comm.deliverChatMessage(successMsg);
		end

		-- process our boons
		if resultSummary.boon ~= 0 then

			-- build the boon dice table
			local boonDice = {};
			for n = 1, math.abs(resultSummary.boon) do
				local boonDie = {};
				if resultSummary.boon > 0 then
					boonDie.type = "dSummaryx6";
				else
					boonDie.type = "dSummaryx3";
				end
				boonDie.result = 0;
				table.insert(boonDice, boonDie);
			end

			-- build the boon message
			local boonMsg = {};
      boonMsg.dicedisplay = 0;
			if resultSummary.boon > 0 then
				boonMsg.text = "Advantage:";
				-- TODO - Launch advantage info/spend window
				Debug.console("TODO - Launch advantage info/spend window. Advantages = "  .. resultSummary.boon);
			else
				boonMsg.text = "Threat:";
				-- TODO - Launch threat info/spend window.  How to do this for the PCs when the GM rolls threat for an NPC?
				Debug.console("TODO - Launch threat info/spend window. Threat = "  .. resultSummary.boon);
			end
			-- boonMsg.font = "chatitalicfont";
			boonMsg.dice = boonDice;
			boonMsg.dicesecret = gmonly;
			if User.isHost() and (gmonly or not revealalldice) then
				Comm.addChatMessage(boonMsg);
			else
				Comm.deliverChatMessage(boonMsg);
			end

		end

		-- process our specials
		if resultSummary.comet ~= 0 or resultSummary.exertion ~= 0 or resultSummary.delay ~= 0 or resultSummary.chaos ~= 0 then

			-- build the special dice table
			local specialDice = {};
			for n = 1, math.abs(resultSummary.comet) do
				-- Star Wars Triumph
				local specialDie = {};
				specialDie.type = "dSummaryx8";
				specialDie.result = 0;
				table.insert(specialDice, specialDie);
				-- TODO - Launch Triumph info/spend window.
				Debug.console("TODO - Launch Triumph info/spend window.");
			end
			for n = 1, math.abs(resultSummary.exertion) do
				local specialDie = {};
				specialDie.type = "dSummaryx4";
				specialDie.result = 0;
				table.insert(specialDice, specialDie);
			end
			for n = 1, math.abs(resultSummary.delay) do
				local specialDie = {};
				specialDie.type = "dSummaryx5";
				specialDie.result = 0;
				table.insert(specialDice, specialDie);
			end
			for n = 1, math.abs(resultSummary.chaos) do
				-- Star Wars Despair
				local specialDie = {};
				specialDie.type = "dSummaryx1";
				specialDie.result = 0;
				table.insert(specialDice, specialDie);
				-- TODO - Launch Despair info/spend window.  How to do this for the PCs when the GM rolls threat for an NPC?
				Debug.console("TODO - Launch despair info/spend window.");
			end

			-- build the special message
			local specialMsg = {};
      specialMsg.dicedisplay = 0;
			specialMsg.text = "Special:";
--			specialMsg.font = "chatitalicfont";
			specialMsg.dice = specialDice;
			specialMsg.dicesecret = gmonly;
      specialMsg.dicedisplay = 0;
			if User.isHost() and (gmonly or not revealalldice) then
				Comm.addChatMessage(specialMsg);
			else
				Comm.deliverChatMessage(specialMsg);
			end
		end

		-- Handle initiative roll here - indicated by INIT in roll description
		if string.find(description, "INIT") then
			initiativecount = resultSummary.success + resultSummary.boon / 100;
			--Debug.console("Initiative roll = " .. initiativecount .. ", for characternode = " .. characternode.getNodeName());
			updateActorInit(characternode, initiativecount);
		end

		-- Handle attack roll here - indicated by ATTACK in roll description
		-- Currently only used to generate a damage result.
		if string.find(description, "ATTACK") then
			if resultSummary.success > 0 then
				local damagemsg = {};
				damagemsg.font = "msgfont";
				damagemsg.type = "wounds";
				local sDamage = "";
        local bFlatDamage = true;
				--sDamage = string.match(description, "%[DAMAGE.*%((%w+)%)%]");
				sDamage = string.match(description, "%[DAMAGE:%s*(%w+)%]");
        if sDamage == nil then
          -- +DMG means base damage plus Brawl characteristic
          sDamage = string.match(description, "%[DAMAGE:%s%+*(%w+)%]");
          bFlatDamage = false;
        end

				local totaldamage = tonumber(sDamage) + resultSummary.success
				--Debug.console("Total Damage = " .. totaldamage);
        if bFlatDamage == true then
          damagemsg.text = "[Damage: " .. totaldamage .. "]";
        else
          local iBrawn = DB.getValue(DB.findNode(characternode), "brawn.current", 0);
          totaldamage = totaldamage + iBrawn;
          damagemsg.text = "[Damage: " .. totaldamage .. "]";
        end
				if User.isHost() and (gmonly or not revealalldice) then
					Comm.addChatMessage(damagemsg);
				else
					Comm.deliverChatMessage(damagemsg);
				end
			end
		end
	end

	-- Handle critical roll here - indicated by CRITICAL in roll description
	if string.find(description, "CRITICAL") then
		--resultMsg.dice = resultdice;
		local critModifier = resultMsg.diemodifier;

		local critResult = 0 + critModifier;

		for k,v in ipairs(resultMsg.dice) do
			critResult = critResult + v.result;
		end

		Debug.console("Critical result = " .. critResult)

		--  Determine the critical sustained from result of d100 roll plus modifiers

		local critDetails = {};

		for k,v in pairs(DataCommon.critical_injury_result_data) do
			if critResult >= v.d100_start and critResult <= v.d100_end then
				Debug.console("Found crit of " .. v.name);
				critDetails = v;
				break;
			end
		end

		Debug.console("Crit = " .. critDetails.name .. ". Severity = " .. critDetails.severity .. ". Description = " .. critDetails.description);

		-- print a message
		local msg = {};
		msg.font = "msgfont";
		msg.type = "critical";

		if namenode then
			 PlayerDBManager.createCriticalNonOwnedDB(sourcenode, critDetails.name, critDetails.description, critDetails.severity);
			if critDetails.severity == 999 then
				msg.text = NPCManagerGenesys.getNpcName(sourcenode) .. " has gained the critical:  " .. critDetails.name .. NPCManagerGenesys.extraIdentityText();
			else
				msg.text = NPCManagerGenesys.getNpcName(sourcenode) .. " has gained the critical:  " .. critDetails.name .. ".  \nSeverity = " .. critDetails.severity .. ", " .. NPCManagerGenesys.extraIdentityText();
			end
		else
			if critDetails.severity == 999 then
				msg.text = "Critical:  " .. critDetails.name;
			else
				msg.text = "Critical:  " .. critDetails.name .. ".  Severity = " .. critDetails.severity;
			end
		end
		ChatManager.Comm.deliverChatMessage(msg);
	end

	-- Handle vehicle critical roll here - indicated by CRITVEHICLE in roll description
	if string.find(description, "CRITVEHICLE") then
		Debug.console("Critical vehicle result handler.")
		Debug.console("Target node for critical = ", sourcenode);

		--resultMsg.dice = resultdice;
		local critModifier = resultMsg.diemodifier;

		local critResult = 0 + critModifier;

		for k,v in ipairs(resultMsg.dice) do
			critResult = critResult + v.result;
		end

		Debug.console("Critical result = " .. critResult)

		--  Determine the critical sustained from result of d100 roll plus modifiers

		local critDetails = {};

		for k,v in pairs(DataCommon.critical_vehicle_result_data) do
			if critResult >= v.d100_start and critResult <= v.d100_end then
				Debug.console("Found crit of " .. v.name);
				critDetails = v;
				break;
			end
		end

		Debug.console("Crit = " .. critDetails.name .. ". Severity = " .. critDetails.severity .. ". Description = " .. critDetails.description);

		-- print a message
		local msg = {};
		msg.font = "msgfont";
		msg.type = "critvehicle";

		if sourcenode.getNodeName() ~= "" then
			PlayerDBManager.createCriticalNonOwnedDB(sourcenode.createChild("vehicle"), critDetails.name, critDetails.description, critDetails.severity);
			if critDetails.severity == 999 then
				msg.text = NPCManagerGenesys.getNpcName(sourcenode) .. " has gained the critical:  " .. critDetails.name .. NPCManagerGenesys.extraIdentityText();
			else
				msg.text = NPCManagerGenesys.getNpcName(sourcenode) .. " has gained the critical:  " .. critDetails.name .. ".  \nSeverity = " .. critDetails.severity .. ", " .. NPCManagerGenesys.extraIdentityText();
			end
		else
			if critDetails.severity == 999 then
				msg.text = "Vehicle critical:  " .. critDetails.name;
			else
				msg.text = "Vehicle critical:  " .. critDetails.name .. ".  Severity = " .. critDetails.severity;
			end
		end
		Comm.deliverChatMessage(msg);



	end

	-- and return true
	return true;
end

function processResultDie(dice, die)

	-- add the dice to the result
	local newDie = {};
	newDie.type = die.type .. "x" .. die.result;
	newDie.result = die.result;
	Debug.console("die: type = " .. newDie.type .. ", result = " .. newDie.result);
	table.insert(dice, newDie);

	-- now explode the righteous success
	if newDie.type == "dExpertise.5" then
		local explodeDie = {};
		explodeDie.type = "dExpertise";
		explodeDie.result = math.random(1,6);
		processResultDie(dice, explodeDie);
	end
end

function processSummaryDie(summary, die)

	if die.type == "dChallengex1" then
	elseif die.type == "dChallengex2" then
		summary.success = summary.success - 1;
	elseif die.type == "dChallengex3" then
		summary.success = summary.success - 1;
	elseif die.type == "dChallengex4" then
		summary.success = summary.success - 2;
	elseif die.type == "dChallengex5" then
		summary.success = summary.success - 2;
	elseif die.type == "dChallengex6" then
		summary.boon = summary.boon - 1;
	elseif die.type == "dChallengex7" then
		summary.boon = summary.boon - 1;
	elseif die.type == "dChallengex8" then
		summary.boon = summary.boon - 1;
		summary.success = summary.success - 1;
	elseif die.type == "dChallengex9" then
		summary.boon = summary.boon - 1;
		summary.success = summary.success - 1;
	elseif die.type == "dChallengex10" then
		summary.boon = summary.boon - 2;
	elseif die.type == "dChallengex11" then
		summary.boon = summary.boon - 2;
	elseif die.type == "dChallengex12" then
		summary.success = summary.success - 1;
		summary.chaos = summary.chaos + 1;

	elseif die.type == "dBoostx3" then
		summary.boon = summary.boon + 2;
	elseif die.type == "dBoostx4" then
		summary.boon = summary.boon + 1;
	elseif die.type == "dBoostx5" then
		summary.success = summary.success + 1;
		summary.boon = summary.boon + 1;
	elseif die.type == "dBoostx6" then
		summary.success = summary.success + 1;

	elseif die.type == "dSetbackx3" then
		summary.success = summary.success - 1;
	elseif die.type == "dSetbackx4" then
		summary.success = summary.success - 1;
	elseif die.type == "dSetbackx5" then
		summary.boon = summary.boon - 1;
	elseif die.type == "dSetbackx6" then
		summary.boon = summary.boon - 1;


	elseif die.type == "dAbilityx2" then
		summary.success = summary.success + 1;
	elseif die.type == "dAbilityx3" then
		summary.success = summary.success + 1;
	elseif die.type == "dAbilityx4" then
		summary.success = summary.success + 2;
	elseif die.type == "dAbilityx5" then
		summary.boon = summary.boon + 1;
	elseif die.type == "dAbilityx6" then
		summary.boon = summary.boon + 1;
	elseif die.type == "dAbilityx7" then
		summary.success = summary.success + 1;
		summary.boon = summary.boon + 1;
	elseif die.type == "dAbilityx8" then
		summary.boon = summary.boon + 2;

	elseif die.type == "dDifficultyx2" then
		summary.success = summary.success - 1;
	elseif die.type == "dDifficultyx3" then
		summary.success = summary.success - 2;
	elseif die.type == "dDifficultyx4" then
		summary.boon = summary.boon - 1;
	elseif die.type == "dDifficultyx5" then
		summary.boon = summary.boon - 1;
	elseif die.type == "dDifficultyx6" then
		summary.boon = summary.boon - 1;
	elseif die.type == "dDifficultyx7" then
		summary.boon = summary.boon - 2;
	elseif die.type == "dDifficultyx8" then
		summary.success = summary.success - 1;
		summary.boon = summary.boon -1;

	elseif die.type == "dProficiencyx2" then
		summary.success = summary.success + 1;
	elseif die.type == "dProficiencyx3" then
		summary.success = summary.success + 1;
	elseif die.type == "dProficiencyx4" then
		summary.success = summary.success + 2;
	elseif die.type == "dProficiencyx5" then
		summary.success = summary.success + 2;
	elseif die.type == "dProficiencyx6" then
		summary.boon = summary.boon + 1;
	elseif die.type == "dProficiencyx7" then
		summary.success = summary.success + 1;
		summary.boon = summary.boon + 1;
	elseif die.type == "dProficiencyx8" then
		summary.success = summary.success + 1;
		summary.boon = summary.boon + 1;
	elseif die.type == "dProficiencyx9" then
		summary.success = summary.success + 1;
		summary.boon = summary.boon + 1;
	elseif die.type == "dProficiencyx10" then
		summary.boon = summary.boon + 2;
	elseif die.type == "dProficiencyx11" then
		summary.boon = summary.boon + 2;
	elseif die.type == "dProficiencyx12" then
		summary.success = summary.success + 1;
		summary.comet = summary.comet + 1;

	elseif die.type == "dForcex1" then
		summary.exertion = summary.exertion + 1;
	elseif die.type == "dForcex2" then
		summary.exertion = summary.exertion + 1;
	elseif die.type == "dForcex3" then
		summary.exertion = summary.exertion + 1;
	elseif die.type == "dForcex4" then
		summary.exertion = summary.exertion + 1;
	elseif die.type == "dForcex5" then
		summary.exertion = summary.exertion + 1;
	elseif die.type == "dForcex6" then
		summary.exertion = summary.exertion + 1;
	elseif die.type == "dForcex7" then
		summary.exertion = summary.exertion + 2;
	elseif die.type == "dForcex8" then
		summary.delay = summary.delay + 1;
	elseif die.type == "dForcex9" then
		summary.delay = summary.delay + 1;
	elseif die.type == "dForcex10" then
		summary.delay = summary.delay + 2;
	elseif die.type == "dForcex11" then
		summary.delay = summary.delay + 2;
	elseif die.type == "dForcex12" then
		summary.delay = summary.delay + 2;


	elseif die.type == "dConservativex2" then
		summary.boon = summary.boon + 1;
	elseif die.type == "dConservativex3" then
		summary.boon = summary.boon + 1;
	elseif die.type == "dConservativex4" then
		summary.success = summary.success + 1;
		summary.delay = summary.delay + 1;
	elseif die.type == "dConservativex5" then
		summary.success = summary.success + 1;
		summary.delay = summary.delay + 1;
	elseif die.type == "dConservativex6" then
		summary.success = summary.success + 1;
	elseif die.type == "dConservativex7" then
		summary.success = summary.success + 1;
	elseif die.type == "dConservativex8" then
		summary.success = summary.success + 1;
	elseif die.type == "dConservativex9" then
		summary.success = summary.success + 1;
	elseif die.type == "dConservativex10" then
		summary.success = summary.success + 1;
		summary.boon = summary.boon + 1;

	elseif die.type == "dExpertisex2" then
		summary.boon = summary.boon + 1;
	elseif die.type == "dExpertisex3" then
		summary.boon = summary.boon + 1;
	elseif die.type == "dExpertisex4" then
		summary.success = summary.success + 1;
	elseif die.type == "dExpertisex5" then
		summary.success = summary.success + 1;
	elseif die.type == "dExpertisex6" then
		summary.comet = summary.comet + 1;

	elseif die.type == "dFortunex4" then
		summary.boon = summary.boon + 1;
	elseif die.type == "dFortunex5" then
		summary.success = summary.success + 1;
	elseif die.type == "dFortunex6" then
		summary.success = summary.success + 1;

	elseif die.type == "dMisfortunex1" then
		summary.success = summary.success - 1;
	elseif die.type == "dMisfortunex2" then
		summary.success = summary.success - 1;
	elseif die.type == "dMisfortunex3" then
		summary.boon = summary.boon - 1;

	elseif die.type == "dRecklessx1" then
		summary.boon = summary.boon - 1;
	elseif die.type == "dRecklessx2" then
		summary.boon = summary.boon - 1;
	elseif die.type == "dRecklessx5" then
		summary.boon = summary.boon + 2;
	elseif die.type == "dRecklessx6" then
		summary.success = summary.success + 1;
		summary.exertion = summary.exertion + 1;
	elseif die.type == "dRecklessx7" then
		summary.success = summary.success + 1;
		summary.exertion = summary.exertion + 1;
	elseif die.type == "dRecklessx8" then
		summary.success = summary.success + 1;
		summary.boon = summary.boon + 1;
	elseif die.type == "dRecklessx9" then
		summary.success = summary.success + 2;
	elseif die.type == "dRecklessx10" then
		summary.success = summary.success + 2;

	elseif die.type == "dSummaryx1" then
		summary.chaos = summary.chaos + 1;
	elseif die.type == "dSummaryx2" then
		summary.success = summary.success - 1;
	elseif die.type == "dSummaryx3" then
		summary.boon = summary.boon - 1;
	elseif die.type == "dSummaryx4" then
		summary.exertion = summary.exertion + 1;
	elseif die.type == "dSummaryx5" then
		summary.delay = summary.delay + 1;
	elseif die.type == "dSummaryx6" then
		summary.boon = summary.boon + 1;
	elseif die.type == "dSummaryx7" then
		summary.success = summary.success + 1;
	elseif die.type == "dSummaryx8" then
		summary.comet = summary.comet + 1;

	elseif die.type == "mBanex1" then
		summary.boon = summary.boon - 1;
	elseif die.type == "mBanex2" then
		summary.boon = summary.boon - 1;
	elseif die.type == "mBanex3" then
		summary.boon = summary.boon - 1;
	elseif die.type == "mBanex4" then
		summary.boon = summary.boon - 1;
	elseif die.type == "mBanex5" then
		summary.boon = summary.boon - 1;
	elseif die.type == "mBanex6" then
		summary.boon = summary.boon - 1;

	elseif die.type == "mBoonx1" then
		summary.boon = summary.boon + 1;
	elseif die.type == "mBoonx2" then
		summary.boon = summary.boon + 1;
	elseif die.type == "mBoonx3" then
		summary.boon = summary.boon + 1;
	elseif die.type == "mBoonx4" then
		summary.boon = summary.boon + 1;
	elseif die.type == "mBoonx5" then
		summary.boon = summary.boon + 1;
	elseif die.type == "mBoonx6" then
		summary.boon = summary.boon + 1;

	elseif die.type == "mChallengex1" then
		summary.success = summary.success - 1;
	elseif die.type == "mChallengex2" then
		summary.success = summary.success - 1;
	elseif die.type == "mChallengex3" then
		summary.success = summary.success - 1;
	elseif die.type == "mChallengex4" then
		summary.success = summary.success - 1;
	elseif die.type == "mChallengex5" then
		summary.success = summary.success - 1;
	elseif die.type == "mChallengex6" then
		summary.success = summary.success - 1;
	elseif die.type == "mChallengex7" then
		summary.success = summary.success - 1;
	elseif die.type == "mChallengex8" then
		summary.success = summary.success - 1;

	elseif die.type == "mCometx1" then
		summary.comet = summary.comet + 1;
	elseif die.type == "mCometx2" then
		summary.comet = summary.comet + 1;
	elseif die.type == "mCometx3" then
		summary.comet = summary.comet + 1;
	elseif die.type == "mCometx4" then
		summary.comet = summary.comet + 1;
	elseif die.type == "mCometx5" then
		summary.comet = summary.comet + 1;
	elseif die.type == "mCometx6" then
		summary.comet = summary.comet + 1;

	elseif die.type == "mDelayx1" then
		summary.delay = summary.delay + 1;
	elseif die.type == "mDelayx2" then
		summary.delay = summary.delay + 1;
	elseif die.type == "mDelayx3" then
		summary.delay = summary.delay + 1;
	elseif die.type == "mDelayx4" then
		summary.delay = summary.delay + 1;
	elseif die.type == "mDelayx5" then
		summary.delay = summary.delay + 1;
	elseif die.type == "mDelayx6" then
		summary.delay = summary.delay + 1;
	elseif die.type == "mDelayx7" then
		summary.delay = summary.delay + 1;
	elseif die.type == "mDelayx8" then
		summary.delay = summary.delay + 1;
	elseif die.type == "mDelayx9" then
		summary.delay = summary.delay + 1;
	elseif die.type == "mDelayx10" then
		summary.delay = summary.delay + 1;

	elseif die.type == "mExertionx1" then
		summary.exertion = summary.exertion + 1;
	elseif die.type == "mExertionx2" then
		summary.exertion = summary.exertion + 1;
	elseif die.type == "mExertionx3" then
		summary.exertion = summary.exertion + 1;
	elseif die.type == "mExertionx4" then
		summary.exertion = summary.exertion + 1;
	elseif die.type == "mExertionx5" then
		summary.exertion = summary.exertion + 1;
	elseif die.type == "mExertionx6" then
		summary.exertion = summary.exertion + 1;
	elseif die.type == "mExertionx7" then
		summary.exertion = summary.exertion + 1;
	elseif die.type == "mExertionx8" then
		summary.exertion = summary.exertion + 1;
	elseif die.type == "mExertionx9" then
		summary.exertion = summary.exertion + 1;
	elseif die.type == "mExertionx10" then
		summary.exertion = summary.exertion + 1;

	elseif die.type == "mSuccessx1" then
		summary.success = summary.success + 1;
	elseif die.type == "mSuccessx2" then
		summary.success = summary.success + 1;
	elseif die.type == "mSuccessx3" then
		summary.success = summary.success + 1;
	elseif die.type == "mSuccessx4" then
		summary.success = summary.success + 1;
	elseif die.type == "mSuccessx5" then
		summary.success = summary.success + 1;
	elseif die.type == "mSuccessx6" then
		summary.success = summary.success + 1;
	elseif die.type == "mSuccessx7" then
		summary.success = summary.success + 1;
	elseif die.type == "mSuccessx8" then
		summary.success = summary.success + 1;

	end
end

-- Used to pass rolled initiative to the InitiativeManager script using the Special Message functionality so the GM can act on the player's roll
function updateActorInit(characternode, initiativecount)
	local msgparams = {};


  local aType = "npc";
  if StringManager.startsWith(characternode,"charsheet") then
    aType = "pc";
  end

  msgparams[1] = aType;
  msgparams[2] = characternode;
	msgparams[3] = initiativecount;


--  local rSource = ActorManager.getActor(aType, characternode);
--  DB.setValue(ActorManager.getCTNode(rSource), "initresult", "number", initiativecount);

  --InitiativeManager.updateActorInitiative(characternode, initiativecount);
	ChatManagerGenesys.sendSpecialMessage(SPECIAL_MSGTYPE_UPDATEACTORINIT, msgparams);
end

function handleUpdateActorInit(msguser, msgidentity, msgparams)
  local aType = msgparams[1];
  local characternode = msgparams[2];
	local initiativecount = msgparams[3];

  local rSource = ActorManager.getActor(aType, characternode);
  DB.setValue(ActorManager.getCTNode(rSource), "initresult", "number", initiativecount);
--	local characternode = DB.findNode(msgparams[1]);
--	local initiativecount = msgparams[2];
--	InitiativeManager.updateActorInitiative(characternode, initiativecount);
end



function processDiegen(command, params)
	if User.isHost() then
		if params == "reveal" then
			revealalldice = true;

			local msg = {};
			msg.font = "systemfont";
			msg.text = "Revealing all die rolls";
			Comm.addChatMessage(msg);

			return;
		end
		if params == "hide" then
			revealalldice = false;

			local msg = {};
			msg.font = "systemfont";
			msg.text = "Hiding all die rolls";
			Comm.addChatMessage(msg);

			return;
		end
	end

	local diestring, descriptionstring = string.match(params, "%s*(%S+)%s*(.*)");

	if not diestring then
		local msg = {};
		msg.font = "systemfont";
		msg.text = "Usage: /diegen [dice] [description]";
		msg.text = msg.text .. "\n\nAvailable dice: dAbility, dProficiency, dDifficulty, dChallenge, dBoost, dSetback";
		msg.text = msg.text .. "\n\nYor can abbreviate dice to: da, dp, dd, dc, db, ds, respectively";
		msg.text = msg.text .. "\n\nExamples of die roll:";
		msg.text = msg.text .. "\n\n/diegen 3dAbility+dProficiency+2dDifficulty+1dBoost";
		msg.text = msg.text .. "\n\n/diegen 3da+dp+2dd+1db";
		Comm.addChatMessage(msg);
		return;
	end

	local dice = {};
	local modifier = 0;

	for s, m, d in string.gmatch(diestring, "([%+%-]?)(%d*)(%w*)") do
		if m == "" and d == "" then
			break;
		end

		if d ~= "" then
			for i = 1, tonumber(m) or 1 do
				table.insert(dice, d);
				if d == "da" then table.insert(dice, "dAbility")
				elseif d == "dp" then	table.insert(dice, "dProficiency")
				elseif d == "dd" then	table.insert(dice, "dDifficulty")
				elseif d == "dc" then	table.insert(dice, "dChallenge")
				elseif d == "db" then	table.insert(dice, "dBoost")
				elseif d == "ds" then	table.insert(dice, "dSetback")
				elseif d== "d100" then table.insert(dice,"d10");
				end
			end
		else
			if s == "-" then
				modifier = modifier - m;
			else
				modifier = modifier + m;
			end
		end
	end

	if #dice == 0 then
		local msg = {};

		msg.font = "systemfont";
		msg.text = descriptionstring;
		msg.dice = {};
		msg.diemodifier = modifier;
		msg.dicesecret = false;

		if User.isHost() then
			msg.sender = GmIdentityManager.getCurrent();
		else
			msg.sender = User.getIdentityLabel();
		end

		Comm.deliverChatMessage(msg);
	else
		Comm.throwDice("dicegen", dice, modifier, descriptionstring);
	end
end



---------------------------------------------------------------------------------

function processDiceCriticalPersonal(rSource, rTarget, rRoll)
  processDiceCritical(rSource, rTarget, rRoll, "[CRITICAL]");
end

function processDiceCriticalVehicle(rSource, rTarget, rRoll)
  processDiceCritical(rSource, rTarget, rRoll, "[CRITVEHICLE]");
end

function processDiceCritical(rSource, rTarget, rRoll, description)
	local modifier = rRoll.nMod;
	local characternode = DB.findNode(rRoll.sDesc); -- Character node receiving the critical damage
	local gmonly = false;

--	Debug.console("processDice - rSource = ", rSource);

	-- Used to track success and advantages for initiative in the form of <successes>.<advantages>
	local initiativecount = 0;

	-- get the identity
	local identity = User.getIdentityLabel();
	if not identity then
		identity = User.getUsername();
	end
	if User.isHost() then
		local gmid, isgm = GmIdentityManager.getCurrent();
		identity = gmid;
	end

	-- get the custom data
--	local customdata = rSource.getCustomData();
--	if customdata then
--		if customdata[1] then
--			local sourcenodename = customdata[1];
--			sourcenode = DB.findNode(sourcenodename);
--		end
--		if customdata[2] then
--			identity = customdata[2];
--		end
--		if customdata[3] then
--			gmonly = customdata[3];
--		end
--	end

	-- build the result dice table
	local dice = rRoll.aDice;

	local resultdice = {};
	for cnt=1, #dice do
    local newDie = {};
    -- We roll 2 d10
    -- Fist dice is 10s, so we multiply by 10
    -- Second dice are units, where a roll of 10 is considered 0
    -- If we roll 0,0 -- we consider it 100 (later in the code)
    newDie.type = dice[cnt].type .. "x" .. dice[cnt].result;
    newDie.result = dice[cnt].result;

    if dice[cnt].result == 10 then
      newDie.type = dice[cnt].type .. "x0";
      newDie.result = 0;
    end
    if cnt==1 then
      newDie.result = newDie.result * 10;
    end
    table.insert(resultdice, newDie);
		--processResultDie(resultdice, die);
  end


	-- update the identity if we found the character node

	if characternode.getChild("name")  then
		local namenode = characternode.getChild("name");
		if namenode then
			identity = namenode.getValue();
		end
	end

  -- determine if a dice summary should be displayed
	--local showsummary = OptionsManager.getOption("interface_showdiceresultsummary");
	-- Removed preference as ruleset automation relies on getting roll summary data (init rolls, damage calc, etc.).
	local showsummary = false;
	-- space the message
  local spacerMsg = {};
	spacerMsg.font = "narratorfont";
	spacerMsg.text = "";
	spacerMsg.dicesecret = gmonly;
	if User.isHost() and (gmonly or not revealalldice) then
		Comm.addChatMessage(spacerMsg);
	else
    -- TODO_john: find out how CoreRPG is hidding rolls
		Comm.deliverChatMessage(spacerMsg);
	end

	-- build the header message
	if identity ~= "" then

		-- build the header message
		local headerMsg = {};
		headerMsg.font = "narratorfont";
		headerMsg.sender = identity;
		headerMsg.text = description;
		headerMsg.dicesecret = gmonly;
		if User.isHost() and (gmonly or not revealalldice) then
			Comm.addChatMessage(headerMsg);
		else
			Comm.deliverChatMessage(headerMsg);
		end

	end

	-- build our dice result message
	local resultMsg = {};
	if showsummary then
		resultMsg.text = "Result:";
	end

	-- Crit rolls are just d100 rolls, no need to show the special dice summary.  Plus show total of the roll.
	showsummary = false;
	resultMsg.dicedisplay = 1;


	-- resultMsg.font = "chatitalicfont";
	resultMsg.dice = resultdice;
	resultMsg.diemodifier = modifier;
	resultMsg.dicesecret = gmonly;
	if User.isHost() and (gmonly or not revealalldice) then
		Comm.addChatMessage(resultMsg);
	else
		Comm.deliverChatMessage(resultMsg);
	end


	-- Handle critical roll here - indicated by CRITICAL in roll description
	if description == "[CRITICAL]" then
--	if string.find(description, "[CRITICAL]") then
		--resultMsg.dice = resultdice;
		local critModifier = resultMsg.diemodifier;
		local critResult = 0;
		for k,v in ipairs(resultMsg.dice) do
			critResult = critResult + v.result;
		end
    if critResult == 0 then
      critResult = 100;
    end
    critResult = critResult + critModifier;

		Debug.console("Critical result = " .. critResult)

		--  Determine the critical sustained from result of d100 roll plus modifiers

		local critDetails = {};

		for k,v in pairs(DataCommon.critical_injury_result_data) do
			if critResult >= v.d100_start and critResult <= v.d100_end then
				Debug.console("Found crit of " .. v.name);
				critDetails = v;
				break;
			end
		end

		Debug.console("Crit = " .. critDetails.name .. ". Severity = " .. critDetails.severity .. ". Description = " .. critDetails.description);

		-- print a message
		local msg = {};
		msg.font = "msgfont";
		msg.type = "critical";

		if characternode.getChild("name") then
			 PlayerDBManager.createCriticalNonOwnedDB(characternode, critDetails.name, critDetails.description, critDetails.severity);
			if critDetails.severity == 999 then
				msg.text = NPCManagerGenesys.getNpcName(characternode) .. " has gained the critical:  " .. critDetails.name .. NPCManagerGenesys.extraIdentityText();
			else
				msg.text = NPCManagerGenesys.getNpcName(characternode) .. " has gained the critical:  " .. critDetails.name .. ".  \nSeverity = " .. critDetails.severity .. ", " .. NPCManagerGenesys.extraIdentityText();
			end
		else
			if critDetails.severity == 999 then
				msg.text = "Critical:  " .. critDetails.name;
			else
				msg.text = "Critical:  " .. critDetails.name .. ".  Severity = " .. critDetails.severity;
			end
		end
		Comm.deliverChatMessage(msg);
	end

	-- Handle vehicle critical roll here - indicated by CRITVEHICLE in roll description
	if description == "[CRITVEHICLE]" then
--	if string.find(description, "[CRITVEHICLE]") then
		--resultMsg.dice = resultdice;
		local critModifier = resultMsg.diemodifier;
		local critResult = 0 + critModifier;
		for k,v in ipairs(resultMsg.dice) do
			critResult = critResult + v.result;
		end
    if critResult == 0 then
      critResult = 100;
    end
    critResult = critResult + critModifier;

		Debug.console("Critical result = " .. critResult)

		--  Determine the critical sustained from result of d100 roll plus modifiers

		local critDetails = {};

		for k,v in pairs(DataCommon.critical_vehicle_result_data) do
			if critResult >= v.d100_start and critResult <= v.d100_end then
				Debug.console("Found crit of " .. v.name);
				critDetails = v;
				break;
			end
		end

		Debug.console("Crit = " .. critDetails.name .. ". Severity = " .. critDetails.severity .. ". Description = " .. critDetails.description);

		-- print a message
		local msg = {};
		msg.font = "msgfont";
		msg.type = "critvehicle";

	   local current_vehicle, current_vehicle_node = DBManagerGenesys.ActorVehicle(characternode);


    if current_vehicle ~="" and current_vehicle_node then
      local current_vehicle_owner_node = current_vehicle_node.getParent().getParent();
      local vehicle_name = DB.getValue(current_vehicle_node,"name","");
      local vehicle_owner = DB.getValue(current_vehicle_owner_node,"name","");
      local sVehicleName;
      PlayerDBManager.createCriticalNonOwnedDB(current_vehicle_node, critDetails.name, critDetails.description, critDetails.severity);
      if ActorManager.isPC(current_vehicle_owner_node) then
        sVehicleName = "[Vehicle: " .. vehicle_name .. "] [Owner: " .. vehicle_owner .. "]";
      else
        sVehicleName = "[Vehicle: " .. vehicle_name .. "]";
      end
			if critDetails.severity == 999 then
				msg.text = sVehicleName  .. "\nhas gained the critical: \n" .. critDetails.name .. NPCManagerGenesys.extraIdentityText();
			else
				msg.text = sVehicleName  .. "\nhas gained the critical: \n" .. critDetails.name .. ".\nSeverity = " .. critDetails.severity .. ", " .. NPCManagerGenesys.extraIdentityText();
			end
		else
			if critDetails.severity == 999 then
				msg.text = "Vehicle critical:  " .. critDetails.name;
			else
				msg.text = "Vehicle critical:  " .. critDetails.name .. ".  Severity = " .. critDetails.severity;
			end
		end
		Comm.deliverChatMessage(msg);
	end

	-- and return true
	return true;
end
