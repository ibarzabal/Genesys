--
-- Please see the license.html file included with this distribution for
-- attribution and copyright information.
--

function onInit()
	onFactionChanged();
end

function updateDisplay()
	local sFaction = friendfoe.getStringValue();

	local sOptCTSI = OptionsManager.getOption("CTSI");
	local bShowInit = ((sOptCTSI == "friend") and (sFaction == "friend")) or (sOptCTSI == "on");


	-- Hide Info from NPCs
	local nodeRecord = getDatabaseNode();
	local sClass = DB.getValue(nodeRecord, "link", "", "");
	local v = (DB.getValue(nodeRecord, "link", "", "") == "charsheet");
	wounds_threshold.setVisible(v);
	wounds_current.setVisible(v);
	strain_threshold.setVisible(v);
	strain_current.setVisible(v);
	meleedefence.setVisible(v);
	rangeddefence.setVisible(v);
	soak.setVisible(v);

	initresult.setVisible(bShowInit);

	if active.getValue() == 1 then
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

		windowlist.scrollToWindow(self);
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

function onActiveChanged()
	updateDisplay();
end

function onFactionChanged()
	updateDisplay();
end

function onIDChanged()
	local nodeRecord = getDatabaseNode();
	local sClass = DB.getValue(nodeRecord, "link", "npc", "");
	if sClass == "npc" then
		local bID = LibraryData.getIDState("npc", nodeRecord, true);
		name.setVisible(bID);
		nonid_name.setVisible(not bID);
	else
		name.setVisible(true);
		nonid_name.setVisible(false);
	end
end
