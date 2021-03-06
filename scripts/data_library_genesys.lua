function getItemIsIdentified(vRecord, vDefault)
	return LibraryData.getIDState("item", vRecord, true);
end

function getCRGroupedList(v)
	local nOutput = v or 0;
	if nOutput > 0 then
		if nOutput < 0.14 then
			nOutput = "1/8";
		elseif nOutput < 0.2 then
			nOutput = "1/6";
		elseif nOutput < 0.3 then
			nOutput = "1/4";
		elseif nOutput < 0.4 then
			nOutput = "1/3";
		elseif nOutput < 1 then
			nOutput = "1/2";
		end
	end
	return tostring(nOutput);
end

function getCRGroup(v)
	local nOutput = v or 0;
	if nOutput > 0 then
		if nOutput < 0.14 then
			nOutput = 0.125;
		elseif nOutput < 0.2 then
			nOutput = 0.166;
		elseif nOutput < 0.3 then
			nOutput = 0.25;
		elseif nOutput < 0.4 then
			nOutput = 0.33;
		elseif nOutput < 1 then
			nOutput = 0.5;
		end
	end
	return tostring(nOutput);
end

function getNPCCRValue(vNode)
	return getCRGroup(DB.getValue(vNode, "cr", 0));
end

function getTypeGroup(v)
	local sOutput = "";
	if v then
		local sCreatureType = StringManager.trim(v):lower();
		for _,sListCreatureType in ipairs(DataCommon.creaturetype) do
			if sCreatureType:match(sListCreatureType) then
				sOutput = StringManager.capitalize(sListCreatureType);
				break;
			end
		end
	end
	return sOutput;
end

function getNPCTypeValue(vNode)
	return getTypeGroup(DB.getValue(vNode, "type", ""));
end

function getItemRecordDisplayClass(vNode)
	local sRecordDisplayClass = "item";
	if vNode then
		local sBasePath, sSecondPath = UtilityManager.getDataBaseNodePathSplit(vNode);
		if sBasePath == "reference" then
			if sSecondPath == "weapon" then
				sRecordDisplayClass = "referenceweapon";
			elseif sSecondPath == "armor" then
				sRecordDisplayClass = "referencearmor";
			elseif sSecondPath == "equipment" then
				sRecordDisplayClass = "referenceequipment";
			-- added for genesys
			elseif sSecondPath == "gear" then
				sRecordDisplayClass = "referencegear";
			else
				sRecordDisplayClass = "item";
			end
		end
	end
	return sRecordDisplayClass;
end

function isItemIdentifiable(vNode)
	return (getItemRecordDisplayClass(vNode) == "item");
end

function getSpellSchoolValue(vNode)
	local v = StringManager.trim(DB.getValue(vNode, "school", ""));
	local sType = v:match("^%w+");
	if sType then
		v = StringManager.trim(sType);
	end
	v = StringManager.capitalize(v);
	return v;
end

function getSpellSourceValue(vNode)
	return StringManager.split(DB.getValue(vNode, "level", ""), ",", true);
end

function getClassTypeValue(vNode)
	local sClassType = DB.getValue(vNode, "classtype", "");
	if sClassType == "prestige" then
		return Interface.getString("class_label_classtype_prestige");
	elseif sClassType == "npc" then
		return Interface.getString("class_label_classtype_npc");
	end
	return Interface.getString("class_label_classtype_base");
end






--
-- Please see the license.html file included with this distribution for
-- attribution and copyright information.
--

