local container = {}

local CollectionService = game:GetService("CollectionService")
local UserStates = Character.UserStates

local ConnectionTable = {}
local Charging = false

function container.ToggleCharge()
    Charging = not Charging
    
    if Charging then
        IsCharging()
    else
        NotCharging()
    end
end

-- Creates charge value in character userstates to make client sprint for you
-- WILL RETURN THE OBJECT ONCE CREATED
function CreateCharge()
    local NewCharge = Instance.new("NumberValue")
    NewCharge.Name = "Charge"
    NewCharge.Value = 0
    NewCharge.Parent = UserStates.SpeedModifiers
  
    coroutine.wrap(function()
        task.wait(0.25)
        NewCharge.Value = 24
    end)()

    return NewCharge
end

-- Logic for when the charging boolean is true, makes the player charge and keep
-- charging until its toggled off

function IsCharging()
    CollectionService:AddTag(Character, "Charging")

    local chargeItem = CreateCharge()

    local ReCharge
    ReCharge = CollectionService:GetInstanceRemovedSignal("Charging"):Connect(function(inst)
    if inst == Character then
        task.wait(.2)

            for _, check in pairs(UserStates.SpeedModifiers:GetChildren()) do
                if check.Name == "Charge" then
                    check:Destroy()
                end
            end

            CollectionService:AddTag(Character, "Charging")
            chargeItem = CreateCharge()

            ConnectionTable["NewCharge"] = {chargeItem, ReCharge}
        end
    end)

    ConnectionTable["NewCharge"] = {chargeItem, ReCharge}
end

-- Logic to cleanup all of the charging connections to get rid of charge

function NotCharging()
    if ConnectionTable["NewCharge"] then
        for _, check in pairs(UserStates.SpeedModifiers:GetChildren()) do
            if check.Name == "Charge" then
                check:Destroy()
            end
        end

        ConnectionTable["NewCharge"][2]:Disconnect()
        ConnectionTable["NewCharge"] = nil
    end

    CollectionService:RemoveTag(Character, "Charging")
end
