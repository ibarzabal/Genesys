--
-- Please see the license.html file included with this distribution for
-- attribution and copyright information.
--

function onInit()
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
	local bSection1 = false;

	if User.getRulesetName() == "StarWarsFFG" then
		setting.setVisible(false);
		setting_label.setVisible(false);
--	else
--		if updateControl("setting", bReadOnly, bID) then bSection1 = true; end
	end
--	if updateControl("source", bReadOnly, bID) then bSection1 = true; end
--	if updateControl("source_page", bReadOnly, bID) then bSection1 = true; end
--	divider.setVisible(bSection1);
end
