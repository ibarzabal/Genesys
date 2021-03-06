--
-- Please see the license.html file included with this distribution for
-- attribution and copyright information.
--
function onInit()
	registerMenuItem(Interface.getString("list_menu_createitem"), "insert", 5);
	--local char_class = window.parentcontrol.window.getClass();
 	--local npc_type = DB.getValue(DB.getChild(getDatabaseNode().getParent(),"main_npc_category"),"","");
	--if char_class == "npc" and npc_type == "minion" then
	--	constructDefaultskilllist("short");
	--else
	--	constructDefaultskilllist("full");
	--end
	local isSW = (User.getRulesetName() == "StarWarsFFG");
	if isSW then
		constructDefaultskilllist();
	else
		-- If Character has 0 skills, populate it with default skills
		local CharSkillCount = DB.getChildCount(window.getDatabaseNode(), "skilllist");
		if CharSkillCount == 0 then
	--	Debug.chat("Settings:", DB.getChildCount("reference","settings"));
	--	Debug.chat("Skills:", DB.getChildCount("reference.skills",""));

	--	Debug.chat (getDatabaseNode().getPath());
		local nodeChar = window.getDatabaseNode();
		local wSelect = Interface.openWindow("select_dialog", "");
		local sTitle = Interface.getString("char_build_title_selectsetting_title");
		local sMessage = Interface.getString("char_build_title_selectsetting_msg");
		local rSettingAdd; --{ nodeChar = nodeChar, nodeSource = nodeSource, nLevel = nLevel, nodeClass = nodeClass, nCasterLevel = nCasterLevel, nPactMagicLevel = nPactMagicLevel };
		local aSpecializationOptions = getSettingOptions(nodeSource);
		wSelect.requestSelection (sTitle, sMessage, aSpecializationOptions, addSettingHelper, rSettingAdd, 1, 1, true);
		end
	end
end

function getSettingOptions(nodeClass)
	local aOptions = {};
		table.insert(aOptions, { text = Interface.getString("build_setting_selectsetting_default"), linkclass = "", linkrecord = "" });
		for _,v in pairs(DB.getChildrenGlobal("setting")) do
		table.insert(aOptions, { text = DB.getValue(v, "name", ""), linkclass = "referencesetting", linkrecord = v.getPath() });
	end
	return aOptions;
end

function addSettingHelper(aSelection, rClassAdd)
	if aSelection then
		if #aSelection ~= 1 then
			outputUserMessage("char_error_addsetting");
			return;
		end

		if aSelection[1] == Interface.getString("build_setting_selectsetting_default") then
			constructDefaultskilllist();
			return;
		end

		local aSettingOptions = getSettingOptions();
		for _,v in ipairs(aSettingOptions) do
			if v.text == aSelection[1] then
--				Debug.chat(v.linkrecord); --addClassFeatureDB(nodeChar, "reference_classability", v.linkrecord, rClassAdd.nodeClass);
--				Debug.chat(DB.getChildrenGlobal(v.linkrecord,"skills"));
				local sNode = v.linkrecord;
				CharManager.addInfoDB(getDatabaseNode().getParent(), "referencesetting", sNode);
				break;
			end
		end
	end
end

function onClose()
	local nodeChar = getDatabaseNode().getParent();
--	DB.removeHandler(DB.getPath(nodeChar, "skilllist"), "onChildUpdate", onStatUpdate);

--	DB.removeHandler(DB.getPath(nodeChar, "skilllist"), "onChildAdded", onSkillDataUpdate);
--	DB.removeHandler(DB.getPath(nodeChar, "skilllist"), "onChildDeleted", onSkillDataUpdate);
end

function onSkillDataUpdate()
--	CharManager.updateSkillPoints(window.getDatabaseNode());
end

function onListChanged()
	update();
end

