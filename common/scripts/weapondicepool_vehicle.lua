local dragging = false;

function onInit()

	-- determine if node is static
	if window.getDatabaseNode().isStatic() then
		setVisible(false);
		return
	end

	-- set the hover cursor
	setHoverCursor("hand");

end

-- Genesys - for now dragging genesys dice is causing too many issues with FGU and FGC
-- disabling drag, players should double click instead
-- function onDragStart(button, x, y, draginfo)
-- 	dragging = false;
-- 	return onDrag(button, x, y, draginfo);
-- end
--
-- function onDrag(button, x, y, draginfo)
--
-- 	if not dragging then
--
-- 		--Debug.console("Weapon roll from window class = " .. window.getClass() .. ". window database node = " .. window.getDatabaseNode().getNodeName());
-- 		local weaponnode = window.getDatabaseNode();
-- 		local weaponname = DB.getValue(window.getDatabaseNode(), "name");
-- 		local weaponskillvalue = weaponnode.getChild("skill").getValue();
-- 		local weapondamagevalue = weaponnode.getChild("damage").getValue();
-- 		local weaponcriticalvalue = weaponnode.getChild("critical").getValue();
-- 		local charnode;
--
-- 		local skillsnode;
-- 		-- See if we're rolling form the party sheet (group vehicle) or from a character sheet.
-- 		if string.find(window.getDatabaseNode().getNodeName(), "partysheet.inventory") then
-- 			if User.getCurrentIdentity() then
-- 				--Debug.console("Current PC = " .. "charsheet." .. User.getCurrentIdentity() .. ".skills");
-- 				skillsnode = DB.findNode("charsheet." .. User.getCurrentIdentity() .. ".skilllist");
-- 			end
-- 		else
-- 			charnode = DB.getParent(DB.getParent(window.getDatabaseNode()));
-- 			skillsnode = charnode.getChild("skilllist");
-- 		end
--
-- 		-- If we don't have the skillsnode then we can't populate the dice pool with anything - exit function.
-- 		if skillsnode == nil then
-- 			return;
-- 		end
--
--
-- --		--Debug.console("Weapon name = " .. weaponname .. ", weapon node = " .. weaponnode.getNodeName());
-- --		--Debug.console("Weapon skill name = " .. weaponskillvalue .. ", PC skills node = " .. skillsnode.getNodeName());
-- --
-- --		-- Work through the possible skill values in the weapon and assign relevant skill name to weaponskillname1 or weaponskillname2
-- --		-- Using 2 possible weaponskillnames here to try for a better match - matching should be fine with auto generated skills as we know the name
-- --		local weaponskillname1 = "";
-- --		local weaponskillname2 = "";
-- --		if weaponskillvalue == "RL" then
-- --			weaponskillname1 = "Ranged(Light)(Ag)";
-- --			weaponskillname2 = "Ranged(Light)";
-- --		elseif weaponskillvalue == "RH" then
-- --			weaponskillname1 = "Ranged(Hvy)(Ag)";
-- --			weaponskillname2 = "Ranged(Hvy)";
-- --		elseif weaponskillvalue == "Br" then
-- --			weaponskillname1 = "Brawl (Br)";
-- --			weaponskillname2 = "Brawl";
-- --		elseif weaponskillvalue == "M" then
-- --			weaponskillname1 = "Melee (Br)";
-- --			weaponskillname2 = "Melee";
-- --		elseif weaponskillvalue == "G" then
-- --			weaponskillname1 = "Gunnery (Ag)";
-- --			weaponskillname2 = "Gunnery";
-- --		elseif weaponskillvalue == "LS" then
-- --			weaponskillname1 = "Lightsaber (Br)";
-- --			weaponskillname2 = "Lightsaber";
-- --		else
-- --			-- don't have a matching weaponskill name - what to do?!?
-- --			Debug.console("weapondicepool.lua: onDoubleClick.  No match for skill assigned to weapon - make sure a skill is assigned to the weapon.");
-- --			return false;
-- --		end
--
-- 		local weaponskillnode = nil;
-- 		for k,v in pairs(skillsnode.getChildren()) do
-- 			--Debug.console("Looking at current child: " .. k .. ", skillname = " .. v.getChild("name").getValue());
-- 			if v.getChild("name").getValue() == weaponskillvalue then
-- 				--Debug.console("Have the " .. weaponskillname1 .. " db node = " .. v.getNodeName());
-- 				weaponskillnode = v;
-- 				break;
-- 			end
-- 		end
--
-- 		local dice = {};
-- 		local skilldescription;
-- 		local msgidentity = DB.getValue(weaponskillnode, "...name", "");
-- 		DicePoolManager.addSkillDice(weaponskillnode, dice);
-- 		if table.getn(dice) > 0 then
-- 			draginfo.setType("skill");
-- 			if weaponskillnode.getChild("name") then
-- 				draginfo.setDescription(weaponname .. " - " .. weaponskillvalue .. " [ATTACK]\r[DAMAGE: " .. weapondamagevalue .. "] [CRIT: " .. weaponcriticalvalue .. "]");
-- 			end
-- 			draginfo.setDieList(dice);
-- 			draginfo.setDatabaseNode(weaponskillnode);
-- 			dragging = true;
-- 			return true;
-- 			--DieBoxGenManager.addSkillDice(skilldescription, dice, weaponskillnode, msgidentity);
-- 		end
--
-- --		local dice = {};
-- --		DicePoolManager.addSkillDice(initskillnode, dice);
-- --		if table.getn(dice) > 0 then
-- --			draginfo.setType("skill");
-- --			if initskillnode.getChild("name") then
-- --				draginfo.setDescription(initskillnode.getChild("name").getValue()  .. " [INIT]");
-- --			end
-- --			draginfo.setDieList(dice);
-- --			draginfo.setDatabaseNode(initskillnode);
-- --			dragging = true;
-- --			return true;
-- --		end
-- 	end
-- 	return false;
-- end
--
-- function onDragEnd(draginfo)
-- 	dragging = false;
-- end

