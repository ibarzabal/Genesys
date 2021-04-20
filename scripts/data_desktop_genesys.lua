--
-- Please see the license.html file included with this distribution for
-- attribution and copyright information.
--

function onInit()
	Interface.onDesktopInit = onDesktopInit;

	registerPublicNodes();

	OptionsManager.setOptionDefault("DDCL", "desktopdecal_sw");
end

function onDesktopInit()
	buildDesktop();

	if not User.isLocal() and not User.isHost() then
		Interface.openWindow("charselect_client", "");
	end

	registerModuleSets();
	if User.isLocal() then
		if not GlobalRegistry or not GlobalRegistry[User.getRulesetName()] or not GlobalRegistry[User.getRulesetName()].setup then
			Interface.openWindow("setup", "");
		end
	else
		if not CampaignRegistry or not CampaignRegistry.setup then
			Interface.openWindow("setup", "");
		end
	end
end

function registerPublicNodes()
	if User.isHost() then
		DB.createNode("options").setPublic(true);
		DB.createNode("partysheet").setPublic(true);
		DB.createNode("calendar").setPublic(true);
		DB.createNode("combattracker").setPublic(true);
		DB.createNode("modifiers").setPublic(true);
		DB.createNode("effects").setPublic(true);
	end
end

function buildDesktop()
	if User.isLocal() then
		DesktopManager.registerStackShortcuts(aCoreDesktopStack["local"]);
		DesktopManager.registerDockShortcuts(aCoreDesktopDock["local"]);
	else
		if User.isHost() then
			DesktopManager.registerStackShortcuts(aCoreDesktopStack["host"]);
		else
			DesktopManager.registerStackShortcuts(aCoreDesktopStack["client"]);
		end
		if Interface.getVersion() < 4 then
			DesktopManager.registerDockShortcuts(aCoreDesktopDock["live"]);
		else
			DesktopManager.registerDockShortcuts(aCoreDesktopDockV4["live"]);
		end
	end
end

function addDataModuleSet(sMode, vDataModuleSet)
	table.insert(aDataModuleSet[sMode], vDataModuleSet);
end

function addTokenPackSet(sMode, vTokenModuleSet)
	table.insert(aTokenPackSet[sMode], vTokenModuleSet);
end

function registerModuleSets()
	if User.isLocal() then
		DesktopManager.addDataModuleSets(aDataModuleSet["local"]);
		DesktopManager.addTokenPackSets(aTokenPackSet["local"]);
	elseif User.isHost() then
		DesktopManager.addDataModuleSets(aDataModuleSet["host"]);
		DesktopManager.addTokenPackSets(aTokenPackSet["host"]);
	else
		DesktopManager.addDataModuleSets(aDataModuleSet["client"]);
		DesktopManager.addTokenPackSets(aTokenPackSet["client"]);
	end
end

aCoreDesktopStack =
{
	["local"] =
	{
		{
			icon="button_color",
			icon_down="button_color_down",
			tooltipres="sidebar_tooltip_colors",
			class="pointerselection",
		},
	},
	["host"] =
	{
		{
			icon="button_ct",
			icon_down="button_ct_down",
			tooltipres="sidebar_tooltip_ct",
			class="initiativetracker",
			path="combattracker",
		},
		{
			icon="button_partysheet",
			icon_down="button_partysheet_down",
			tooltipres="sidebar_tooltip_ps",
			class="partysheet_host",
			path="partysheet",
		},
		{
			icon="button_calendar",
			icon_down="button_calendar_down",
			tooltipres="sidebar_tooltip_calendar",
			class="calendar",
			path="calendar",
		},
		{
			icon="button_color",
			icon_down="button_color_down",
			tooltipres="sidebar_tooltip_colors",
			class="pointerselection",
		},
		{
			icon="button_light",
			icon_down="button_light_down",
			tooltipres="sidebar_tooltip_lighting",
			class="lightingselection",
		},
		{
			icon="button_options",
			icon_down="button_options_down",
			tooltipres="sidebar_tooltip_options",
			class="options",
		},
		{
			icon="button_modifiers",
			icon_down="button_modifiers_down",
			tooltipres="sidebar_tooltip_modifiers",
			class="modifiers",
			path="modifiers",
		},
		{
			icon="button_effects",
			icon_down="button_effects_down",
			tooltipres="sidebar_tooltip_effects",
			class="effectlist",
			path="effects",
		},
	},
	["client"] =
	{
		{
			icon="button_ct",
			icon_down="button_ct_down",
			tooltipres="sidebar_tooltip_ct",
			class="initiativetracker",
			path="combattracker",
		},
		{
			icon="button_partysheet",
			icon_down="button_partysheet_down",
			tooltipres="sidebar_tooltip_ps",
			class="partysheet_client",
			path="partysheet",
		},
		{
			icon="button_calendar",
			icon_down="button_calendar_down",
			tooltipres="sidebar_tooltip_calendar",
			class="calendar",
			path="calendar",
		},
		{
			icon="button_color",
			icon_down="button_color_down",
			tooltipres="sidebar_tooltip_colors",
			class="pointerselection",
		},
		{
			icon="button_modifiers",
			icon_down="button_modifiers_down",
			tooltipres="sidebar_tooltip_modifiers",
			class="modifiers",
			path="modifiers",
		},
		{
			icon="button_effects",
			icon_down="button_effects_down",
			tooltipres="sidebar_tooltip_effects",
			class="effectlist",
			path="effects",
		},
		{
			icon="button_options",
			icon_down="button_options_down",
			tooltipres="sidebar_tooltip_options",
			class="options",
		},
	},
};

