--////////////////////////////////////////////////////////
--            small hubby - By 7g0d
--////////////////////////////////////////////////////////

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer

-- Функция ожидания загрузки персонажа
local function waitForCharacterLoad()
    repeat
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local hrp = character:FindFirstChild("HumanoidRootPart")
            if humanoid and hrp and humanoid.Health > 0 then
                return true
            end
        end
        task.wait(0.5)
    until false
end

-- Функция создания интерфейса (будет вызвана после загрузки)
local function createGUI()
    -------------------------------------------------------------------------------
    --    ScreenGui (mainFrame) with dragging functionality
    -------------------------------------------------------------------------------
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "VenomHubScreenGui"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "VenomHubMainFrame"
    mainFrame.Size = UDim2.new(0, 170, 0, 150)
    mainFrame.Position = UDim2.new(0.05, 0, 0.1, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(204, 82, 155)
    mainFrame.BorderSizePixel = 2
    mainFrame.Visible = true
    mainFrame.Active = true
    mainFrame.Selectable = true
    mainFrame.Parent = screenGui

    -- Dragging functionality
    local dragging = false
    local dragInput, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    mainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)

    -- Заголовок
    local titleBar = Instance.new("TextLabel")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 30)
    titleBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    titleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleBar.Font = Enum.Font.SourceSansBold
    titleBar.TextSize = 18
    titleBar.Text = "Small Hubby"
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

    -- Прокручиваемая область для кнопок
    local contentFrame = Instance.new("ScrollingFrame")
    contentFrame.Name = "ContentFrame"
    contentFrame.Size = UDim2.new(1, -10, 1, -60)
    contentFrame.Position = UDim2.new(0, 5, 0, 35)
    contentFrame.BackgroundTransparency = 1
    contentFrame.BorderSizePixel = 0
    contentFrame.ScrollingDirection = Enum.ScrollingDirection.Y
    contentFrame.ScrollBarThickness = 4
    contentFrame.Parent = mainFrame

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Padding = UDim.new(0,5)
    UIListLayout.Parent = contentFrame

    -------------------------------------------------------------------------------
    --    K keybind
    -------------------------------------------------------------------------------
    UserInputService.InputBegan:Connect(function(input, gp)
        if not gp and input.KeyCode == Enum.KeyCode.K then
            mainFrame.Visible = not mainFrame.Visible
        end
    end)

    --======================= AUTOFARM SYSTEM =========================--
    local autofarmEnabled = false
    local autofarmCooldown = false
    local openedTargetsCount = 0
    local ignoredSafes = {}
    local CoolDowns = { AutoPickUps = { MoneyCooldown = false } }
    local Settings = { IsDead = false }

    -- Anti-kick anchor system
    local anchorConnection = nil
    local anchorPosition = nil
    local anchorEnabled = false

    -- Services for autofarm
    local services = {
        ws = game:GetService("Workspace"),
        pl = game:GetService("Players"),
        rs_rep = game:GetService("ReplicatedStorage"),
        rs = game:GetService("RunService"),
        uis = game:GetService("UserInputService")
    }

    local localPlayer = services.pl.LocalPlayer
    local task = task
    local wait = task.wait

    -- Global Variables for Ping
    local pingThreshold = 100
    local isPingHigh = false

    -- Function to check ping
    local function getPing()
        local ping = localPlayer:GetNetworkPing()
        return ping * 1000
    end

    -- A new coroutine to constantly check ping in the background
    task.spawn(function()
        while task.wait(5) do
            local ping = getPing()
            if ping > pingThreshold then
                isPingHigh = true
            else
                isPingHigh = false
            end
        end
    end)

    --======================= SHADOW MODE (Reworked Invisibility) =========================--
    local Shadow_Active = false
    local Shadow_Usable = true

    do
        repeat task.wait() until game:IsLoaded();

        local svc_ref = cloneref or function(...) return ... end;

        local GS = setmetatable({}, {
            __index = function(_, k)
                return svc_ref(game:GetService(k));
            end
        });

        local P: Player = GS.Players.LocalPlayer;
        local Char: Model = P.Character or P.CharacterAdded:Wait();
        local HMND
        local HRP

        local function RefreshCharRefs()
            Char = P.Character
            if Char then
                HRP = Char:FindFirstChild("HumanoidRootPart")
                HMND = Char:FindFirstChildOfClass("Humanoid")
            else
                HRP = nil
                HMND = nil
            end
        end

        RefreshCharRefs()

        local AnimTrack_Cache = nil
        local CamoAnim = Instance.new("Animation", nil);
        CamoAnim.AnimationId = "rbxassetid://215384594";

        local RS: RunService = GS.RunService;
        local UpdateFrame = RS.Heartbeat;
        local WaitRender = RS.RenderStepped;

        local CoreGS: CoreGui = GS.CoreGui;
        local StartGS: StarterGui = GS.StarterGui;

        -- GUI for warning message
        local HUD = Instance.new("ScreenGui");
        HUD.Name = "ShadowWarningHUD";
        HUD.Parent = CoreGS;
        HUD.ResetOnSpawn = false;
        HUD.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;

        local WarningText = Instance.new("TextLabel", HUD);
        WarningText.Text = "⚠️You are visible⚠️";
        WarningText.Visible = false;
        WarningText.Size = UDim2.new(0, 200, 0, 30);
        WarningText.Position = UDim2.new(0.5, -100, 0.85, 0);
        WarningText.BackgroundTransparency = 1;
        WarningText.Font = Enum.Font.GothamSemibold;
        WarningText.TextSize = 24;
        WarningText.TextColor3 = Color3.fromRGB(255, 255, 0);
        WarningText.TextStrokeTransparency = 0.5;
        WarningText.ZIndex = 10;

        -- Check R6 requirement
        if Char and not Char:FindFirstChild("Torso") then
            pcall(function()
                StartGS:SetCore("SendNotification", {
                    Title = "fuck off",
                    Text = "fucking nigger",
                    Duration = 5,
                });
            end)
            Shadow_Usable = false
        end

        local function CheckGrounded()
            return HMND and HMND:IsDescendantOf(workspace) and HMND.FloorMaterial ~= Enum.Material.Air;
        end

        local function CacheAnimTrack()
            if AnimTrack_Cache then
                pcall(function() AnimTrack_Cache:Stop() end)
                AnimTrack_Cache = nil
            end
            if HMND then
                local success, result = pcall(function()
                    return HMND:LoadAnimation(CamoAnim)
                end)
                if success then
                    AnimTrack_Cache = result
                    AnimTrack_Cache.Priority = Enum.AnimationPriority.Action4;
                else
                    AnimTrack_Cache = nil
                end
            else
                AnimTrack_Cache = nil
            end
        end

        local function DeactivateShadow()
            if not Shadow_Active then return end
            Shadow_Active = false;

            if AnimTrack_Cache then
                pcall(function() AnimTrack_Cache:Stop() end)
            end

            if HMND then
                workspace.CurrentCamera.CameraSubject = HMND;
            end

            if Char then
                for _, v in pairs(Char:GetDescendants()) do
                    if v:IsA("BasePart") and v.Transparency == 0.5 then
                        v.Transparency = 0;
                    end
                end
            end
            
            WarningText.Visible = false;
        end

        local function ActivateShadow()
            if Shadow_Active or not Shadow_Usable then return end

            RefreshCharRefs()
            if not Char or not HMND or not HRP then
                return
            end
            if not Char:FindFirstChild("Torso") then
                pcall(function() StartGS:SetCore("SendNotification", {Title = "fuck off", Text = "fucking nigger", Duration = 5}) end)
                return
            end

            Shadow_Active = true;
            workspace.CurrentCamera.CameraSubject = HRP;

            CacheAnimTrack()
        end

        local function ShadowStep(deltaTime)
            if not Char or not HMND or not HRP or not HMND:IsDescendantOf(workspace) or HMND.Health <= 0 then
                WarningText.Visible = false;
                return
            end

            WarningText.Visible = not CheckGrounded();

            local walk_speed = 12
            if HMND.MoveDirection.Magnitude > 0 then
                local velocity_offset = HMND.MoveDirection * walk_speed * deltaTime
                HRP.CFrame = HRP.CFrame + velocity_offset
            end

            local InitialCFrame = HRP.CFrame;
            local InitialCamOffset = HMND.CameraOffset;

            local _, yaw_angle = workspace.CurrentCamera.CFrame:ToOrientation();
            HRP.CFrame = CFrame.new(HRP.CFrame.Position) * CFrame.fromOrientation(0, yaw_angle, 0);
            HRP.CFrame = HRP.CFrame * CFrame.Angles(math.rad(90), 0, 0);
            HMND.CameraOffset = Vector3.new(0, 1.44, 0);

            if AnimTrack_Cache then
                local successPlay = pcall(function()
                    if not AnimTrack_Cache.IsPlaying then
                        AnimTrack_Cache:Play();
                    end
                    AnimTrack_Cache:AdjustSpeed(0);
                    AnimTrack_Cache.TimePosition = 0.3;
                end)
                if not successPlay then
                    CacheAnimTrack()
                end
            elseif HMND and HMND.Health > 0 then
                CacheAnimTrack()
            end

            WaitRender:Wait();

            if HMND and HMND:IsDescendantOf(workspace) then
                HMND.CameraOffset = InitialCamOffset;
            end
            if HRP and HRP:IsDescendantOf(workspace) then
                HRP.CFrame = InitialCFrame;
            end

            if AnimTrack_Cache then
                pcall(function() AnimTrack_Cache:Stop() end)
            end

            if HRP and HRP:IsDescendantOf(workspace) then
                local LookVec = workspace.CurrentCamera.CFrame.LookVector;
                local FlatLook = Vector3.new(LookVec.X, 0, LookVec.Z).Unit;
                if FlatLook.Magnitude > 0.1 then
                    local FinalCFrame = CFrame.new(HRP.Position, HRP.Position + FlatLook);
                    HRP.CFrame = FinalCFrame;
                end
            end

            if Char then
                for _, v in pairs(Char:GetDescendants()) do
                    if (v:IsA("BasePart") and v.Transparency ~= 1) then
                        v.Transparency = 0.5;
                    end
                end
            end
        end

        UpdateFrame:Connect(function(deltaTime)
            if not Shadow_Active or not Shadow_Usable then
                if not Shadow_Active and Char then
                    for _, v in pairs(Char:GetDescendants()) do
                        if v:IsA("BasePart") and v.Transparency == 0.5 then v.Transparency = 0 end
                    end
                end
                WarningText.Visible = false
                return;
            end
            
            ShadowStep(deltaTime)
        end)

        P.CharacterAdded:Connect(function(NewCharacter)
            if Shadow_Active then DeactivateShadow() end

            if AnimTrack_Cache then
                pcall(function() AnimTrack_Cache:Stop() end)
                AnimTrack_Cache = nil
            end

            task.wait()

            RefreshCharRefs()

            if not HMND then
                task.wait(0.5)
                RefreshCharRefs()
                if not HMND then
                    Shadow_Usable = false
                    if Shadow_Active then DeactivateShadow() end
                    return
                end
            end

            if HMND.RigType ~= Enum.HumanoidRigType.R6 then
                Shadow_Usable = false
                if Shadow_Active then DeactivateShadow() end
                return
            else
                Shadow_Usable = true
            end
            
            if autofarmEnabled and Shadow_Usable then
                ActivateShadow()
            end
        end)

        P.CharacterRemoving:Connect(function(OldCharacter)
            if AnimTrack_Cache then
                pcall(function() AnimTrack_Cache:Stop() end)
                AnimTrack_Cache = nil
            end
            WarningText.Visible = false
        end)

        _G.ActivateShadow = ActivateShadow
        _G.DeactivateShadow = DeactivateShadow
        _G.IsShadowActive = function() return Shadow_Active end
    end

    --======================= BREAD COLLECTOR =========================--
    local Collector_Enabled = false
    local Collector_Signal = nil
    local Collector_Task = nil

    local function Collector_CoreLogic()
        local RS_S = game:GetService("RunService")
        local RS_Rep = game:GetService("ReplicatedStorage")
        local WS = game:GetService("Workspace")

        local function RunCollectorLogic()
            if not Collector_Enabled or Settings.IsDead then return end

            local breadContainer = WS.Filter:FindFirstChild("SpawnedBread")
            local pickupRemote = RS_Rep.Events:FindFirstChild("CZDPZUS")

            if not breadContainer then
                return
            end
            if not pickupRemote then
                return
            end

            local p_char = localPlayer.Character
            local root_part = p_char and p_char:FindFirstChild("HumanoidRootPart")

            if not root_part or CoolDowns.AutoPickUps.MoneyCooldown then return end

            local current_pos = root_part.Position
            for _, item in ipairs(breadContainer:GetChildren()) do
                local dist_sq = (current_pos - item.Position).Magnitude^2
                if dist_sq < 25 and not CoolDowns.AutoPickUps.MoneyCooldown then
                    CoolDowns.AutoPickUps.MoneyCooldown = true
                    
                    pcall(function()
                        pickupRemote:FireServer(item)
                    end)
                    
                    task.wait(1.0)
                    
                    CoolDowns.AutoPickUps.MoneyCooldown = false
                    break
                end
            end
        end

        Collector_Signal = RS_S.RenderStepped:Connect(RunCollectorLogic)
    end

    local function Collector_Activate()
        if Collector_Enabled then return end
        Collector_Enabled = true

        if Collector_Signal then
            Collector_Signal:Disconnect()
            Collector_Signal = nil
        end
        if Collector_Task then
            coroutine.close(Collector_Task)
            Collector_Task = nil
        end

        Collector_CoreLogic()
    end

    local function Collector_Deactivate()
        if not Collector_Enabled then return end
        Collector_Enabled = false

        if Collector_Signal then
            Collector_Signal:Disconnect()
            Collector_Signal = nil
        end

        if CoolDowns and CoolDowns.AutoPickUps then
            CoolDowns.AutoPickUps.MoneyCooldown = false
        end
    end

    --======================= AUTOFARM MAIN FUNCTIONS =========================--
    local function Autofarm_Enable()
        if autofarmEnabled then return end
        autofarmEnabled = true
        
        _G.ActivateShadow()
        Collector_Activate()
    end

    local function Autofarm_Disable()
        if not autofarmEnabled then return end
        autofarmEnabled = false
        
        _G.DeactivateShadow()
        Collector_Deactivate()
    end

