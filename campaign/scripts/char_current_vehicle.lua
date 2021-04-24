--
-- Please see the license.html file included with this distribution for
-- attribution and copyright information.
--

function onInit()
	onLinkChanged();
end


function onClose()
	local node = getDatabaseNode();
	local current_vehicle, current_vehicle_node = DBManagerGenesys.ActorVehicle(node);
	DB.removeHandler(DB.getPath(current_vehicle_node) .. ".*", "onChildAdded", onListsUpdated);
	DB.removeHandler(DB.getPath(current_vehicle_node) .. ".*", "onChildDeleted", onListsUpdated);
	DB.removeHandler(DB.getPath(current_vehicle_node) .. ".*", "onChildUpdate", onListsUpdated);
end

function onListsUpdated()
	local node = getDatabaseNode();
	local current_vehicle, current_vehicle_node = DBManagerGenesys.ActorVehicle(node);
	if current_vehicle_node and current_vehicle ~=""  then
		linkPCFields(current_vehicle_node);
	end
end

function onLinkChanged()
	local node = getDatabaseNode();
	local current_vehicle, current_vehicle_node = DBManagerGenesys.ActorVehicle(node);

	onClose(); -- If there are handlers from a previous vehicle, remove...
	if current_vehicle_node  and current_vehicle ~="" then
		parentcontrol.window.contents.setVisible(true);
		linkPCFields(current_vehicle_node);
		DB.addHandler(DB.getPath(current_vehicle_node) .. ".*", "onChildAdded", onListsUpdated);
		DB.addHandler(DB.getPath(current_vehicle_node) .. ".*", "onChildDeleted", onListsUpdated);
		DB.addHandler(DB.getPath(current_vehicle_node) .. ".*", "onChildUpdate", onListsUpdated);
	else
		parentcontrol.window.contents.setVisible(false);
	end
end

function updateControl(sControl, bReadOnly, bID)
	if not self[sControl] then
		return false;
	end

	if not bID then
		return self[sControl].update(bReadOnly, true);
	end

	local sLabel = self[sControl].getName() .. "_label";
	if bReadOnly and self[sControl].isEmpty() then
		self[sLabel].setVisible(false);
		if sControl == "control_skill" then
			self["control_skill_dice"].setVisible(false);
		end
	else
		self[sLabel].setVisible(true);
		if sControl == "control_skill" then
			self["control_skill_dice"].setVisible(true);
		end
	end

	return self[sControl].update(bReadOnly);
end


function linkPCFields(nodeVehicle)
--	local nodeRecord = getDatabaseNode();
	local bReadOnly = true; -- WindowManager.getReadOnlyState(nodeRecord);
	local bID = true; --LibraryData.getIDState("item_attachment", nodeRecord);

	local current_vehicle_owner_node = nodeVehicle.getParent().getParent();


  main_statblock1_silhouette.setLink(nodeVehicle.createChild("silhouette","number"));
  main_statblock1_speed.setLink(nodeVehicle.createChild("speed.max","number"));
  main_statblock1_handling.setLink(nodeVehicle.createChild("handling","number"));

	vehicle_defense.setLink(nodeVehicle.createChild("defense","number"));
	vehicle_armor.setLink(nodeVehicle.createChild("armor","number"));
	hull_trauma_threshold.setLink(nodeVehicle.createChild("hull_trauma.threshold","number"));
	hull_trauma_current_link.setLink(nodeVehicle.createChild("hull_trauma.current","number"));
	system_strain_threshold.setLink(nodeVehicle.createChild("system_strain.threshold","number"));
	system_strain_current_link.setLink(nodeVehicle.createChild("system_strain.current","number"));

	owner.setLink(current_vehicle_owner_node.createChild("name","string"));
	name.setLink(nodeVehicle.createChild("name","string"));
	type.setLink(nodeVehicle.createChild("type","string"));

	control_skill.setLink(nodeVehicle.createChild("control_skill","string"));
	compliment.setLink(nodeVehicle.createChild("compliment","string"));
	passenger_capacity.setLink(nodeVehicle.createChild("passenger_capacity","string"));
	encumbrance_capacity.setLink(nodeVehicle.createChild("encumbrance_capacity","number"));
	encumbrance_capacity_notes.setLink(nodeVehicle.createChild("encumbrance_capacity_notes","string"));
	consumables.setLink(nodeVehicle.createChild("consumables","string"));
	hard_points.setLink(nodeVehicle.createChild("hard_points","number"));
	notes.setLink(nodeVehicle.createChild("notes","string"));

	if getDatabaseNode() then
		local temp_node = getDatabaseNode().createChild("temp_vehicle");
		local temp_w_node = temp_node.createChild("weapons");
		local temp_a_node = temp_node.createChild("attachments");
		local temp_c_node = temp_node.createChild("critical_damage");
		local weaponsnode = DB.getChild(nodeVehicle,"weapons");
		local attachmentsnode = DB.getChild(nodeVehicle,"attachments");
		local criticalsnode = DB.getChild(nodeVehicle,"critical_damage");

		if temp_w_node then
			DB.deleteChildren(DB.getPath(temp_w_node));
		end
		if temp_a_node then
			DB.deleteChildren(DB.getPath(temp_a_node));
		end
		if temp_c_node then
			DB.deleteChildren(DB.getPath(temp_c_node));
		end

		if weaponsnode and temp_w_node then
			DBManagerGenesys.copyNode(weaponsnode, temp_w_node);
		end
		if attachmentsnode and temp_a_node then
			DBManagerGenesys.copyNode(attachmentsnode, temp_a_node);
		end
		if criticalsnode and temp_c_node then
			DBManagerGenesys.copyNode(criticalsnode, temp_c_node);
		end
	end

end
