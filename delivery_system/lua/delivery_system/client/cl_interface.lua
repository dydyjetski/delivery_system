DELIVERY.isMenuOpen = false

function DELIVERY:OpenMenu()
    if DELIVERY.isMenuOpen then return end
    DELIVERY.isMenuOpen = true

    if IsValid(self.vMainMenu) then
        self.vMainMenu:Remove()
    end
    
    local vFrame = GtaLib:createMenu("AJ Menu", "Test subtitle")
    vFrame:setTitle("Delivery System") 
    vFrame:setSubtitle("Prêt à travailler ?") 
    vFrame:isClosable(true)
    vFrame.onClose = function() 
        DELIVERY.isMenuOpen = false
    end
    self.vMainMenu = vFrame

	
    GtaLib:drawMenu(vFrame, function(menu)
		GtaLib:button(menu, "Prendre une mission !", "", {
            onActive = function()
                if LocalPlayer():GetNWBool("IsOnDelivery", false) then LocalPlayer():ChatPrint("Je t'ai déjà assigner une tâche !") return end
				net.Start("DIDI:START_DELIVERY")
				net.SendToServer()
				menu:close()
            end,
            onHovered = function()
            end
        }, { textColor = color_red, rightText = ""} )

		if LocalPlayer():GetNWInt("PackageCount", 0) >= 1 then
		    GtaLib:button(menu, "Vendre mes colis", "Vous avez " .. LocalPlayer():GetNWInt("PackageCount", 0) .. " colis sur vous.", {
            onActive = function()
                net.Start("DIDI:SELL_PACKAGES")
				net.SendToServer()
				menu:close()
            end,
            onHovered = function()
            end
        }, { textColor = color_red, rightText = ""} )
		end

        GtaLib:button(menu, "Fermer", "", {
            onActive = function()
                menu:close()
            end,
            onHovered = function()
            end
        }, { textColor = Color(255,0,0), rightText = ""} )
    end)
end


net.Receive("DIDI:OPEN_DELIVERY_SYSTEM_NPC", function()
	DELIVERY:OpenMenu()
end)