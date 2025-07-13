AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
    self:SetModel(table.Random(DELIVERY.Config.ModelPackage))
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)

    local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        phys:Wake()
    end
end

function ENT:Use(ply)
    if not IsValid(ply) or not ply:IsPlayer() then return end
    if ply ~= self.DeliveryOwner then
        ply:ChatPrint("Ce colis n'est pas pour toi !")
        return
    end

    ply:ChatPrint("Tu as récupéré le colis, retourne au NPC !")

    local currentCount = ply:GetNWInt("PackageCount", 0)
    ply:SetNWInt("PackageCount", currentCount + 1)

    ply:SetNWBool("IsOnDelivery", false)
    self:Remove()
end


hook.Add("PlayerInitialSpawn", "InitPackageCount", function(ply)
    ply:SetNWInt("PackageCount", 0)
    ply:SetNWBool("IsOnDelivery", false)
end)