local function teleportTo(targetPart)
    if not (targetPart and targetPart:IsA("BasePart")) then
        return false
    end

    local char = localPlayer.Character or localPlayer.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart", 10)
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not humanoid then
        return false
    end

    local targetCFrame = targetPart.CFrame
    local lookVector = targetCFrame.LookVector
    local targetPos = (targetCFrame + lookVector * 3).Position

    local attempts = 0
    local maxAttempts = 45  -- 4.5 секунд
    local movementDirection = 1  -- 1 = вперед, -1 = назад

    -- Сохраняем старую позицию для основного телепорта
    local oldPosition = hrp.Position

    while attempts < maxAttempts do
        attempts += 1

        -- Обновляем ссылки на персонажа
        if not char or not char:IsDescendantOf(workspace) then
            char = localPlayer.Character
            if not char then break end
            hrp = char:FindFirstChild("HumanoidRootPart")
            humanoid = char:FindFirstChildOfClass("Humanoid")
            if not hrp or not humanoid then break end
        end

        if hrp and hrp:IsDescendantOf(workspace) then
            -- Основной телепорт к цели (сохраняем старую логику)
            local newCFrame = CFrame.lookAt(targetPos, targetPos + Vector3.new(lookVector.X, 0, lookVector.Z))
            hrp.CFrame = newCFrame
            
            -- Движение вперед-назад каждые 0.1 секунды
            if movementDirection == 1 then
                -- Движение вперед
                humanoid:Move(Vector3.new(lookVector.X, 0, lookVector.Z))
            else
                -- Движение назад
                humanoid:Move(Vector3.new(-lookVector.X, 0, -lookVector.Z))
            end
            
            -- Меняем направление каждые 2 итерации (0.2 секунды)
            if attempts % 2 == 0 then
                movementDirection = -movementDirection
            end
        end

        task.wait(0.1)
    end

    -- Останавливаем движение после завершения
    humanoid:Move(Vector3.new(0, 0, 0))

    -- Проверка: если рядом с целью — успех
    if hrp and hrp:IsDescendantOf(workspace) and (hrp.Position - targetPos).Magnitude <= 5 then
        return true
    end
    
    -- Если не удалось добраться, возвращаем на старую позицию
    if hrp and hrp:IsDescendantOf(workspace) then
        hrp.CFrame = CFrame.new(oldPosition)
    end
    
    return false
