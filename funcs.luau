local container = {}
local Character = game.Players.LocalPlayer.Character
local UserStates = Character.UserStates

function container.CheckGrab()
    if UserStates.Grabbed.Value == 0 and UserStates.Pin.Value == "None" then
        return false
    end
    return true
end

return container
