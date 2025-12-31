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

--======================= Teleport Farm (ONLY IF TARGET HOLDS SHIV OR FISTS) =========================--
local TPFarm_Enabled = false
local TPFarm_TargetName = ""  -- Set target name
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer
local TPFarm_Connections = {}
local DeathRespawn_Event = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("DeathRespawn")

-- === Noclip ===
local NoclipEnabled = false
local NoclipConnection = nil

-- === Item State ===
local ItemState = {
    itemPickupCount = 0,
    currentHasItem = false,
    canTeleport = false
}

-- === Auto Drop Item ===
local AutoDropConnection = nil

local function pressKey(key, holdTime)
    VirtualInputManager:SendKeyEvent(true, key, false, game)
    task.wait(holdTime or 0.1)
    VirtualInputManager:SendKeyEvent(false, key, false, game)
end

local function EnableAutoDrop()
    if AutoDropConnection then return end
    
    AutoDropConnection = LocalPlayer.Backpack.ChildAdded:Connect(function(item)
        if not TPFarm_Enabled then return end
        if item:IsA("Tool") then
            print("Item detected in inventory: " .. item.Name .. " - Auto dropping")
            task.wait(0.1)
            pressKey(Enum.KeyCode.Two)
            task.wait(0.1)
            pressKey(Enum.KeyCode.Backspace)
        end
    end)
end

local function DisableAutoDrop()
    if AutoDropConnection then
        AutoDropConnection:Disconnect()
        AutoDropConnection = nil
    end
end

-- === Noclip Functions ===
local function EnableNoclip()
    if NoclipConnection then return end
    NoclipEnabled = true
    NoclipConnection = RunService.RenderStepped:Connect(function()
        if LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end

local function DisableNoclip()
    NoclipEnabled = false
    if NoclipConnection then
        NoclipConnection:Disconnect()
        NoclipConnection = nil
    end
    if not LocalPlayer.Character then return end

    -- Restore collision
    local torsoParts = {}
    local torso = LocalPlayer.Character:FindFirstChild("Torso")
    local upperTorso = LocalPlayer.Character:FindFirstChild("UpperTorso")
    local lowerTorso = LocalPlayer.Character:FindFirstChild("LowerTorso")

    if upperTorso then table.insert(torsoParts, upperTorso) end
    if lowerTorso then table.insert(torsoParts, lowerTorso) end
    if torso then table.insert(torsoParts, torso) end

    -- Disable collision on all parts
    for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end

    -- Enable ONLY on torso parts
    for _, part in pairs(torsoParts) do
        if part then
            part.CanCollide = true
        end
    end
end

local function ToggleNoclip()
    if NoclipEnabled then
        DisableNoclip()
    else
        EnableNoclip()
    end
end

-- === Rest of logic (no changes) ===
local function UpdateItemState()
    if TPFarm_TargetName == "" then
        ItemState.canTeleport = false
        return false
    end
    local target = Players:FindFirstChild(TPFarm_TargetName)
    if not target then
        ItemState.canTeleport = false
        return false
    end
    local char = target.Character
    if not char then
        ItemState.canTeleport = false
        return false
    end
    local tool = char:FindFirstChildOfClass("Tool")
    local hasItemNow = (tool and (tool.Name == "Shiv" or tool.Name == "Fists"))
    if tool and tool.Name == "Fists" then return true end

    if hasItemNow and not ItemState.currentHasItem then
        ItemState.itemPickupCount = ItemState.itemPickupCount + 1
        ItemState.canTeleport = (ItemState.itemPickupCount % 2 == 1)
    end
    ItemState.currentHasItem = hasItemNow
    return hasItemNow and ItemState.canTeleport
end

local function ResetItemState()
    ItemState.itemPickupCount = 0
    ItemState.currentHasItem = false
    ItemState.canTeleport = false
end

local function TPFarm_OnCharacterAdded(char)
    if TPFarm_Connections.Stepped then
        TPFarm_Connections.Stepped:Disconnect()
    end
    task.wait(0.4)
    local hrp = char:WaitForChild("HumanoidRootPart", 1)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not (hrp and hum) then return end

    if NoclipEnabled then
        task.wait(0.1)
        EnableNoclip()
    end

    local lastTP = 0
    local tpInterval = 0.02
    local function teleportToTarget()
        if not TPFarm_Enabled then
            ResetItemState()
            return
        end
        local canTeleportNow = UpdateItemState()
        if not canTeleportNow then return end

        local target = Players:FindFirstChild(TPFarm_TargetName)
        if not target or not target.Character then
            ResetItemState()
            return
        end
        local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
        if not targetHRP then return end

        local now = tick()
        if now - lastTP < tpInterval then return end
        hrp.CFrame = targetHRP.CFrame + (targetHRP.CFrame.LookVector * 3)
        lastTP = now
    end

    TPFarm_Connections.Stepped = RunService.Stepped:Connect(teleportToTarget)
    TPFarm_Connections.Health = hum:GetPropertyChangedSignal("Health"):Connect(function()
        if TPFarm_Enabled then
            hum.Health = 0
        end
    end)
end

local function SetupTargetTracking()
    if TPFarm_Connections.TargetToolAdded then TPFarm_Connections.TargetToolAdded:Disconnect() end
    if TPFarm_Connections.TargetToolRemoved then TPFarm_Connections.TargetToolRemoved:Disconnect() end
    if TPFarm_Connections.TargetCharAdded then TPFarm_Connections.TargetCharAdded:Disconnect() end

    local target = Players:FindFirstChild(TPFarm_TargetName)
    if not target then return end

    local function setupCharacterTracking(char)
        if not char then return end
        TPFarm_Connections.TargetToolAdded = char.ChildAdded:Connect(function(child)
            if TPFarm_Enabled and child:IsA("Tool") and (child.Name == "Shiv" or child.Name == "Fists") then
                if child.Name == "Shiv" then
                    ItemState.itemPickupCount = ItemState.itemPickupCount + 1
                    ItemState.canTeleport = (ItemState.itemPickupCount % 2 == 1)
                end
                ItemState.currentHasItem = true
            end
        end)
        TPFarm_Connections.TargetToolRemoved = char.ChildRemoved:Connect(function(child)
            if TPFarm_Enabled and child:IsA("Tool") and (child.Name == "Shiv" or child.Name == "Fists") then
                ItemState.currentHasItem = false
            end
        end)
    end

    if target.Character then
        setupCharacterTracking(target.Character)
    end
    TPFarm_Connections.TargetCharAdded = target.CharacterAdded:Connect(function(char)
        if TPFarm_Enabled then
            ResetItemState()
            setupCharacterTracking(char)
        end
    end)
end

local function TPFarm_Enable()
    if TPFarm_Enabled then return end
    if TPFarm_TargetName == "" then return end
    ResetItemState()
    TPFarm_Enabled = true
    SetupTargetTracking()
    ToggleNoclip()
    EnableAutoDrop()

    if LocalPlayer.Character then
        TPFarm_OnCharacterAdded(LocalPlayer.Character)
    end
    TPFarm_Connections.CharAdded = LocalPlayer.CharacterAdded:Connect(function(char)
        if not TPFarm_Enabled then return end
        TPFarm_OnCharacterAdded(char)
        local tool = LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
        if tool then tool.Parent = char end
    end)
    TPFarm_Connections.Render = RunService.RenderStepped:Connect(function()
        if not TPFarm_Enabled then return end
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum and hum.Health <= 0 then
            DeathRespawn_Event:InvokeServer("KMG4R904")
        end
    end)
end

local function TPFarm_Disable()
    if not TPFarm_Enabled then return end
    TPFarm_Enabled = false
    DisableNoclip()
    DisableAutoDrop()
    for _, conn in pairs(TPFarm_Connections) do
        if conn then conn:Disconnect() end
    end
    TPFarm_Connections = {}
    ResetItemState()
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        if TPFarm_Enabled then
            TPFarm_Disable()
        else
            TPFarm_Enable()
        end
    elseif input.KeyCode == Enum.KeyCode.Delete then
        ToggleNoclip()
    end
end)

