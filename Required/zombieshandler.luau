local container = {}

local LocalPlayer = game.Players.LocalPlayer
local ZombiesFolder = workspace:WaitForChild("Zombies")
local Map = workspace:FindFirstChild("Map", true)

local PROXIMITY_RADIUS_HIT = 25
local PROXIMITY_RADIUS_PUSH = 5

local SPECIAL_ZOMBIE_COLORS = {
    ["Barrel"] = Color3.new(1, 1, 1),
    ["Fast"] = Color3.new(0.25, 1, 0.75),
    ["Cuirassier"] = Color3.new(1, 0, 0.05)
}

function createAdornment(Size, AlwaysOnTop, ZombieType)
    local Adornment = Instance.new("BoxHandleAdornment")
    Adornment.Size = Size
    Adornment.AlwaysOnTop = AlwaysOnTop
    Adornment.Transparency = .5
    
    local IsSpecial = SPECIAL_ZOMBIE_COLORS[ZombieType]
    
    if IsSpecial then
        Adornment.Color3 = IsSpecial -- Color them for special colors, then NEVER color again
    end
    
    return Adornment
end

function updateAdornment(Adornment, ZombieHumanoid)
    local Health, MaxHealth = ZombieHumanoid.Health, ZombieHumanoid.MaxHealth
    Adornment.Color3 = Color3.fromHSV(0.336 * (Health/MaxHealth), 1, 1)
end

function container.updateZombieHandles(Zombies)
    for _, ZombieData in pairs(Zombies) do
        local Zombie = ZombieData[1] -- The zombie model itself
        local ZombieRoot = ZombieData[2]
        local ZombieHumanoid = ZombieData[3]
        local ZombieType = ZombieData[4]
        
        local Adornment = Zombie:FindFirstChildOfClass("BoxHandleAdornment")
        local IsSpecial = SPECIAL_ZOMBIE_COLORS[ZombieType]
        
        if Adornment then
            if IsSpecial then
                continue
            else
                updateAdornment(Adornment, ZombieHumanoid)
                continue
            end
        else
            Adornment = createAdornment(Vector3.new(.5, .5, .5), true, ZombieType)
        
            Adornment.ZIndex = 1
            Adornment.Adornee = ZombieRoot
            Adornment.Parent = Zombie
        
            if not IsSpecial then
                updateAdornment(Adornment, ZombieHumanoid)
            end
        end
    end
end

function container.getNearbyZombies()
    local Zombies = {}

    for _, Zombie in pairs(ZombiesFolder:GetChildren()) do
        if Zombie.Name ~= "Agent" and Zombie.Name ~= "Slim" then
            continue
        end
        
        local ZombieHumanoid = Zombie:FindFirstChildOfClass("Humanoid")
        local ZombieRoot = Zombie:FindFirstChild("HumanoidRootPart")

        if not (ZombieHumanoid and ZombieRoot) then
            continue
        end
        
        local ZombieType = Zombie:GetAttribute("Type")

        table.insert(Zombies, {Zombie, ZombieRoot, ZombieHumanoid, ZombieType})
    end

    local ModesFolder = Map.Parent:FindFirstChild("Modes")

    for _, ObjZombie in pairs(ModesFoder:GetDescendants()) do
        local ZombieHumanoid = Zombie:FindFirstChildOfClass("Humanoid")
        local ZombieRoot = Zombie:FindFirstChild("HumanoidRootPart")

        if not (ZombieHumanoid and ZombieRoot) then
            continue
        end

        table.insert(Zombies, {ObjZombie, ZombieRoot, ZombieHumanoid, "Barrel"})
    end

    return Zombies
end

function container.getNearbyZombiesFiltered(HitBombers)
    local Zombies = container.getNearbyZombies()
    
    local ToHit = {}
    local ToPush = {}
    
    for _, ZombieData in pairs(Zombies) do
        local Zombie = ZombieData[1] -- The zombie model itself
        local ZombieRoot = ZombieData[2]
        local ZombieHumanoid = ZombieData[3]
        local ZombieType = ZombieData[4]
        
        if not HitBombers and ZombieType == "Barrel" then
            continue
        end
    
        local Dist = LocalPlayer:DistanceFromCharacter(ZombieRoot.Position)
    
        if Dist > PROXIMITY_RADIUS_PUSH and Dist <= PROXIMITY_RADIUS_HIT then
            table.insert(ToHit, {Zombie, ZombieRoot})
        elseif Dist <= PROXIMITY_RADIUS_PUSH then
            table.insert(ToPush, {Zombie, ZombieRoot})
        end
    end

    return ToHit, ToPush
end

return container
