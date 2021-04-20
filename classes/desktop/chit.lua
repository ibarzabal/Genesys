-- MOD: Trenloe November 2013.  Added onLogin handler.

local dragging = false;

local removingchit = "false";  --Flag used to stop removeStoryPointPCchit from occurring twice.

local StoryPointPCchitwindow = nil;
local StoryPointGMchitwindow = nil;

SPECIAL_MSGTYPE_REFRESHDESTINYCHITS = "refreshdestinychits";
SPECIAL_MSGTYPE_REMOVEStoryPointPCCHIT = "removeStoryPointPCchit";

function onInit()
	setHoverCursor("hand");

	if chit then
		setIcon(chit[1] .. "chit");
	end

	if window.getClass() == "StoryPointPCchit" or window.getClass() == "StoryPointGMchit" then
		if User.isHost() then
			-- subscribe to the login events so that client side chits can be updated when the player logs in.
			User.onLogin = onLogin;
			-- set up the right-click chit menus - GM only
			registerMenuItem("Clear Pile", "deletealltokens", 1);
			registerMenuItem("Update Player Chits", "broadcast", 7);
		end

		-- Register StoryPointPCchit window instance for use later in GM forced update.
		if window.getClass() == "StoryPointPCchit" then
			StoryPointPCchitwindow = window;
		end

		-- Register StoryPointGMchit window instance for use later in GM forced update.
		if window.getClass() == "StoryPointGMchit" then
			StoryPointGMchitwindow = window;
		end

		-- register special messages
		-- CoreRPG cannot handle these messages properly, so we use our own system
		ChatManagerGenesys.registerSpecialMessageHandler(SPECIAL_MSGTYPE_REFRESHDESTINYCHITS, handleRefreshdestinyChits);
		ChatManagerGenesys.registerSpecialMessageHandler(SPECIAL_MSGTYPE_REMOVEStoryPointPCCHIT, handleRemoveStoryPointPCChits);
		-- register some bogus message handlers so CoreRPG.OOBManager does not throw us some invalid OOB types
		OOBManager.registerOOBMsgHandler(SPECIAL_MSGTYPE_REFRESHDESTINYCHITS, ProcessNothing);
		OOBManager.registerOOBMsgHandler(SPECIAL_MSGTYPE_REMOVEStoryPointPCCHIT, ProcessNothing);


		if User.isHost() then
			if chit then
				--Set the destiny chits to the current value in the database
				refreshDestinyChits();
			end
		end
	end

	if window.getClass() == "woundchit" then
		registerMenuItem("Reset to 1", "erase", 1);
		registerMenuItem("Assign 2 chits", "num2", 2);
	end
end

function refreshDestinyChits()
	ChatManagerGenesys.sendSpecialMessage(SPECIAL_MSGTYPE_REFRESHDESTINYCHITS, {});
end

function ProcessNothing()
	local nada = "";
end

function handleRefreshdestinyChits(msguser, msgidentity, msgparams)
	local StoryPointPCnode = nil;
	local StoryPointGMnode = nil;

	if window.getClass() == "StoryPointPCchit" then
		-- ensure that we have the light side chit node - create it if it does not exist (e.g. for a new campaign)
		if User.isHost() then
			-- If we are the GM this may be a new campaign, need to create the node if not already there.
			if not StoryPointPCnode then
				StoryPointPCnode = DB.createNode("StoryPointPCchit.chits","number");
			end
		end

		-- If we don't have the StoryPointPCchit node at this point, find it.
		if not StoryPointPCnode then
			StoryPointPCnode = DB.findNode("StoryPointPCchit.chits");
		end

		--Debug.console("chit.lua: handleRefreshdestinyChits() StoryPointPCnode.getValue = " .. StoryPointPCnode.getValue());

		if StoryPointPCnode then
			-- refresh chits here
			if StoryPointPCnode.getValue()<=0 then
				setIcon("StoryPointPCchit0");
			elseif StoryPointPCnode.getValue()<8 then
				setIcon("StoryPointPCchit" .. StoryPointPCnode.getValue());
			else
				setIcon("StoryPointPCchit8more");
			end
		end
	end

	if window.getClass() == "StoryPointGMchit" then
		-- ensure that we have the light side chit node, create it if it does not exist (e.g. for a new campaign)
		if not StoryPointGMnode then
			StoryPointGMnode = DB.createNode("StoryPointGMchit.chits","number");
		end
		-- refresh chits here
		if StoryPointGMnode then
			if StoryPointGMnode.getValue()<=0 then
				setIcon("StoryPointGMchit0");
			elseif StoryPointGMnode.getValue()<8 then
				setIcon("StoryPointGMchit" .. StoryPointGMnode.getValue());
			else
				setIcon("StoryPointGMchit8more");
			end
		end
	end