--================= 3 Save-кнопки (Cube/Vibecheck/Mountain) =======
local event = DeathRespawn_Event  -- Сократим название

-- 1) Save Cube
local SaveCube_Enabled = false
local SaveCube_Connection
local SaveCube_Position = Vector3.new(-4100.053, -153.305, -1253.413)
local SaveCube_LastTP = 0
local SaveCube_TPInterval = 0.1

local function SaveCube_Enable()
    if SaveCube_Enabled then return end
    SaveCube_Enabled = true

    SaveCube_Connection = RunService.RenderStepped:Connect(function()
        if not SaveCube_Enabled then return end
        local currentTime = tick()
        if currentTime - SaveCube_LastTP < SaveCube_TPInterval then return end
        
        local char = LocalPlayer.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hrp then
                hrp.CFrame = CFrame.new(SaveCube_Position)
                SaveCube_LastTP = currentTime
            end
            if hum and hum.Health <= 0 then
                event:InvokeServer("KMG4R904") -- авто возрождение
            end
        end
    end)
end

local function SaveCube_Disable()
    if not SaveCube_Enabled then return end
    SaveCube_Enabled = false
    if SaveCube_Connection then
        SaveCube_Connection:Disconnect()
        SaveCube_Connection = nil
    end
end

-- 2) Save Vibecheck
local SaveVibe_Enabled = false
local SaveVibe_Connection
local SaveVibe_Position = Vector3.new(-4746.183, 29.395, -25.344)
local SaveVibe_LastTP = 0
local SaveVibe_TPInterval = 0.1

local function SaveVibe_Enable()
    if SaveVibe_Enabled then return end
    SaveVibe_Enabled = true

    SaveVibe_Connection = RunService.RenderStepped:Connect(function()
        if not SaveVibe_Enabled then return end
        local currentTime = tick()
        if currentTime - SaveVibe_LastTP < SaveVibe_TPInterval then return end
        
        local char = LocalPlayer.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hrp then
                hrp.CFrame = CFrame.new(SaveVibe_Position)
                SaveVibe_LastTP = currentTime
            end
            if hum and hum.Health <= 0 then
                event:InvokeServer("KMG4R904")
            end
        end
    end)
end

local function SaveVibe_Disable()
    if not SaveVibe_Enabled then return end
    SaveVibe_Enabled = false
    if SaveVibe_Connection then
        SaveVibe_Connection:Disconnect()
        SaveVibe_Connection = nil
    end
