

local allowedUserIDs = {
    1411788887,
    3614588702,
    8692629785,
}

local function checkUserID()
    local player = game:GetService("Players").LocalPlayer
    local userID = player.UserId
    
    for _, allowedID in ipairs(allowedUserIDs) do
        if userID == allowedID then
            return true
        end
    end
    
    return false
end

if not checkUserID() then
    return
end
