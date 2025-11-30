

local allowedUserIDs = {
    1411788887,
    3614588702,
    8692629785,
    8602525544,
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


local EXPECTED = "FurrySharks/furrysharks" -- часть репозитория

local function isStolen()
    local info = debug.getinfo(2, "s")
    local source = info.source or ""
    
    
    if source:find("raw.githubusercontent.com") then
        if not source:find(EXPECTED) then
            return false -- оригинал
        end
    end
    return true
end

if isStolen() then
    while true do task.wait(10) end -- или error, или game.Players.LocalPlayer:Kick()
end

print("yep its working")