-- JOHN WORK IN PROGRESS -------------
aRecordOverrides = {
	-- CoreRPG overrides
	-- New record types
	["species_archetype"] = {
		bExport = true,
		aDataMap = { "species_archetype", "reference.species_archetypes" },
		aDisplayIcon = { "button_species_archetypes", "button_species_archetypes_down" },
		sRecordDisplayClass = "referencespecies_archetype",
		aCustomFilters = {
			["Source"] = { sField = "source", sType = "string"},
		},
	},

	["setting"] = {
		bExport = true,
		aDataMap = { "setting", "reference.settings" },
		aDisplayIcon = { "button_settings", "button_settings_down" },
		sRecordDisplayClass = "referencesetting",
		aCustomFilters = {
			["Source"] = { sField = "source", sType = "string"},
			},
		},

	["career"] = {
		bExport = true,
		aDataMap = { "career", "reference.careers" },
		aDisplayIcon = { "button_careers", "button_careers_down" },
		sRecordDisplayClass = "referencecareer",
		aCustomFilters = {
			["Source"] = { sField = "source", sType = "string"},
		},
	},
	["skill"] = {
		bExport = true,
		aDataMap = { "skill", "reference.skills" },
		aDisplayIcon = { "button_skills", "button_skills_down" },
		sRecordDisplayClass = "referenceskill",
		aCustomFilters = {
			["Category"] = { sField = "category" },
			["Characteristic"] = { sField = "characteristic" },
			["Source"] = { sField = "source", sType = "string"},
		},
	},
	["npc"] = {
		aDataMap = { "npc", "reference.npcdata" },
--		aGMListButtons = { "button_npc_letter", "button_npc_type" };
		aCustomFilters = {
			["Category"] = { sField = "npc_category", sType = "string"},
			["Source"] = { sField = "source", sType = "string"},
		},
	},
	["item"] = {
		fIsIdentifiable = isItemIdentifiable,
		aDataMap = { "item", "reference.equipment", "reference.weapon", "reference.armor", "reference.magicitems", "reference.gear" },
		fRecordDisplayClass = getItemRecordDisplayClass,
		aRecordDisplayClasses = { "item", "referencearmor", "referenceweapon", "referenceequipment", "referencegear" },
		aGMListButtons = { "button_item_armor", "button_item_weapons", "button_item_gear", "button_item_vehicle_weapons" };
		aPlayerListButtons = { "button_item_armor", "button_item_weapons", "button_item_gear", "button_item_vehicle_weapons" };

		aCustomFilters = {
			["Source"] = { sField = "source", sType = "string"},
			["Skill"] = { sField = "skill" },
			["Type"] = { sField = "type" },
			["Subtype"] = { sField = "subtype" },
		},
	},

	["table"] = {
		bExport = true,
		aDataMap = { "tables", "reference.tables" },
		-- sRecordDisplayClass = "table",
		aGMEditButtons = { "button_add_table_guided", "button_add_table_import" },
		aCustomFilters = {
			["Source"] = { sField = "source", sType = "string"},
		},
	},

	-- New record types
	["talent"] = {
		bExport = true,
		aDataMap = { "talent", "reference.talents" },
		aDisplayIcon = { "button_talents", "button_talents_down" },
		sRecordDisplayClass = "referencetalent",
		aGMListButtons = { "button_talent_type" };
		aPlayerListButtons = { "button_talent_type" };
		aCustomFilters = {
			["Tier"] = { sField = "tier" },
			["Activation"] = { sField = "activation" },
			["Ranked"] = { sField = "ranked" },
			["Source"] = { sField = "source" }
		},
	},
	["item_attachment"] = {
		bExport = true,
		fIsIdentifiable = isItemIdentifiable,
		aDataMap = { "item_attachment", "reference.item_attachment_armor", "reference.item_attachment_weapon"},
		aDisplayIcon = { "button_item_attachments", "button_item_attachments_down" },
		sRecordDisplayClass = "reference_item_attachment",
		aCustomFilters = {
			["Source"] = { sField = "source", sType = "string"},
			["Equipment Type"] = { sField = "equipment_type", sType = "string"},
		},
	},


	["special_ability"] = {
		bExport = true,
		aDataMap = { "special_ability", "reference.special_abilities" },
		aDisplayIcon = { "button_special_abilities", "button_special_abilities_down" },
		sRecordDisplayClass = "referenceracialtrait",
		aCustomFilters = {
			["Source"] = { sField = "source", sType = "string"},
		},
	},

	["vehicle"] = {
		bExport = true,
		aDataMap = { "vehicle", "reference.vehicles" },
		aDisplayIcon = { "button_vehicles", "button_vehicles_down" },
		-- sRecordDisplayClass = "vehicle",
		aGMListButtons = { "button_vehicle_type" };
		aCustomFilters = {
			["Type"] = { sField = "type" },
			["Source"] = { sField = "source", sType = "string"},
		},
	},


};