end

-- 3) Save asshole
local SaveMount_Enabled = false
local SaveMount_Connection
local SaveMount_Position = Vector3.new(-4608.989, 106.800, 75.743)
local SaveMount_LastTP = 0
local SaveMount_TPInterval = 0.1

local function SaveMount_Enable()
    if SaveMount_Enabled then return end
    SaveMount_Enabled = true

    SaveMount_Connection = RunService.RenderStepped:Connect(function()
        if not SaveMount_Enabled then return end
        local currentTime = tick()
        if currentTime - SaveMount_LastTP < SaveMount_TPInterval then return end
        
        local char = LocalPlayer.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hrp then
                hrp.CFrame = CFrame.new(SaveMount_Position)
                SaveMount_LastTP = currentTime
            end
            if hum and hum.Health <= 0 then
                event:InvokeServer("KMG4R904")
            end
        end
    end)
end

local function SaveMount_Disable()
    if not SaveMount_Enabled then return end
    SaveMount_Enabled = false
    if SaveMount_Connection then
        SaveMount_Connection:Disconnect()
        SaveMount_Connection = nil
    end
end

-- 5) Save Lil pookie
local niggapoint_Enabled = false
local niggapoint_Connection
local niggapoint_Position = Vector3.new(-4545.079, 35.201, 206.437)
local niggapoint_LastTP = 0
local niggapoint_TPInterval = 0.1

-- Функция для включения телепортации к новой точке
local function niggapoint_Enable()
    if niggapoint_Enabled then return end
    niggapoint_Enabled = true

    niggapoint_Connection = RunService.RenderStepped:Connect(function()
        if not niggapoint_Enabled then return end
        local currentTime = tick()
        if currentTime - niggapoint_LastTP < niggapoint_TPInterval then return end
        
        local char = LocalPlayer.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hrp then
                hrp.CFrame = CFrame.new(niggapoint_Position)
                niggapoint_LastTP = currentTime
            end
            if hum and hum.Health <= 0 then
                event:InvokeServer("KMG4R904") -- авто возрождение
            end
        end
    end)
end

-- Функция для выключения телепортации к новой точке
local function niggapoint_Disable()
    if not niggapoint_Enabled then return end
    niggapoint_Enabled = false
    if niggapoint_Connection then
        niggapoint_Connection:Disconnect()
        niggapoint_Connection = nil
    end
end


-- 4) Save Dealer
local NewSavePoint_Enabled = false
local NewSavePoint_Connection
local NewSavePoint_Position = Vector3.new(-3844.006, 3.300, 31.621)
local NewSavePoint_LastTP = 0
local NewSavePoint_TPInterval = 0.1

-- Функция для включения телепортации к новой точке
local function NewSavePoint_Enable()
    if NewSavePoint_Enabled then return end
    NewSavePoint_Enabled = true

    NewSavePoint_Connection = RunService.RenderStepped:Connect(function()
        if not NewSavePoint_Enabled then return end
        local currentTime = tick()
        if currentTime - NewSavePoint_LastTP < NewSavePoint_TPInterval then return end
        
        local char = LocalPlayer.Character
        if char then
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hrp then
                hrp.CFrame = CFrame.new(NewSavePoint_Position)
                NewSavePoint_LastTP = currentTime
            end
            if hum and hum.Health <= 0 then
                event:InvokeServer("KMG4R904") -- авто возрождение
            end
        end
    end)
end

-- Функция для выключения телепортации к новой точке
local function NewSavePoint_Disable()
    if not NewSavePoint_Enabled then return end
    NewSavePoint_Enabled = false
    if NewSavePoint_Connection then
        NewSavePoint_Connection:Disconnect()
        NewSavePoint_Connection = nil
    end
end






