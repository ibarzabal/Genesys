local dragging = false;

function onInit()
	if rollable or (gmrollable and User.isHost()) then
		local w = addBitmapWidget("field_rollable");
--		w.setPosition("bottomleft", -1, -4);
		setHoverCursor("hand");
	elseif rollable2 or (gmrollable2 and User.isHost()) then
		local w = addBitmapWidget("field_rollable_transparent");
--		w.setPosition("topright", 0, 2);
--		w.sendToBack();
		setHoverCursor("hand");
	end

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
-- 	if not dragging then
-- 		local sourcenode = window.getDatabaseNode();
--
-- 		local skilllistnode = window.getDatabaseNode().getChild("skilllist");
-- 		local initskillnode = nil;
-- 		local initskillname = "";
-- 		--Debug.console("skilllist node = " .. skilllistnode.getNodeName());
-- 		if self.getName() == "combat_init_cool_btn" then
-- 			initskillname = "Cool";
-- 		elseif self.getName() == "combat_init_vigilance_btn" then
-- 			initskillname = "Vigilance";
-- 		end
--
-- 		for k,v in pairs(skilllistnode.getChildren()) do
-- 			--Debug.console("Looking at current child: " .. k);
-- 			if v.getChild("name").getValue() == initskillname then
-- 				--Debug.console("Have the " .. initskillname .. " db node = " .. v.getNodeName());
-- 				initskillnode = v;
-- 				break;
-- 			end
-- 		end
--
-- 		-- Try secondary skilllist of "Cool" or "Vigilance" (named without the characterstic)
-- 		if not initskillnode then
-- 			if self.getName() == "combat_init_cool_btn" then
-- 				initskillname = "Cool";
-- 			elseif self.getName() == "combat_init_vigilance_btn" then
-- 				initskillname = "Vigilance";
-- 			end
--
-- 			for k,v in pairs(skilllistnode.getChildren()) do
-- 				--Debug.console("Looking at current child: " .. k);
-- 				if v.getChild("name").getValue() == initskillname then
-- 					--Debug.console("Have the " .. initskillname .. " db node = " .. v.getNodeName());
-- 					initskillnode = v;
-- 					break;
-- 				end
-- 			end
-- 		end
--
-- 		-- TODO: Need to code for no match in skilllist - i.e. use characteristic score only.
--
-- 		local dice = {};
-- 		DicePoolManager.addSkillDice(initskillnode, dice);
-- 		if table.getn(dice) > 0 then
-- 			draginfo.setType("skill");
-- 			draginfo.setDescription(initskillname  .. " [INIT]");
-- 			draginfo.setDieList(dice);
-- 			draginfo.setDatabaseNode(initskillnode);
-- --			draginfo.setIdentity(initskillnode.getChild("name").getValue()  .. " [INIT]");
-- 			dragging = true;
-- 			return true;
-- 		end
-- 	end
-- 	return false;
-- end
--
--
--
--
-- function onDragEnd(draginfo)
-- 	dragging = false;
-- end

-- Allows population of the dice pool by a double-click on the dice button by the skill
function onDoubleClick()
	local skilllistnode = window.getDatabaseNode().getChild("skilllist");

	if not skilllistnode then
		return;
	end
	local initskillnode = nil;
	local initskillname = "";
	if self.getName() == "combat_init_cool_btn" then
		initskillname = "Cool";
	elseif self.getName() == "combat_init_vigilance_btn" then
		initskillname = "Vigilance";
	end

	for k,v in pairs(skilllistnode.getChildren()) do
		if v.getChild("name").getValue() == initskillname then
			initskillnode = v;
			break;
		end
	end

	-- Try secondary skilllist of "Cool" or "Vigilance" (named without the characterstic)
	if not initskillnode then
		if self.getName() == "combat_init_cool_btn" then
			initskillname = "Cool";
		elseif self.getName() == "combat_init_vigilance_btn" then
			initskillname = "Vigilance";
		end
		for k,v in pairs(skilllistnode.getChildren()) do
			Debug.console("Looking at current child: " .. k);
			if v.getChild("name").getValue() == initskillname then
				initskillnode = v;
				break;
			end
		end
	end


	local dice = {};
	local skilldescription;


	--todo: Need to code for no match in skilllist - i.e. use characteristic score only.
	-- If Pc/NPC does not have the correct skill... roll using characteristic

-- WORK IN PROGRESS
--	if not initskillnode then
--		local skillcheckvalue;
--		local msgidentity = DB.getValue(window.getDatabaseNode(),"name","");
--		if initskillname == "Cool" then
--			skillcheckvalue = "presence";
--		else
--			skillcheckvalue = "willpower";
--		end
--		local characteristicnode = actionnode.getChild("..." .. skillcheckvalue .. ".current");
--		if characteristicnode then
--			DicePoolManager.addCharacteristicDice(characteristicnode, dice);
--		end
--	end






	local msgidentity = DB.getValue(initskillnode, "...name", "");
	DicePoolManager.addSkillDice(initskillnode, dice);
	if table.getn(dice) > 0 then
		if initskillnode.getChild("name") then
			skilldescription = initskillnode.getChild("name").getValue() .. " [INIT]";
		end
		local actornode = window.getDatabaseNode();
		DieBoxGenManager.addSkillDice(skilldescription, dice, initskillnode, msgidentity, actornode,"clear");

	end
end
