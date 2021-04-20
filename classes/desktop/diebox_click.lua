control = nil;

function registerControl(ctrl)
	control = ctrl;
end

function addSkillDice(skilldescription, dice, sourcenode)
	if dice then
		if OptionsManager.getOption("interface_cleardicepoolondrag") == "on"
			control.resetAll();
		end
		control.setType("skill");
		control.setDescription(skilldescription);
		control.setSourcenode(sourcenode);
		for k, v in pairs(dice) do
			control.addDie(v);
		end
	end
end