-------------------------------------------------------------------------------
--    5. Функция создания строки (createToggleRow) для кнопок
-------------------------------------------------------------------------------
local function createToggleRow(parent, scriptName, canToggle, isEnabledFn, onEnable, onDisable, getKeyBindFn, setKeyBindFn)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 30)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = scriptName
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.SourceSansSemibold
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.2, 0, 1, 0)
    button.Position = UDim2.new(0.4, 5, 0, 0)
    button.Font = Enum.Font.SourceSans
    button.TextSize = 16
    button.Parent = frame

    local bindButton = Instance.new("TextButton")
    bindButton.Size = UDim2.new(0.2, 0, 1, 0)
    bindButton.Position = UDim2.new(0.6, 10, 0, 0)
    bindButton.Font = Enum.Font.SourceSans
    bindButton.TextSize = 16
    bindButton.Text = "Bind"
    bindButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    bindButton.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
    bindButton.Parent = frame

    local function updateToggleButton()
        if not canToggle then
            button.Text = "Run"
            button.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
            return
        end
        if isEnabledFn() then
            button.Text = "ON"
            button.BackgroundColor3 = Color3.fromRGB(68, 166, 68)
        else
            button.Text = "OFF"
            button.BackgroundColor3 = Color3.fromRGB(168, 45, 45)
        end
    end
    updateToggleButton()

    button.MouseButton1Click:Connect(function()
        if not canToggle then
            -- одноразовый запуск
            onEnable()
            button.Text = "DONE"
            button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
            button.Active = false
            bindButton.Active = false
            return
        end
        if isEnabledFn() then
            onDisable()
        else
            onEnable()
        end
        updateToggleButton()
    end)

    if getKeyBindFn and setKeyBindFn then
        local capturingKey = false
        local lastClickTime = 0  -- Для отслеживания двойного клика

        local function updateBindButtonText()
            local kb = getKeyBindFn()
            if kb then
                bindButton.Text = "[".. kb.Name .."]"
            else
                bindButton.Text = "Bind"
            end
        end
        updateBindButtonText()

        bindButton.MouseButton1Click:Connect(function()
            local currentTime = tick()
            if currentTime - lastClickTime < 0.5 then  -- Двойной клик (меньше 0.5 сек)
                setKeyBindFn(nil)  -- Удаляем бинд
                capturingKey = false
                updateBindButtonText()
            else
                if capturingKey then
                    capturingKey = false
                    updateBindButtonText()
                else
                    capturingKey = true
                    bindButton.Text = "Press Key..."
                end
            end
            lastClickTime = currentTime
        end)

        UserInputService.InputBegan:Connect(function(input, gp)
            if gp then return end
            if capturingKey then
                if input.KeyCode ~= Enum.KeyCode.Unknown then
                    setKeyBindFn(input.KeyCode)
                    capturingKey = false
                    updateBindButtonText()
                end
            else
                local kb = getKeyBindFn()
                if kb and input.KeyCode == kb then
                    if canToggle then
                        if isEnabledFn() then
                            onDisable()
                        else
                            onEnable()
                        end
                        updateToggleButton()
                    else
                        -- одноразовый
                        if not DeletedMob_Ran then
                            onEnable()
                            button.Text = "DONE"
                            button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
                            button.Active = false
                            bindButton.Active = false
                        end
                    end
                end
            end
        end)
    else
        bindButton.Visible = false
    end

    return frame
end

-- Дополнительная строка ввода для Teleport Farm
local function createTPFarmTargetRow(parent)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 30)
    row.BackgroundTransparency = 1
    row.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "TP Target:"
    label.TextColor3 = Color3.new(1,1,1)
    label.Font = Enum.Font.SourceSansSemibold
    label.TextSize = 16
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = row

    local input = Instance.new("TextBox")
    input.Size = UDim2.new(0.5, 0, 1, 0)
    input.Position = UDim2.new(0.4, 5, 0, 0)
    input.BackgroundColor3 = Color3.fromRGB(80,80,80)
    input.TextColor3 = Color3.new(1,1,1)
    input.Font = Enum.Font.SourceSans
    input.TextSize = 16
    input.Text = TPFarm_TargetName
    input.ClearTextOnFocus = false
    input.Parent = row

    input.FocusLost:Connect(function()
        TPFarm_TargetName = input.Text
    end)
end

-------------------------------------------------------------------------------
--   6. Создаём кнопки в нужном порядке
-------------------------------------------------------------------------------

-- invis
do
    createToggleRow(
        mainContentFrame,
        "Invisibility",
        true,
        function() return InvisEnabled end,
        InvisButton_Enable,
        InvisButton_Disable,
        function() return InvisBind end,
        function(k) InvisBind = k end
    )
end

-- bounty detector
do
    local bountyFarmBind = nil
    createToggleRow(
        mainContentFrame,
        "Bounty detector",
        true,
        function() return BountyFarm_Enabled end,
        BountyFarm_Enable,
        BountyFarm_Disable,
        function() return bountyFarmBind end,
        function(k) bountyFarmBind = k end
    )
end

-- auto clicker
do
    local autoClickerBind = nil
    createToggleRow(
        mainContentFrame,
        "Auto Clicker",
        true,
        function() return AutoClicker_Enabled end,
        AutoClicker_Enable,
        AutoClicker_Disable,
        function() return autoClickerBind end,
        function(k) autoClickerBind = k end
    )
end


--Camera Look Up
do
    local cameraFreezeBind = nil
    createToggleRow(
        mainContentFrame,
        "Camera Freezer",
        true,
        function() return CameraFreeze_Enabled end,
        CameraFreeze_Enable,
        CameraFreeze_Disable,
        function() return CameraFreeze_Bind end,
        function(k) 
            CameraFreeze_Bind = k 
            -- Обновляем горячую клавишу
            UserInputService.InputBegan:Connect(function(input, gp)
                if not gp and input.KeyCode == CameraFreeze_Bind then
                    if CameraFreeze_Enabled then
                        CameraFreeze_Disable()
                    else
                        CameraFreeze_Enable()
                    end
                end
            end)
        end
    )
end

-- Admin Check
do
    local adminCheckBind = nil
    createToggleRow(
        mainContentFrame,
        "Save Ass",
        true,
        function() return AdminCheck_Enabled end,
        AdminCheck_Enable,
        AdminCheck_Disable,
        function() return adminCheckBind end,
        function(k) adminCheckBind = k end
    )
end

-- Anti AFK
do
    local antiAFKBind = nil
    createToggleRow(
        mainContentFrame,
        "Anti AFK",
        true,
        function() return AntiAFK_Enabled end,
        AntiAFK_Enable,
        AntiAFK_Disable,
        function() return antiAFKBind end,
        function(k) antiAFKBind = k end
    )
end