-- Allows population of the dice pool by a double-click on the dice button by the skill
function onDoubleClick()
	Debug.console("Weapon roll from window class = " .. window.getClass() .. ". window database node = " .. window.getDatabaseNode().getNodeName());
	--Debug.console("TODO - code Cool initiative roll.  Control = " .. self.getName());
	local weaponnode = window.getDatabaseNode();
	local vehiclename = DB.getValue(window.getDatabaseNode().getParent().getParent(), "name","");

	local weaponname = DB.getValue(window.getDatabaseNode(), "name","");
	local weaponskillvalue = DB.getValue(weaponnode.getChild("skill"),"");
	local weapondamagevalue = weaponnode.getChild("damage").getValue();
	local weaponcriticalvalue = weaponnode.getChild("critical").getValue();

	if (weapondamagevalue == "" or weaponskillvalue =="") then
		return
	end

	local charnode;

	local skillsnode;

--	-- See if we're rolling form the party sheet (group vehicle) or from a character sheet.
--	if string.find(window.getDatabaseNode().getNodeName(), "partysheet.inventory") then
--		if User.getCurrentIdentity() then
--			--Debug.console("Current PC = " .. "charsheet." .. User.getCurrentIdentity() .. ".skilllist");
--			skillsnode = DB.findNode("charsheet." .. User.getCurrentIdentity() .. ".skillist");
--		end
--	else
		charnode = DB.getParent(DB.getParent(DB.getParent(window.getDatabaseNode())));
		skillsnode = charnode.getChild("skilllist");
--	end
	-- If we don't have the skillsnode then we can't populate the dice pool with anything - exit function.
	if skillsnode == nil then
		return;
	end

	local weaponskillnode = nil;
	for k,v in pairs(skillsnode.getChildren()) do
		--Debug.console("Looking at current child: " .. k .. ", skillname = " .. v.getChild("name").getValue());
		if v.getChild("name").getValue() == weaponskillvalue then
			--Debug.console("Have the " .. weaponskillname1 .. " db node = " .. v.getNodeName());
			weaponskillnode = v;
			break;
		end
	end

	-- TODO: Need to code for no match in skills - i.e. use characteristic score only.

	local dice = {};
	local skilldescription;
	local msgidentity = DB.getValue(weaponskillnode, "...name", "");
	DicePoolManager.addSkillDice(weaponskillnode, dice);
	if table.getn(dice) > 0 then
		if weaponskillnode.getChild("name") then
			skilldescription = "[Vehicle: " .. vehiclename .. "]\n" .. weaponname .. " - " .. weaponskillvalue .. " [ATTACK]\r[DAMAGE: " .. weapondamagevalue .. "] [CRIT: " .. weaponcriticalvalue .. "]";
		end
		local actornode = DB.getParent(DB.getParent(window.getDatabaseNode()));
		DieBoxGenManager.addSkillDice(skilldescription, dice, weaponskillnode, msgidentity, actornode,"default");
	end
end
