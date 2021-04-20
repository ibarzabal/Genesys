SPECIAL_MSGTYPE_UPDATEDIEBOXLIST = "updatedieboxgenlist";
SPECIAL_MSGTYPE_UPDATECLIENTDIEBOXLIST = "updateclientdieboxgenlist";
SPECIAL_MSGTYPE_SYNCHDIEBOXDATA = "synchdieboxgendata";
SPECIAL_MSGTYPE_REMOTEREBUILDDIEBOX = "remoterebuilddieboxgen";

local dieboxgenviewlistcontrol = nil;

function onInit()
	Debug.console("dieboxgenviewlistmanager.lua: onInit()");
	-- Register special message handler to allow sharing dicepool info with all connected clients
	ChatManagerGenesys.registerSpecialMessageHandler(SPECIAL_MSGTYPE_UPDATEDIEBOXLIST, handleUpdateDieBoxGenList);
	ChatManagerGenesys.registerSpecialMessageHandler(SPECIAL_MSGTYPE_UPDATECLIENTDIEBOXLIST, handleUpdateClientDieBoxGenList);
	ChatManagerGenesys.registerSpecialMessageHandler(SPECIAL_MSGTYPE_SYNCHDIEBOXDATA, handleSynchDieBoxGenData);
	ChatManagerGenesys.registerSpecialMessageHandler(SPECIAL_MSGTYPE_REMOTEREBUILDDIEBOX, handleRemoteRebuildDieBoxGen);

	--Avoid error messages by oob handler
	OOBManager.registerOOBMsgHandler(SPECIAL_MSGTYPE_UPDATEDIEBOXLIST, ProcessNothing);
	OOBManager.registerOOBMsgHandler(SPECIAL_MSGTYPE_UPDATECLIENTDIEBOXLIST, ProcessNothing);
	OOBManager.registerOOBMsgHandler(SPECIAL_MSGTYPE_SYNCHDIEBOXDATA, ProcessNothing);
	OOBManager.registerOOBMsgHandler(SPECIAL_MSGTYPE_REMOTEREBUILDDIEBOX, ProcessNothing);

	if User.isHost() then
			-- subscribe to the login events so that the die box list can be updated when the player logs in and logs out.
			User.onLogin = onLogin;
	end

end



function ProcessNothing()
local nada = "";
end

function onLogin(username, activated)
	-- Update the dieboxgen list to all clients & GM when a player logs in (activated = true) or out
	Debug.console("dieboxgenviewlistmanager.lua: onLogin(), username = " .. username);
	if User.isHost() and activated then
		-- We have a new user logging in - update die box view list across all clients.
		updateDieBoxGenList("");
	else
		-- A user is logging out, remove them from the die box view list.
		updateDieBoxGenList(username, true);
	end
end

function registerControl(control)
	dieboxgenviewlistcontrol = control;
end

function unregisterSMHandler()
	Debug.console("dieboxgenviewlistmanager.lua: unregisterSMHandler()");
	dieboxgenviewlistcontrol = nil;
	--ChatManagerGenesys.unregisterSpecialMessageHandler(SPECIAL_MSGTYPE_UPDATEDIEBOXLIST, handleUpdateDieBoxGenList);
	--if not User.isHost() then
		-- Do not unregister is the user is host (GM) - this allows the players to use the diceboxviewlist even if the GM doesn't have it open.
		--ChatManagerGenesys.unregisterSpecialMessageHandler(SPECIAL_MSGTYPE_UPDATECLIENTDIEBOXLIST, handleUpdateClientDieBoxGenList);
	--end
end

function remoteRebuildDieBoxGenData()
	-- Called by a remote client to rebuild the die box - usually when the player switches PCs or selects their first PC.
	Debug.console("dieboxgenviewlistmanager.lua: remoteRebuildDieBoxGenData()");

	ChatManagerGenesys.sendSpecialMessage(SPECIAL_MSGTYPE_REMOTEREBUILDDIEBOX, {});
end

function handleRemoteRebuildDieBoxGen()
	if User.isHost() then
		updateDieBoxGenList("");
	end
end

function synchDieBoxGenData()
	-- Called when the die box viewer is first opened to synch current die pool data.
	Debug.console("dieboxgenviewlistmanager.lua: synchDieBoxGenData()");
	--local msgparams = {};
	-- Only the GM can create the list of logged in users.
	--msgparams[1] = User.getUsername();
	ChatManagerGenesys.sendSpecialMessage(SPECIAL_MSGTYPE_SYNCHDIEBOXDATA, {});

end

function handleSynchDieBoxGenData(msguser, msgidentity, msgparams)
	--local username = msgparams[1];
	--Debug.console("dieboxgenviewlist.lua: handleSynchDieBoxGenData()  Username = " .. username);
	Debug.console("dieboxgenviewlistmanager.lua: handleSynchDieBoxGenData()");
	--updateClientDieBoxGenList();
	--if User.isHost() then
	--	updateDieBoxGenList(username);
	--end

	DieBoxGenManager.readDicepool();

end

function updateClientDieBoxGenList()
	Debug.console("dieboxgenviewlistmanager.lua: updateClientDieBoxGenList()");
	local msgparams = {};
	-- Only the GM can create the list of logged in users.
	msgparams[1] = User.getUsername();
	ChatManagerGenesys.sendSpecialMessage(SPECIAL_MSGTYPE_UPDATECLIENTDIEBOXLIST, msgparams);

end

function handleUpdateClientDieBoxGenList(msguser, msgidentity, msgparams)
	local username = msgparams[1];
	Debug.console("dieboxgenviewlistmanager.lua: handleUpdateClientDieBoxGenList()  Username = " .. username);
	if User.isHost() then
		updateDieBoxGenList(username);
	end

end

