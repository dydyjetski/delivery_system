include("shared.lua")

function ENT:Draw()
    self:DrawModel()
end

hook.Add("HUDPaint", "MyAddon_DrawDeliveryText", function()
    local ply = LocalPlayer()
    if not IsValid(ply) then return end

    local ent = nil
    for _, e in pairs(ents.FindByClass("delivery_box")) do
        if IsValid(e) and e:GetNWEntity("DeliveryOwner") == ply then
            ent = e
            break
        end
    end

    if not IsValid(ent) then return end

    local pos = ent:GetPos() + Vector(0, 0, 80)
    local screenPos = pos:ToScreen()

    local dist = ply:GetPos():Distance(ent:GetPos())
    local km = math.Round(dist / 1000, 2)

    draw.SimpleText(
        "Le colis est ici !",
        DELIVERY:Font(25),
        screenPos.x,
        screenPos.y - 20,
        Color(255, 200, 0, 255),
        TEXT_ALIGN_CENTER,
        TEXT_ALIGN_CENTER
    )

    draw.SimpleText(
        km .. " km",
        DELIVERY:Font(15),
        screenPos.x,
        screenPos.y ,
        Color(255, 255, 255, 255),
        TEXT_ALIGN_CENTER,
        TEXT_ALIGN_CENTER
    )
end)
