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
  updateControl("setting", bReadOnly, bID);
  main_statblock1_brawn_current.setReadOnly(bReadOnly);
  main_statblock1_agility_current.setReadOnly(bReadOnly);
  main_statblock1_intellect_current.setReadOnly(bReadOnly);
  main_statblock1_cunning_current.setReadOnly(bReadOnly);
  main_statblock1_willpower_current.setReadOnly(bReadOnly);
  main_statblock1_presence_current.setReadOnly(bReadOnly);


end
