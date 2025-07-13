include ("entities/npc_delivery/shared.lua")

function ENT:Draw()
    self:DrawModel()

    local rectHeight = 50 
    local barHeight = 10 

    local rectPosY =  -rectHeight / 2

    local leviationHeight = 2
    local leviationSpeed = 1 
    self.LeviationOffset = math.sin(CurTime() * leviationSpeed) * leviationHeight

    cam.Start3D2D(self:GetPos() + self:GetUp() * (80 + self.LeviationOffset), Angle(0, LocalPlayer():EyeAngles().y - 90, 90), 0.2)
        draw.SimpleText("Livraison", DELIVERY:Font(40), 0, rectPosY + rectHeight / 2 - barHeight / 2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    cam.End3D2D()      

end