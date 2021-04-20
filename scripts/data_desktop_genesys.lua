-- 
-- Please see the license.html file included with this distribution for 
-- attribution and copyright information.
--

function onInit()
	for k,v in pairs(aDataModuleSet) do
		for _,v2 in ipairs(v) do
			Desktop.addDataModuleSet(k, v2);
		end
	end
end

aDataModuleSet = 
{
	["local"] =
	{
		{
			name = "3.5E - SRD",
			modules =
			{
				{ name = "3.5E Basic Rules" },
				{ name = "3.5E Magic Items" },
				{ name = "3.5E Spells" },
			},
		},
	},
	["client"] =
	{
		{
			name = "3.5E - SRD",
			modules =
			{
				{ name = "3.5E Basic Rules" },
				{ name = "3.5E Spells" },
			},
		},
	},
	["host"] =
	{
		{
			name = "3.5E - SRD",
			modules =
			{
				{ name = "3.5E Basic Rules" },
				{ name = "3.5E Magic Items" },
				{ name = "3.5E Monsters" },
				{ name = "3.5E Spells" },
			},
		},
	},
};
