--
-- Please see the license.html file included with this distribution for
-- attribution and copyright information.
--

iscustom = true;
sets = {};

function onInit()
	updateMenu();

--	onCheckPenaltyChange();
--	onStatUpdate();
end

function updateWindow()
	local sLabel = name.getValue();
	local t = DataCommon.skilldata[sLabel];
	if t then
		setCustom(false);
	else
		setCustom(true);
	end
end

function onSystemChanged(bPFMode)
	total.onSourceUpdate();
end

function onMenuSelection(selection, subselection)
	if selection == 6 and subselection == 7 then
		local node = getDatabaseNode();
		if node then
			node.delete();
		else
			close();
		end
	end
end

-- function onCheckPenaltyChange()
-- 	if armorcheckmultiplier.getValue() ~= 0 then
-- 		armorwidget.setIcon("char_armorcheck");
-- 	else
-- 		armorwidget.setIcon(nil);
-- 	end
-- end

--function onStatUpdate()
--	Debug.chat("char_skill.onStatUpdate executed");
----	stat.update(characteristic.getStringValue());
--end

-- This function is called to set the entry to non-custom or custom.
-- Custom entries have configurable stats and editable labels.
function setCustom(state)
	iscustom = state;

	if iscustom then
		name.setEnabled(true);
		name.setLine(true);
		characteristic.setEnabled(true);
		characteristic.setLine(true);
		category.setEnabled(true);
		category.setLine(true);

	else
		name.setEnabled(false);
		name.setLine(false);
		characteristic.setEnabled(false);
		category.setEnabled(false);
		category.setLine(false);
		characteristic.setLine(false);
		category.setEnabled(false);
		category.setLine(false);

	end

	updateMenu();
end

function isCustom()
	return iscustom;
end

function updateMenu()
	resetMenuItems();

	if iscustom then
		registerMenuItem(Interface.getString("list_menu_deleteitem"), "delete", 6);
		registerMenuItem(Interface.getString("list_menu_deleteconfirm"), "delete", 6, 7);
	else
		local sLabel = name.getValue();
		local rSkill = DataCommon.skilldata[sLabel];
		if rSkill and rSkill.sublabeling then
			registerMenuItem(Interface.getString("list_menu_deleteitem"), "delete", 6);
			registerMenuItem(Interface.getString("list_menu_deleteconfirm"), "delete", 6, 7);
		end
	end
end
