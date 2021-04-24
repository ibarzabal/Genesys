--
-- Please see the license.html file included with this distribution for
-- attribution and copyright information.
--

function onInit()
	-- Register the deletion menu item for the host
	registerMenuItem(Interface.getString("list_menu_deleteitem"), "delete", 6);
	registerMenuItem(Interface.getString("list_menu_deleteconfirm"), "delete", 6, 7);

	-- Set the displays to what should be shown
	setTargetingVisible();
	setCharacteristicsVisible();
	setVehicleVisible();
	setActiveVisible();
	setSpacingVisible();
	setEffectsVisible();

	-- Acquire token reference, if any
	linkToken();

	-- Set up the PC links
	onLinkChanged();
	onFactionChanged();
	onHealthChanged();

	-- Register the deletion menu item for the host
	registerMenuItem(Interface.getString("list_menu_deleteitem"), "delete", 6);
	registerMenuItem(Interface.getString("list_menu_deleteconfirm"), "delete", 6, 7);
end

function updateDisplay()
	local sFaction = friendfoe.getStringValue();

	if DB.getValue(getDatabaseNode(), "active", 0) == 1 then
		name.setFont("sheetlabel");
		nonid_name.setFont("sheetlabel");

		active_spacer_top.setVisible(true);
		active_spacer_bottom.setVisible(true);

		if sFaction == "friend" then
			setFrame("ctentrybox_friend_active");
		elseif sFaction == "neutral" then
			setFrame("ctentrybox_neutral_active");
		elseif sFaction == "foe" then
			setFrame("ctentrybox_foe_active");
		else
			setFrame("ctentrybox_active");
		end
	else
		name.setFont("sheettext");
		nonid_name.setFont("sheettext");

		active_spacer_top.setVisible(false);
		active_spacer_bottom.setVisible(false);

		if sFaction == "friend" then
			setFrame("ctentrybox_friend");
		elseif sFaction == "neutral" then
			setFrame("ctentrybox_neutral");
		elseif sFaction == "foe" then
			setFrame("ctentrybox_foe");
		else
			setFrame("ctentrybox");
		end
	end
end

function linkToken()
	local imageinstance = token.populateFromImageNode(tokenrefnode.getValue(), tokenrefid.getValue());
	if imageinstance then
		TokenManager.linkToken(getDatabaseNode(), imageinstance);
	end
end

function onMenuSelection(selection, subselection)
	if selection == 6 and subselection == 7 then
		delete();
	end
end

function delete()
	local node = getDatabaseNode();
	if not node then
		close();
		return;
	end

	-- Remember node name
	local sNode = node.getPath();

	-- Clear any effects and wounds first, so that rolls aren't triggered when initiative advanced
	effects.reset(false);

	-- Move to the next actor, if this CT entry is active
	if DB.getValue(node, "active", 0) == 1 then
		CombatManager.nextActor();
	end

	-- Delete the database node and close the window
	local cList = windowlist;
	node.delete();

	-- Update list information (global subsection toggles)
	cList.onVisibilityToggle();
	cList.onEntrySectionToggle();
end

function onLinkChanged()
	-- If a PC, then set up the links to the char sheet
	local sClass, sRecord = link.getValue();
--	if sClass == "charsheet" then
		linkPCFields();
		name.setLine(false);
--	end
	onIDChanged();
end

function onHealthChanged()
	local rActor = ActorManager.resolveActor(getDatabaseNode());
	local _,sStatus,sColor = ActorHealthManager.getHealthInfo(rActor);
	--GENESYS: for now I will skip this, I will see if I make something useful out of it later
	return true;
--[[	wounds.setColor(sColor);
	status.setValue(sStatus);

	local sClass,_ = link.getValue();
	if sClass ~= "charsheet" then
		idelete.setVisibility((sStatus == ActorHealthManager.STATUS_DYING) or (sStatus == ActorHealthManager.STATUS_DEAD));
	end
	]]
end


