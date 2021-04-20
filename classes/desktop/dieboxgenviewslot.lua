local control = nil;

function onInit()
	Debug.console("dieboxgenviewslot.lua: onInit()");
	control = self;
end

function setIdentityName(name)
	dieboxgenviewslotname.setValue(name);
	Debug.console("dieboxgenviewslot.lua - identity name: " .. name);
	if User.getIdentityLabel(name) == "" or name == "GM" or User.getIdentityLabel(User.getCurrentIdentity(name)) == nil or User.getIdentityLabel(User.getCurrentIdentity(name)) == User.getIdentityLabel(User.getCurrentIdentity()) then
		Debug.console("dieboxgenviewslot.lua - setting dieboxgenviewplayername to identity name: " .. name);
		dieboxgenviewplayername.setValue(name);
	else
		Debug.console("dieboxgenviewslot.lua - setting dieboxgenviewplayername to identity label: " .. User.getIdentityLabel(User.getCurrentIdentity(name)) .. ", based off identity name = " .. name);
		dieboxgenviewplayername.setValue(User.getIdentityLabel(User.getCurrentIdentity(name)));
	end
end

function getIdentityName()
	return dieboxgenviewslotname.getValue();
end