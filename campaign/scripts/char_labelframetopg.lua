local widget = nil;

function onInit()
	if icons and icons[1] then
		setIcon(icons[1]);
	end
end

function setIcon(sIcon)
	if widget then
		widget.destroy();
	end

	if sIcon then
		widget = addBitmapWidget(sIcon);
		widget.setPosition("topleft", 2, 10);
	end
end


function onDoubleClick(x, y)
  if target and target[1] then
    Interface.openWindow("masterindex",target[1]);
  end
end