end

-- Function to find the nearest working target with priority system
local function findNearestTarget(targetsToIgnore)
    local bredMakurzFolder = services.ws.Map:FindFirstChild("BredMakurz") or services.ws.Filter:FindFirstChild("BredMakurz")
    local char = localPlayer.Character

    if not bredMakurzFolder then
        return nil
    end
    if not char then return nil end

    local playerPosition = char:FindFirstChild("HumanoidRootPart").Position

    -- Priority system: MediumSafe > SmallSafe > Registers
    local mediumSafes = {}
    local smallSafes = {}
    local registers = {}

    -- Categorize all available targets
    for _, v in ipairs(bredMakurzFolder:GetChildren()) do
        if not table.find(targetsToIgnore, v) then
            local values = v:FindFirstChild("Values")
            if values then
                local broken = values:FindFirstChild("Broken")
                if broken and broken:IsA("BoolValue") and not broken.Value then
                    local targetPart = v.PrimaryPart or v:FindFirstChild("MainPart") or v:FindFirstChild("PosPart")
                    if targetPart then
                        local distance = (targetPart.Position - playerPosition).Magnitude
                        
                        -- Categorize by name pattern (more flexible)
                        local lowerName = string.lower(v.Name)
                        
                        if string.find(lowerName, "medium") then
                            table.insert(mediumSafes, {target = v, distance = distance})
                        elseif string.find(lowerName, "small") then
                            table.insert(smallSafes, {target = v, distance = distance})
                        elseif string.find(lowerName, "register") then
                            table.insert(registers, {target = v, distance = distance})
                        end
                    end
                end
            end
        end
    end

    -- Sort each category by distance
    table.sort(mediumSafes, function(a, b) return a.distance < b.distance end)
    table.sort(smallSafes, function(a, b) return a.distance < b.distance end)
    table.sort(registers, function(a, b) return a.distance < b.distance end)

    -- Return targets in priority order
    if #mediumSafes > 0 then
        return mediumSafes[1].target
    elseif #smallSafes > 0 then
        return smallSafes[1].target
    elseif #registers > 0 then
        return registers[1].target
    end

    return nil
