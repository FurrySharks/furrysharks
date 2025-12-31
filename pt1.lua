--////////////////////////////////////////////////////////
--            HellYeah HUB - By 7g0d
--////////////////////////////////////////////////////////

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

-------------------------------------------------------------------------------
--    1.ScreenGui (mainFrame)
-------------------------------------------------------------------------------

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "VenomHubScreenGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Name = "VenomHubMainFrame"
mainFrame.Size = UDim2.new(0, 280, 0, 600)
mainFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(199, 126, 58)
mainFrame.BorderSizePixel = 2
mainFrame.Visible = true
mainFrame.Active = true
mainFrame.Selectable = true
mainFrame.Parent = screenGui

-- Заголовок
local titleBar = Instance.new("TextLabel")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
titleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
titleBar.Font = Enum.Font.SourceSansBold
titleBar.TextSize = 18
titleBar.Text = "Again in prime"
titleBar.Parent = mainFrame

-- Подпись внизу
local footerLabel = Instance.new("TextLabel")
footerLabel.Size = UDim2.new(1, 0, 0, 20)
footerLabel.Position = UDim2.new(0, 0, 1, -20)
footerLabel.BackgroundTransparency = 1
footerLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
footerLabel.Font = Enum.Font.SourceSansSemibold
footerLabel.TextSize = 16
footerLabel.Text = "By 7g0d"
footerLabel.Parent = mainFrame

-- Вкладки
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, 0, 0, 30)
tabBar.Position = UDim2.new(0, 0, 0, 30)
tabBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
tabBar.Parent = mainFrame

local tabCorner = Instance.new("UICorner")
tabCorner.CornerRadius = UDim.new(0, 4)
tabCorner.Parent = tabBar

local tabStroke = Instance.new("UIStroke")
tabStroke.Color = Color3.fromRGB(100, 100, 100)
tabStroke.Thickness = 1
tabStroke.Parent = tabBar

local mainTabBtn = Instance.new("TextButton")
mainTabBtn.Size = UDim2.new(0.5, 0, 1, 0)
mainTabBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
mainTabBtn.Text = "Main"
mainTabBtn.TextColor3 = Color3.new(1,1,1)
mainTabBtn.Font = Enum.Font.SourceSansBold
mainTabBtn.TextSize = 16
mainTabBtn.Parent = tabBar

local mainTabCorner = Instance.new("UICorner")
mainTabCorner.CornerRadius = UDim.new(0, 4)
mainTabCorner.Parent = mainTabBtn

local mainTabStroke = Instance.new("UIStroke")
mainTabStroke.Color = Color3.fromRGB(120, 120, 120)
mainTabStroke.Thickness = 1
mainTabStroke.Parent = mainTabBtn

local devTabBtn = Instance.new("TextButton")
devTabBtn.Size = UDim2.new(0.5, 0, 1, 0)
devTabBtn.Position = UDim2.new(0.5, 0, 0, 0)
devTabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
devTabBtn.Text = "Dev Tools"
devTabBtn.TextColor3 = Color3.new(1,1,1)
devTabBtn.Font = Enum.Font.SourceSansBold
devTabBtn.TextSize = 16
devTabBtn.Parent = tabBar

local devTabCorner = Instance.new("UICorner")
devTabCorner.CornerRadius = UDim.new(0, 4)
devTabCorner.Parent = devTabBtn

local devTabStroke = Instance.new("UIStroke")
devTabStroke.Color = Color3.fromRGB(100, 100, 100)
devTabStroke.Thickness = 1
devTabStroke.Parent = devTabBtn

-- Hover effects
local function addHover(button, normalColor, hoverColor)
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = hoverColor
    end)
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = normalColor
    end)
end

addHover(mainTabBtn, Color3.fromRGB(80, 80, 80), Color3.fromRGB(100, 100, 100))
addHover(devTabBtn, Color3.fromRGB(50, 50, 50), Color3.fromRGB(70, 70, 70))

-- Основной контент
local mainContentFrame = Instance.new("ScrollingFrame")
mainContentFrame.Name = "MainContentFrame"
mainContentFrame.Size = UDim2.new(1, -10, 1, -80)  -- Учитывая таббар
mainContentFrame.Position = UDim2.new(0, 5, 0, 60)
mainContentFrame.BackgroundTransparency = 1
mainContentFrame.BorderSizePixel = 0
mainContentFrame.ScrollingDirection = Enum.ScrollingDirection.Y
mainContentFrame.ScrollBarThickness = 4
mainContentFrame.Parent = mainFrame
mainContentFrame.Visible = true

