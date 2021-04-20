local alignvalue = "center";

local updating = false;

local sourcenode = nil;
local sourcelabel = nil;

function onInit()

	-- get the source node
	local sourcenodename;
	if sourcename then
		sourcenodename = sourcename[1];
	else
		sourcenodename = getName();
	end
	if window.getDatabaseNode().isOwner() then
		sourcenode = window.getDatabaseNode().createChild(sourcenodename, "string");
	else
		sourcenode = window.getDatabaseNode().getChild(sourcenodename);
	end

	-- if the source node exists
	if sourcenode then

		-- get the default values
		if align then
			alignvalue = align[1];
		end

		-- subscribe to the sourcenode update event
		sourcenode.onUpdate = onUpdate;

		-- and trigger an update
		update_value();


		if super and super.onInit then
			super.onInit();
		end

		if isReadOnly() then
			self.update(true);
		else
			local node = getDatabaseNode();
			if not node or node.isReadOnly() then
				self.update(true);
			end
		end


	end

end

function onUpdate(source)
	update_value();
end

function update_value()
	-- DebugManager.logMessage("rangecontrol.update");
	if not updating then
		updating = true;
		if sourcenode then

			-- get the source value
			local sourcevalue = sourcenode.getValue();

			-- create the source label if required
			if not sourcelabel then
				sourcelabel = addTextWidget("sheetlabel", "");
			end

			-- set the source label
--			if sourcevalue == "" then
--				sourcelabel.setText("PR");
--			else
				sourcelabel.setText(sourcevalue);
			--end

			-- set the label colour
			if sourcevalue == "" then
				sourcelabel.setFont("sheettext");
			else
				sourcelabel.setFont("sheetlabel");
			end

			-- get the control size
			local controlw, controlh = sourcelabel.getSize();

			-- position the label
			if string.lower(alignvalue) == "left" then
				sourcelabel.setPosition("left", (controlw/2), 0);
			elseif string.lower(alignvalue) == "right" then
				sourcelabel.setPosition("right", -(controlw/2), 0);
			else
				sourcelabel.setPosition("",0,0);
			end
		end
		updating = false;
	end
end

function update(bReadOnly, bForceHide)
	local bLocalShow;
	if bForceHide then
		bLocalShow = false;
	else
		bLocalShow = true;
--		if bReadOnly and not nohide and getValue() == 0 then
--			bLocalShow = false;
--		end
	end

	setReadOnly(bReadOnly);
	setVisible(bLocalShow);

	local sLabel = getName() .. "_label";
	if window[sLabel] then
		window[sLabel].setVisible(bLocalShow);
	end

	if self.onUpdate then
		self.onUpdate(bLocalShow);
	end

	return bLocalShow;
end



function onClickDown(button, x, y)
	if not disabled and not isReadOnly() then
		if sourcenode then
			local value = sourcenode.getValue();
			if value == "PR" then
				sourcenode.setValue("BR");
			elseif value == "BR" then
				sourcenode.setValue("AG");
			elseif value == "AG" then
				sourcenode.setValue("IN");
			elseif value == "IN" then
				sourcenode.setValue("CU");
			elseif value == "CU" then
				sourcenode.setValue("WI");
			else
				sourcenode.setValue("PR");

			end
		end
	end
end


function onValueChanged()
	if isVisible() then
		if window.VisDataCleared then
			if getValue() == 0 then
				window.VisDataCleared();
			end
		end
	else
		if window.InvisDataAdded then
			if getValue() ~= 0 then
				window.InvisDataAdded();
			end
		end
	end
end