end

-- Function to check if the player has a tool (crowbar)
local function hasTool(toolName)
    local backpackTool = localPlayer.Backpack:FindFirstChild(toolName)
    local characterTool = localPlayer.Character and localPlayer.Character:FindFirstChild(toolName)
    return backpackTool or characterTool
end

-- Function to find the nearest crowbar dealer
local function findNearestDealer()
    local shopz = services.ws.Map:FindFirstChild("Shopz")
    local char = localPlayer.Character

    if not shopz or not char then return nil end

    local nearestDealer = nil
    local shortestDistance = math.huge
    local playerPosition = char:FindFirstChild("HumanoidRootPart").Position

    for _, dealer in ipairs(shopz:GetChildren()) do
        local crowbarStock = dealer:FindFirstChild("CurrentStocks") and dealer.CurrentStocks:FindFirstChild("Crowbar")
        if crowbarStock and crowbarStock.Value > 0 and dealer:FindFirstChild("MainPart") then
            local distance = (dealer.MainPart.Position - playerPosition).Magnitude
            if distance < shortestDistance then
                shortestDistance = distance
                nearestDealer = dealer
            end
        end
    end
    return nearestDealer
end

-- Function to open a safe with simulated hits
local function openSafe(safeModel)
    local equippedCrowbar = hasTool("Crowbar")
    if not equippedCrowbar then
        return
    end
    
    local remoteXMHH = services.rs_rep:WaitForChild("Events"):WaitForChild("XMHH.2")
    local remoteXMHH2 = services.rs_rep:WaitForChild("Events"):WaitForChild("XMHH2.2")
    local safeMainPart = safeModel:WaitForChild("MainPart", 5)

    if not safeMainPart then return end

    local startTime = tick()
    while safeModel and safeModel.Parent and safeModel.Values and safeModel.Values.Broken and not safeModel.Values.Broken.Value and (tick() - startTime < 15) do
        local char = localPlayer.Character
        if not char then break end

        local safeOpenValue = remoteXMHH:InvokeServer("\240\159\141\158", tick(), equippedCrowbar, "DZDRRRKI", safeModel, "Register")

        if safeOpenValue == nil then
            task.wait(0)
            continue
        end

        local currentTime = tick()
        remoteXMHH2:FireServer(
            "\240\159\141\158", currentTime, equippedCrowbar, "2389ZFX34", safeOpenValue, false,
            char["Right Arm"], safeMainPart, safeModel, safeMainPart.Position, safeMainPart.Position
        )
        
        task.wait(0)
    end

    -- === ЗАДЕРЖКА: 15 сек для первых 2 целей ПОСЛЕ РЕСПАУНА, иначе 11 ===
    local delay = 11

    if openedTargetsCount < 2 then
        delay = 11
        openedTargetsCount += 1
    end

    task.wait(delay)
