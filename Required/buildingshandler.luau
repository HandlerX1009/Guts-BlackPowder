local container = {}

local LocalPlayer = game.Players.LocalPlayer
local Backpack = LocalPlayer.Backpack

local Hammer = Backpack:FindFirstChild("Hammer")

local ENABLED = false
if not Hammer then
    warn("Player does not have hammer - disabling auto repair")
    ENABLED = true
end

local BuildingsFolder = workspace.Buildings

local MAX_HEALTH_COLOR = Color3.new(0, 0, 1)

function CreateAdornment(buildingHitbox)
    local Adornment = Instance.new("BoxHandleAdornment")
    Adornment.Size = Vector3.new(1, 6, 1)
    Adornment.Transparency = .5
    Adornment.ZIndex = 1

    Adornment.Adornee = buildingHitbox
    return Adornment
end

function GetBuildings()
    local Buildings = {}
    local PlayerFolders = {}
    
    for _, PlayerFolder in pairs(BuildingsFolder:GetChildren()) do
        table.insert(PlayerFolders, unpack(PlayerFolder:GetChildren()))
    end
    
    for _, Building in pairs(PlayerFolders) do
        local BuildingHealth = Building:FindFirstChild("BuildingHealth")
        local Hitbox = Building:FindFirstChild("Hitbox")
        
        if not (BuildingHealth and Hitbox) then
            continue
        end

        local BuildingMaxHealth = BuildingHealth:GetAttribute("MaxHealth")
        
        table.insert(Buildings, {Building, Hitbox, BuildingHealth, BuildingMaxHealth})
    end
    
    return Buildings
end

function container.UpdateandRepairBuildings()
    local Buildings = GetBuildings()

    for _, buildingData in pairs(Buildings)
        local building = buildingData[1]
        local buildingHitbox = buildingData[2]
        local health, maxhealth = buildingData[3], buildingData[4] -- Health is a NumberValue object, while maxhealth is an attribute from that

        local adornment = building:FindFirstChildOfClass("BoxHandleAdornment")

        if not adornment then
            adornment = CreateAdornment(buildingHitbox)
            adornment.Parent = building
        end

        if health.Value == maxhealth then
            adornment.Color3 = MAX_HEALTH_COLOR
        else
            adornment.Color3 = Color3.fromHSV(0.336*(health/maxhealth), 1, 1)
        end
  
        if health >= maxhealth or not ENABLED then
            continue
        end

        Hammer.RemoteEvent:FireServer("Repair", health)
    end
end

return container
