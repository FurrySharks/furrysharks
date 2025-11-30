

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


local EXPECTED_URL = "https://raw.githubusercontent.com/FurrySharks/furrysharks/refs/heads/main/yaya.lua"

local function checkSource()
    local success, hash = pcall(getscripthash)
    if not success then return false end
    
    local currentUrl = "https://raw.githubusercontent.com/" .. hash
    
    if currentUrl ~= EXPECTED_URL and currentUrl ~= EXPECTED_URL:gsub("refs/heads", "refs/tags") then
        return false
    end
    return true
end

if not checkSource() then
    error("haha fuck off skid")
    -- или просто return / while true do task.wait(9e9) end
end