end

-- =================================================================================
-- --- ОСНОВНАЯ ЛОГИКА АВТОФАРМА С ПРИОРИТЕТОМ НА MEDIUM SAFE ---
-- =================================================================================
local noTargetCounter = 0

task.spawn(function()
    while true do
        wait(1)
        local char = localPlayer.Character
        local humanoid = char and char:FindFirstChildOfClass("Humanoid")
        
        if humanoid then
            Settings.IsDead = humanoid.Health <= 0
        end
        
        -- Force re-enable shadow if autofarm is on but shadow turned off
        if autofarmEnabled and not Shadow_Active then
            _G.ActivateShadow()
        end
        
        if not autofarmEnabled or autofarmCooldown or not char or not humanoid or humanoid.Health <= 0 or isPingHigh then
            continue
        end
        
        local crowbar = hasTool("Crowbar")
        if not crowbar then
            local dealer = findNearestDealer()
            if dealer then
                if teleportTo(dealer:WaitForChild("MainPart")) then
                    wait(1)
                    services.rs_rep.Events.BYZERSPROTEC:FireServer(true, "shop", dealer.MainPart, "IllegalStore")
                    wait(1)
                    local args = {"IllegalStore", "Melees", "Crowbar", dealer.MainPart, nil, true}
                    services.rs_rep.Events.SSHPRMTE1:InvokeServer(unpack(args))
                    wait(25)
                    services.rs_rep.Events.BYZERSPROTEC:FireServer(false)
                else
                    wait(1)
                end
            else
                wait(1)
            end
        else
            local target = findNearestTarget(ignoredSafes)
            if target then
                noTargetCounter = 0
                
                if teleportTo(target:WaitForChild("MainPart")) then
                    if localPlayer.Character:FindFirstChild("Crowbar") == nil then
                        local success, err = pcall(function()
                            localPlayer.Character.Humanoid:EquipTool(crowbar)
                        end)
                        if not success then
                            task.wait(1)
                            pcall(function() localPlayer.Character.Humanoid:EquipTool(crowbar) end)
                        end
                    end
                    
                    wait(0.1)
                    openSafe(target)
                else
                    table.insert(ignoredSafes, target)
                    wait(0.5)
                end
            else
                noTargetCounter = noTargetCounter + 1
                
                if noTargetCounter >= 4 then
                    ignoredSafes = {}
                    noTargetCounter = 0
                    wait(10)
                else
                    wait(7)
                end
            end
        end
    end
end)

