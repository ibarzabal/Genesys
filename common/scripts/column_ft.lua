-- GENESYS: replacing CORE column_ft.lua

--
-- Please see the license.html file included with this distribution for
-- attribution and copyright information.
--

 -- GENESYS
local updating = false;
local node = nil;

function onInit()
	if isReadOnly() then
		self.update(true);
	else
		node = getDatabaseNode();
		if not node or node.isReadOnly() then
			self.update(true);
		end
	end
end

function onLoseFocus()
	update();
end

function onGainFocus()
	update(false,false,true);
end

function update(bReadOnly, bForceHide, Reverse)
	local bLocalShow;


	-- GENESYS
	-- Replaces special codes with Genesys Symbols
	if not updating then
		if node and node.isOwner() and not node.isStatic() then
			-- set the updating flag
			updating = true;
			-- get the source node value
			local oldvalue = node.getValue();
			local newvalue = StringManagerGenesys.ReplaceCodeWithSymbols(oldvalue, Reverse);
			if newvalue ~= oldvalue then
				node.setValue(newvalue);
			end
			-- clear the update flag
			updating = false;
		end
	end

	if bForceHide then
		bLocalShow = false;
	else
		bLocalShow = true;
		if bReadOnly and not nohide and isEmpty() then
			bLocalShow = false;
		end
	end

	setVisible(bLocalShow);
	setReadOnly(bReadOnly);

	local sLabel = getName() .. "_label";
	if window[sLabel] then
		window[sLabel].setVisible(bLocalShow);
	end
	if separator then
		if window[separator[1]] then
			window[separator[1]].setVisible(bLocalShow);
		end
	end

	if self.onVisUpdate then
		self.onVisUpdate(bLocalShow, bReadOnly);
	end

	return bLocalShow;
end

function onVisUpdate(bLocalShow, bReadOnly)
	if bReadOnly then
		setFrame(nil);
	else
		setFrame("fielddark", 7,5,7,5);
	end
end

function onValueChanged()
	if isVisible() then
		if window.VisDataCleared then
			if isEmpty() then
				window.VisDataCleared();
			end
		end
	else
		if window.InvisDataAdded then
			if not isEmpty() then
				window.InvisDataAdded();
			end
		end
	end
end
