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
	local bID = true;

  updateControl("description", bReadOnly, bID);
	updateControl("source", bReadOnly, bID);
	updateControl("source_page", bReadOnly, bID);

end


function onDrop(x, y, draginfo)
--	local sType = type.getValue();
--	local bWeapon = (sType == "Weapon");
--	local bArmor = (sType == "Armor");
	if draginfo.isType("shortcut") then
		local sClass, sRecord = draginfo.getShortcutData();
		if StringManager.contains({"referenceskill"}, sClass) then
			if User.isHost() or getDatabaseNode().isOwner() then
				addSkill(getDatabaseNode(), sClass, sRecord);
--				DBManagerGenesys.addSkillReference(getDatabaseNode(), sRecord)
			end
			return true;
		end
	end
	-- return CharManager.onDrop(getDatabaseNode(), x, y, draginfo);
end



function addSkill(nodeSetting, sClass, sRecord, sType)
--	local attachment_desc = DB.getValue(nodeSource, "name", "");
--	local sFormat = Interface.getString("char_message_attachmentadd");
--	local sMsg = string.format(sFormat, attachment_desc, DB.getValue(nodeItem, "name", ""));
	local recordnode = DB.findNode(sRecord);
--	local AttachmentType = DB.getValue(recordnode,"equipment_type","");
	local newskillnode;

	if recordnode then
		newskillnode = nodeSetting.createChild("skills").createChild();
		DB.setValue(newskillnode, "name", "string", DB.getValue(recordnode, "name", ""));
		DB.setValue(newskillnode, "characteristic", "string", DB.getValue(recordnode, "characteristic", ""));
		DB.setValue(newskillnode, "category", "string", DB.getValue(recordnode, "category", ""));
		--DBManagerGenesys.copyNode(recordnode, newskillnode);
--	else
--		ChatManager.SystemMessage(Interface.getString("char_message_attachmentmismatch"));
	end
	return true;
end



function addSkill1(nodeChar, sClass, sRecord)
	local nodeSource = DB.findNode(sRecord);
  if not nodeSource then
		return;
	end

	local sspecies_archetype = DB.getValue(nodeSource, "name", "");

	local sFormat = Interface.getString("char_message_species_archetypeadd");
	local sMsg = string.format(sFormat, sspecies_archetype, DB.getValue(nodeChar, "name", ""));
	ChatManager.SystemMessage(sMsg);

	DB.setValue(nodeChar, "species_archetype", "string", sspecies_archetype);
	DB.setValue(nodeChar, "species_archetypelink", "windowreference", sClass, nodeSource.getNodeName());
end


function addSkillReference(nodeSetting, nodeSource)
	if not nodeSource or not nodeSetting then
		return;
	end

	local sName = StringManager.trim(DB.getValue(nodeSource, "name", ""));
	if sName == "" then
		return;
	end

	local wSkill = nil;
--	for _,w in pairs(getWindows()) do
--		if StringManager.trim(w.name.getValue()) == sName then
--			wSkill = w;
--			break;
--		end
--	end
--	if not wSkill then
		wSkill = nodeSetting.createChild("skilllist").createChild();
--		local sStat = DB.getValue(nodeSource, "stat", "");
--		local nMod  = DB.getValue(nodeSource, "adj_mod", 0);
--		local nBase = DB.getValue(nodeSource, "base_check", 0);
		wSkill.name.setValue(sName);
--		DB.setValue(wSkill.getDatabaseNode(), "base_check", "number", nBase);
--		DB.setValue(wSkill.getDatabaseNode(), "adj_mod", "number", nMod);
--		DB.setValue(wSkill.getDatabaseNode(), "stat", "string", sStat);
--		DB.setValue(wSkill.getDatabaseNode(), "text", "formattedtext", DB.getValue(nodeSource, "text", ""));
--	else
--		DB.setValue(wSkill.getDatabaseNode(), "text", "formattedtext", DB.getValue(nodeSource, "text", ""));
--	end
end
