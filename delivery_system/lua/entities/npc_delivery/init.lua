AddCSLuaFile("entities/npc_delivery/cl_init.lua")
AddCSLuaFile("entities/npc_delivery/shared.lua")

include ("entities/npc_delivery/shared.lua")

function ENT:Initialize()

    self:SetModel(DELIVERY.Config.Model) 
    self:SetHullType(HULL_HUMAN)
    self:SetHullSizeNormal()
    self:SetNPCState(NPC_STATE_SCRIPT)
    self:SetSolid(SOLID_BBOX)
    self:SetUseType(SIMPLE_USE)
    self:DropToFloor()
end

local cooldowns = {}

function ENT:Use(activator, caller)
    if not IsValid(activator) or not activator:IsPlayer() then return end
    local distance = activator:GetPos():Distance(self:GetPos())
    if distance > 100 then return end
    local steamID = activator:SteamID() 
    if cooldowns[steamID] and CurTime() < cooldowns[steamID] then
        return 
    end

    local jobName = activator:getJobTable().name
    if jobName ~= DELIVERY.Config.AllowedTeams then
        activator:ChatPrint("Vous ne pouvez pas utiliser ce NPC avec votre métier.")
        return
    end




    net.Start("DIDI:OPEN_DELIVERY_SYSTEM_NPC")
    net.Send(activator)
end