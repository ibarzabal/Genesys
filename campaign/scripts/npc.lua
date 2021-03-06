--
-- Please see the license.html file included with this distribution for
-- attribution and copyright information.
--


--function onDrop(x, y, draginfo)
--	return NPCManagerGenesys.onDrop(getDatabaseNode(), x, y, draginfo);
--end

function onDrop(x, y, draginfo)
	if draginfo.isType("shortcut") then
		local sClass, sRecord = draginfo.getShortcutData();
		if StringManager.contains({"referencecareer", "referencespecies_archetype"}, sClass) then
			CharManager.addInfoDB(getDatabaseNode(), sClass, sRecord);
			return true;
		end
		if StringManager.contains({"vehicle"}, sClass) then
			addVehicle(getDatabaseNode(), sClass, sRecord)
			return true;
		end

		if StringManager.contains({"item"}, sClass) then
			ItemManager.handleAnyDrop(getDatabaseNode(), draginfo);
			return true;
		end
	end

	return CharManager.onDrop(getDatabaseNode(), x, y, draginfo);
end


function addVehicle(nodeChar, sClass, sRecord)
--	local attachment_desc = DB.getValue(nodeSource, "name", "");
--	local sFormat = Interface.getString("char_message_attachmentadd");
--	local sMsg = string.format(sFormat, attachment_desc, DB.getValue(nodeItem, "name", ""));
	local recordnode = DB.findNode(sRecord);
	-- local AttachmentType = DB.getValue(recordnode,"equipment_type","");
	local newitemnode;


	newitemnode = nodeChar.createChild("vehicleslist").createChild();
	DBManagerGenesys.copyNode(recordnode, newitemnode);
	return true;

end


-- function onInit()
-- 	TypeChanged();
-- 	onLockChanged();
-- 	onIDChanged();
-- end
--
-- function TypeChanged()
-- 	local sType = DB.getValue(getDatabaseNode(), "npctype", "");
--
-- 	if sType == "Trap" then
-- 		tabs.setTab(1, "main_trap", "tab_main");
-- 	elseif sType == "Vehicle" then
-- 		tabs.setTab(1, "main_vehicle", "tab_main");
-- 	else
-- 		tabs.setTab(1, "main_creature", "tab_main");
-- 	end
-- end
--
-- function onLockChanged()
-- 	StateChanged();
-- end
--
-- function StateChanged()
-- 	if header.subwindow then
-- 		header.subwindow.update();
-- 	end
-- 	if main_trap.subwindow then
-- 		main_trap.subwindow.update();
-- 	end
-- 	if main_vehicle.subwindow then
-- 		main_vehicle.subwindow.update();
-- 	end
-- 	if main_creature.subwindow then
-- 		main_creature.subwindow.update();
-- 	end
-- 	if spells.subwindow then
-- 		spells.subwindow.update();
-- 	end
--
-- 	local bReadOnly = WindowManager.getReadOnlyState(getDatabaseNode());
--
-- 	npctype.setReadOnly(bReadOnly);
-- 	text.setReadOnly(bReadOnly);
-- end
--
-- function onIDChanged()
-- 	onNameUpdated();
-- 	if header.subwindow then
-- 		header.subwindow.updateIDState();
-- 	end
-- 	if User.isHost() then
-- 		if main_trap.subwindow then
-- 			main_trap.subwindow.update();
-- 		end
-- 		if main_vehicle.subwindow then
-- 			main_vehicle.subwindow.update();
-- 		end
-- 		if main_creature.subwindow then
-- 			main_creature.subwindow.update();
-- 		end
-- 	else
-- 		local bID = LibraryData.getIDState("npc", getDatabaseNode(), true);
-- 		tabs.setVisibility(bID);
-- 		npctype.setVisible(bID);
-- 	end
-- end
--
-- function onNameUpdated()
-- 	local nodeRecord = getDatabaseNode();
-- 	local bID = LibraryData.getIDState("npc", nodeRecord, true);
--
-- 	local sTooltip = "";
-- 	if bID then
-- 		sTooltip = DB.getValue(nodeRecord, "name", "");
-- 		if sTooltip == "" then
-- 			sTooltip = Interface.getString("library_recordtype_empty_npc")
-- 		end
-- 	else
-- 		sTooltip = DB.getValue(nodeRecord, "nonid_name", "");
-- 		if sTooltip == "" then
-- 			sTooltip = Interface.getString("library_recordtype_empty_nonid_npc")
-- 		end
-- 	end
-- 	setTooltipText(sTooltip);
-- end
--