-- Melee Aura 4 Alt MAX!
do
    local meleeBind = nil
    createToggleRow(
        mainContentFrame,
        "Melee Aura",
        true,
        function() return MeleeAura_Enabled end,
        MeleeAura_Enable,
        MeleeAura_Disable,
        function() return meleeBind end,
        function(k) meleeBind = k end
    )
end

-- Teleport Farm
do
    local tpBind = nil
    createToggleRow(
        mainContentFrame,
        "Teleport Farm",
        true,
        function() return TPFarm_Enabled end,
        TPFarm_Enable,
        TPFarm_Disable,
        function() return tpBind end,
        function(k) tpBind = k end
    )
    createTPFarmTargetRow(mainContentFrame)
end

-- Save Cube
do
    local scBind = nil
    createToggleRow(
        mainContentFrame,
        "Save Hell",
        true,
        function() return SaveCube_Enabled end,
        SaveCube_Enable,
        SaveCube_Disable,
        function() return scBind end,
        function(k) scBind = k end
    )
end

-- Save Vibecheck
do
    local svBind = nil
    createToggleRow(
        mainContentFrame,
        "Save Room",
        true,
        function() return SaveVibe_Enabled end,
        SaveVibe_Enable,
        SaveVibe_Disable,
        function() return svBind end,
        function(k) svBind = k end
    )
end

-- Save Mountain
do
    local smBind = nil
    createToggleRow(
        mainContentFrame,
        "Save AssHole",
        true,
        function() return SaveMount_Enabled end,
        SaveMount_Enable,
        SaveMount_Disable,
        function() return smBind end,
        function(k) smBind = k end
    )
end

-- Save Lil Pookie
do
    local niggapointBind = nil
    createToggleRow(
        mainContentFrame,
        "Save Invis",
        true,
        function() return niggapoint_Enabled end,
        niggapoint_Enable,
        niggapoint_Disable,
        function() return niggapointBind end,
        function(k) niggapointBind = k end
    )
end

-- Save dealer
do
    local newSavePointBind = nil
    createToggleRow(
        mainContentFrame,
        "Save Gate",
        true,
        function() return NewSavePoint_Enabled end,
        NewSavePoint_Enable,
        NewSavePoint_Disable,
        function() return newSavePointBind end,
        function(k) newSavePointBind = k end
    )
end

-- ===================== Dev Tools Integration =====================

-- Teleport GUI
local teleportGui = Instance.new("ScreenGui")
teleportGui.Name = "TeleportGui"
teleportGui.ResetOnSpawn = false
teleportGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
teleportGui.Enabled = false

-- Main frame for Teleport
local teleportFrame = Instance.new("Frame")
teleportFrame.Size = UDim2.new(0, 280, 0, 120)
teleportFrame.Position = UDim2.new(0.5, -140, 0.5, -60)
teleportFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
teleportFrame.BorderSizePixel = 0
teleportFrame.Active = true
teleportFrame.Draggable = true
teleportFrame.Parent = teleportGui

local teleportCorner = Instance.new("UICorner")
teleportCorner.CornerRadius = UDim.new(0, 8)
teleportCorner.Parent = teleportFrame

local teleportStroke = Instance.new("UIStroke")
teleportStroke.Color = Color3.fromRGB(60, 60, 70)
teleportStroke.Thickness = 1.5
teleportStroke.Parent = teleportFrame

-- Title
local teleportTitle = Instance.new("TextLabel")
teleportTitle.Size = UDim2.new(1, 0, 0, 35)
teleportTitle.BackgroundTransparency = 1
teleportTitle.Text = "TELEPORT"
teleportTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
teleportTitle.TextSize = 16
teleportTitle.Font = Enum.Font.GothamBold
teleportTitle.TextXAlignment = Enum.TextXAlignment.Center
teleportTitle.Parent = teleportFrame

-- Input field
local coordBox = Instance.new("TextBox")
coordBox.Size = UDim2.new(0.9, 0, 0, 30)
coordBox.Position = UDim2.new(0.05, 0, 0, 45)
coordBox.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
coordBox.BorderSizePixel = 0
coordBox.Text = ""
coordBox.PlaceholderText = "Enter coords: X Y Z"
coordBox.TextColor3 = Color3.fromRGB(255, 255, 255)
coordBox.TextSize = 14
coordBox.Font = Enum.Font.Gotham
coordBox.TextXAlignment = Enum.TextXAlignment.Center
coordBox.Parent = teleportFrame
local coordCorner = Instance.new("UICorner")
coordCorner.CornerRadius = UDim.new(0, 6)
coordCorner.Parent = coordBox

-- Teleport button
local tpBtn = Instance.new("TextButton")
tpBtn.Size = UDim2.new(0.9, 0, 0, 35)
tpBtn.Position = UDim2.new(0.05, 0, 0, 80)
tpBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
tpBtn.BorderSizePixel = 0
tpBtn.Text = "TELEPORT"
tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
tpBtn.TextSize = 14
tpBtn.Font = Enum.Font.GothamBold
tpBtn.TextXAlignment = Enum.TextXAlignment.Center
tpBtn.Parent = teleportFrame
local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 6)
btnCorner.Parent = tpBtn

