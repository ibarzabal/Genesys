-- GENESYS: replacing CORE column_ft.lua

--
-- Please see the license.html file included with this distribution for
-- attribution and copyright information.
--

 -- GENESYS
local updating = false;

function onLoseFocus()
	update();
end

function onGainFocus()
	update(true);
end


function update(Reverse)
	-- GENESYS
	-- Replaces special codes with Genesys Symbols
	local node = getDatabaseNode();
	if not updating then
		if node and node.isOwner() and not node.isStatic() then
			-- set the updating flag
			updating = true;
			-- get the source node value
			local oldvalue = node.getValue();
			local newvalue
			local newvalue = StringManagerGenesys.ReplaceCodeWithSymbolsCHR(oldvalue, Reverse);
			if newvalue ~= oldvalue then
				node.setValue(newvalue);
			end
			-- clear the update flag
			updating = false;
		end
	end
end
