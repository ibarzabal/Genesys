--
-- Please see the license.html file included with this distribution for
-- attribution and copyright information.
--

local sortLocked = false;

function setSortLock(isLocked)
	sortLocked = isLocked;
end

function onInit()
	registerMenuItem(Interface.getString("list_menu_createitem"), "insert", 5);
end

function onMenuSelection(selection)
	if selection == 5 then
		addEntry(true);
	end
end

function onListChanged()
	update();
end

function update()
	local bEditMode = (window.parentcontrol.window.inventory_iedit.getValue() == 1);
	for _,w in ipairs(getWindows()) do
		w.idelete.setVisibility(bEditMode);
	end
end

function addEntry(bFocus)
	local w = createWindow();
	if w then
		if bFocus then
			w.name.setFocus();
		end
	end
	return w;
end

function onClickDown(button, x, y)
	return true;
end

function onClickRelease(button, x, y)
	if not getNextWindow(nil) then
		addEntry(true);
	end
	return true;
end