local btnStroke = Instance.new("UIStroke")
btnStroke.Color = Color3.fromRGB(0, 200, 255)
btnStroke.Thickness = 1.5
btnStroke.Parent = tpBtn

-- Hover effect
tpBtn.MouseEnter:Connect(function()
    tpBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 235)
end)
tpBtn.MouseLeave:Connect(function()
    tpBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
end)

-- Teleport function
local function teleport()
    local input = coordBox.Text:gsub(",", " ")  -- Replace commas with spaces
    local coords = {}
    for num in input:gmatch("%S+") do
        local val = tonumber(num)
        if val then
            table.insert(coords, val)
        end
    end
    
    if #coords == 3 then
        local x, y, z = coords[1], coords[2], coords[3]
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
            print("Teleported to " .. x .. ", " .. y .. ", " .. z)
        else
            warn("Character not loaded!")
        end
    else
        warn("Invalid coords! Use: X Y Z")
    end
end

tpBtn.MouseButton1Click:Connect(teleport)

-- Toggle menu (INSERT)
local teleportVisible = false
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        teleportVisible = not teleportVisible
        teleportGui.Enabled = teleportVisible
    end
end)

-- Hide by default
teleportGui.Enabled = false

-- Character Coords GUI
local charCoordsGui = Instance.new("ScreenGui")
charCoordsGui.Name = "CoordsOverlay"
charCoordsGui.ResetOnSpawn = false
charCoordsGui.Parent = game.CoreGui  -- или game:GetService("Players").LocalPlayer.PlayerGui
charCoordsGui.Enabled = false

local charFrame = Instance.new("Frame")
charFrame.Size = UDim2.new(0, 260, 0, 120)
charFrame.Position = UDim2.new(0, 300, 0, 200)
charFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
charFrame.BorderSizePixel = 0
charFrame.Active = true
charFrame.Draggable = true   -- ВОТ ЭТО ГЛАВНОЕ — Roblox сам делает перетаскивание!
charFrame.Parent = charCoordsGui

-- Красивая обводка
local charBorder = Instance.new("UIStroke")
charBorder.Thickness = 3
charBorder.Color = Color3.fromRGB(0, 170, 255)
charBorder.Parent = charFrame

-- Закруглённые углы
local charCorner = Instance.new("UICorner")
charCorner.CornerRadius = UDim.new(0, 12)
charCorner.Parent = charFrame

-- Заголовок
local charTitle = Instance.new("TextLabel")
charTitle.Size = UDim2.new(1, 0, 0, 30)
charTitle.Position = UDim2.new(0, 0, 0, 5)
charTitle.BackgroundTransparency = 1
charTitle.Text = "Coordinates"
charTitle.TextColor3 = Color3.fromRGB(0, 200, 255)
charTitle.Font = Enum.Font.GothamBold
charTitle.TextSize = 18
charTitle.Parent = charFrame

-- Текст координат
local charCoords = Instance.new("TextLabel")
charCoords.Size = UDim2.new(1, -20, 0, 50)
charCoords.Position = UDim2.new(0, 10, 0, 40)
charCoords.BackgroundTransparency = 1
charCoords.Text = "X: —\nY: —\nZ: —"
charCoords.TextColor3 = Color3.fromRGB(255, 255, 255)
charCoords.Font = Enum.Font.Gotham
charCoords.TextSize = 18
charCoords.TextXAlignment = Enum.TextXAlignment.Left
charCoords.Parent = charFrame

-- Кнопка Copy
local charCopybtn = Instance.new("TextButton")
charCopybtn.Size = UDim2.new(0, 90, 0, 34)
charCopybtn.Position = UDim2.new(0.5, -45, 1, -48)
charCopybtn.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
charCopybtn.Text = "Copy"
charCopybtn.TextColor3 = Color3.new(1,1,1)
charCopybtn.Font = Enum.Font.GothamBold
charCopybtn.TextSize = 16
charCopybtn.Parent = charFrame

local charBtncorner = Instance.new("UICorner")
charBtncorner.CornerRadius = UDim.new(0, 8)
charBtncorner.Parent = charCopybtn

-- Обработка кнопки
charCopybtn.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local pos = LocalPlayer.Character.HumanoidRootPart.Position
        local text = string.format("%.3f, %.3f, %.3f", pos.X, pos.Y, pos.Z)
        setclipboard(text)  -- работает на 99% эксплойтов
        charCopybtn.Text = "Copied!"
        wait(0.8)
        charCopybtn.Text = "Copy"
    end
end)

-- Обновление координат
spawn(function()
    while wait(0.05) do
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local p = LocalPlayer.Character.HumanoidRootPart.Position
            charCoords.Text = string.format("X: %.3f\nY: %.3f\nZ: %.3f", p.X, p.Y, p.Z)
        else
            charCoords.Text = "X: —\nY: —\nZ: —"
        end
    end
end)

-- Mouse Coords GUI
local mouseCoordsGui = Instance.new("ScreenGui")
mouseCoordsGui.Name = "MouseCoords"
mouseCoordsGui.ResetOnSpawn = false
mouseCoordsGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
mouseCoordsGui.Enabled = false

local mouseFrame = Instance.new("Frame")
mouseFrame.Size = UDim2.new(0, 260, 0, 100)
mouseFrame.Position = UDim2.new(0, 100, 0, 100)
mouseFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
mouseFrame.BorderSizePixel = 0
mouseFrame.Active = true
mouseFrame.Draggable = true  -- Перетаскивается как надо
mouseFrame.Parent = mouseCoordsGui