function onIDChanged()
	local nodeRecord = getDatabaseNode();
	local sClass = DB.getValue(nodeRecord, "link", "", "");
	if sClass == "npc" then
		local bID = LibraryData.getIDState("npc", nodeRecord, true);
		name.setVisible(bID);
		nonid_name.setVisible(not bID);
		isidentified.setVisible(true);
	else
		name.setVisible(true);
		nonid_name.setVisible(false);
		isidentified.setVisible(false);
	end
end

function onFactionChanged()
	-- Update the entry frame
	updateDisplay();

	-- If not a friend, then show visibility toggle
	if friendfoe.getStringValue() == "friend" then
		tokenvis.setVisible(false);
	else
		tokenvis.setVisible(true);
	end
end

function onVisibilityChanged()
	TokenManager.updateVisibility(getDatabaseNode());
	windowlist.onVisibilityToggle();
end

function onActiveChanged()
	setActiveVisible();
end

function linkPCFields()
	local nodeChar = link.getTargetDatabaseNode();
	if nodeChar then
		--local bNPC = (sClass ~= "charsheet");
		name.setLink(nodeChar.createChild("name", "string"), true);
		name.setReadOnly(true);
		wounds_threshold.setLink(nodeChar.createChild("wounds.threshold", "number"), true);
		wounds_current.setLink(nodeChar.createChild("wounds.current", "number"));
		strain_threshold.setLink(nodeChar.createChild("strain.threshold", "number"), true);
		strain_current.setLink(nodeChar.createChild("strain.current", "number"));
		meleedefence.setLink(nodeChar.createChild("armour.meleedefence", "number"), true);
		rangeddefence.setLink(nodeChar.createChild("armour.rangeddefence", "number"), true);
		soak.setLink(nodeChar.createChild("armour.soak", "number"), true);
		--npc_category.setLink(nodeChar.createChild("npc_category", "string"), true);

		brawn.setLink(nodeChar.createChild("brawn.current", "number"), true);
		agility.setLink(nodeChar.createChild("agility.current", "number"), true);
		intellect.setLink(nodeChar.createChild("intellect.current", "number"), true);
		cunning.setLink(nodeChar.createChild("cunning.current", "number"), true);
		willpower.setLink(nodeChar.createChild("willpower.current", "number"), true);
		presence.setLink(nodeChar.createChild("presence.current", "number"), true);


		vehicle_name.setLink(nodeChar.createChild("temp_vehicle.name", "string"), true);
  	vehicle_current_node.setLink(nodeChar.createChild("vehicle_current", "string"), true);
		vehicle_owner.setLink(nodeChar.createChild("temp_vehicle.owner", "string"), true);

		control_skill_name.setLink(nodeChar.createChild("temp_vehicle.control_skill", "string"), true);
		v_hull_trauma_threshold.setLink(nodeChar.createChild("temp_vehicle.hull_trauma.threshold", "number"), true);
		v_hull_trauma_current.setLink(nodeChar.createChild("temp_vehicle.hull_trauma.current", "number"), false);
		v_system_strain_threshold.setLink(nodeChar.createChild("temp_vehicle.system_strain.threshold", "number"), true);
		v_system_strain_current.setLink(nodeChar.createChild("temp_vehicle.system_strain.current", "number"), false);
		v_armor.setLink(nodeChar.createChild("temp_vehicle.armor", "number"), true);

		local isSW = (User.getRulesetName() == "StarWarsFFG");

		if isSW then
			v_defense_fore.setLink(nodeChar.createChild("temp_vehicle.defense.fore", "string"), true);
			v_defense_port.setLink(nodeChar.createChild("temp_vehicle.defense.port", "string"), true);
			v_defense_starboard.setLink(nodeChar.createChild("temp_vehicle.defense.starboard", "string"), true);
			v_defense_aft.setLink(nodeChar.createChild("temp_vehicle.defense.aft", "string"), true);
		else
			v_defense.setLink(nodeChar.createChild("temp_vehicle.defense", "string"), true);
		end

	end