aDefaultSidebarState = {
	["gm"] = "charsheet,note,image,table,story,quest,npc,battle,item,item_attachment,vehicle,treasureparcel",
	["play"] = "charsheet,note,image", --item,item_attachment,vehicle",
	["create"] = "charsheet,species_archetype,special_ability,career,talent,item,item_attachment,vehicle,setting,skill",
};

aListViews = {
	["item"] = {
		["armor"] = {
			sTitleRes = "item_grouped_title_armor",
			aColumns = {
				{ sName = "name", sType = "string", sHeadingRes = "item_grouped_label_name", nWidth=200 },
				{ sName = "defense", sType = "number", sHeadingRes = "item_grouped_label_def", sTooltipRes = "item_grouped_tooltip_def", nWidth=40, bCentered=true, nSortOrder=1 },
				{ sName = "soak", sType = "number", sHeadingRes = "item_grouped_label_soak", sTooltipRes = "item_grouped_tooltip_soak", bCentered=true },
				{ sName = "encumbrance", sType = "string", sHeadingRes = "item_grouped_label_encumbrance", sTooltipRes = "item_grouped_tooltip_encumbrance", nWidth=30, bCentered=true },
				{ sName = "hard_points", sType = "number", sHeadingRes = "item_grouped_label_hard_points", sTooltipRes = "item_grouped_tooltip_hard_points", nWidth=30, bCentered=true },
				{ sName = "cost", sType = "string", sHeadingRes = "item_grouped_label_cost", nWidth=100, bCentered=true },
				{ sName = "rarity", sType = "number", sHeadingRes = "item_grouped_label_rarity", bCentered=true },
				{ sName = "special", sType = "string", sHeadingRes = "item_grouped_label_special", nWidth=400 },
			},
			aFilters = {
				{ sDBField = "type", vFilterValue = "Armor" },
				{ sCustom = "item_isidentified" }
			},
			aGroups = { { sDBField = "subtype" } },
			aGroupValueOrder = { "Light", "Medium", "Heavy", "Shield", "Extras" },
		},
		["weapon"] = {
			sTitleRes = "item_grouped_title_weapons",
			aColumns = {
				{ sName = "name", sType = "string", sHeadingRes = "item_grouped_label_name", nWidth=150 },
				{ sName = "skill", sType = "string", sHeadingRes = "item_grouped_label_skill", nWidth=100 },
				{ sName = "damage", sType = "string", sHeadingRes = "item_grouped_label_damage", nWidth=60, bCentered=true },
				{ sName = "critical", sType = "number", sHeadingRes = "item_grouped_label_critical", bCentered=true },
				{ sName = "range", sType = "string", sHeadingRes = "item_grouped_label_range", sTooltipRes = "item_grouped_tooltip_range", nWidth=30, bCentered=true },
				{ sName = "encumbrance", sType = "string", sHeadingRes = "item_grouped_label_encumbrance", sTooltipRes = "item_grouped_tooltip_encumbrance", nWidth=30, bCentered=true },
				{ sName = "hard_points", sType = "number", sHeadingRes = "item_grouped_label_hard_points", sTooltipRes = "item_grouped_tooltip_hard_points", nWidth=30, bCentered=true },
				{ sName = "cost", sType = "string", sHeadingRes = "item_grouped_label_cost", nWidth=100, bCentered=true },
				{ sName = "rarity", sType = "number", sHeadingRes = "item_grouped_label_rarity", bCentered=true },
				{ sName = "special", sType = "string", sHeadingRes = "item_grouped_label_special", nWidth=400 },
			},
			aFilters = {
				{ sDBField = "type", vFilterValue = "Weapon" },
				{ sCustom = "item_isidentified" }
			},
			aGroups = { { sDBField = "subtype" } },
			aGroupValueOrder = { "Simple Unarmed Melee", "Simple Light Melee", "Simple One-Handed Melee", "Simple Two-Handed Melee", "Simple Ranged", "Martial Light Melee", "Martial One-Handed Melee", "Martial Two-Handed Melee", "Martial Ranged", "Exotic Light Melee", "Exotic One-Handed Melee", "Exotic Two-Handed Melee", "Exotic Ranged" },
		},
		["gear"] = {
			sTitleRes = "item_grouped_title_gear",
			aColumns = {
				{ sName = "name", sType = "string", sHeadingRes = "item_grouped_label_name", nWidth=200 },
				{ sName = "encumbrance", sType = "string", sHeadingRes = "item_grouped_label_encumbrance", sTooltipRes = "item_grouped_tooltip_encumbrance", nWidth=30, bCentered=true },
				{ sName = "cost", sType = "string", sHeadingRes = "item_grouped_label_cost", nWidth=100, bCentered=true },
				{ sName = "rarity", sType = "number", sHeadingRes = "item_grouped_label_rarity", bCentered=true },
				{ sName = "special", sType = "string", sHeadingRes = "item_grouped_label_special", nWidth=400 },
			},
			aFilters = {
				{ sDBField = "type", vFilterValue = "Gear" },
				{ sCustom = "item_isidentified" }
			},
			aGroups = { { sDBField = "subtype" } },
			aGroupValueOrder = { "Ammunition", "Adventuring Gear", "Special Substances And Items", "Tools And Skill Kits", "Clothing", "Food, Drink, And Lodging", "Mounts And Related Gear", "Transport", "Spellcasting And Services" },
		},


		["vehicle weapon"] = {
			sTitleRes = "item_grouped_title_vehicle_weapons",
			aColumns = {
				{ sName = "name", sType = "string", sHeadingRes = "item_grouped_label_name", nWidth=150 },
				{ sName = "skill", sType = "string", sHeadingRes = "item_grouped_label_skill", nWidth=100 },
				{ sName = "fire_arc", sType = "string", sHeadingRes = "item_grouped_label_fire_arc", nWidth=100 },
				{ sName = "damage", sType = "string", sHeadingRes = "item_grouped_label_damage", nWidth=60, bCentered=true },
				{ sName = "critical", sType = "number", sHeadingRes = "item_grouped_label_critical", bCentered=true },
				{ sName = "range", sType = "string", sHeadingRes = "item_grouped_label_range", sTooltipRes = "item_grouped_tooltip_range", nWidth=30, bCentered=true },
				{ sName = "encumbrance", sType = "string", sHeadingRes = "item_grouped_label_encumbrance", sTooltipRes = "item_grouped_tooltip_encumbrance", nWidth=30, bCentered=true },
				{ sName = "hard_points", sType = "number", sHeadingRes = "item_grouped_label_hard_points", sTooltipRes = "item_grouped_tooltip_hard_points", nWidth=30, bCentered=true },
				{ sName = "cost", sType = "string", sHeadingRes = "item_grouped_label_cost", nWidth=100, bCentered=true },
				{ sName = "rarity", sType = "number", sHeadingRes = "item_grouped_label_rarity", bCentered=true },
				{ sName = "special", sType = "string", sHeadingRes = "item_grouped_label_special", nWidth=400 },
			},
			aFilters = {
				{ sDBField = "type", vFilterValue = "Vehicle Weapon" },
				{ sCustom = "item_isidentified" }
			},
			aGroups = { { sDBField = "subtype" } },
			aGroupValueOrder = { "Simple Unarmed Melee", "Simple Light Melee", "Simple One-Handed Melee", "Simple Two-Handed Melee", "Simple Ranged", "Martial Light Melee", "Martial One-Handed Melee", "Martial Two-Handed Melee", "Martial Ranged", "Exotic Light Melee", "Exotic One-Handed Melee", "Exotic Two-Handed Melee", "Exotic Ranged" },
		},


		["equipment"] = {
			sTitleRes = "item_grouped_title_equipment",
			aColumns = {
				{ sName = "name", sType = "string", sHeadingRes = "item_grouped_label_name", nWidth=200 },
				{ sName = "cost", sType = "string", sHeadingRes = "item_grouped_label_cost", bCentered=true },
				{ sName = "encumbrance", sType = "string", sHeadingRes = "item_grouped_label_encumbrance", sTooltipRes = "item_grouped_tooltip_encumbrance", nWidth=30, bCentered=true },
			},
			aFilters = {
				{ sCustom = "item_isidentified" }
			},
			aGroups = { { sDBField = "subtype" } },
			aGroupValueOrder = { "Ammunition", "Adventuring Gear", "Special Substances And Items", "Tools And Skill Kits", "Clothing", "Food, Drink, And Lodging", "Mounts And Related Gear", "Transport", "Spellcasting And Services" },
		},
	},
	["specialability"] = {
		["bytype"] = {
			sTitleRes = "specialability_grouped_title_bytype",
			aColumns = {
				{ sName = "name", sType = "string", sHeadingRes = "specialability_grouped_label_name", nWidth=250 },
			},
			aFilters = { },
			aGroups = { { sDBField = "type" } },
			aGroupValueOrder = { },
		},
	},


	["talent"] = {
		["byname"] = {
			sTitleRes = "talent_grouped_title_byname",
			aColumns = {
				{ sName = "name", sName = "string", sHeadingRes = "talent_grouped_label_name", nWidth=170 },
				{ sName = "tier", sTier = "string", sHeadingRes = "talent_grouped_label_tier", nWidth=280, bWrapped = true },
			},
			aFilters = { },
			aGroups = { { sDBField = "name" } },
			aGroupValueOrder = { },
		},
	},

	["setting"] = {
		["byname"] = {
			sTitleRes = "talent_grouped_title_byname",
			aColumns = {
				{ sName = "name", sName = "string", sHeadingRes = "talent_grouped_label_name", nWidth=170 },
			},
			aFilters = { },
			aGroups = { { sDBField = "name" } },
			aGroupValueOrder = { },
		},
	},



	["vehicle"] = {
		["bytype"] = {
			sTitleRes = "vehicle_grouped_title_bytype",
			aColumns = {
				{ sName = "name", sType = "string", sHeadingRes = "vehicle_grouped_label_name", nWidth=200 },
				{ sName = "control_skill", sType = "string", sHeadingRes = "vehicle_grouped_label_control_skill", nWidth=100 },


				{ sName = "silhouette", sType = "number", sHeadingRes = "vehicle_grouped_label_silhouette", nWidth=60, bCentered=true },
				{ sName = "speed.max", sType = "number", sHeadingRes = "vehicle_grouped_label_max_speed", bCentered=true },
				{ sName = "handling", sType = "number", sHeadingRes = "vehicle_grouped_label_handling", bCentered=true },
				{ sName = "defense", sType = "number", sHeadingRes = "vehicle_grouped_label_defense", bCentered=true },
				{ sName = "armor", sType = "number", sHeadingRes = "vehicle_grouped_label_armor", bCentered=true },
				{ sName = "hull_trauma.threshold", sType = "number", sHeadingRes = "vehicle_grouped_label_hull_trauma", bCentered=true },
				{ sName = "system_strain.threshold", sType = "number", sHeadingRes = "vehicle_grouped_label_system_strain", bCentered=true },

				{ sName = "cost", sType = "string", sHeadingRes = "vehicle_grouped_label_cost", nWidth=100, bCentered=true },
				{ sName = "rarity", sType = "number", sHeadingRes = "vehicle_grouped_label_rarity", bCentered=true },
				{ sName = "encumbrance_capacity", sType = "number", sHeadingRes = "vehicle_grouped_label_encumbrance_capacity", sTooltipRes = "vehicle_grouped_tooltip_encumbrance_capacity", bCentered=true },
			},
			aFilters = {},
			aGroups = { { sDBField = "type" } },
			aGroupValueOrder = {},
		},
	},


};


function onInit()
	LibraryData.setCustomFilterHandler("item_isidentified", getItemIsIdentified);
	LibraryData.setCustomGroupOutputHandler("npc_cr", getCRGroupedList);
	LibraryData.setCustomGroupOutputHandler("npc_type", getTypeGroup);
	for kDefSidebar,vDefSidebar in pairs(aDefaultSidebarState) do
		DesktopManager.setDefaultSidebarState(kDefSidebar, vDefSidebar);
	end
	for kRecordType,vRecordType in pairs(aRecordOverrides) do
		LibraryData.overrideRecordTypeInfo(kRecordType, vRecordType);
	end
	for kRecordType,vRecordListViews in pairs(aListViews) do
		for kListView, vListView in pairs(vRecordListViews) do
			LibraryData.setListView(kRecordType, kListView, vListView);
		end
	end
--	LibraryData.setRecordTypeInfo("vehicle", nil);
end
