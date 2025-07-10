DELIVERY.Fonts = {}

-- Automatic responsive functions
RX = RX or function(x) return x / 1920 * ScrW() end
RY = RY or function(y) return y / 1080 * ScrH() end

-- Automatic font-creation function
function DELIVERY:Font(iSize, sType)

	iSize = iSize or 15
	sType = sType or "Medium" -- Availables: Thin, Light, Medium, SemiBold, Bold, ExtraBold, Italic

	local sName = ("DELIVERY:Font:%i:%s"):format(iSize, sType)
	if not DELIVERY.Fonts[sName] then

		surface.CreateFont(sName, {
			font = ("MontserratWasied %s"):format(sType):Trim(),
			size = RX(iSize),
			weight = 500,
			extended = false
		})

		DELIVERY.Fonts[sName] = true

	end

	return sName

end