local mainUIListLayout = Instance.new("UIListLayout")
mainUIListLayout.Padding = UDim.new(0,5)
mainUIListLayout.Parent = mainContentFrame

-- Dev Tools контент
local devContentFrame = Instance.new("ScrollingFrame")
devContentFrame.Name = "DevContentFrame"
devContentFrame.Size = UDim2.new(1, -10, 1, -80)
devContentFrame.Position = UDim2.new(0, 5, 0, 60)
devContentFrame.BackgroundTransparency = 1
devContentFrame.BorderSizePixel = 0
devContentFrame.ScrollingDirection = Enum.ScrollingDirection.Y
devContentFrame.ScrollBarThickness = 4
devContentFrame.Parent = mainFrame
devContentFrame.Visible = false

local devUIListLayout = Instance.new("UIListLayout")
devUIListLayout.Padding = UDim.new(0,5)
devUIListLayout.Parent = devContentFrame

-- Переключение вкладок
local function switchTab(tab)
    if tab == "main" then
        mainContentFrame.Visible = true
        devContentFrame.Visible = false
        mainTabBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        devTabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        mainTabStroke.Color = Color3.fromRGB(120, 120, 120)
        devTabStroke.Color = Color3.fromRGB(100, 100, 100)
    else
        mainContentFrame.Visible = false
        devContentFrame.Visible = true
        mainTabBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        devTabBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        mainTabStroke.Color = Color3.fromRGB(100, 100, 100)
        devTabStroke.Color = Color3.fromRGB(120, 120, 120)
    end
end

mainTabBtn.MouseButton1Click:Connect(function() switchTab("main") end)
devTabBtn.MouseButton1Click:Connect(function() switchTab("dev") end)

-------------------------------------------------------------------------------
--    3. K keybind
-------------------------------------------------------------------------------
UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.K then
        mainFrame.Visible = not mainFrame.Visible
    end
end)

--========================== Admin Check ========================--
local AdminCheck_Enabled = false
local AdminCheck_Connection
local AdminCheck_Coroutine

local AdminList = {
    ["tabootvcat"] = true, ["Revenantic"] = true, ["Saabor"] = true, ["MoIitor"] = true,
    ["IAmUnderAMask"] = true, ["SheriffGorji"] = true, ["xXFireyScorpionXx"] = true,
    ["LoChips"] = true, ["DeliverCreations"] = true, ["TDXiswinning"] = true,
    ["TZZV"] = true, ["FelixVenue"] = true, ["SIEGFRlED"] = true, ["ARRYvvv"] = true,
    ["z_papermoon"] = true, ["Malpheasance"] = true, ["ModHandIer"] = true,
    ["valphex"] = true, ["J_anday"] = true, ["tvdisko"] = true, ["yIlehs"] = true,
    ["COLOSSUSBUILTOFSTEEL"] = true, ["SeizedHolder"] = true, ["r3shape"] = true,
    ["RVVZ"] = true, ["adurize"] = true, ["codedcosmetics"] = true,
    ["QuantumCaterpillar"] = true, ["FractalHarmonics"] = true, ["GalacticSculptor"] = true,
    ["oTheSilver"] = true, ["Kretacaous"] = true, ["icarus_xs1goliath"] = true,
    ["GlamorousDradon"] = true, ["rainjeremy"] = true, ["parachuter2000"] = true,
    ["faintermercury"] = true, ["harht"] = true, ["Sansek1252"] = true,
    ["Snorpuwu"] = true, ["BenAzoten"] = true, ["Cand1ebox"] = true, ["KeenlyAware"] = true,
    ["mrzued"] = true, ["BruhmanVIII"] = true, ["Nystesia"] = true, ["fausties"] = true,
    ["zateopp"] = true, ["Iordnabi"] = true, ["ReviveTheDevil"] = true, ["jake_jpeg"] = true,
    ["UncrossedMeat3888"] = true, ["realpenyy"] = true, ["karateeeh"] = true,
    ["JayyMlg"] = true, ["Lo_Chips"] = true, ["Avelosky"] = true, ["king_ab09"] = true,
    ["TigerLe123"] = true, ["Dalvanuis"] = true, ["iSonMillions"] = true,
    ["Cefasin"] = true, ["ulzig"] = true, ["DieYouOder"] = true, ["whosframed"] = true,
    ["b3THyb1T3z"] = true, ["0mtc"] = true,
}

