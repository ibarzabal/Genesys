--
-- Please see the license.html file included with this distribution for
-- attribution and copyright information.
--

function onInit()
	update();
end

function VisDataCleared()
	update();
end

function InvisDataAdded()
	update();
end

function updateControl(sControl, bReadOnly, bID)
	if not self[sControl] then
		return false;
	end

	if not bID then
		return self[sControl].update(bReadOnly, true);
	end

	return self[sControl].update(bReadOnly);
end

function update()

	local nodeRecord = getDatabaseNode();
	local bReadOnly = WindowManager.getReadOnlyState(nodeRecord);
	local bID = true; --LibraryData.getIDState("item_attachment", nodeRecord);
	updateControl("type", bReadOnly, bID);
	updateControl("control_skill", bReadOnly, bID);
	updateControl("compliment", bReadOnly, bID);
	updateControl("passenger_capacity", bReadOnly, bID);
	updateControl("cost", bReadOnly, bID);
	updateControl("rarity", bReadOnly, bID);
	updateControl("encumbrance_capacity", bReadOnly, bID);
	updateControl("encumbrance_capacity_notes", bReadOnly, bID);
	updateControl("consumables", bReadOnly, bID);
	updateControl("hard_points", bReadOnly, bID);
	updateControl("notes", bReadOnly, bID);
	updateControl("setting", bReadOnly, bID);
	updateControl("source", bReadOnly, bID);
	updateControl("source_page", bReadOnly, bID);
  main_statblock1_silhouette.setReadOnly(bReadOnly);
	main_statblock1_speed.setReadOnly(bReadOnly);
	main_statblock1_handling.setReadOnly(bReadOnly);
	vehicle_defense.setReadOnly(bReadOnly);
	vehicle_armor.setReadOnly(bReadOnly);
	hull_trauma_threshold.setReadOnly(bReadOnly);
	hull_trauma_current.setReadOnly(bReadOnly);
	system_strain_threshold.setReadOnly(bReadOnly);
	system_strain_current.setReadOnly(bReadOnly);

	if bReadOnly then
		attachments_iedit.setVisible(false);
		attachments_iadd.setVisible(false);
		weapons_iedit.setVisible(false);
		weapons_iadd.setVisible(false);
		if critical_damage_iedit then
			critical_damage_iedit.setVisible(false);
			critical_damage_iadd.setVisible(false);
		end
	else
		attachments_iedit.setVisible(true);
		attachments_iadd.setVisible(true);
		weapons_iedit.setVisible(true);
		weapons_iadd.setVisible(true);
		if critical_damage_iedit then
			critical_damage_iedit.setVisible(true);
			critical_damage_iadd.setVisible(true);
		end
	end

	if OptionsManager.isOption("VHPT", "off") then
		hard_points_label.setVisible(false);
		hard_points.setVisible(false);
	end

	if OptionsManager.isOption("VATT", "off") then
		attachments_iedit.setVisible(false);
		attachments_iadd.setVisible(false);
		attachments_header.setVisible(false);
		attachments_iadd.setVisible(false);
		attachments.setVisible(false);
	end
end




function onDrop(x, y, draginfo)
	local sType; --type.getValue();
--	local bWeapon = (sType == "Weapon");
--	local bArmor = (sType == "Armor");
	if draginfo.isType("shortcut") then
		local sClass, sRecord = draginfo.getShortcutData();
		if StringManager.contains({"reference_item_attachment"}, sClass) then
			if User.isHost() or getDatabaseNode().isOwner() then
				sType = "vehicle"; --type.getValue();
				addAttachment(getDatabaseNode(), sClass, sRecord, sType);
			end
			return true;
		end

		if StringManager.contains({"item"}, sClass) then
			if User.isHost() or getDatabaseNode().isOwner() then
				addWeapon(getDatabaseNode(), sClass, sRecord);
			end
			return true;
		end



	end
	-- return CharManager.onDrop(getDatabaseNode(), x, y, draginfo);
end




function addAttachment(nodeItem, sClass, sRecord, sType)
	local attachment_desc = DB.getValue(nodeSource, "name", "");
	local sFormat = Interface.getString("char_message_attachmentadd");
	local sMsg = string.format(sFormat, attachment_desc, DB.getValue(nodeItem, "name", ""));
	local recordnode = DB.findNode(sRecord);
	local AttachmentType = DB.getValue(recordnode,"equipment_type","");
	local newitemnode;

	if sType:lower() == AttachmentType:lower() then
		-- get the new item attachment
		newitemnode = nodeItem.createChild("attachments").createChild();
		DBManagerGenesys.copyNode(recordnode, newitemnode);
	else
		ChatManager.SystemMessage(Interface.getString("char_message_attachmentmismatch"));
	end
	return true;
end




function addWeapon(nodeItem, sClass, sRecord)
	local item_desc = DB.getValue(nodeSource, "name", "");
--	local sFormat = Interface.getString("char_message_attachmentadd");
--	local sMsg = string.format(sFormat, item_desc, DB.getValue(nodeItem, "name", ""));
	local recordnode = DB.findNode(sRecord);
	local ItemType = DB.getValue(recordnode,"type","");
	local newitemnode;

	if (ItemType:lower() == "weapon" or ItemType:lower() == "vehicle weapon") then
		-- get the new item attachment
		newitemnode = nodeItem.createChild("weapons").createChild();
		DBManagerGenesys.copyNode(recordnode, newitemnode);
	else
		ChatManager.SystemMessage(Interface.getString("char_message_vehicle_weapon_mismatch"));
	end
	return true;
end