aCoreDesktopDock =
{
	["local"] =
	{
		{
			icon="button_library",
			icon_down="button_library_down",
			tooltipres="sidebar_tooltip_library",
			class="library",
			subdock = true,
		},
	},
	["live"] =
	{
		{
			icon="button_tokencase",
			icon_down="button_tokencase_down",
			tooltipres="sidebar_tooltip_token",
			class="tokenbag",
			subdock = true,
		},
		{
			icon="button_library",
			icon_down="button_library_down",
			tooltipres="sidebar_tooltip_library",
			class="library",
			subdock = true,
		},
	},
};

aCoreDesktopDockV4 =
{
	["live"] =
	{
		{
			icon="button_assets",
			icon_down="button_assets_down",
			tooltipres="sidebar_tooltip_assets",
			class="tokenbag",
			subdock = true,
		},
		{
			icon="button_library",
			icon_down="button_library_down",
			tooltipres="sidebar_tooltip_library",
			class="library",
			subdock = true,
		},
	},
};

aDataModuleSet =
{
	["local"] =
	{
	},
	["host"] =
	{
	},
	["client"] =
	{
	},
};

aTokenPackSet =
{
	["local"] =
	{
	},
	["host"] =
	{
		{
			name = "Free Tokens",
			modules =
			{
				{ name = "Animal Tokens" },
				{ name = "Character Tokens" },
				{ name = "Monster Tokens" },
			},
		},
		{
			name = "Free Tokens (w/ base)",
			modules =
			{
				{ name = "Animal Pogs" },
				{ name = "Character Pogs" },
				{ name = "Monster Pogs" },
			},
		},
		{
			name = "Free Letter Tokens",
			modules =
			{
				{ name = "Letter Tokens" },
			},
		},
		{
			name = "Devin Night Token Bundle",
			modules =
			{
				{ name = "Adventuring Animals", storeid="DNFGANYNTPADAN" },
				{ name = "TP22 Amazons Tokens", storeid="DNTP22FG2" },
				{ name = "Animals 2", storeid="DNFGANYNTPAN2" },
				{ name = "TP34 Animals Tokens", storeid="DNTP34FG2" },
				{ name = "Astral Antagonists", storeid="DNFGANYNTPASAN" },
				{ name = "TP21 Brigands Tokens", storeid="DNTP21FG2" },
				{ name = "Chaotic Creatures - Token Pack", storeid="DNFGANYTPCC" },
				{ name = "Deities _ Devils", storeid="DNFGANYNTPDAD" },
				{ name = "TP35 Demons and Devils Tokens", storeid="DNTP35FG2" },
				{ name = "TP62 Demons Tokens", storeid="DNTP62FG2" },
				{ name = "Desert Encounters", storeid="DNFGANYNTPDEEN" },
				{ name = "TP57 Dinosaur Tokens", storeid="DNTP57FG2" },
				{ name = "TP24 Dragon Kin Tokens", storeid="DNTP25FG2" },
				{ name = "TP Drow Tokens", storeid="DNTPDrowFG" },
				{ name = "TP63 Elemental Tokens", storeid="DNTP63FG2" },
				{ name = "TP Elves Tokens", storeid="DNTPElvesFG" },
				{ name = "Fantastical Far East", storeid="DNFGANYNTPFFE" },
				{ name = "TP27 Forged Kin Tokens", storeid="DNTP27FG2" },
				{ name = "TP42 Four Legged Fiends Tokens", storeid="DNTP42FG2" },
				{ name = "TP24 Frozen North Tokens", storeid="DNTP24FG2" },
				{ name = "TP28 Giants Tokens", storeid="DNTP28FG2" },
				{ name = "TP23 Goblins and Orcs Tokens", storeid="DNTP23FG2" },
				{ name = "Greater Undead", storeid="DNFGANYNTPGU" },
				{ name = "TP45 Heroic Characters 1 Tokens", storeid="DNTP45FG2" },
				{ name = "TP Heroic Characters 10 Tokens", storeid="DNTPHeroic10FG" },
				{ name = "Heroic Characters 11", storeid="DNFGANYNTPHC11" },
				{ name = "Heroic Characters 12", storeid="DNFGANYNTPHC12" },
				{ name = "Heroic Characters 13", storeid="DNFGANYNTPHC13" },
				{ name = "Heroic Characters 14", storeid="DNFGANYNTPHC14" },
				{ name = "Heroic Characters 15", storeid="DNFGANYNTPHC15" },
				{ name = "Heroic Characters 16", storeid="DNFGANYNTPHC16" },
				{ name = "Token Pack 91 - Heroic Characters 17", storeid="DNFGANYTPHC17" },
				{ name = "TP46 Heroic Characters 2 Tokens", storeid="DNTP46FG2" },
				{ name = "TP47 Heroic Characters 3 Tokens", storeid="DNTP47FG2" },
				{ name = "TP48 Heroic Characters 4 Tokens", storeid="DNTP48FG2" },
				{ name = "TP49 Heroic Characters 5 Tokens", storeid="DNTP49FG2" },
				{ name = "TP58 Heroic Characters 6 Tokens", storeid="DNTP58FG2" },
				{ name = "TP64 Heroic Characters 7 Tokens", storeid="DNTP64FG2" },
				{ name = "TP65 Heroic Characters 8 Tokens", storeid="DNTP65FG2" },
				{ name = "TP Heroic Characters 9 Tokens", storeid="DNTPHeroic9FG" },
				{ name = "TP36 Humanoid Monsters Tokens", storeid="DNTP36FG2" },
				{ name = "TP52 Hybrids Tokens", storeid="DNTP52FG2" },
				{ name = "TP43 Many Legged Fiends Tokens", storeid="DNTP43FG2" },
				{ name = "TP31 Modern Tokens 1 Tokens", storeid="DNTP31FG2" },
				{ name = "TP32 Modern Tokens 2 Tokens", storeid="DNTP32FG2" },
				{ name = "TP53 More Monsters Tokens", storeid="DNTP53FG2" },
				{ name = "TP More Monsters 3 Tokens", storeid="DNTPMoreMonsters3FG" },
				{ name = "TP More Monsters 4 Tokens", storeid="DNTPMoreMonsters4FG" },
				{ name = "TP66 More Monsters Tokens", storeid="DNTP66FG2" },
				{ name = "TP40 No Legged Fiends Tokens", storeid="DNTP40FG2" },
				{ name = "NPCs_ Middle Class", storeid="DNFGANYNTPNPCMC" },
				{ name = "NPCs_ Nobles", storeid="DNFGANYNTPNPCN" },
				{ name = "NPCs: The Poor", storeid="DNFGANYNTP" },
				{ name = "TP30 Pig Faced Orcs Tokens", storeid="DNTP30FG2" },
				{ name = "TP61 Ratmen Tokens", storeid="DNTP61FG2" },
				{ name = "TP55 Shadowpunk 1 Tokens", storeid="DNTP55FG2" },
				{ name = "TP60 Slaves and Prisoners Tokens", storeid="DNTP60FG2" },
				{ name = "TP44 Space Characters Tokens", storeid="DNTP44FG2" },
				{ name = "TP56 Steampunk Tokens", storeid="DNTP56FG2" },
				{ name = "TP37 Summonded Helpers Tokens", storeid="DNTP37FG2" },
				{ name = "The Undying", storeid="DNFGANYNTPTHUN" },
				{ name = "Devin Night Token Pack 77 - Steampunk", storeid="DNANYTP77FG" },
				{ name = "Token Pack 93 - Hybrids 2", storeid="DNFGANYTPH2" },
				{ name = "Token Pack 94: Deitys & Devils 2", storeid="DNFGANYTPDD2" },
				{ name = "Token Pack 95: Humanoid Monsters 2", storeid="DNFGANYTPHM2" },
				{ name = "Token Pack 96 - Orcs", storeid="DNFGANYTPO" },
				{ name = "Tome of Beasts (Token Pack)", storeid="DNFGANYTPTOBP1" },
				{ name = "TP29 Townsfolk 2 Tokens", storeid="DNTP29FG2" },
				{ name = "TP50 Troll, Lizards, Rockmen Characters Tokens", storeid="DNTP50FG2" },
				{ name = "TP41 Two Legged Fiends Tokens", storeid="DNTP41FG2" },
				{ name = "TP26 Undead 1 Tokens", storeid="DNTP26FG2" },
				{ name = "TP38 Undead 2 Tokens", storeid="DNTP38FG2" },
				{ name = "TP59 Vietnam Soldier Tokens", storeid="DNTP59FG2" },
				{ name = "TP33 Vikings Tokens", storeid="DNTP33FG2" },
				{ name = "TP54 Wild West Tokens", storeid="DNTP54FG2" },
				{ name = "TP39 Winged Fiends Tokens", storeid="DNTP39FG2" },
			},
		},
	},
	["client"] =
	{
	},
};
