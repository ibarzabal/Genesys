--
-- Please see the license.html file included with this distribution for
-- attribution and copyright information.
--

function onInit()
--	if User.isHost() then
--		registerMenuItem(Interface.getString("menu_rest"), "lockvisibilityon", 8);
--		registerMenuItem(Interface.getString("menu_restshort"), "pointer_cone", 8, 8);
--		registerMenuItem(Interface.getString("menu_restovernight"), "pointer_circle", 8, 6);
--	end

	if not minisheet and User.isLocal() then
		speak.setVisible(false);
		portrait.setVisible(false);
		localportrait.setVisible(true);
	end
end

function onDrop(x, y, draginfo)
	if draginfo.isType("shortcut") then
		local sClass, sRecord = draginfo.getShortcutData();
		if StringManager.contains({"referencecareer", "referencespecies_archetype"}, sClass) then
			CharManager.addInfoDB(getDatabaseNode(), sClass, sRecord);
			return true;
		end
	end
	return CharManager.onDrop(getDatabaseNode(), x, y, draginfo);
end

-- function onMenuSelection(selection, subselection)
-- 	if selection == 8 then
-- 		local nodeChar = getDatabaseNode();
--
-- 		if subselection == 8 then
-- 			ChatManager.Message(Interface.getString("message_restshort"), true, ActorManager.getActor("pc", nodeChar));
-- 		elseif subselection == 6 then
-- 			ChatManager.Message(Interface.getString("message_restovernight"), true, ActorManager.getActor("pc", nodeChar));
-- 			CharManager.rest(nodeChar);
-- 		end
-- 	end
-- end
