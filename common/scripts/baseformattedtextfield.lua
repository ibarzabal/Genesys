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

function onDoubleClick()
	update(true);
end

function update(Reverse)
	if not updating and not no_symbol_convertion then
		if sourcenode and sourcenode.isOwner() and not sourcenode.isStatic() then

			-- set the updating flag
			updating = true;

			-- get the source node value
			local oldvalue = sourcenode.getValue();
			local newvalue = StringManagerGenesys.ReplaceCodeWithSymbols(oldvalue, Reverse);

			-- set the source node value
			if newvalue ~= oldvalue then
				sourcenode.setValue(newvalue);
			end

			-- clear the update flag
			updating = false;

		end
	end
end
