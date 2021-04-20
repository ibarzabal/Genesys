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
	},
	["career"] = {
		bExport = true,
		aDataMap = { "career", "reference.careers" },
		aDisplayIcon = { "button_classes", "button_careers_down" },
		sRecordDisplayClass = "referencecareer",
		aCustomFilters = {
			["Type"] = { sField = "classtype", fGetValue = getClassTypeValue },
		},
	},
	["skill"] = {
		bExport = true,
		aDataMap = { "skill", "reference.skills" },
		aDisplayIcon = { "button_skills", "button_skills_down" },
		sRecordDisplayClass = "referenceskill",
		aCustomFilters = {
			["Name"] = { sField = "name" },
		},
	},

	["item"] = {
		fIsIdentifiable = isItemIdentifiable,
		aDataMap = { "item", "reference.equipment", "reference.weapon", "reference.armor", "reference.magicitems" },
		fRecordDisplayClass = getItemRecordDisplayClass,
		aRecordDisplayClasses = { "item", "referencearmor", "referenceweapon", "referenceequipment" },
		aGMListButtons = { "button_item_armor", "button_item_weapons" };
		aPlayerListButtons = { "button_item_armor", "button_item_weapons" };
		aCustomFilters = {
			["Type"] = { sField = "type" },
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
			["Description"] = { sField = "description" }
		},
	},
};
-- aDefaultSidebarState = {
-- 	["create"] = "charsheet,class,feat,item,species_archetype,skill,specialability,spell",
-- };



aListViews = {
	["item"] = {
		["armor"] = {
			sTitleRes = "item_grouped_title_armor",
			aColumns = {
				{ sName = "name", sType = "string", sHeadingRes = "item_grouped_label_name", nWidth=200 },
				{ sName = "cost", sType = "string", sHeadingRes = "item_grouped_label_cost", bCentered=true },
				{ sName = "ac", sType = "number", sHeadingRes = "item_grouped_label_ac", sTooltipRes = "item_grouped_tooltip_ac", nWidth=40, bCentered=true, nSortOrder=1 },
				{ sName = "maxstatbonus", sType = "number", sHeadingRes = "item_grouped_label_maxstatbonus", sTooltipRes = "item_grouped_tooltip_maxstatbonus", bCentered=true },
				{ sName = "checkpenalty", sType = "number", sHeadingRes = "item_grouped_label_checkpenalty", sTooltipRes = "item_grouped_tooltip_checkpenalty", bCentered=true },
				{ sName = "spellfailure", sType = "number", sHeadingRes = "item_grouped_label_spellfailure", sTooltipRes = "item_grouped_tooltip_spellfailure", bCentered=true },
				{ sName = "speed30", sType = "number", sHeadingRes = "item_grouped_label_speed30", sTooltipRes = "item_grouped_tooltip_speed30", bCentered=true },
				{ sName = "speed20", sType = "number", sHeadingRes = "item_grouped_label_speed20", sTooltipRes = "item_grouped_tooltip_speed20", bCentered=true },
				{ sName = "weight", sType = "number", sHeadingRes = "item_grouped_label_weight", sTooltipRes = "item_grouped_tooltip_weight", nWidth=30, bCentered=true }
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
				{ sName = "name", sType = "string", sHeadingRes = "item_grouped_label_name", nWidth=200 },
				{ sName = "cost", sType = "string", sHeadingRes = "item_grouped_label_cost", bCentered=true },
				{ sName = "damage", sType = "string", sHeadingRes = "item_grouped_label_damage", nWidth=60, bCentered=true },
				{ sName = "critical", sType = "string", sHeadingRes = "item_grouped_label_critical", bCentered=true },
				{ sName = "range", sType = "number", sHeadingRes = "item_grouped_label_range", sTooltipRes = "item_grouped_tooltip_range", nWidth=30, bCentered=true },
				{ sName = "weight", sType = "number", sHeadingRes = "item_grouped_label_weight", sTooltipRes = "item_grouped_tooltip_weight", nWidth=30, bCentered=true },
				{ sName = "properties", sType = "string", sHeadingRes = "item_grouped_label_properties", nWidth=120 },
				{ sName = "damagetype", sType = "string", sHeadingRes = "item_grouped_label_damagetype", nWidth=150 }
			},
			aFilters = {
				{ sDBField = "type", vFilterValue = "Weapon" },
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
				{ sName = "weight", sType = "number", sHeadingRes = "item_grouped_label_weight", sTooltipRes = "item_grouped_tooltip_weight", nWidth=30, bCentered=true },
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
	["feat"] = {
		["bytype"] = {
			sTitleRes = "feat_grouped_title_bytype",
			aColumns = {
				{ sName = "name", sType = "string", sHeadingRes = "feat_grouped_label_name", nWidth=170 },
				{ sName = "prerequisites", sType = "string", sHeadingRes = "feat_grouped_label_prereq", nWidth=240, bWrapped = true },
				{ sName = "summary", sType = "string", sHeadingRes = "feat_grouped_label_benefit", nWidth=280, bWrapped = true },
			},
			aFilters = { },
			aGroups = { { sDBField = "type" } },
			aGroupValueOrder = { },
		},
	},
};


aDefaultSidebarState = {
	["create"] = "species_archetype,skill,career",
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
	LibraryData.setRecordTypeInfo("vehicle", nil);
end