function update()
	local bEditMode = (window.skilllist_iedit.getValue() == 1);
	--window.idelete_header.setVisible(bEditMode);
	for _,w in ipairs(getWindows()) do
		local bAllowDelete = w.isCustom();
		if not bAllowDelete then
			local sLabel = w.name.getValue();
			local rSkill = DataCommon.skilldata_default[sLabel];
			if rSkill and rSkill.sublabeling then
				bAllowDelete = true;
			end
		end

		if bEditMode then
			w.idelete_spacer.setVisible(false);
			w.idelete.setVisibility(bEditMode);

			w.name.setEnabled(true);
			w.name.setLine(true);
			w.characteristic.setEnabled(true);
			w.characteristic.setLine(true);
			w.category.setEnabled(true);
			w.category.setLine(true);
			w.advances.setEnabled(true);
			w.advances_edit.setEnabled(true);
			w.advances.setVisible(false);
			w.advances_edit.setVisible(true);
			w.career_skill.setEnabled(true);
		else
			w.idelete_spacer.setVisible(bEditMode);
			w.idelete.setVisibility(false);

			w.name.setEnabled(false);
			w.name.setLine(false);
			w.characteristic.setEnabled(false);
			w.category.setEnabled(false);
			w.category.setLine(false);
			w.characteristic.setLine(false);
			w.category.setEnabled(false);
			w.category.setLine(false);
			w.advances.setEnabled(false);
			w.advances_edit.setEnabled(false);
			w.advances.setVisible(true);
			w.advances_edit.setVisible(false);
			w.career_skill.setEnabled(false);
		end
	end
end


function onStatUpdate()
	for _,w in pairs(getWindows()) do
		w.onStatUpdate();
	end
end

function addEntry(bFocus)
	local w = createWindow();
	w.setCustom(true);
	if bFocus and w then
		w.name.setFocus();
	end
	return w;
end

function onMenuSelection(item)
	if item == 5 then
		addEntry(true);
	end
end

-- Create default skill selection
function constructDefaultskilllist(sListType)
--	if sListType == "short" then
--		return 1;
--	end

	local aSystemskilllist = DataCommon.skilldata_default;
	-- Create missing entries for all known skilllist
	local entrymap = {};
	for _,w in pairs(getWindows()) do
		local sLabel = w.name.getValue();
		local t = aSystemskilllist[sLabel];
		if t and not t.sublabeling then
			if not entrymap[sLabel] then
				entrymap[sLabel] = { w };
			else
				table.insert(entrymap[sLabel], w);
			end
		end
	end

	-- Set properties and create missing entries for all known skilllist
	for k, t in pairs(DataCommon.skilldata_default) do
		if not t.sublabeling then
			local matches = entrymap[k];
			if not matches then
				local w = createWindow();
				if w then
					w.name.setValue(k);
					if t.characteristic then
						w.characteristic.setValue(t.characteristic);
					else
						w.characteristic.setValue("");
					end
					if t.category then
						w.category.setValue(t.category);
					else
						w.category.setValue("");
					end

					if t.trainedonly then
						w.showonminisheet.setValue(0);
					end
					matches = { w };
				end
			end
		end
	end

	-- Set properties for all skilllist
--	for _,w in pairs(getWindows()) do
--		w.updateWindow();
--	end
end

function addNewInstance(sLabel)
	local rSkill = DataCommon.skilldata_default[sLabel];
	if rSkill and rSkill.sublabeling then
		local w = createWindow();
		w.name.setValue(sLabel);
--		w.statname.setStringValue(rSkill.stat);
		w.updateWindow();
		w.sublabel.setFocus();
		onListChanged();
	end
end


function resolveRefNode(sRecord)
	local nodeSource = DB.findNode(sRecord);
	if not nodeSource then
		local sRecordSansModule = StringManager.split(sRecord, "@")[1];
		nodeSource = DB.findNode(sRecordSansModule .. "@*");
		if not nodeSource then
			ChatManager.SystemMessage(Interface.getString("char_error_missingrecord"));
		end
	end
	return nodeSource;
end
