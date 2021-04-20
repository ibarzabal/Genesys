function updateSkills(npcNode)

	--Debug.console("Running MinionManager.updateSkills.  Node = " .. npcNode.getNodeName());

	if User.isHost() then

		local minionsRemaining = npcNode.getValue();

		local skillsNode = npcNode.getChild("...skilllist");
		if skillsNode then
			local aSkills = skillsNode.getChildren();

			for k,v in pairs(aSkills) do
				if v.getChild(".career_skill").getValue() == 1 then
					v.getChild(".advances").setValue(minionsRemaining - 1);
				end
			end
		end
	end
end

function updateSkill(skillNode)
	local minionsRemaining;
	--Debug.console("Running MinionManager.updateSkills.  Node = " .. skillNode.getNodeName());
	skillNode.createChild(".advances","number");
	if skillNode then
		if skillNode.getChild(".career_skill").getValue() == 1 then
			minionsRemaining = skillNode.getParent().getParent().getChild("minion.minions_remaining").getValue(); -- skillNode.getChild("...minion.minions_remaining").getValue();
			skillNode.getChild(".advances").setValue(minionsRemaining - 1);
		else
			skillNode.getChild(".advances").setValue(0);
		end
	end
end
