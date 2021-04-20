function onInit()

	-- show the splash screen
	--Interface.openWindow("splash", "");


	-- registerPublicNodes
		if User.isHost() then
	--		DB.createNode("preferences").setPublic(true);
	--		DB.createNode("partysheet").setPublic(true);
	--		DB.createNode("initiativetracker").setPublic(true);
			DB.createNode("StoryPointPCchit").setPublic(true);
			DB.createNode("StoryPointGMchit").setPublic(true);
	--		DB.createNode("tokens").setPublic(true);
			-- Added to allow player side access to NPC token details - is this overkill?  Does it allow too much access?
	--		DB.createNode("npclist").setPublic(true);
		end

end
