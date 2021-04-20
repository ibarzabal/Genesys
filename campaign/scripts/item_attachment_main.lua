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
	local bID = LibraryData.getIDState("item_attachment", nodeRecord);
  updateControl("nonid_name", bReadOnly, bID);
  updateControl("nonidentified", bReadOnly, bID);
  updateControl("equipment_type", bReadOnly, bID);
  updateControl("use_with", bReadOnly, bID);
  updateControl("modifiers", bReadOnly, bID);
  updateControl("hardpoints_required", bReadOnly, bID);
  updateControl("cost", bReadOnly, bID);
  updateControl("rarity", bReadOnly, bID);
  updateControl("description", bReadOnly, bID);
  updateControl("setting", bReadOnly, bID);

end