local function CheckAdmins()
    local players = Players:GetPlayers()
    for i = 1, #players do
        if AdminList[players[i].Name] then
            LocalPlayer:Kick("Admin")
            wait(2)
            game:Shutdown()
            return
        end
    end
end

local function AdminCheck_Enable()
    if AdminCheck_Enabled then return end
    AdminCheck_Enabled = true

    CheckAdmins()

    AdminCheck_Connection = Players.PlayerAdded:Connect(function(plr)
        if AdminCheck_Enabled and AdminList[plr.Name] then
            LocalPlayer:Kick("Detected Nigger")
            wait(2)
            game:Shutdown()
        end
    end)

    AdminCheck_Coroutine = spawn(function()
        while AdminCheck_Enabled do
            CheckAdmins()
            wait(4)
        end
    end)
end

local function AdminCheck_Disable()
    if not AdminCheck_Enabled then return end
    AdminCheck_Enabled = false

    if AdminCheck_Connection then
        AdminCheck_Connection:Disconnect()
        AdminCheck_Connection = nil
    end
    if AdminCheck_Coroutine then
        cancel(AdminCheck_Coroutine)
        AdminCheck_Coroutine = nil
    end
end

--======================= Kill Button ===========================
-- Функция для полного отключения скрипта
local function killScript()
    -- Остановка всех активных процессов
    if Fly_Connection then Fly_Connection:Disconnect() end
    if AutoKeyPress_Connection then task.cancel(AutoKeyPress_Connection) end
    if AutoPressX_Connection then task.cancel(AutoPressX_Connection) end
    if AdminCheck_Connection then AdminCheck_Connection:Disconnect() end
    if AntiAFK_IdledConnection then AntiAFK_IdledConnection:Disconnect() end
    if MeleeAura_Connection then MeleeAura_Connection:Disconnect() end
    if TPFarm_SteppedConnection then TPFarm_SteppedConnection:Disconnect() end
    if TPFarm_RenderConnection then TPFarm_RenderConnection:Disconnect() end
    if TPFarm_CharConnection then TPFarm_CharConnection:Disconnect() end
    if SaveCube_Connection then SaveCube_Connection:Disconnect() end
    if SaveVibe_Connection then SaveVibe_Connection:Disconnect() end
    if SaveMount_Connection then SaveMount_Connection:Disconnect() end
    if NewSavePoint_Connection then NewSavePoint_Connection:Disconnect() end

    -- Удаление интерфейса
    if screenGui then
        screenGui:Destroy()
        screenGui = nil
    end

    -- Очистка переменных
    Fly_Enabled = false
    AutoKeyPress_Enabled = false
    AutoPressX_Enabled = false
    AdminCheck_Enabled = false
    AntiAFK_Enabled = false
    MeleeAura_Enabled = false
    TPFarm_Enabled = false
    SaveCube_Enabled = false
    SaveVibe_Enabled = false
    SaveMount_Enabled = false
    NewSavePoint_Enabled = false

    -- Сообщение в консоль
    print("Скрипт полностью отключен.")
end

-- Создание кнопки "Убить скрипт"
local killButtonFrame = Instance.new("Frame")
killButtonFrame.Size = UDim2.new(1, 0, 0, 30)
killButtonFrame.BackgroundTransparency = 1
killButtonFrame.Parent = mainContentFrame

local killButtonLabel = Instance.new("TextLabel")
killButtonLabel.Size = UDim2.new(0.4, 0, 1, 0)
killButtonLabel.BackgroundTransparency = 1
killButtonLabel.Text = "KILL BUTTON"
killButtonLabel.TextColor3 = Color3.new(1, 1, 1)
killButtonLabel.Font = Enum.Font.SourceSansSemibold
killButtonLabel.TextSize = 16
killButtonLabel.TextXAlignment = Enum.TextXAlignment.Left
killButtonLabel.Parent = killButtonFrame

local killButton = Instance.new("TextButton")
killButton.Size = UDim2.new(0.2, 0, 1, 0)
killButton.Position = UDim2.new(0.4, 5, 0, 0)
killButton.Font = Enum.Font.SourceSans
killButton.TextSize = 16
killButton.Text = "KILL"
killButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
killButton.TextColor3 = Color3.new(255, 255, 255)
killButton.Parent = killButtonFrame

-- Обработка нажатия на кнопку
killButton.MouseButton1Click:Connect(function()
    killScript() -- Функция вызывается только при нажатии на кнопку
    killButton.Text = "DONE"
    killButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0) -- Зеленый цвет после выполнения
    killButton.Active = false -- Делаем кнопку неактивной после нажатия
