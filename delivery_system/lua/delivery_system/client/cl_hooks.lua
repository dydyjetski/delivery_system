-- Clear fonts cache after a screen size change
hook.Add("OnScreenSizeChanged", "DELIVERY:OnScreenSizeChanged", function()
	DELIVERY.Fonts = {}
end)