--// 100% РАБОЧАЯ ЗАЩАЯ ЗАЩИТА ОТ ВОРОВСТВА 2025 (без ошибок)

local allowedUserIDs = {1411788887, 3614588702, 8692629785, 8602525544}

-- 1. Вайтлист
local player = game:GetService("Players").LocalPlayer
if not table.find(allowedUserIDs, player.UserId) then
    player:Kick("Ты не в вайтлисте")
    while true do end
end

-- 2. Проверка источника (главное — без ошибок и без ложных киков)
local function isOriginalScript()
    -- Способ 1: getscripthash() — самый точный и надёжный
    local ok, hash = pcall(getscripthash)
    if ok and hash and type(hash) == "string" and hash:find("FurrySharks/furrysharks") then
        return true
    end

    -- Способ 2: debug.getinfo с безопасной обработкой
    for i = 1, 6 do
        local ok2, info = pcall(debug.getinfo, i, "s")
        if ok2 and info and info.source and type(info.source) == "string" then
            local src = info.source:lower()
            if src:find("raw.githubusercontent.com") 
            and src:find("furrysharks/furrysharks") then
                return true
            end
        end
    end

    return false
end

if not isOriginalScript() then
    if player and player.Kick then
        player:Kick("Скрипт украден или запущен не с оригинальной ссылки!\nОригинал только у FurrySharks")
    end
    while true do task.wait(9e9) end
end

print("yep its working — защита пройдена!")