-- Стиль
Instance.new("UICorner", mouseFrame).CornerRadius = UDim.new(0, 10)
local mouseStroke = Instance.new("UIStroke", mouseFrame)
mouseStroke.Thickness = 2.5
mouseStroke.Color = Color3.fromRGB(0, 190, 255)

-- Заголовок
local mouseTitle = Instance.new("TextLabel", mouseFrame)
mouseTitle.Size = UDim2.new(1, 0, 0, 28)
mouseTitle.BackgroundTransparency = 1
mouseTitle.Text = "Mouse Position [Z - copy]"
mouseTitle.TextColor3 = Color3.fromRGB(0, 210, 255)
mouseTitle.Font = Enum.Font.GothamBold
mouseTitle.TextSize = 16

-- Координаты
local mouseCoords = Instance.new("TextLabel", mouseFrame)
mouseCoords.Size = UDim2.new(1, -20, 1, -35)
mouseCoords.Position = UDim2.new(0, 10, 0, 30)
mouseCoords.BackgroundTransparency = 1
mouseCoords.Text = "X: 0\nY: 0"
mouseCoords.TextColor3 = Color3.new(1, 1, 1)
mouseCoords.Font = Enum.Font.Gotham
mouseCoords.TextSize = 22
mouseCoords.TextXAlignment = Enum.TextXAlignment.Left
mouseCoords.TextYAlignment = Enum.TextYAlignment.Top

-- === Клавиша Z для копирования ===
local COPY_KEY = Enum.KeyCode.Z  -- поменяй здесь, если хочешь другую

local debounce = false
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == COPY_KEY and not debounce then
        debounce = true
        
        local mousePos = UserInputService:GetMouseLocation()
        local text = string.format("%d, %d", mousePos.X, mousePos.Y)
        
        -- Копируем всеми способами
        if setclipboard then setclipboard(text) end
        if toclipboard then toclipboard(text) end
        if Clipboard then Clipboard.set(text) end
        
        -- Визуальная подсказка
        mouseTitle.Text = "Copied! " .. text
        mouseCoords.TextColor3 = Color3.fromRGB(100, 255, 100)
        task.wait(0.8)
        mouseTitle.Text = "Mouse Position [Z - copy]"
        mouseCoords.TextColor3 = Color3.new(1, 1, 1)
        
        debounce = false
    end
end)

-- === Обновление координат мыши ===
RunService.RenderStepped:Connect(function()
    local pos = UserInputService:GetMouseLocation()
    mouseCoords.Text = string.format("X: %d\nY: %d", pos.X, pos.Y)
end)

-- ===================== FREECAM ======================
local FreeCam_Enabled = false
local FreeCam_Connection = nil
local FreeCam_SPEED = 180
local FreeCam_SLOW_MULT = 0.40
local FreeCam_MOUSE_SENS = 0.045
local FreeCam_yaw = 0
local FreeCam_pitch = 0
local FreeCam_camPos = nil
local FreeCam_floatingPart = nil
local FreeCam_toolEquipped = false

local function FreeCam_freezeCharacter()
    local char = LocalPlayer.Character
    if not char or FreeCam_toolEquipped then return end
    
    if not FreeCam_floatingPart then
        FreeCam_floatingPart = Instance.new("Part")
        FreeCam_floatingPart.Name = "FreecamFloatingPart"
        FreeCam_floatingPart.Size = Vector3.new(0.1, 0.1, 0.1)
        FreeCam_floatingPart.Transparency = 1
        FreeCam_floatingPart.CanCollide = false
        FreeCam_floatingPart.Anchored = true
        FreeCam_floatingPart.Parent = workspace
    end
    
    local humanoidRootPart = char:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        FreeCam_floatingPart.Position = humanoidRootPart.Position
    end
    
    task.spawn(function()
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "FreecamFloatingPart" and not part.Anchored then
                part.Anchored = true
            end
        end
    end)
    
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid:ChangeState(Enum.HumanoidStateType.Physics)
    end
end

local function FreeCam_unfreezeCharacter()
    if LocalPlayer.Character then
        task.spawn(function()
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "FreecamFloatingPart" and part.Anchored then
                    part.Anchored = false
                end
            end
        end)
    end
    
    local char = LocalPlayer.Character
    if char then
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Running)
        end
    end
end

local function FreeCam_unfreezePlayer()
    if FreeCam_floatingPart then
        FreeCam_floatingPart:Destroy()
        FreeCam_floatingPart = nil
    end
    FreeCam_unfreezeCharacter()
end

local function FreeCam_onToolEquipped()
    FreeCam_toolEquipped = true
    if FreeCam_Enabled then
        FreeCam_unfreezeCharacter()
    end
end

local function FreeCam_onToolUnequipped()
    FreeCam_toolEquipped = false
    if FreeCam_Enabled then
        FreeCam_freezeCharacter()
    end
end

