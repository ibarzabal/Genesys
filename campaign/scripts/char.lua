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
		if StringManager.contains({"vehicle"}, sClass) then
			addVehicle(getDatabaseNode(), sClass, sRecord)
			return true;
		end

		if StringManager.contains({"item"}, sClass) then
			ItemManager.handleAnyDrop(getDatabaseNode(), draginfo);
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



function addVehicle(nodeChar, sClass, sRecord)
--	local attachment_desc = DB.getValue(nodeSource, "name", "");
--	local sFormat = Interface.getString("char_message_attachmentadd");
--	local sMsg = string.format(sFormat, attachment_desc, DB.getValue(nodeItem, "name", ""));
	local recordnode = DB.findNode(sRecord);
	-- local AttachmentType = DB.getValue(recordnode,"equipment_type","");
	local newitemnode;


	newitemnode = nodeChar.createChild("vehicleslist").createChild();
	DBManagerGenesys.copyNode(recordnode, newitemnode);
	return true;

end
