-- Notify a player with the specified message
function DELIVERY:Notify(pPlayer, sContent)

	assert(IsValid(pPlayer) and pPlayer:IsPlayer(), "Unable to notify an invalid player entity")

	if DarkRP then
		return DarkRP.notify(pPlayer, 0, 7, sContent)
	end

	return pPlayer:PrintMessage(HUD_PRINTTALK, sContent)
	
end

net.Receive("DIDI:START_DELIVERY", function(len, ply)
    if not IsValid(ply) then return end

    local npc
    for _, ent in ipairs(ents.FindByClass("npc_delivery")) do
        if ent:GetPos():DistToSqr(ply:GetPos()) <= 150 * 150 then
            npc = ent
            break
        end
    end

    if not IsValid(npc) then
        ply:ChatPrint("Tu dois être à côté du livreur pour prendre une mission.")
        return
    end

    local spawnPos = DELIVERY.Config.DeliveryPos[math.random(#DELIVERY.Config.DeliveryPos)]
    local ent = ents.Create("delivery_box")
    if not IsValid(ent) then return end

    ent:SetPos(spawnPos)
    ent:Spawn()

    ent.DeliveryOwner = ply 

	ent:SetNWEntity("DeliveryOwner", ply)
    ply:SetNWBool("IsOnDelivery", true)
end)

net.Receive("DIDI:SELL_PACKAGES", function(len, ply)
    if not IsValid(ply) then return end

    local npc
    for _, ent in ipairs(ents.FindByClass("npc_delivery")) do
        if ent:GetPos():DistToSqr(ply:GetPos()) <= 150 * 150 then
            npc = ent
            break
        end
    end

    if not IsValid(npc) then
        ply:ChatPrint("Tu dois être à côté du livreur pour vendre tes colis.")
        return
    end
    
    local count = ply:GetNWInt("PackageCount", 0)
    if count <= 0 then
        ply:ChatPrint("Tu n'as aucun colis à vendre.")
        return
    end

    local baseReward = count * DELIVERY.Config.Reward
    local userGroup = ply:GetUserGroup()
    local groupBonus = DELIVERY.Config.GroupBonus[userGroup] or 0
    local bonusAmount = baseReward * groupBonus
    local gain = baseReward + bonusAmount

    ply:addMoney(gain)

    ply:ChatPrint("Tu as gagné " .. DarkRP.formatMoney(gain) .. (groupBonus > 0 and " (bonus " .. (groupBonus * 100) .. "%)" or ""))

    ply:SetNWInt("PackageCount", 0) 
end)