end




----------------------------------------------------------------------------
--if nodeChar then
--	name.setLink(nodeChar.createChild("name", "string"), true);
--
--	hptotal.setLink(nodeChar.createChild("hp.total", "number"));
--	hptemp.setLink(nodeChar.createChild("hp.temporary", "number"));
--	wounds.setLink(nodeChar.createChild("hp.wounds", "number"));
--	deathsavesuccess.setLink(nodeChar.createChild("hp.deathsavesuccess", "number"));
--	deathsavefail.setLink(nodeChar.createChild("hp.deathsavefail", "number"));
--
--	type.setLink(nodeChar.createChild("race", "string"));
--	size.setLink(nodeChar.createChild("size", "string"));
--	alignment.setLink(nodeChar.createChild("alignment", "string"));
--
--	strength.setLink(nodeChar.createChild("abilities.strength.score", "number"), true);
--	dexterity.setLink(nodeChar.createChild("abilities.dexterity.score", "number"), true);
--	constitution.setLink(nodeChar.createChild("abilities.constitution.score", "number"), true);
--	intelligence.setLink(nodeChar.createChild("abilities.intelligence.score", "number"), true);
--	wisdom.setLink(nodeChar.createChild("abilities.wisdom.score", "number"), true);
--	charisma.setLink(nodeChar.createChild("abilities.charisma.score", "number"), true);
--
--	init.setLink(nodeChar.createChild("initiative.total", "number"), true);
--	ac.setLink(nodeChar.createChild("defenses.ac.total", "number"), true);
--	speed.setLink(nodeChar.createChild("speed.total", "number"), true);
--end
------------------------------------------------------------------------------


--
-- SECTION VISIBILITY FUNCTIONS
--

function setTargetingVisible()
	local v = false;
	if activatetargeting.getValue() == 1 then
		v = true;
	end

	targetingicon.setVisible(v);

	sub_targeting.setVisible(v);

	frame_targeting.setVisible(v);

	target_summary.onTargetsChanged();
end

function setCharacteristicsVisible()
	local v = false;
	if activatecharacteristics.getValue() == 1 then
		v = true;
	end

	characteristic_icon.setVisible(v);

	brawn.setVisible(v);
	brawn_label.setVisible(v);
	agility.setVisible(v);
	agility_label.setVisible(v);
	intellect.setVisible(v);
	intellect_label.setVisible(v);
	cunning.setVisible(v);
	cunning_label.setVisible(v);
	willpower.setVisible(v);
	willpower_label.setVisible(v);
	presence.setVisible(v);
	presence_label.setVisible(v);

	spacer_characteristic.setVisible(v);

	frame_characteristics.setVisible(v);
end

-----------------------------
function setVehicleVisible()
	local v = false;
	local sClass, sRecord = link.getValue();
	local bNPC = (sClass ~= "charsheet");
	local isVehicle = (vehicle_current_node.getValue() ~= "");

	if activatevehicle.getValue() == 1 and isVehicle then
		v = true;
	end

	vehicle_icon.setVisible(v);
	vehicle_name.setVisible(v);
	vehicle_name_label.setVisible(v);

	v_hull_trauma_label.setVisible(v);
	v_hull_trauma_threshold.setVisible(v);
	v_hull_trauma_current.setVisible(v);

	v_system_strain_label.setVisible(v);
	v_system_strain_threshold.setVisible(v);
	v_system_strain_current.setVisible(v);

	v_armor_label.setVisible(v);
	v_armor.setVisible(v);

	local isSW = (User.getRulesetName() == "StarWarsFFG");
	v_defense_label.setVisible(v);

	if isSW then
		v_defense_fore.setVisible(v and isSW);
		v_defense_port.setVisible(v and isSW);
		v_defense_starboard.setVisible(v and isSW);
		v_defense_aft.setVisible(v and isSW);
	else
		v_defense.setVisible(v and not isSW);
	end
	vehicle_owner.setVisible(v and not bNPC);
	vehicle_owner_label.setVisible(v and not bNPC);
	control_skill_label.setVisible(v and bNPC);
	control_skill.setVisible(v and bNPC);
	control_skill_name.setVisible(v and bNPC);
	vehicle_weapons_header.setVisible(v and bNPC);
	vehicle_weapons.setVisible(v and bNPC);
	spacer_vehicle.setVisible(v);
	frame_vehicle.setVisible(v);
