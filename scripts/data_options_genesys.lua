--
-- Please see the license.html file included with this distribution for
-- attribution and copyright information.
--

function onInit()
	OptionsManager.addOptionValue("DDCL", "option_val_DDCL_genesys_core", "desktopdecal_genesys_core", true);
	OptionsManager.addOptionValue("DDCL", "option_val_DDCL_genesys_android", "desktopdecal_genesys_android", true);
	OptionsManager.addOptionValue("DDCL", "option_val_DDCL_genesys_terrinoth", "desktopdecal_genesys_terrinoth", true);

	OptionsManager.registerOption2("interface_cleardicepoolondrag", true, "option_header_game", "interface_cleardicepoolondrag_label", "option_entry_cycler" ,
			{ labels = "option_val_on", values = "on", baselabel = "option_val_off", baseval = "off", default = "on" });

	OptionsManager.setOptionDefault("DDCL", "desktopdecal_genesys_core");
end
