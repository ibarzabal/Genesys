local control = nil;
local gmhiddencontrol = nil;
local l_actornode = nil;
SPECIAL_MSGTYPE_SENDPLAYERDICEPOOL = "sendplayerdicepool";

 function onInit()
--	Register special message handler to share dicepool with other FG instances
  ChatManagerGenesys.registerSpecialMessageHandler(SPECIAL_MSGTYPE_SENDPLAYERDICEPOOL, handleSendPlayerDicepool);
  OOBManager.registerOOBMsgHandler(SPECIAL_MSGTYPE_SENDPLAYERDICEPOOL, ProcessNothing);

end
function ProcessNothing()
local nada = "";
end



function registerControl(ctrl)
	control = ctrl;
end

function rollDice()
	control.onDieboxButtonPress();
end

function rollInitDice()
	-- Hide the dice rolls
	local isGMHidden = getGMHidden();
	if not isGMHidden then
		setGMHidden(true);
	end
	control.onDieboxButtonPress();
	-- Set back to the original setting after the roll
	if not isGMHidden then
		setGMHidden(false);
	end
end

function registerGMHiddenControl(ctrl)
	gmhiddencontrol = ctrl;
end

function getGMHidden()
	if gmhiddencontrol.getValue() == 0 then
		return false;
	else
		return true;
	end
end

function setGMHidden(hide)
	if hide then
		gmhiddencontrol.setValue(1);
	else
		gmhiddencontrol.setValue(0);
	end
end


function addDie(type)
	if control then
		control.addDie(type);
	end
end

function addDice(dice)
	if control then
		control.addDice(dice);
	end
end

function getActorNode()
  if l_actornode then
    return l_actornode;
  end
end

-- Added to allow skill dice to be added to the die box by clicking on the button next to the skill.
function addSkillDice(skilldescription, dice, sourcenode, msgidentity,actornode,override_clear)
    if actornode then
      l_actornode = actornode;
    else
      l_actornode = nil;
    end

   	if dice then
  		if (OptionsManager.getOption("interface_cleardicepoolondrag") == "on"  or override_clear == "clear") and override_clear ~= "keep" then
        control.resetAll();
  		end
		control.setType("skill");
		control.setDescription(skilldescription);
		control.setSourcenode(sourcenode);
		control.setIdentity(msgidentity);
		for k, v in pairs(dice) do
			control.addDie(v);
		end
	end
end

-- Added to allow skill dice to be added to the die box by clicking on the button next to the skill.
function addCharacteristicDice(description, dice, sourcenode, msgidentity)
	if dice then
		if OptionsManager.getOption("interface_cleardicepoolondrag") == "on" then
			control.resetAll();
		end
		control.setType("characteristic");
		control.setDescription(description);
		control.setSourcenode(sourcenode);
		control.setIdentity(msgidentity);
		for k, v in pairs(dice) do
			control.addDie(v);
		end
	end
end

function readDicepool()
	-- Used to pass dicepool info to GM/client to enable viewing of the dicepool remotely.
	local dieboxgenremote = nil;
	local dielist = control.getDice();
	--Debug.console("diceboxmanager.lua: readDicepool.  Dicepool description =  = " .. control.getDescription());
	for k, n in pairs(dielist) do
		--Debug.console("diceboxmanager.lua: readDicepool.  Dice = " .. k .. ", " .. n);
	end
	--dieboxgenremote = Interface.openWindow("dieboxgenremote", "");
	--dieboxgenremote.dieboxgencontrol.setDice(dielist);
	--dieboxgenremote.dieboxgencontrol.setDescription(control.getDescription());

	sendPlayerDicepool(dielist, control.getDescription());
end

-- functions used to view the player dicepool via special messages
function sendPlayerDicepool(dielist, description)
	--Debug.console("charlistentry.lua: sendPlayerDicepool.  indentityOwner = " .. indentityOwner);
	local msgparams = {};
	--local dieliststring = "";
	for k, n in pairs(dielist) do
	--	dieliststring = dieliststring .. k .. "," .. v .. "||");
		--Debug.console("dieboxgenmanager.lua: readDicepool.  Dice = " .. k .. ", " .. n);
	end
	dieliststring = table.concat(dielist, ",");
	Debug.console("dieboxgenmanager.lua: sendPlayerDicepool.  Dieliststring = " .. dieliststring);
	msgparams[1] = dieliststring;
	msgparams[2] = description;
	if User.isHost() then
		msgparams[3] = "GM";
	else
		msgparams[3] = User.getUsername();
	end
	ChatManagerGenesys.sendSpecialMessage(SPECIAL_MSGTYPE_SENDPLAYERDICEPOOL, msgparams);
end

function handleSendPlayerDicepool(msguser, msgidentity, msgparams)
	local dieliststring = msgparams[1];
	local description = msgparams[2];
	local username = msgparams[3];
	local dielist = {};

	if User.getUsername() ~= msguser then
		-- Make dielist table from dieliststring
		dielist = StringManager.split(dieliststring, ",");

		-- Open dieboxgen on remote desktop and send die and description info.
		--dieboxgenremote = Interface.openWindow("dieboxgenremote", "");
		--dieboxgenremote.dieboxgencontrol.setDice(dielist);
		--dieboxgenremote.dieboxgencontrol.setDescription(description);

		DieBoxGenViewListManager.setDiceBoxViewListData(username, dielist, description);

	end

	--Debug.console("charlistentry.lua: handleSendPlayerDicepool.  msguser = " .. msguser .. ", msgidentity = " .. msgidentity .. ", dicepoolPlayer = " .. dicepoolPlayer);
	--if User.getUsername() == dicepoolPlayer then
	--	Debug.console("charlistentry.lua: handleSendPlayerDicepool.  I am the player with the dicepool!  This is the dicepool you are looking for.");
	--	DieBoxGenManager.readDicepool();
	--end
end

-- Added to allow double clicking on force dice to add to the dieboxgen without overwriting it - thanks to Archamus for this
function addForceDice(dice, sourcenode, msgidentity)
	if dice then
		control.setType("dice");
		control.setSourcenode(sourcenode);
		control.setIdentity(msgidentity);
		for k, v in pairs(dice) do
			control.addDie(v);
		end
	end
end