local function FreeCam_Enable()
    if FreeCam_Enabled then return end
    FreeCam_Enabled = true

    workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
    FreeCam_camPos = workspace.CurrentCamera.CFrame.Position

    local x, y, _ = workspace.CurrentCamera.CFrame:ToOrientation()
    FreeCam_pitch = x
    FreeCam_yaw = y

    UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
    UserInputService.MouseIconEnabled = false

    if not FreeCam_toolEquipped then
        FreeCam_freezeCharacter()
    end

    FreeCam_Connection = RunService.RenderStepped:Connect(function(dt)
        local delta = UserInputService:GetMouseDelta()
        FreeCam_yaw = FreeCam_yaw - delta.X * FreeCam_MOUSE_SENS
        FreeCam_pitch = FreeCam_pitch - delta.Y * FreeCam_MOUSE_SENS
        FreeCam_pitch = math.clamp(FreeCam_pitch, math.rad(-85), math.rad(85))

        local rotation = CFrame.fromOrientation(FreeCam_pitch, FreeCam_yaw, 0)

        local move = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + Vector3.new(0, 0, -1) end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move + Vector3.new(0, 0, 1) end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move + Vector3.new(-1, 0, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + Vector3.new(1, 0, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.E) then move = move + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.Q) then move = move + Vector3.new(0, -1, 0) end

        local speed = FreeCam_SPEED
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            speed = speed * FreeCam_SLOW_MULT
        end

        FreeCam_camPos = FreeCam_camPos + rotation:VectorToWorldSpace(move) * speed * dt
        workspace.CurrentCamera.CFrame = CFrame.new(FreeCam_camPos) * rotation
        
        if FreeCam_floatingPart and FreeCam_floatingPart.Parent then
            FreeCam_floatingPart.Position = FreeCam_camPos - rotation.LookVector * 5
        end
    end)
end

local function FreeCam_Disable()
    if not FreeCam_Enabled then return end
    FreeCam_Enabled = false

    if FreeCam_Connection then
        FreeCam_Connection:Disconnect()
        FreeCam_Connection = nil
    end

    FreeCam_unfreezePlayer()

    UserInputService.MouseBehavior = Enum.MouseBehavior.Default
    UserInputService.MouseIconEnabled = true
    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
end

-- Respawn fix
LocalPlayer.CharacterAdded:Connect(function()
    if FreeCam_Enabled then
        task.wait(0.2)
        if not FreeCam_toolEquipped then
            FreeCam_freezeCharacter()
        end
    end
end)

-- TP Tool
local function FreeCam_CreateTPTool()
    local mouse = LocalPlayer:GetMouse()
    
    local function isAlive(Player, headCheck)
        local Player = Player or LocalPlayer
        if Player and Player.Character and ((Player.Character:FindFirstChildOfClass("Humanoid")) and (Player.Character:FindFirstChild("HumanoidRootPart")) and (headCheck and Player.Character:FindFirstChild("Head") or not headCheck)) then
            return true
        else
            return false
        end
    end
    
    local tool = Instance.new("Tool")
    tool.Name = "TPTool"
    tool.RequiresHandle = false
    
    tool.Equipped:Connect(function()
        FreeCam_onToolEquipped()
    end)
    
    tool.Unequipped:Connect(function()
        FreeCam_onToolUnequipped()
    end)
    
    tool.Activated:Connect(function()
        if isAlive() then
            LocalPlayer.Character.HumanoidRootPart.CFrame = mouse.Hit + Vector3.new(0, 3, 0)
        end
    end)
    
    tool.Parent = LocalPlayer.Backpack
end


-- Dev Tools кнопки
do
    -- Teleport GUI Toggle
    local teleportEnabled = false
    createToggleRow(
        devContentFrame,
        "Teleport GUI",
        true,
        function() return teleportEnabled end,
        function() 
            teleportEnabled = true
            teleportGui.Enabled = true
        end,
        function() 
            teleportEnabled = false
            teleportGui.Enabled = false
        end
    )
end

-- freecam
do
    local freeCamBind = nil
    createToggleRow(
        devContentFrame,
        "FreeCam",
        true,
        function() return FreeCam_Enabled end,
        function()
            FreeCam_Enable()
            FreeCam_CreateTPTool()
        end,
        FreeCam_Disable,
        function() return freeCamBind end,
        function(k) freeCamBind = k end
    )
end

do
    -- Char Coords Toggle
    local charCoordsEnabled = false
    createToggleRow(
        devContentFrame,
        "Char Coords",
        true,
        function() return charCoordsEnabled end,
        function() 
            charCoordsEnabled = true
            charCoordsGui.Enabled = true
        end,
        function() 
            charCoordsEnabled = false
            charCoordsGui.Enabled = false
        end
    )
end

do
    -- Mouse Coords Toggle
    local mouseCoordsEnabled = false
    createToggleRow(
        devContentFrame,
        "Mouse Coords",
        true,
        function() return mouseCoordsEnabled end,
        function() 
            mouseCoordsEnabled = true
            mouseCoordsGui.Enabled = true
        end,
        function() 
            mouseCoordsEnabled = false
            mouseCoordsGui.Enabled = false
        end
    )
end

do
    -- Dex Explorer
    createToggleRow(
        devContentFrame,
        "Dex Explorer",
        false,  -- Не toggle, одноразовый
        function() return false end,
        function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Ramzesuskan/YummySrc/refs/heads/main/dex.lua", true))()
        end,
        function() end
    )
end

--////////////////////////////////////////////////////