task.spawn(function()
    local deathRespawnEvent = services.rs_rep:WaitForChild("Events"):WaitForChild("DeathRespawn")
    while task.wait() do
        local char = localPlayer.Character
        if char then
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health <= 0 and autofarmEnabled then
                deathRespawnEvent:InvokeServer("KMG4R904")
                task.wait(2)
                if autofarmEnabled then
                    _G.ActivateShadow()
                end
            end
        end
    end
end)


    localPlayer.CharacterAdded:Connect(function(character)
        if not autofarmEnabled then
            return
        end

        character:WaitForChild("HumanoidRootPart", 5)
        autofarmCooldown = false
        ignoredSafes = {}
        
        -- СБРАСЫВАЕМ СЧЁТЧИК ПОСЛЕ КАЖДОЙ СМЕРТИ/РЕСПАУНА
        openedTargetsCount = 0
        
        task.wait(2)
        Autofarm_Enable()
    end)

    --======================= ADMIN DETECTION SYSTEM =========================--
    local AdminCheck_Enabled = false
    local AdminCheck_Connection = nil

    local staffPlayers = {
        groups = {
            [4165692] = { ["Tester"] = true, ["Contributor"] = true, ["Tester+"] = true, ["Developer"] = true,
                ["Developer+"] = true, ["Community Manager"] = true, ["Manager"] = true, ["Owner"] = true },
            [32406137] = { ["Junior"] = true, ["Moderator"] = true, ["Senior"] = true, ["Administrator"] = true,
                ["Manager"] = true, ["Holder"] = true },
            [8024440] = { ["zzzz"] = true, ["reshape enjoyer"] = true, ["i heart reshape"] = true, ["reshape superfan"] = true },
            [14927228] = { ["♞"] = true }
        },
        users = { 
             3294804378, 93676120, 54087314, 81275825, 140837601, 1229486091, 46567801, 418086275, 29706395,
             3717066084, 1424338327, 5046662686, 5046661126, 5046659439, 418199326, 1024216621, 1810535041,
             63238912, 111250044, 63315426, 730176906, 141193516, 194512073, 193945439, 412741116, 195538733,
             102045519, 955294, 957835150, 25689921, 366613818, 281593651, 455275714, 208929505, 96783330,
             156152502, 93281166, 959606619, 142821118, 632886139, 175931803, 122209625, 278097946, 142989311,
             1517131734, 446849296, 87189764, 67180844, 9212846, 47352513, 48058122, 155413858, 10497435,
             513615792, 55893752, 55476024, 151691292, 136584758, 16983447, 3111449, 94693025, 271400893,
             5005262660, 295331237, 64489098, 244844600, 114332275, 25048901, 69262878, 50801509, 92504899,
             42066711, 50585425, 31365111, 166406495, 2457253857, 29761878, 21831137, 948293345, 439942262,
             38578487, 1163048, 7713309208, 3659305297, 15598614, 34616594, 626833004, 198610386, 153835477,
             3923114296, 3937697838, 102146039, 119861460, 371665775, 1206543842, 93428604, 1863173316, 90814576,
             374665997, 423005063, 140172831, 42662179, 9066859, 438805620, 14855669, 727189337, 1871290386,
             608073286
        }
    }

    local function hasTracker(player)
        if not player or not player:IsA("Player") then return false, nil end
        local children = player:GetChildren()
        for i = 1, #children do
            local child = children[i]
            if typeof(child.Name) == "string" and string.sub(child.Name, -8) == "Tracker$" then
                local trackedPlayerName = string.sub(child.Name, 1, -9)
                 if Players:FindFirstChild(trackedPlayerName) then
                    return true, trackedPlayerName
                end
            end
        end
        return false, nil
    end

    local function isStaff(player)
        if not player or not player:IsA("Player") then return false end

        if staffPlayers.groups then
            for groupID, roles in pairs(staffPlayers.groups) do
                local successRank, rank = pcall(function() return player:GetRankInGroup(groupID) end)
                if successRank and rank and rank > 0 then
                    local successRole, roleName = pcall(function() return player:GetRoleInGroup(groupID) end)
                    if successRole and roleName and roles[roleName] then
                        return true, roleName, groupID
                    end
                end
            end
        end

        if staffPlayers.users then
            for i = 1, #staffPlayers.users do
                if player.UserId == staffPlayers.users[i] then
                    return true, "UserID", player.UserId
                end
            end
        end

        return false
    end

    local function kickformat(staffInfo)
        if not staffInfo or not staffInfo.Staff then return "Staff detected." end
        local message = "Staff detected:\n"
        for i, staff in ipairs(staffInfo.Staff) do
            local idType = "Role"
            local idValue = staff.Role or "Unknown"
            if staff.Role == "UserID" then
                idType = "UserID"
                idValue = staff.GroupId or "Unknown"
            elseif staff.Role == "Tracker User" then
                 idType = "Tracker"
                 idValue = "Active"
            end

            message = message .. string.format(
                "- %s (%s: %s)%s",
                staff.Name or "Unknown",
                idType,
                idValue,
                staff.TrackedPlayer and " - Tracking: " .. staff.TrackedPlayer or ""
            )
            if i < #staffInfo.Staff then
                message = message .. "\n"
            end
        end
        return message
    end

    local function kickWithStaffInfo(staffInfo)
        local kickMsg = kickformat(staffInfo)
        if LocalPlayer then
            LocalPlayer:Kick("Staff joined\n\n" .. kickMsg)
        end
    end

    local function checkCurrentStaff()
        local staffFound = {}
        local currentPlayers = Players:GetPlayers()
        for i = 1, #currentPlayers do
            local player = currentPlayers[i]
            if player ~= LocalPlayer then
                local isPlayerStaff, role, groupID = isStaff(player)
                local hasTrackers, trackedPlayer = hasTracker(player)

                if isPlayerStaff or hasTrackers then
                    table.insert(staffFound, {
                        Name = player.Name,
                        Role = hasTrackers and "Tracker User" or role,
                        GroupId = groupID,
                        TrackedPlayer = trackedPlayer
                    })
                end
            end
        end

        if #staffFound > 0 then
            kickWithStaffInfo({Staff = staffFound})
            return true
        end
        return false
    end

    local function onPlayerJoining(player)
         if not AdminCheck_Enabled then return end

         local isPlayerStaff, role, groupID = isStaff(player)
         local hasTrackers, trackedPlayer = hasTracker(player)

         if isPlayerStaff or hasTrackers then
             local staffInfo = {
                 Staff = {{
                     Name = player.Name,
                     Role = hasTrackers and "Tracker User" or role,
                     GroupId = groupID,
                     TrackedPlayer = trackedPlayer
                 }}
             }
             kickWithStaffInfo(staffInfo)
         end
    end

    local function AdminCheck_Enable()
        if AdminCheck_Enabled then return end
        AdminCheck_Enabled = true

        if AdminCheck_Connection then
            AdminCheck_Connection:Disconnect()
            AdminCheck_Connection = nil
        end

        AdminCheck_Connection = Players.PlayerAdded:Connect(onPlayerJoining)

        task.spawn(function()
            local foundStaff = checkCurrentStaff()

            if foundStaff then
                AdminCheck_Enabled = false
                if AdminCheck_Connection then
                     AdminCheck_Connection:Disconnect()
                     AdminCheck_Connection = nil
                end
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
    end

    --========================== Anti AFK ===========================--
    local AntiAFK_Enabled = false
    local AntiAFK_IdledConnection
    local AntiAFK_Coroutine

    local function AntiAFK_DoAction()
        -- Имитируем нажатие клавиши "W" (движение вперёд)
        pcall(function()
            VirtualUser:CaptureController()
            VirtualUser:SetKeyDown(Enum.KeyCode.W)
            task.wait(0.05) -- 50 миллисекунд — достаточно для детекции, но не для заметного движения
            VirtualUser:SetKeyUp(Enum.KeyCode.W)
        end)
        
        -- Опционально: лёгкое движение камеры для дополнительной "активности"
        pcall(function()
            local cam = workspace.CurrentCamera
            if cam then
                cam.CFrame = cam.CFrame * CFrame.Angles(0, math.rad(0.3), 0)
                task.wait(0.01)
                cam.CFrame = cam.CFrame * CFrame.Angles(0, math.rad(-0.3), 0)
            end
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
                task.wait(25) -- каждые 25 секунд (можно изменить, обычно AFK-кик ~5–10 мин)
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
        if AntiAFK_Coroutine then
            -- Корутина завершится сама при следующей проверке AntiAFK_Enabled
            AntiAFK_Coroutine = nil
        end
    end

    --=================== Melee Aura =====================--
    local MeleeAura_Enabled = false
    local MeleeAura_Connection

    local runAttackLoop do
        local plrs = game:GetService("Players")
        local me = plrs.LocalPlayer
        local run = game:GetService("RunService")

        local remote1 = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("XMHH.2")
        local remote2 = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("XMHH2.2")

        local maxdist = 20

        local function Attack(target)
            if not (target and target:FindFirstChild("Head")) then return end
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
                if Handle and target:FindFirstChild("Head") then
                    local arg2 = {
                        [1] = "🍞",
                        [2] = tick(),
                        [3] = tool,
                        [4] = "2389ZFX34",
                        [5] = result,
                        [6] = false,
                        [7] = Handle,
                        [8] = target:FindFirstChild("Head"),
                        [9] = target,
                        [10] = me.Character:FindFirstChild("HumanoidRootPart").Position,
                        [11] = target:FindFirstChild("Head").Position
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

    --======================= Kill Button =========================--
    local function killScript()
        if AntiAFK_IdledConnection then AntiAFK_IdledConnection:Disconnect() end
        if AdminCheck_Connection then AdminCheck_Connection:Disconnect() end
        if Collector_Signal then Collector_Signal:Disconnect() end

        autofarmEnabled = false
        AdminCheck_Enabled = false
        AntiAFK_Enabled = false
        Collector_Enabled = false

        _G.DeactivateShadow()

        if screenGui then
            screenGui:Destroy()
            screenGui = nil
        end
    end

    -------------------------------------------------------------------------------
    --    Функция создания строки (createToggleRow) для кнопок
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
                if capturingKey then
                    capturingKey = false
                    bindButton.Text = "Bind"
                else
                    capturingKey = true
                    bindButton.Text = "Press Key..."
                end
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
                            onEnable()
                            button.Text = "DONE"
                            button.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
                            button.Active = false
                            bindButton.Active = false
                        end
                    end
                end
            end)
        else
            bindButton.Visible = false
        end

        return frame
    end

    -------------------------------------------------------------------------------
    --   Создаём кнопки в нужном порядке
    -------------------------------------------------------------------------------

    -- Autofarm button
    do
        local autofarmBind = nil
        createToggleRow(
            contentFrame,
            "Autofarm",
            true,
            function() return autofarmEnabled end,
            Autofarm_Enable,
            Autofarm_Disable,
            function() return autofarmBind end,
            function(k) autofarmBind = k end
        )
    end

    -- Admin Detection button
    do
        local adminCheckBind = nil
        createToggleRow(
            contentFrame,
            "Staff",
            true,
            function() return AdminCheck_Enabled end,
            AdminCheck_Enable,
            AdminCheck_Disable,
            function() return adminCheckBind end,
            function(k) adminCheckBind = k end
        )
    end

    -- Anti AFK button
    do
        local antiAFKBind = nil
        createToggleRow(
            contentFrame,
            "Anti AFK",
            true,
            function() return AntiAFK_Enabled end,
            AntiAFK_Enable,
            AntiAFK_Disable,
            function() return antiAFKBind end,
            function(k) antiAFKBind = k end
        )
    end

    -- 5) Melee Aura 4 Alt MAX!
    do
        local meleeBind = nil
        createToggleRow(
            contentFrame,
            "Melee Aura",
            true,
            function() return MeleeAura_Enabled end,
            MeleeAura_Enable,
            MeleeAura_Disable,
            function() return meleeBind end,
            function(k) meleeBind = k end
        )
    end

    -- Kill Button
    local killButtonFrame = Instance.new("Frame")
    killButtonFrame.Size = UDim2.new(1, 0, 0, 30)
    killButtonFrame.BackgroundTransparency = 1
    killButtonFrame.Parent = contentFrame

    local killButtonLabel = Instance.new("TextLabel")
    killButtonLabel.Size = UDim2.new(0.4, 0, 1, 0)
    killButtonLabel.BackgroundTransparency = 1
    killButtonLabel.Text = "kill button"
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

    killButton.MouseButton1Click:Connect(function()
        killScript()
        killButton.Text = "DONE"
        killButton.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        killButton.Active = false
    end)
end

-- Ожидаем загрузку игры и персонажа
task.spawn(function()
    repeat task.wait() until game:IsLoaded()
    print("Game loaded, waiting for character...")
    
    waitForCharacterLoad()
    print("Character loaded, creating GUI...")
    
    -- Теперь создаем интерфейс
    createGUI()
end)
