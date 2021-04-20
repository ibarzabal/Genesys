local sourcenode = nil;
local updating = false;

function onInit()
	sourcenode = getDatabaseNode();
	if sourcenode then
		if sourcenode.isStatic() then
			--setEnabled(false);
			setReadOnly(true);
		end
	end
end

function onClose()
	update();
end

function onLoseFocus()
	update();
end

function update()
	-- GENESYS
	-- Replaces special codes with Genesys Symbols
	if not updating then
		if sourcenode and sourcenode.isOwner() and not sourcenode.isStatic() then
			-- set the updating flag
			updating = true;
			-- get the source node value
			local oldvalue = sourcenode.getValue();
			local newvalue = StringManagerGenesys.ReplaceCodeWithSymbols(oldvalue);
			if newvalue ~= oldvalue then
				sourcenode.setValue(newvalue);
			end
			-- clear the update flag
			updating = false;
		end
	end
end



function onDrop(x, y, draginfo)
	return false;
end
