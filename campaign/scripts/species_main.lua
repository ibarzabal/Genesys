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


	updateControl("wound_threshold", bReadOnly, bID);
	updateControl("strain_threshold", bReadOnly, bID);
	updateControl("starting_xp", bReadOnly, bID);
  updateControl("description", bReadOnly, bID);
	if User.getRulesetName() == "StarWarsFFG" then
		setting.setVisible(false);
		setting_label.setVisible(false);
	else
	  updateControl("setting", bReadOnly, bID);
	end
	updateControl("source", bReadOnly, bID);
	updateControl("source_page", bReadOnly, bID);
  main_statblock1_brawn_current.setReadOnly(bReadOnly);
  main_statblock1_agility_current.setReadOnly(bReadOnly);
  main_statblock1_intellect_current.setReadOnly(bReadOnly);
  main_statblock1_cunning_current.setReadOnly(bReadOnly);
  main_statblock1_willpower_current.setReadOnly(bReadOnly);
  main_statblock1_presence_current.setReadOnly(bReadOnly);

	if bReadOnly then
		abilities_iedit.setVisible(false);
		abilities_iadd.setVisible(false);
	else
		abilities_iedit.setVisible(true);
		abilities_iadd.setVisible(false);
	end



end


function onDrop(x, y, draginfo)
--	local bWeapon = (sType == "Weapon");
--	local bArmor = (sType == "Armor");
	if draginfo.isType("shortcut") then
		local sClass, sRecord = draginfo.getShortcutData();
		if StringManager.contains({"referenceracialtrait"}, sClass) then
			if User.isHost() or getDatabaseNode().isOwner() then
				addAbilities(getDatabaseNode(), sClass, sRecord);
			end
			return true;
		end
	end
	-- return CharManager.onDrop(getDatabaseNode(), x, y, draginfo);
end




function addAbilities(nodeItem, sClass, sRecord)
	local attachment_desc = DB.getValue(nodeSource, "name", "");
	local sFormat = Interface.getString("char_message_abilityadd");
	local sMsg = string.format(sFormat, attachment_desc, DB.getValue(nodeItem, "name", ""));
	local recordnode = DB.findNode(sRecord);
	local newitemnode;

	-- get the new ability
	newitemnode = nodeItem.createChild("abilities").createChild();
	DBManagerGenesys.copyNode(recordnode, newitemnode);

	return true;

end
