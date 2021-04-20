--
-- Please see the license.html file included with this distribution for
-- attribution and copyright information.
--

local enableglobaltoggle = true;
local enablevisibilitytoggle = true;

function onInit()
--	registerMenuItem(Interface.getString("list_menu_createitem"), "insert", 5);
--
--	Interface.onHotkeyActivated = onHotkey;
--
--	onVisibilityToggle();
--	onEntrySectionToggle();
--
--
DB.addHandler("StoryPointPCchit.chits", "onUpdate", onStoryPointUpdate);
DB.addHandler("StoryPointGMchit.chits", "onUpdate", onStoryPointUpdate);
--	--	DB.addHandler(DB.getPath(nodeChar, "skilllist"), "onChildDeleted", onSkillDataUpdate);



--	local node = getDatabaseNode();
--	DB.addHandler(DB.getPath(node, "*.name"), "onUpdate", onNameOrTokenUpdated);
--	DB.addHandler(DB.getPath(node, "*.nonid_name"), "onUpdate", onNameOrTokenUpdated);
--	DB.addHandler(DB.getPath(node, "*.isidentified"), "onUpdate", onNameOrTokenUpdated);
--	DB.addHandler(DB.getPath(node, "*.token"), "onUpdate", onNameOrTokenUpdated);
end

-- function onClose()
--   DB.removeHandler("StoryPointPCchit.chits", "onUpdate", onStoryPointUpdate);
--   DB.removeHandler("StoryPointGMchit.chits", "onUpdate", onStoryPointUpdate);
-- end

--function onStoryPointUpdate()
--	for _,w in pairs(getWindows()) do
--
--	end
--end