end


function setActiveVisible()
	local v = false;
	if activateactive.getValue() == 1 then
		v = true;
	end

	local sClass, sRecord = link.getValue();
	local bNPC = (sClass ~= "charsheet");
	if bNPC and active.getValue() == 1 then
		v = true;
	end

	if bNPC then
		activeicon.setVisible(v);
		combat_weapons_weapon.setVisible(v);
		combat_weapons_whatskill.setVisible(v);
		combat_weapons_damage.setVisible(v);
		combat_weapons_critical.setVisible(v);
		combat_weapons_range.setVisible(v);
		weapons.setVisible(v);
		spacer_action.setVisible(v);
		frame_active.setVisible(v);
		if active.getValue() == 1 and vehicle_current_node.getValue() ~= "" then
			vehicle_icon.setVisible(v);
			vehicle_name.setVisible(v);
			vehicle_name_label.setVisible(v);

			v_hull_trauma_label.setVisible(v);
			v_hull_trauma_threshold.setVisible(v);
			v_hull_trauma_current.setVisible(v);

			v_system_strain_label.setVisible(v);
			v_system_strain_threshold.setVisible(v);
			v_system_strain_current.setVisible(v);

			v_armor_label.setVisible(v);
			v_armor.setVisible(v);

			local isSW = (User.getRulesetName() == "StarWarsFFG");
			v_defense_label.setVisible(v);

			if isSW then
				v_defense_fore.setVisible(v and isSW);
				v_defense_port.setVisible(v and isSW);
				v_defense_starboard.setVisible(v and isSW);
				v_defense_aft.setVisible(v and isSW);
			else
				v_defense.setVisible(v and not isSW);
			end
			vehicle_owner.setVisible(v and not bNPC);
			vehicle_owner_label.setVisible(v and not bNPC);
			control_skill_label.setVisible(v and bNPC);
			control_skill.setVisible(v and bNPC);
			control_skill_name.setVisible(v and bNPC);
			vehicle_weapons_header.setVisible(v and bNPC);
			vehicle_weapons.setVisible(v and bNPC);
			spacer_vehicle.setVisible(v);
			frame_vehicle.setVisible(v);
		else
			setVehicleVisible();
		end
	else
		activeicon.setVisible(false);
		combat_weapons_weapon.setVisible(false);
		combat_weapons_whatskill.setVisible(false);
		combat_weapons_damage.setVisible(false);
		combat_weapons_critical.setVisible(false);
		combat_weapons_range.setVisible(false);
		weapons.setVisible(false);
		spacer_action.setVisible(false);
		frame_active.setVisible(false);
		setVehicleVisible();
	end
end

function setSpacingVisible()
	local v = false;
	if activatespacing.getValue() == 1 then
		v = true;
	end

	spacingicon.setVisible(v);

	space.setVisible(v);
	spacelabel.setVisible(v);
	reach.setVisible(v);
	reachlabel.setVisible(v);
	spacer_space.setVisible(v);

	frame_spacing.setVisible(v);
end

function setEffectsVisible()
	local v = false;
	if activateeffects.getValue() == 1 then
		v = true;
	end

	effecticon.setVisible(v);

	effects.setVisible(v);
	effects_iadd.setVisible(v);
	for _,w in pairs(effects.getWindows()) do
		w.idelete.setValue(0);
	end

	frame_effects.setVisible(v);

	effect_summary.onEffectsChanged();
end
