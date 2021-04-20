--
-- Please see the license.html file included with this distribution for
-- attribution and copyright information.
--

function onInit()
	ItemManager.setCustomCharAdd(onCharItemAdd);
end

function updateEncumbrance(nodeChar)
	local nEncTotal = 0;

	local nCount, nWeight;
	for _,vNode in pairs(DB.getChildren(nodeChar, "inventorylist")) do
		if DB.getValue(vNode, "carried", 0) ~= 0 then
			nCount = DB.getValue(vNode, "count", 0);
			if nCount < 1 then
				nCount = 1;
			end
			nWeight = DB.getValue(vNode, "weight", 0);

			nEncTotal = nEncTotal + (nCount * nWeight);
		end
	end

	DB.setValue(nodeChar, "encumbrance.load", "number", nEncTotal);
end

function onCharItemAdd(nodeItem)
	DB.setValue(nodeItem, "carried", "number", 1);
end

function resolveRefNode(sRecord)
	local nodeSource = DB.findNode(sRecord);
	if not nodeSource then
		local sRecordSansModule = StringManager.split(sRecord, "@")[1];
		nodeSource = DB.findNode(sRecordSansModule .. "@*");
		if not nodeSource then
			ChatManager.SystemMessage(Interface.getString("char_error_missingrecord"));
		end
	end
	return nodeSource;
end


--
-- CHARACTER SHEET DROPS
--

function addInfoDB(nodeChar, sClass, sRecord, nodeTargetList)
	if not nodeChar then
		return false;
	end

	if sClass == "referencespecies_archetype" then
		addSpecies(nodeChar, sClass, sRecord);
	elseif sClass == "referencecareer" then
		addCareer(nodeChar, sClass, sRecord);

	elseif sClass == "referenceracialtrait" then
		addRacialTrait(nodeChar, sClass, sRecord, nodeTargetList);
	elseif sClass == "referenceclassability" then
		addClassFeature(nodeChar, sClass, sRecord, nodeTargetList);
	elseif sClass == "referencefeat" then
		addFeat(nodeChar, sClass, sRecord, nodeTargetList);
	else
		return false;
	end

	return true;
end


function addSpecies(nodeChar, sClass, sRecord)
	local nodeSource = resolveRefNode(sRecord);
	if not nodeSource then
		return;
	end

	local sspecies_archetype = DB.getValue(nodeSource, "name", "");

	local sFormat = Interface.getString("char_message_species_archetypeadd");
	local sMsg = string.format(sFormat, sspecies_archetype, DB.getValue(nodeChar, "name", ""));
	ChatManager.SystemMessage(sMsg);

	DB.setValue(nodeChar, "species_archetype", "string", sspecies_archetype);
	DB.setValue(nodeChar, "species_archetypelink", "windowreference", sClass, nodeSource.getNodeName());
end

function addCareer(nodeChar, sClass, sRecord)
	local nodeSource = resolveRefNode(sRecord);
	if not nodeSource then
		return;
	end

	local sspecies_archetype = DB.getValue(nodeSource, "name", "");

	local sFormat = Interface.getString("char_message_species_archetypeadd");
	local sMsg = string.format(sFormat, sspecies_archetype, DB.getValue(nodeChar, "name", ""));
	ChatManager.SystemMessage(sMsg);

	DB.setValue(nodeChar, "career", "string", sspecies_archetype);
	DB.setValue(nodeChar, "careerlink", "windowreference", sClass, nodeSource.getNodeName());
end