end

function removeStoryPointPCChits()
	local msgparams = {};
	msgparams[1] = "true";		--Used as the removingchit flag to ensure that the OOB process only fires once on the GM side.
	ChatManagerGenesys.sendSpecialMessage(SPECIAL_MSGTYPE_REMOVEStoryPointPCCHIT, msgparams);
end

function handleRemoveStoryPointPCChits(msguser, msgidentity, msgparams)
	-- Can onlt adjust the database as the host
	removingchit = msgparams[1];
	if User.isHost() and  removingchit == "true" then
		local msg = {};
		msg.font = "msgfont";

		-- create  new Story Point (Player) node, or find it if it already exists
		StoryPointPCnode = DB.createNode("StoryPointPCchit.chits", "number");
		if StoryPointPCnode then
			-- Only remove a chit if there are actually any there to remove
			if StoryPointPCnode.getValue() > 0 then
				-- decrease the StoryPointPC count
				StoryPointPCnode.setValue(StoryPointPCnode.getValue() - 1);
				--Debug.console("StoryPointPC use.");
				--msg.text = "Story Point (Player) has been decremented to " ..  StoryPointPCnode.getValue();
				if msgidentity == "" then
					msg.text = "A Story Point (Player) chit has been used by  " .. msguser;
				elseif msgidentity == "GM" then
					msg.text = "A Story Point (Player) chit has been played by the GM on behalf of the players.";
				else
					msg.text = "A Story Point (Player) chit has been used by  " .. msguser .. ", for character " .. msgidentity;
				end
				ChatManagerGenesys.deliverMessage(msg);

				-- create new Story Point (GM) node, or find it if it already exists
				StoryPointGMnode = DB.createNode("StoryPointGMchit.chits", "number");
				if StoryPointGMnode then
					-- increase the StoryPointGM count
					StoryPointGMnode.setValue(StoryPointGMnode.getValue() + 1);
					--msg.text = "Story Point (GM) has been incremented to " ..  StoryPointGMnode.getValue();
					--ChatManager.deliverMessage(msg);
				end
				-- Reset flag to stop further processing of this function until another drag event occurs.
				removingchit = "false";
				msgparams[1] = "false";  --Needed to reset removing chit properly when this function fires again.
				-- Refresh the chits.
				refreshDestinyChits();
			end
		end
	end
end

function onLogin(username, activated)
	if User.isHost() and activated then
		--Add the player as a holder to the destiny chits nodes - this is needed to avoid an error accessing the nodes when a user connects to a campaign DB for the first time.
		--local StoryPointPCnode = DB.findNode("StoryPointPCchit");
		--if not StoryPointPCnode then
		--	StoryPointPCnode.addHolder(username);
		--end

		--local StoryPointGMnode = DB.findNode("StoryPointGMchit");
		--if not StoryPointGMnode then
			--StoryPointGMnode.addHolder(username);
		--end

		--Refresh the client side chit icons
		refreshDestinyChits();
	end
end

function onMenuSelection(selection)
	if chit then
		if window.getClass() == "StoryPointPCchit" or window.getClass() == "StoryPointGMchit" then
			if selection == 1 then
				-- Reset both chit piles to 0
				local msg = {};
				msg.font = "msgfont";

				if window.getClass() == "StoryPointPCchit" then
					-- create new Story Point (Player) node, or find it if it already exists
					StoryPointPCnode = DB.createNode("StoryPointPCchit.chits", "number");
					if StoryPointPCnode then
						-- remove all the StoryPointPC
						StoryPointPCnode.setValue(0);
						msg.text = "Story Point (Player) has been decremented to " ..  StoryPointPCnode.getValue();
						ChatManagerGenesys.deliverMessage(msg);
						refreshDestinyChits();
					end
				end

				if window.getClass() == "StoryPointGMchit" then
					StoryPointGMnode = DB.createNode("StoryPointGMchit.chits", "number");
					if StoryPointGMnode then
						-- remove all the StoryPointGM
						StoryPointGMnode.setValue(0);
						msg.text = "Story Point (GM) has been decremented to " ..  StoryPointGMnode.getValue();
						ChatManagerGenesys.deliverMessage(msg);
						refreshDestinyChits();
					end
				end
			elseif selection == 7 then
				-- Synchronise the chit piles with the connected players - added for the rare occasion where the client does not synch properly on login
				refreshDestinyChits();
			end
		end

		if window.getClass() == "woundchit" then
			if selection == 1 then

			elseif selection == 2 then

			end
		end
	end
