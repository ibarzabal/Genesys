local dragging = false;
local dicewidget = nil;

function onInit()
	super.onInit();
	setHoverCursor("hand");
	dicewidget = addBitmapWidget("textentry_die");
	dicewidget.setPosition("bottomleft", 0, -4);

	if label then
		labelwidget = addTextWidget("sheetlabelinline", label[1]);
		local w,h = labelwidget.getSize();
		labelwidget.setPosition("bottomleft", w/2+1, h/2);
	end




end

-- Genesys - for now dragging genesys dice is causing too many issues with FGU and FGC
-- disabling drag, players should double click instead
--function onDragStart(button, x, y, draginfo)
--	dragging = false;
--	return onDrag(button, x, y, draginfo);
--end
--
--function onDrag(button, x, y, draginfo)
--	if not dragging then
--		local sourcenode = getDatabaseNode();
--		if sourcenode then
--			local sourcename = sourcenode.getNodeName();
--			-- build the description
--			local description = "";
--			    if string.find("agility",sourcename, 1, true) then
--				description = "Agility";
--			elseif string.find("willpower",sourcename, 1, true) then
--				description = "Willpower";
--			elseif string.find("brawn",sourcename, 1, true) then
--				description = "Brawn";
--			elseif string.find("intellect",sourcename, 1, true) then
--				description = "Intellect";
--			elseif string.find("cunning",sourcename, 1, true) then
--				description = "Cunning";
--			elseif string.find("presence",sourcename, 1, true) then
--				description = "Presence";
--			end
--
--
--			-- build the dice pool
--			local dice = {};
--			DicePoolManager.addCharacteristicDice(sourcenode, dice);
--			-- complete the drag information
--			if table.getn(dice) > 0 then
--				draginfo.setType("characteristic");
--				draginfo.setDescription(description);
--				draginfo.setDieList(dice);
--				draginfo.setDatabaseNode(sourcenode);
--				dragging = true;
--				return true;
--			end
--		end
--	end
--	return false;
--end
--
--function onDragEnd(draginfo)
--	dragging = false;
--end

-- Allows population of the dice pool by a double-click on the dice button by the skill
function onDoubleClick()
	--local sourcenode = window.getDatabaseNode();
	local sourcenode = getDatabaseNode();
	--Debug.console("Characteristic roll databasenode = " .. sourcenode.getNodeName());

	if sourcenode then
		local sourcename = sourcenode.getNodeName();

		local description = "";

		-- build the description
		local description = "";
		if string.find(sourcename, "agility", 1, true) then
			description = "agility";
		elseif string.find(sourcename, "willpower", 1, true) then
			description = "willpower";
		elseif string.find(sourcename, "brawn", 1, true) then
			description = "brawn";
		elseif string.find(sourcename, "intellect", 1, true) then
			description = "intellect";
		elseif string.find(sourcename, "cunning", 1, true) then
			description = "cunning";
		elseif string.find(sourcename, "presence", 1, true) then
			description = "presence";
		end

		local dice = {};
		local msgidentity = DB.getValue(sourcenode, "..name", "");
		DicePoolManager.addCharacteristicDice(sourcenode, dice);
		if table.getn(dice) > 0 then
			DieBoxManager.addCharacteristicDice(description, dice, sourcenode, msgidentity);
		end
	end
end
