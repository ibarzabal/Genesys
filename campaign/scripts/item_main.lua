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

--function onDrop(x, y, draginfo)
--	return ItemManager.handleAnyDrop(getDatabaseNode(), draginfo);
--end



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
	local bID = LibraryData.getIDState("item", nodeRecord);

	local sType = type.getValue();
	local bWeapon = (sType == "Weapon");
	local bVehicleWeapon = (sType == "Vehicle Weapon");
	if bVehicleWeapon then
		bWeapon = true;
	end
	local bArmor = (sType == "Armor");
	local bGear = (sType == "Gear");

	local bSection1 = false;
	if User.isHost() then
		if updateControl("nonid_name", bReadOnly, true) then bSection1 = true; end;
	else
		updateControl("nonid_name", false);
	end
	if (User.isHost() or not bID) then
		if updateControl("nonidentified", bReadOnly, true) then bSection1 = true; end;
	else
		updateControl("nonidentified", false);
	end

	local bSection2 = false;
	if updateControl("type", bReadOnly, bID) then bSection2 = true; end
	if updateControl("subtype", bReadOnly, bID) then bSection2 = true; end

	local bSection3 = false;
	if updateControl("cost", bReadOnly, bID) then bSection3 = true; end
	if updateControl("encumbrance", bReadOnly, bID) then bSection3 = true; end
	if updateControl("hard_points", bReadOnly, bID) then bSection3 = true; end
	if updateControl("rarity", bReadOnly, bID) then bSection3 = true; end
	if updateControl("special", bReadOnly, bID) then bSection3 = true; end

	local bSection4 = false;
	if updateControl("skill", bReadOnly, bID and bWeapon) then bSection4 = true; end
	if updateControl("fire_arc", bReadOnly, bID and bVehicleWeapon) then bSection4 = true; end
	if updateControl("damage", bReadOnly, bID and bWeapon) then bSection4 = true; end
--	if updateControl("damagetype", bReadOnly, bID and bWeapon) then bSection4 = true; end
	if updateControl("critical", bReadOnly, bID and bWeapon) then bSection4 = true; end
	if updateControl("range", bReadOnly, bID and bWeapon) then bSection4 = true; end

	if updateControl("defense", bReadOnly, bID and bArmor) then bSection4 = true; end
	if updateControl("soak", bReadOnly, bID and bArmor) then bSection4 = true; end

	updateControl("description", bReadOnly, bID);
	updateControl("setting", bReadOnly, bID);
	updateControl("attachments", bReadOnly, bID);


	local bSection6 = bID;
	description.setVisible(bID);
	description.setReadOnly(bReadOnly);

	divider.setVisible(bSection1 and bSection2);
	divider2.setVisible((bSection1 or bSection2) and bSection3);
	divider3.setVisible((bSection1 or bSection2 or bSection3) and bSection4);
	divider4.setVisible((bSection1 or bSection2 or bSection3 or bSection4));
	-- Make hard points only visible for weapons and armor

	if (bWeapon or bArmor) or (bGear and OptionsManager.isOption("GATT", "on")) then
		hard_points_label.setVisible(true);
		hard_points.setVisible(true);
		attachments_header.setVisible(true);
		attachments_iedit.setVisible(true);
		attachments.setVisible(true);
	else
		hard_points_label.setVisible(false);
		hard_points.setVisible(false);
		attachments_header.setVisible(false);
		attachments_iedit.setVisible(false);
		attachments.setVisible(false);
	end
	if bReadOnly then
		attachments_iedit.setVisible(false);
	end
--	divider5.setVisible((bSection1 or bSection2 or bSection3 or bSection4) and bSection6);
end



function onDrop(x, y, draginfo)
	local sType = type.getValue();
--	local bWeapon = (sType == "Weapon");
--	local bArmor = (sType == "Armor");
	if draginfo.isType("shortcut") then
		local sClass, sRecord = draginfo.getShortcutData();
		if StringManager.contains({"reference_item_attachment"}, sClass) then
			if User.isHost() or getDatabaseNode().isOwner() then
				addAttachment(getDatabaseNode(), sClass, sRecord, sType);
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