end)


--========================== Auto Clicker ===========================--
local AutoClicker_Enabled = false
local AutoClicker_Connection
local AutoClicker_ClickTime = 47
local AutoClicker_CooldownTime = 9

local function AutoClicker_Enable()
    if AutoClicker_Enabled then return end
    AutoClicker_Enabled = true

    AutoClicker_Connection = task.spawn(function()
        while AutoClicker_Enabled do
            -- Фаза кликов (53 секунды)
            local clickEndTime = os.clock() + AutoClicker_ClickTime
            
            while os.clock() < clickEndTime and AutoClicker_Enabled do
                -- Симулируем клик левой кнопкой мыши
                VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                task.wait(0.01)
                VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                
                -- Ждем 100 миллисекунд между кликами
                task.wait(0.1)
            end
            
            if not AutoClicker_Enabled then break end
            
            -- Фаза коoldown (7 секунд)
            local cooldownEndTime = os.clock() + AutoClicker_CooldownTime
            
            while os.clock() < cooldownEndTime and AutoClicker_Enabled do
                task.wait(0.1) -- Ждем небольшими интервалами для возможности прерывания
            end
        end
    end)
end

local function AutoClicker_Disable()
    if not AutoClicker_Enabled then return end
    AutoClicker_Enabled = false
    if AutoClicker_Connection then
        task.cancel(AutoClicker_Connection)
        AutoClicker_Connection = nil
    end
end

local function killScript()

AutoClicker_Disable()

end
--========================== Camera Freeze ===========================--
local CameraFreeze_Enabled = false
local CameraFreeze_Connection = nil
local CameraFreeze_Bind = Enum.KeyCode.F4
local FrozenCFrame = nil

local function FreezeCamera()
    if not CameraFreeze_Enabled then return end
    
    -- Запоминаем текущее положение камеры при первом включении
    if not FrozenCFrame then
        FrozenCFrame = workspace.CurrentCamera.CFrame
    end
    
    -- Фиксируем камеру
    workspace.CurrentCamera.CFrame = FrozenCFrame
    
    -- Блокируем ввод мыши
    if UserInputService.MouseBehavior ~= Enum.MouseBehavior.LockCurrentPosition then
        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
    end
end

local function UnfreezeCamera()
    if UserInputService.MouseBehavior == Enum.MouseBehavior.LockCurrentPosition then
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    end
    FrozenCFrame = nil
end

local function CameraFreeze_Enable()
    if CameraFreeze_Enabled then return end
    CameraFreeze_Enabled = true
    CameraFreeze_Connection = RunService.RenderStepped:Connect(FreezeCamera)
end

local function CameraFreeze_Disable()
    if not CameraFreeze_Enabled then return end
    CameraFreeze_Enabled = false
    if CameraFreeze_Connection then
        CameraFreeze_Connection:Disconnect()
        CameraFreeze_Connection = nil
    end
    UnfreezeCamera()
end

local function killScript()
    
    CameraFreeze_Disable()
    
end

--======================= INVISIBILITY ========================--
local InvisEnabled = false
local InvisConnection = nil
local InvisBind = nil

-- Инициализация персонажа
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")
local OriginalCameraOffset = Humanoid.CameraOffset

Player.CharacterAdded:Connect(function(NewCharacter)
    Character = NewCharacter
    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    Humanoid = Character:WaitForChild("Humanoid")
    OriginalCameraOffset = Humanoid.CameraOffset
    
    -- При смене персонажа выключаем невидимость
    InvisEnabled = false
    if InvisConnection then
        InvisConnection:Disconnect()
        InvisConnection = nil
    end
end)

local function Grounded()
    return Humanoid and Humanoid.Parent and Humanoid.FloorMaterial ~= Enum.Material.Air
end

local function ToggleInvisibility()
    if not Character:FindFirstChild("Torso") then return end
    
    InvisEnabled = not InvisEnabled
    
    -- ТОЧНО ТАК ЖЕ КАК В ИСХОДНОМ КОДЕ
    if InvisEnabled then
        workspace.CurrentCamera.CameraSubject = HumanoidRootPart
    else
        Humanoid.CameraOffset = OriginalCameraOffset
        workspace.CurrentCamera.CameraSubject = Humanoid
        
        -- Восстанавливаем прозрачность при выключении
        for _, v in pairs(Character:GetDescendants()) do
            if v:IsA("BasePart") and v.Transparency == 0.5 then
                v.Transparency = 0
            end
        end
    end
