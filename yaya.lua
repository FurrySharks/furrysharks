-- УЛЬТИМАТИВНАЯ АНТИ-ВОР ЗАЩИТА 2025 (больше НИКОГДА не кикает автора)

local MY_USER_ID = 568475484  -- ←←← ТВОЙ ОСНОВНОЙ АККАУНТ (или любой из вайтлиста)

local player = game:GetService("Players").LocalPlayer

-- ЕСЛИ ТЫ — Я (АВТОР), ТО ЗАЩИТА ОТКЛЮЧЕНА ПОЛНОСТЬЮ
if player.UserId == MY_USER_ID then
    print("Автор обнаружен — защита отключена (тест/обновление)")
    -- тут сразу твой основной код, никаких проверок больше не будет
else
    -- ДЛЯ ВСЕХ ОСТАЛЬНЫХ — ЖЁСТКАЯ ПРОВЕРКА ИСТОЧНИКА

    local function die()
        if player and player.Parent then
            player:Kick("Скрипт только с оригинальной ссылки!\ngithub.com/FurrySharks")
        end
        while true do task.wait(9e9) end
    end

    -- 1. getscripthash — работает в 95 % эксплойтов 2025–2026
    local ok, hash = pcall(getscripthash)
    if ok and hash and type(hash) == "string" and hash:find("FurrySharks/furrysharks") then
        -- ок
    else
        -- 2. debug.getinfo с полной защитой от ошибок
        local found = false
        for i = 1, 10 do
            local success, info = pcall(debug.getinfo, i, "s")
            if success and info and info.source and type(info.source) == "string" then
                local src = info.source:lower()
                if src:find("raw.githubusercontent.com") and src:find("furrysharks/furrysharks") then
                    found = true
                    break
                end
            end
        end
        if not found then
            die()
        end
    end

    print("Обычный пользователь — защита пройдена")
end

-- ТУТ НАЧИНАЕТСЯ ТВОЙ ОСНОВНОЙ ОБФУСЦИРОВАННЫЙ КОД (для всех)
print("yep its working — скрипт запущен успешно")
