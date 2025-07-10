DELIVERY.Config = {}

DELIVERY.Config.Model = "models/Barney.mdl" -- model du NPC qui donne les missions

DELIVERY.Config.ModelPackage = { -- différent model pour les colis
	"models/props_junk/cardboard_box001b.mdl",
	"models/props_junk/cardboard_box003a.mdl",
	"models/props_c17/SuitCase001a.mdl",
	"models/props_c17/BriefCase001a.mdl"
}

DELIVERY.Config.DeliveryPos = { -- où spawn les colis
	Vector(-1877.735596, -4002.236572, -13878.968750),
	Vector(-7703.411621, -2804.500000, -13879.968750)
}

DELIVERY.Config.AllowedTeams = "Citoyen" -- quel métier peut intéragir avec le NPC ?

DELIVERY.Config.Reward = 1000 -- combien on donne d'argent par colis ?

-- groupes avec bonus (en pourcentage)
DELIVERY.Config.GroupBonus = {
    ["vip"] = 0.005,       -- 0.5%
    ["superadmin"] = 0.1   -- 10%
}