end

local function StartInvisLoop()
    if InvisConnection then
        InvisConnection:Disconnect()
    end
    
    InvisConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not InvisEnabled then
            -- При выключении восстанавливаем прозрачность
            for _, v in pairs(Character:GetDescendants()) do
                if v:IsA("BasePart") and v.Transparency == 0.5 then
                    v.Transparency = 0
                end
            end
            return
        end
        
        -- Основная логика невидимости
        local _, y = workspace.CurrentCamera.CFrame:ToOrientation()
        HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.CFrame.Position) * 
                                  CFrame.fromOrientation(0, y, 0)
        
        local OldCFrame = HumanoidRootPart.CFrame
        HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * 
                                  CFrame.Angles(math.rad(90), 0, 0)
        Humanoid.CameraOffset = Vector3.new(0, 1.44, 0)
        
        local Animation = Instance.new("Animation")
        Animation.AnimationId = "rbxassetid://215384594"
        
        local Track = Humanoid:LoadAnimation(Animation)
        Track.Priority = Enum.AnimationPriority.Action4
        Track:Play()
        Track:AdjustSpeed(0)
        Track.TimePosition = 0.3
        
        game:GetService("RunService").RenderStepped:Wait()
        Track:Stop()
        
        local LookVector = workspace.CurrentCamera.CFrame.LookVector
        local Horizontal = Vector3.new(LookVector.X, 0, LookVector.Z).Unit
        local TargetCFrame = CFrame.new(HumanoidRootPart.Position, 
                                        HumanoidRootPart.Position + Horizontal)
        HumanoidRootPart.CFrame = TargetCFrame
        
        -- Устанавливаем прозрачность
        for _, v in pairs(Character:GetDescendants()) do
            if v:IsA("BasePart") and v.Transparency ~= 1 then
                v.Transparency = 0.5
            end
        end
    end)
end

-- Функции для кнопки
local function InvisButton_Enable()
    if InvisEnabled then return end
    ToggleInvisibility()
    if InvisEnabled then
        StartInvisLoop()
    end
end

local function InvisButton_Disable()
    if not InvisEnabled then return end
    ToggleInvisibility()
end


--========================== Anti AFK ===========================--
local AntiAFK_Enabled = false
local AntiAFK_IdledConnection
local AntiAFK_Coroutine

local function AntiAFK_DoAction()
    pcall(function()
        VirtualUser:CaptureController()
        VirtualUser:SetKeyDown('0x20')  -- пробел
        task.wait(0.1)
        VirtualUser:SetKeyUp('0x20')
    end)
    pcall(function()
        local camera = workspace.CurrentCamera
        camera.CFrame = camera.CFrame * CFrame.Angles(math.rad(0.5), 0, 0)
        task.wait(0.1)
        camera.CFrame = camera.CFrame * CFrame.Angles(math.rad(-0.5), 0, 0)
    end)
end

local function AntiAFK_Enable()
    if AntiAFK_Enabled then return end
    AntiAFK_Enabled = true

    local player = LocalPlayer
    AntiAFK_IdledConnection = player.Idled:Connect(function()
        if AntiAFK_Enabled then
            AntiAFK_DoAction()
        end
    end)

    AntiAFK_Coroutine = coroutine.create(function()
        while AntiAFK_Enabled do
            AntiAFK_DoAction()
            task.wait(30)
        end
    end)
    coroutine.resume(AntiAFK_Coroutine)
end

local function AntiAFK_Disable()
    if not AntiAFK_Enabled then return end
    AntiAFK_Enabled = false

    if AntiAFK_IdledConnection then
        AntiAFK_IdledConnection:Disconnect()
        AntiAFK_IdledConnection = nil
    end
    AntiAFK_Coroutine = nil
end

--=================== Melee Aura 4 Alt MAX! =====================--
local MeleeAura_Enabled = false
local MeleeAura_Connection

