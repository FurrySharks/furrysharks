

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


local function isOriginal()
    -- Способ 1: getscripthash() — самый надёжный (есть почти во всех актуальных эксплойтах)
    local success, hash = pcall(getscripthash)
    if success and hash and hash:find("FurrySharks/furrysharks") then
        return true
    end

    -- Способ 2: debug источник (работает всегда)
    for i = 1, 5 do
        local info = debug.getinfo(i, "s")
        if info and info.source then
            local src = info.source:lower()
            if src:find("raw.githubusercontent.com") 
            and src:find("furrysharks/furrysharks") 
            and src:find("yaya.lua") then
                return true
            end
        end
    end

    return false
end

-- Если не оригинал — кик + вечный цикл
if not isOriginal() then
    local plr = game:GetService("Players").LocalPlayer
    if plr then
        plr:Kick("Скрипт украден или запущен не с оригинальной ссылки\nТолько от FurrySharks")
    end
    while true do task.wait(9e9) end
end

print("yep its working")
