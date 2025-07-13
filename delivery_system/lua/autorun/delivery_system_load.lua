-- Loader file for 'delivery_system'
-- Automatically created by gcreator (github.com/wasied)
DELIVERY = {}

-- Make loading functions
local function Inclu(f) return include("delivery_system/"..f) end
local function AddCS(f) return AddCSLuaFile("delivery_system/"..f) end
local function IncAdd(f) return Inclu(f), AddCS(f) end

-- Load addon files
IncAdd("config.lua")
-- IncAdd("constants.lua")

local tResources = {
	"resource/fonts/*.ttf"
}

if SERVER then

	-- Automatically find resources to load
	for _, sPath in ipairs(tResources) do

		local tFiles = file.Find("addons/delivery_system/"..sPath, "GAME")

		for _, sFile in ipairs(tFiles or {}) do
			resource.AddSingleFile(string.GetPathFromFilename(sPath)..sFile)
		end

	end

	Inclu("server/sv_functions.lua")
	Inclu("server/sv_hooks.lua")
	Inclu("server/sv_network.lua")

	AddCS("client/cl_functions.lua")
	AddCS("client/cl_hooks.lua")
	AddCS("client/cl_interface.lua")

else

	Inclu("client/cl_functions.lua")
	Inclu("client/cl_hooks.lua")
	Inclu("client/cl_interface.lua")

end