local runAttackLoop do
    local plrs = game:GetService("Players")
    local me = plrs.LocalPlayer
    local run = game:GetService("RunService")

    local remote1 = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("XMHH.2")
    local remote2 = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("XMHH2.2")

    local maxdist = 20
    local hitOrder = {"Left Arm", "UpperTorso", "Right Arm", "Left Leg", "Right Leg"}
    local currentHitIndex = 1

    local function Attack(target)
        if not target then return end
        
        -- Получаем следующую часть тела для атаки
        local hitPartName = hitOrder[currentHitIndex]
        local hitPart = target:FindFirstChild(hitPartName)
        
        -- Если нужная часть не найдена, пробуем Head как запасной вариант
        if not hitPart then
            hitPart = target:FindFirstChild("Head")
            if not hitPart then return end
        end
        
        -- Переходим к следующей части тела для следующей атаки
        currentHitIndex = currentHitIndex + 1
        if currentHitIndex > #hitOrder then
            currentHitIndex = 1
        end

        local arg1 = {
            [1] = "🍞",
            [2] = tick(),
            [3] = me.Character and me.Character:FindFirstChildOfClass("Tool"),
            [4] = "43TRFWX",
            [5] = "Normal",
            [6] = tick(),
            [7] = true
        }
        local result = remote1:InvokeServer(unpack(arg1))
        task.wait(0.5)

        local tool = me.Character and me.Character:FindFirstChildOfClass("Tool")
        if tool then
            local Handle = tool:FindFirstChild("WeaponHandle") or tool:FindFirstChild("Handle")
                          or me.Character:FindFirstChild("Right Arm")
            if Handle then
                local arg2 = {
                    [1] = "🍞",
                    [2] = tick(),
                    [3] = tool,
                    [4] = "2389ZFX34",
                    [5] = result,
                    [6] = false,
                    [7] = Handle,
                    [8] = hitPart,
                    [9] = target,
                    [10] = me.Character:FindFirstChild("HumanoidRootPart").Position,
                    [11] = hitPart.Position
                }
                remote2:FireServer(unpack(arg2))
            end
        end
    end

    runAttackLoop = function()
        return run.RenderStepped:Connect(function()
            if not MeleeAura_Enabled then return end
            local char = me.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                for _, plr in ipairs(plrs:GetPlayers()) do
                    if plr ~= me then
                        local c = plr.Character
                        local hrp2 = c and c:FindFirstChild("HumanoidRootPart")
                        local hum = c and c:FindFirstChildOfClass("Humanoid")
                        if hrp2 and hum then
                            local dist = (hrp.Position - hrp2.Position).Magnitude
                            if dist < maxdist and hum.Health > 15 and not c:FindFirstChildOfClass("ForceField") then
                                Attack(c)
                            end
                        end
                    end
                end
            end
        end)
    end
end

local function MeleeAura_Enable()
    if MeleeAura_Enabled then return end
    MeleeAura_Enabled = true
    MeleeAura_Connection = runAttackLoop()
end

local function MeleeAura_Disable()
    if not MeleeAura_Enabled then return end
    MeleeAura_Enabled = false

    if MeleeAura_Connection then
        MeleeAura_Connection:Disconnect()
        MeleeAura_Connection = nil
    end
end

--=========================== Bounty Detector (Deaths Based) ===========================
local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local BountyFarm_Enabled = false
local isRunning = false
local DEATH_RADIUS = 20
local REQUIRED_DEATHS = 100
local deathCount = 0

-- Death respawn event from HellYeah
local DeathRespawn_Event = ReplicatedStorage:WaitForChild("Events"):WaitForChild("DeathRespawn")

-- Tables for all connections
local diedConnections = {}
local characterAddedConnections = {}
local playerAddedConnection = nil

-- Shiv pickup state
local waitingForDeath = false
local shivTeleportActive = false
local shivTeleportConnection = nil

-- Save positions for closest teleport
local SavePositions = {
    Hell = Vector3.new(-4100.053, -153.305, -1253.413),
    Room = Vector3.new(-4746.183, 29.395, -25.344),
    AssHole = Vector3.new(-4608.989, 106.800, 75.743),
    Invis = Vector3.new(-4545.079, 35.201, 206.437),
    Gate = Vector3.new(-3844.006, 3.300, 31.621)
}

local function pressKey(key, holdTime)
    VirtualInputManager:SendKeyEvent(true, key, false, game)
    task.wait(holdTime or 0.1)
    VirtualInputManager:SendKeyEvent(false, key, false, game)
end

local function teleportBack()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    hrp.CFrame = hrp.CFrame * CFrame.new(0, 0, 6)
end

-- Auto respawn function from HellYeah
local function autoRespawn()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum and hum.Health <= 0 then
        DeathRespawn_Event:InvokeServer("KMG4R904")
    end
end

