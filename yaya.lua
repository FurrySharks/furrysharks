-- ЖЁСТКАЯ ЗАЩИТА ПО ТОЧНОЙ ССЫЛКЕ (декабрь 2025, работает везде)

local OFFICIAL_URL = "https://raw.githubusercontent.com/ramzesuskan/godshub/refs/heads/main/mommy.lua"

local function getCurrentScriptUrl()
    -- Способ 1: getscripthash() — возвращает точный путь на GitHub (лучший способ 2025-2026)
    local ok, hash = pcall(getscripthash)
    if ok and hash and type(hash) == "string" and hash ~= "" then
        return "https://raw.githubusercontent.com/" .. hash:gsub("^/+", "")
    end

    -- Способ 2: debug.getinfo — на случай очень старого эксплойта
    for i = 1, 10 do
        local success, info = pcall(debug.getinfo, i, "s")
        if success and info and info.source then
            local src = info.source
            if src:sub(1,1) == "@" then
                src = src:sub(2) -- убираем @
                if src:find("https://") or src:find("http://") then
                    return src:lower()
                end
            end
        end
    end

    return nil
end

local currentUrl = getCurrentScriptUrl()

if not currentUrl or not currentUrl:find(OFFICIAL_URL:lower()) then
    -- Это не твоя ссылка → в топку
    local plr = game:GetService("Players").LocalPlayer
    if plr then
        plr:Kick("Этот скрипт работает ТОЛЬКО с официальной ссылки!\n\nПравильная:\n" .. OFFICIAL_URL)
    end
    while true do task.wait(9e9) end
end

-- Если дошёл сюда — значит человек запустил именно через твою ссылку
print("Оригинальная ссылка подтверждена! Скрипт запущен.")
