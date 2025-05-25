local container = {}

function container.CheckGrab()
    local UserStates = Character.UserStates
    
    if UserStates.Grabbed.Value == 0 and UserStates.Pin.Value == "None" then
        return false
    end
    return true
end

return container