-- Find Shiv in workspace
local function findShivPosition()
    local shivModel = workspace:FindFirstChild("Filter")
    if not shivModel then return nil end
    
    local spawnedTools = shivModel:FindFirstChild("SpawnedTools")
    if not spawnedTools then return nil end
    
    for _, item in pairs(spawnedTools:GetChildren()) do
        if item:IsA("Model") and item.Name == "Model" then
            local shiv = item:FindFirstChild("Shiv")
            if shiv and shiv:IsA("Model") then
                local weaponHandle = shiv:FindFirstChild("WeaponHandle")
                if weaponHandle then
                    return weaponHandle.Position
                end
            end
        end
    end
    
    return nil
end

-- Get closest save position to current character
local function getClosestSavePosition()
    local char = LocalPlayer.Character
    if not char then return SavePositions.Gate end
    
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return SavePositions.Gate end
    
    local closestPos = SavePositions.Gate
    local closestDist = math.huge
    
    for _, pos in pairs(SavePositions) do
        local dist = (hrp.Position - pos).Magnitude
        if dist < closestDist then
            closestDist = dist
            closestPos = pos
        end
    end
    
    return closestPos
end

-- Teleport to Shiv with retry logic (same as HellYeah saves)
local function teleportToShiv()
    if shivTeleportActive then return end
    shivTeleportActive = true
    
    local startTime = tick()
    local maxDuration = 8
    local tpInterval = 0.1
    local lastTP = 0
    local shivPickedUp = false
    
    local function stopTeleport()
        shivTeleportActive = false
        if shivTeleportConnection then
            shivTeleportConnection:Disconnect()
            shivTeleportConnection = nil
        end
    end
    
    -- Start teleport loop (same as HellYeah saves)
    shivTeleportConnection = RunService.RenderStepped:Connect(function()
        if not BountyFarm_Enabled or not shivTeleportActive then
            stopTeleport()
            return
        end
        
        local currentTime = tick()
        
        -- Check if duration exceeded
        if currentTime - startTime > maxDuration then
            stopTeleport()
            return
        end
        
        -- Throttle teleport
        if currentTime - lastTP < tpInterval then return end
        
        local char = LocalPlayer.Character
        if not char then
            stopTeleport()
            return
        end
        
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")
        
        if not hrp or not hum then
            stopTeleport()
            return
        end
        
        -- Auto respawn if dead
        if hum.Health <= 0 then
            autoRespawn()
            return
        end
        
        -- Check if Shiv already picked up
        local shivInHand = char:FindFirstChild("Shiv")
        local shivInBackpack = LocalPlayer.Backpack:FindFirstChild("Shiv")
        
        if shivInHand or shivInBackpack then
            shivPickedUp = true
            stopTeleport()
            return
        end
        
        -- Find Shiv position
        local shivPos = findShivPosition()
        
        if shivPos then
            -- Teleport to Shiv (same CFrame method as HellYeah saves)
            hrp.CFrame = CFrame.new(shivPos)
            lastTP = currentTime
        else
            -- If Shiv not found, teleport to closest save
            local closestSave = getClosestSavePosition()
            hrp.CFrame = CFrame.new(closestSave)
            lastTP = currentTime
        end
    end)
    
    -- Monitor for death during teleport
    task.spawn(function()
        while shivTeleportActive do
            local char = LocalPlayer.Character
            local hum = char and char:FindFirstChildOfClass("Humanoid")
            
            if hum and hum.Health <= 0 then
                print("Character died during Shiv pickup - respawning and retrying")
                autoRespawn()
                task.wait(2)
                
                if BountyFarm_Enabled then
                    stopTeleport()
                    teleportToShiv()
                end
                return
            end
            
            task.wait(0.1)
        end
    end)
    
    -- After 8 seconds, check result
    task.delay(maxDuration, function()
        if not shivTeleportActive and not shivPickedUp then
            return
        end
        
        stopTeleport()
        
        -- Check if Shiv was picked up
        local char = LocalPlayer.Character
        if char then
            local shivInHand = char:FindFirstChild("Shiv")
            local shivInBackpack = LocalPlayer.Backpack:FindFirstChild("Shiv")
            
            if shivInHand or shivInBackpack then
                print("Shiv picked up successfully!")
                -- Continue with remaining sequence
                task.wait(0.2)
                pressKey(Enum.KeyCode.X)
                task.wait(0.2)
                pressKey(Enum.KeyCode.Two)
                task.wait(0.2)
                pressKey(Enum.KeyCode.Z)
                
                deathCount = 0
                isRunning = false
                waitingForDeath = false
            else
                print("Failed to pick up Shiv - respawning and retrying")
                autoRespawn()
                task.wait(2)
                
                if BountyFarm_Enabled then
                    teleportToShiv()
                end
            end
        end
    end)