end

function onDragStart(button, x, y, draginfo)
	if window.getClass() == "StoryPointPCchit" or window.getClass() == "StoryPointGMchit" then
		-- Allow all users to drag Story Point (Player) chits
		if window.getClass() == "StoryPointPCchit" then
			dragging = false;
			return onDrag(button, x, y, draginfo);

		--Allow GM to drag both StoryPointPC and StoryPointGM
		elseif User.isHost() then
			dragging = false;
			return onDrag(button, x, y, draginfo);
		end
	else
		dragging = false;
		return onDrag(button, x, y, draginfo);
	end
end

function onDrag(button, x, y, draginfo)
	if chit and not dragging then
		draginfo.setType("chit");
		draginfo.setDescription(chit[1]);
		draginfo.setIcon(chit[1] .. "chit");
		draginfo.setCustomData(chit[1]);
		dragging = true;
		return true;
	end
end

function onDragEnd(draginfo)
	dragging = false;
	if chit then
		local msg = {};
		msg.font = "msgfont";

		if window.getClass() == "StoryPointPCchit" then
			removeStoryPointPCChits();
		end

		if window.getClass() == "StoryPointGMchit" then
			StoryPointGMnode = DB.createNode("StoryPointGMchit.chits", "number");
			if StoryPointGMnode then
				-- Only remove a chit if there are actually any there to remove
				if StoryPointGMnode.getValue() > 0 then
					-- decrease the StoryPointGM count
					StoryPointGMnode.setValue(StoryPointGMnode.getValue() - 1);
					--msg.text = "Story Point (GM) has been decremented to " ..  StoryPointGMnode.getValue();
					msg.text = "A Story Point (GM) chit has been used by the GM";
					ChatManagerGenesys.deliverMessage(msg);
					-- create  new Story Point (Player) node, or find it if it already exists
					StoryPointPCnode = DB.createNode("StoryPointPCchit.chits", "number");
					if StoryPointPCnode then
						-- increase the StoryPointPC count
						StoryPointPCnode.setValue(StoryPointPCnode.getValue() + 1);
						--msg.text = "Story Point (Player) has been incremented to " ..  StoryPointPCnode.getValue();
						--ChatManager.deliverMessage(msg);
					end
					refreshDestinyChits();
				end
			end
		end
	end
end

function onDoubleClick(x, y)
	--Only process if the user is the GM
	if chit and User.isHost() then
		local msg = {};
		msg.font = "msgfont";

		if window.getClass() == "StoryPointPCchit" then
			-- create  new Story Point (Player) node, or find it if it already exists
			StoryPointPCnode = DB.findNode("StoryPointPCchit.chits", "number");
			if not StoryPointPCnode then
				StoryPointPCnode = DB.createNode("StoryPointPCchit.chits", "number");
			end
			if StoryPointPCnode then
				-- increase the StoryPointPC count
				StoryPointPCnode.setValue(StoryPointPCnode.getValue() + 1);
				--msg.text = "Story Point (Player) has been increased to " ..  StoryPointPCnode.getValue();
				--ChatManager.deliverMessage(msg);
			end
			-- Initiate special message functionality to refresh chits on clients.
			refreshDestinyChits();
		end

		if window.getClass() == "StoryPointGMchit" then
			-- create  new Story Point (GM) node, or find it if it already exists
			StoryPointPCnode = DB.createNode("StoryPointPCchit.chits", "number");
			StoryPointGMnode = DB.createNode("StoryPointGMchit.chits", "number");
			if StoryPointGMnode then
				-- increase the StoryPointGM count
				StoryPointGMnode.setValue(StoryPointGMnode.getValue() + 1);
				--msg.text = "Story Point (GM) has been increased to " ..  StoryPointGMnode.getValue();
				--ChatManager.deliverMessage(msg);
			end
			-- Initiate special message functionality to refresh chits on clients.
			refreshDestinyChits();
		end

		return true;
	end
end
