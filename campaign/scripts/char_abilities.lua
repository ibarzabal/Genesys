--
-- Please see the license.html file included with this distribution for
-- attribution and copyright information.
--

function collapse()
	talentstitle.collapse();
	languagestitle.collapse();
end

function expand()
	talentstitle.expand();
	languagestitle.expand();
end

function onDrop(x, y, draginfo)
	if draginfo.isType("shortcut") then
		local sClass, sRecord = draginfo.getShortcutData();
		return CharManager.addInfoDB(getDatabaseNode(), sClass, sRecord);
	end
end