end

-- Wait for character death and pickup Shiv
local function waitForDeathAndPickupShiv()
    waitingForDeath = true
    
    local char = LocalPlayer.Character
    if not char then
        waitingForDeath = false
        return
    end
    
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then
        waitingForDeath = false
        return
    end
    
    print("Waiting for character death...")
    
    local deathConnection
    deathConnection = hum.Died:Connect(function()
        if deathConnection then
            deathConnection:Disconnect()
        end
        
        print("Character died - preparing to pickup Shiv")
        waitingForDeath = false
        
        -- Auto respawn
        autoRespawn()
        task.wait(2)
        
        if BountyFarm_Enabled then
            -- Press C again after respawn
            pressKey(Enum.KeyCode.C)
            task.wait(0.2)
            
            -- Start teleporting to Shiv and press E
            teleportToShiv()
            
            -- Press E while teleporting
            task.spawn(function()
                while shivTeleportActive do
                    pressKey(Enum.KeyCode.E)
                    task.wait(0.3)
                end
            end)
        end
    end)
end

local function executeSequence()
    if isRunning or not BountyFarm_Enabled then return end
    isRunning = true

    -- ORIGINAL LOGIC BEFORE FIRST C
    pressKey(Enum.KeyCode.Two)
    task.wait(0.2)
    pressKey(Enum.KeyCode.Z)
    task.wait(0.2)
    pressKey(Enum.KeyCode.Two)
    task.wait(0.2)
    pressKey(Enum.KeyCode.X)
    task.wait(0.3)
    teleportBack()
    task.wait(0.4)
    pressKey(Enum.KeyCode.Backspace)
    task.wait(0.2)
    
    -- First C press
    pressKey(Enum.KeyCode.C)
    task.wait(0.2)
    
    -- Wait for death and continue with Shiv pickup
    waitForDeathAndPickupShiv()
end

local function onCharacterAdded(character)
    local humanoid = character:WaitForChild("Humanoid", 5)
    local hrp = character:WaitForChild("HumanoidRootPart", 5)
    if not humanoid or not hrp then return end

    local connection = humanoid.Died:Connect(function()
        if not BountyFarm_Enabled or isRunning then return end
        local myChar = LocalPlayer.Character
        if not myChar then return end
        local myHRP = myChar:FindFirstChild("HumanoidRootPart")
        if not myHRP then return end

        local distance = (hrp.Position - myHRP.Position).Magnitude
        if distance <= DEATH_RADIUS then
            deathCount += 1
            if deathCount >= REQUIRED_DEATHS then
                task.spawn(executeSequence)
            end
        end
    end)

    table.insert(diedConnections, connection)
end

local function trackPlayer(player)
    if player == LocalPlayer then return end

    if player.Character then
        onCharacterAdded(player.Character)
    end

    local conn = player.CharacterAdded:Connect(onCharacterAdded)
    table.insert(characterAddedConnections, conn)
end

local function BountyFarm_Enable()
    if BountyFarm_Enabled then return end

    BountyFarm_Enabled = true
    isRunning = false
    deathCount = 0
    waitingForDeath = false
    shivTeleportActive = false

    for _, player in ipairs(Players:GetPlayers()) do
        trackPlayer(player)
    end

    playerAddedConnection = Players.PlayerAdded:Connect(trackPlayer)
end

local function BountyFarm_Disable()
    if not BountyFarm_Enabled then return end

    BountyFarm_Enabled = false
    isRunning = false
    deathCount = 0
    waitingForDeath = false
    shivTeleportActive = false

    if shivTeleportConnection then
        shivTeleportConnection:Disconnect()
        shivTeleportConnection = nil
    end

    for _, conn in ipairs(diedConnections) do
        if conn.Connected then conn:Disconnect() end
    end
    diedConnections = {}

    for _, conn in ipairs(characterAddedConnections) do
        if conn.Connected then conn:Disconnect() end
    end
    characterAddedConnections = {}

    if playerAddedConnection and playerAddedConnection.Connected then
        playerAddedConnection:Disconnect()
        playerAddedConnection = nil
    end
end

local function BountyFarm_Toggle()
    if BountyFarm_Enabled then
        BountyFarm_Disable()
    else
        BountyFarm_Enable()
    end
end