function updateDieBoxGenList(username, isLogout)
	--Used to update the die box list.  Just the top level die boxes, not the content of the die boxes.
	-- if isLogout = true a user is logging out and we need to remove the dix box view slot associated with the username
	-- if isLogout is false or not present, username is used to update only for a specific user - request from user side for an update
	--Debug.console("dieboxgenviewlist.lua: updateDieBoxGenList()  getWindowCount() = " .. getWindowCount());
	local userlist = {};

	-- Only the GM can create the list of logged in users.
	if User.isHost() then
		-- Create the GM dieboxgenviewslot
		--local gmname = "GM - " .. User.getUsername();
		--Just use GM as the GM name - this will cause issues if a player has logged in with the username of GM!
		-- TODO: Code to avoid a clash if a player has logged in as GM.
		local gmname = "GM";
		table.insert(userlist, gmname);
		-- Create all of the dieboxgenviewslot windows based off all of the logged in players.
		for k,v in pairs(User.getActiveUsers()) do
			table.insert(userlist, v);
			--local dieboxgenwindow = createWindow();
			--dieboxgenwindow.setIdentityName(v);
		end

		if isLogout then
			-- Remove the logging out user from the list.
			for k,v in pairs(userlist) do
				if v == username then
					table.remove(userlist, k);
				end
			end
			-- Clear the username variable to allow all die box view lists to be updated
			username = ""
		end

		local msgparams = {};
		userliststring = table.concat(userlist, ",");
		Debug.console("dieboxgenviewlist.lua: updateDieBoxGenList().  User list = " .. userliststring);
		--Debug.console("dicepoolmanager.lua: readDicepool.  Dieliststring = " .. dieliststring);
		msgparams[1] = userliststring;
		msgparams[2] = username;
		ChatManagerGenesys.sendSpecialMessage(SPECIAL_MSGTYPE_UPDATEDIEBOXLIST, msgparams);

		-- Update refreshed die box view list with data
		synchDieBoxGenData();
	end

end

function handleUpdateDieBoxGenList(msguser, msgidentity, msgparams)
	if dieboxgenviewlistcontrol then
		local userliststring = msgparams[1];
		local username = msgparams[2];
		local userlist = {};
		Debug.console("dieboxgenviewlist.lua: handleUpdateDieBoxGenList()  userliststring = " .. userliststring .. ", username = " .. username);
		if username == "" or User.getUsername() == username then
			--Debug.console("dieboxgenviewlist.lua: handleUpdateDieBoxGenList()  updating...");

			--Debug.console("dicepoolmanager.lua: handleSendPlayerDicepool. msguser = " .. msguser .. ", msgidentity = " .. msgidentity);

			-- Make userlist table from userliststring
			userlist = StringManager.split(userliststring, ",");

			-- Remove all current windows in the windowlist - we will add in new ones.
			dieboxgenviewlistcontrol.closeAll();
			-- Create all of the dieboxgenviewslot windows based off all of the logged in players.
			for k,v in pairs(userlist) do
				--Debug.console("dieboxgenviewlist.lua: handleUpdateDieBoxGenList().  Looping through userlist table - " .. k .. ", " .. v);
				-- Don't add the local dieboxgen to the view - we can already see it!
				local localusername = "";
				if User.isHost() then
					localusername = "GM";
				else
					localusername = User.getUsername();
				end

				if v ~= localusername then
					-- Create the die box view control in the list
					local dieboxgenwindow = dieboxgenviewlistcontrol.createWindow();
					--Debug.console("dieboxgenviewlist.lua: handleUpdateDieBoxGenList(). After creating window.");
					dieboxgenwindow.setIdentityName(v);

					-- Set the name of the entry in the dicepool viewer to the name of the currently active PC for the player in question
					-- Sets the name to the player name if no PC is currently selected.
					--if User.getIdentityLabel(User.getCurrentIdentity(v)) == nil then
					--	dieboxgenwindow.setIdentityName(v);
					--else
					--	dieboxgenwindow.setIdentityName(User.getIdentityLabel(User.getCurrentIdentity(v)));
					--end
				end
			end
			--Debug.console("dieboxgenviewlist.lua: handleUpdateDieBoxGenList()  getWindowCount() = " .. self.getWindowCount());
		end
	end
end

function onClose()
	--InitiativeManager.unregisterControl();
end

function setDiceBoxViewListData(username, dielist, description)
	Debug.console("diceboxviewlistmanager.lua: setDiceBoxViewListData.  username = " .. username);
	local diceboxviewwindows = {}
	if dieboxgenviewlistcontrol then
		diceboxviewwindows = dieboxgenviewlistcontrol.getWindows();
		for k,v in pairs(diceboxviewwindows) do
			if v.getIdentityName() == username then
				v.dieboxgenremote.setDice(dielist);
				v.dieboxgenremote.setDescription(description);
			end
		end
	end
end

function onDrop(x, y, draginfo)
	Debug.console("initslotlist.lua:onDrop.");
	local actorwindow = getWindowAt(x, y);
	if actorwindow then
		return actorwindow.onDrop(x, y, draginfo);
	else
		return InitiativeManager.onDrop(x, y, draginfo);
	end
end

--function onSortCompare(w1, w2)
--	if w1.initslotinitiative.getValue() ~= w2.initslotinitiative.getValue() then
--		return w1.initslotinitiative.getValue() < w2.initslotinitiative.getValue();
--	elseif w1.getClass() ~= w2.getClass() then
--		return w1.getClass() > w2.getClass();
--	elseif w1.initslotclassname.getValue() ~= w2.initslotclassname.getValue() then
--		return w1.initslotclassname.getValue() > w2.initslotclassname.getValue();
--	else
--		return w1.initslotname.getValue() > w2.initslotname.getValue();
--	end
--end
