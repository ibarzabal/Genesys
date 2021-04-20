-- 
-- Please see the license.html file included with this distribution for 
-- attribution and copyright information.
--

function onInit()
	if User.isHost() then
		setHoverCursor("hand");
	end
end

function onDragStart(button, x, y, draginfo)
	if User.isHost() then
		draginfo.setType("combattrackerentry");
		draginfo.setStringData(getValue());
		draginfo.setCustomData(window.getDatabaseNode());
		return true;
	end
end
