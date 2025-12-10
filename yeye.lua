-- HWID PROTECTION
local allowedHWIDs = {
    "7eb53080-c826-11ee-a3b9-806e6f6e6963",
}

local function getHWID()
    if gethwid then
        return gethwid()
    elseif game:GetService("RbxAnalyticsService") then
        return game:GetService("RbxAnalyticsService"):GetClientId()
    end
    return nil
end

local currentHWID = getHWID()
if not currentHWID then 
    while true do end
end

local authorized = false
for _, hwid in ipairs(allowedHWIDs) do
    if currentHWID == hwid then
        authorized = true
        break
    end
end

if not authorized then
    while true do end
end

