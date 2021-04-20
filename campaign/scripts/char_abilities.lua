--
-- Please see the license.html file included with this distribution for
-- attribution and copyright information.
--

function collapse()
	special_abilitiestitle.collapse();
	featurestitle.collapse();
	traitstitle.collapse();
end

function expand()
	special_abilitiestitle.expand();
	featurestitle.expand();
	traitstitle.expand();
end

function onDrop(x, y, draginfo)
	if draginfo.isType("shortcut") then
		local sClass, sRecord = draginfo.getShortcutData();
		return CharManager.addInfoDB(getDatabaseNode(), sClass, sRecord);
	end
end



--
-- Please see the license.html file included with this distribution for
-- attribution and copyright information.
--

function collapse1()
	talentstitle.collapse();
	languagestitle.collapse();
end

function expand1()
	talentstitle.expand();
	languagestitle.expand();
end

function onDrop1(x, y, draginfo)
	if draginfo.isType("shortcut") then
		local sClass, sRecord = draginfo.getShortcutData();
		return CharManager.addInfoDB(getDatabaseNode(), sClass, sRecord);
	end
end
