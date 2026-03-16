local player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local flying = false
local flySpeed = 50
local bodyVelocity
local bodyGyro

local spinBV = nil
local spinEnabled = false

local ultraSpinBV = nil
local ultraSpinEnabled = false

local flingNickEnabled = false
local flingNickConnection = nil
local flingNickTarget = nil

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FunnHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = player.PlayerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 250, 0, 550)
mainFrame.Position = UDim2.new(0.5, -125, 1, 10)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
title.Text = "Funn Hub"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = title

local tabButtons = Instance.new("Frame")
tabButtons.Size = UDim2.new(1, 0, 0, 30)
tabButtons.Position = UDim2.new(0, 0, 0, 30)
tabButtons.BackgroundTransparency = 1
tabButtons.Parent = mainFrame

local mainTabButton = Instance.new("TextButton")
mainTabButton.Size = UDim2.new(0.5, 0, 1, 0)
mainTabButton.Position = UDim2.new(0, 0, 0, 0)
mainTabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
mainTabButton.Text = "Main"
mainTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
mainTabButton.Font = Enum.Font.Gotham
mainTabButton.TextSize = 14
mainTabButton.Parent = tabButtons

local funTabButton = Instance.new("TextButton")
funTabButton.Size = UDim2.new(0.5, 0, 1, 0)
funTabButton.Position = UDim2.new(0.5, 0, 0, 0)
funTabButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
funTabButton.Text = "Fun"
funTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
funTabButton.Font = Enum.Font.Gotham
funTabButton.TextSize = 14
funTabButton.Parent = tabButtons

local mainScrollingFrame = Instance.new("ScrollingFrame")
mainScrollingFrame.Size = UDim2.new(1, 0, 1, -60)
mainScrollingFrame.Position = UDim2.new(0, 0, 0, 60)
mainScrollingFrame.BackgroundTransparency = 1
mainScrollingFrame.ScrollBarThickness = 8
mainScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
mainScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 350)
mainScrollingFrame.Parent = mainFrame

local mainContent = Instance.new("Frame")
mainContent.Size = UDim2.new(1, 0, 0, 350)
mainContent.BackgroundTransparency = 1
mainContent.Parent = mainScrollingFrame

local funContent = Instance.new("Frame")
funContent.Size = UDim2.new(1, 0, 0, 470)
funContent.Position = UDim2.new(0, 0, 0, 60)
funContent.BackgroundTransparency = 1
funContent.Visible = false
funContent.Parent = mainFrame

local flySpeedLabel = Instance.new("TextLabel")
flySpeedLabel.Size = UDim2.new(0.5, -10, 0, 25)
flySpeedLabel.Position = UDim2.new(0, 10, 0, 10)
flySpeedLabel.BackgroundTransparency = 1
flySpeedLabel.Text = "Fly Speed:"
flySpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
flySpeedLabel.Font = Enum.Font.Gotham
flySpeedLabel.TextSize = 14
flySpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
flySpeedLabel.Parent = mainContent

local flySpeedBox = Instance.new("TextBox")
flySpeedBox.Size = UDim2.new(0.5, -10, 0, 25)
flySpeedBox.Position = UDim2.new(0.5, 0, 0, 10)
flySpeedBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
flySpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
flySpeedBox.Font = Enum.Font.Gotham
flySpeedBox.TextSize = 14
flySpeedBox.Text = "50"
flySpeedBox.ClearTextOnFocus = false
flySpeedBox.Parent = mainContent

local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0, 4)
boxCorner.Parent = flySpeedBox

local walkSpeedLabel = Instance.new("TextLabel")
walkSpeedLabel.Size = UDim2.new(0.5, -10, 0, 25)
walkSpeedLabel.Position = UDim2.new(0, 10, 0, 45)
walkSpeedLabel.BackgroundTransparency = 1
walkSpeedLabel.Text = "WalkSpeed:"
walkSpeedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
walkSpeedLabel.Font = Enum.Font.Gotham
walkSpeedLabel.TextSize = 14
walkSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
walkSpeedLabel.Parent = mainContent

local walkSpeedBox = Instance.new("TextBox")
walkSpeedBox.Size = UDim2.new(0.5, -10, 0, 25)
walkSpeedBox.Position = UDim2.new(0.5, 0, 0, 45)
walkSpeedBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
walkSpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
walkSpeedBox.Font = Enum.Font.Gotham
walkSpeedBox.TextSize = 14
walkSpeedBox.Text = "16"
walkSpeedBox.ClearTextOnFocus = false
walkSpeedBox.Parent = mainContent

local walkCorner = Instance.new("UICorner")
walkCorner.CornerRadius = UDim.new(0, 4)
walkCorner.Parent = walkSpeedBox

local jumpPowerLabel = Instance.new("TextLabel")
jumpPowerLabel.Size = UDim2.new(0.5, -10, 0, 25)
jumpPowerLabel.Position = UDim2.new(0, 10, 0, 80)
jumpPowerLabel.BackgroundTransparency = 1
jumpPowerLabel.Text = "JumpPower:"
jumpPowerLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
jumpPowerLabel.Font = Enum.Font.Gotham
jumpPowerLabel.TextSize = 14
jumpPowerLabel.TextXAlignment = Enum.TextXAlignment.Left
jumpPowerLabel.Parent = mainContent

local jumpPowerBox = Instance.new("TextBox")
jumpPowerBox.Size = UDim2.new(0.5, -10, 0, 25)
jumpPowerBox.Position = UDim2.new(0.5, 0, 0, 80)
jumpPowerBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
jumpPowerBox.TextColor3 = Color3.fromRGB(255, 255, 255)
jumpPowerBox.Font = Enum.Font.Gotham
jumpPowerBox.TextSize = 14
jumpPowerBox.Text = "50"
jumpPowerBox.ClearTextOnFocus = false
jumpPowerBox.Parent = mainContent

local jumpCorner = Instance.new("UICorner")
jumpCorner.CornerRadius = UDim.new(0, 4)
jumpCorner.Parent = jumpPowerBox

local applyButton = Instance.new("TextButton")
applyButton.Size = UDim2.new(0.8, 0, 0, 30)
applyButton.Position = UDim2.new(0.1, 0, 0, 120)
applyButton.BackgroundColor3 = Color3.fromRGB(70, 130, 200)
applyButton.Text = "Apply"
applyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
applyButton.Font = Enum.Font.GothamBold
applyButton.TextSize = 14
applyButton.Parent = mainContent

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 6)
buttonCorner.Parent = applyButton

local toggleFlyButton = Instance.new("TextButton")
toggleFlyButton.Size = UDim2.new(0.8, 0, 0, 30)
toggleFlyButton.Position = UDim2.new(0.1, 0, 0, 160)
toggleFlyButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
toggleFlyButton.Text = "Toggle Fly (X)"
toggleFlyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleFlyButton.Font = Enum.Font.Gotham
toggleFlyButton.TextSize = 14
toggleFlyButton.Parent = mainContent

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 6)
toggleCorner.Parent = toggleFlyButton

local noclipLabel = Instance.new("TextLabel")
noclipLabel.Size = UDim2.new(0.5, -10, 0, 25)
noclipLabel.Position = UDim2.new(0, 10, 0, 200)
noclipLabel.BackgroundTransparency = 1
noclipLabel.Text = "Noclip"
noclipLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
noclipLabel.Font = Enum.Font.Gotham
noclipLabel.TextSize = 14
noclipLabel.TextXAlignment = Enum.TextXAlignment.Left
noclipLabel.Parent = mainContent

local noclipToggle = Instance.new("TextButton")
noclipToggle.Size = UDim2.new(0, 50, 0, 25)
noclipToggle.Position = UDim2.new(0.5, 0, 0, 200)
noclipToggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
noclipToggle.Text = "OFF"
noclipToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
noclipToggle.Font = Enum.Font.Gotham
noclipToggle.TextSize = 14
noclipToggle.Parent = mainContent

local noclipToggleCorner = Instance.new("UICorner")
noclipToggleCorner.CornerRadius = UDim.new(0, 4)
noclipToggleCorner.Parent = noclipToggle

local fakeLagLabel = Instance.new("TextLabel")
fakeLagLabel.Size = UDim2.new(0.5, -10, 0, 25)
fakeLagLabel.Position = UDim2.new(0, 10, 0, 10)
fakeLagLabel.BackgroundTransparency = 1
fakeLagLabel.Text = "Fake Lag"
fakeLagLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
fakeLagLabel.Font = Enum.Font.Gotham
fakeLagLabel.TextSize = 14
fakeLagLabel.TextXAlignment = Enum.TextXAlignment.Left
fakeLagLabel.Parent = funContent

local fakeLagToggle = Instance.new("TextButton")
fakeLagToggle.Size = UDim2.new(0, 50, 0, 25)
fakeLagToggle.Position = UDim2.new(0.5, 0, 0, 10)
fakeLagToggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
fakeLagToggle.Text = "OFF"
fakeLagToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
fakeLagToggle.Font = Enum.Font.Gotham
fakeLagToggle.TextSize = 14
fakeLagToggle.Parent = funContent

local fakeLagToggleCorner = Instance.new("UICorner")
fakeLagToggleCorner.CornerRadius = UDim.new(0, 4)
fakeLagToggleCorner.Parent = fakeLagToggle

local fakeLagDelayLabel = Instance.new("TextLabel")
fakeLagDelayLabel.Size = UDim2.new(0.5, -10, 0, 25)
fakeLagDelayLabel.Position = UDim2.new(0, 10, 0, 45)
fakeLagDelayLabel.BackgroundTransparency = 1
fakeLagDelayLabel.Text = "Delay (ms):"
fakeLagDelayLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
fakeLagDelayLabel.Font = Enum.Font.Gotham
fakeLagDelayLabel.TextSize = 14
fakeLagDelayLabel.TextXAlignment = Enum.TextXAlignment.Left
fakeLagDelayLabel.Parent = funContent

local fakeLagDelayBox = Instance.new("TextBox")
fakeLagDelayBox.Size = UDim2.new(0.5, -10, 0, 25)
fakeLagDelayBox.Position = UDim2.new(0.5, 0, 0, 45)
fakeLagDelayBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
fakeLagDelayBox.TextColor3 = Color3.fromRGB(255, 255, 255)
fakeLagDelayBox.Font = Enum.Font.Gotham
fakeLagDelayBox.TextSize = 14
fakeLagDelayBox.Text = "500"
fakeLagDelayBox.ClearTextOnFocus = false
fakeLagDelayBox.Parent = funContent

local fakeLagDelayCorner = Instance.new("UICorner")
fakeLagDelayCorner.CornerRadius = UDim.new(0, 4)
fakeLagDelayCorner.Parent = fakeLagDelayBox

local delayWalkLabel = Instance.new("TextLabel")
delayWalkLabel.Size = UDim2.new(0.5, -10, 0, 25)
delayWalkLabel.Position = UDim2.new(0, 10, 0, 80)
delayWalkLabel.BackgroundTransparency = 1
delayWalkLabel.Text = "Delay Walk"
delayWalkLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
delayWalkLabel.Font = Enum.Font.Gotham
delayWalkLabel.TextSize = 14
delayWalkLabel.TextXAlignment = Enum.TextXAlignment.Left
delayWalkLabel.Parent = funContent

local delayWalkToggle = Instance.new("TextButton")
delayWalkToggle.Size = UDim2.new(0, 50, 0, 25)
delayWalkToggle.Position = UDim2.new(0.5, 0, 0, 80)
delayWalkToggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
delayWalkToggle.Text = "OFF"
delayWalkToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
delayWalkToggle.Font = Enum.Font.Gotham
delayWalkToggle.TextSize = 14
delayWalkToggle.Parent = funContent

local delayWalkToggleCorner = Instance.new("UICorner")
delayWalkToggleCorner.CornerRadius = UDim.new(0, 4)
delayWalkToggleCorner.Parent = delayWalkToggle

local delayWalkDelayLabel = Instance.new("TextLabel")
delayWalkDelayLabel.Size = UDim2.new(0.5, -10, 0, 25)
delayWalkDelayLabel.Position = UDim2.new(0, 10, 0, 115)
delayWalkDelayLabel.BackgroundTransparency = 1
delayWalkDelayLabel.Text = "Delay (ms):"
delayWalkDelayLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
delayWalkDelayLabel.Font = Enum.Font.Gotham
delayWalkDelayLabel.TextSize = 14
delayWalkDelayLabel.TextXAlignment = Enum.TextXAlignment.Left
delayWalkDelayLabel.Parent = funContent

local delayWalkDelayBox = Instance.new("TextBox")
delayWalkDelayBox.Size = UDim2.new(0.5, -10, 0, 25)
delayWalkDelayBox.Position = UDim2.new(0.5, 0, 0, 115)
delayWalkDelayBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
delayWalkDelayBox.TextColor3 = Color3.fromRGB(255, 255, 255)
delayWalkDelayBox.Font = Enum.Font.Gotham
delayWalkDelayBox.TextSize = 14
delayWalkDelayBox.Text = "500"
delayWalkDelayBox.ClearTextOnFocus = false
delayWalkDelayBox.Parent = funContent

local delayWalkDelayCorner = Instance.new("UICorner")
delayWalkDelayCorner.CornerRadius = UDim.new(0, 4)
delayWalkDelayCorner.Parent = delayWalkDelayBox

local spinLabel = Instance.new("TextLabel")
spinLabel.Size = UDim2.new(0.5, -10, 0, 25)
spinLabel.Position = UDim2.new(0, 10, 0, 150)
spinLabel.BackgroundTransparency = 1
spinLabel.Text = "Spin (self)"
spinLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
spinLabel.Font = Enum.Font.Gotham
spinLabel.TextSize = 14
spinLabel.TextXAlignment = Enum.TextXAlignment.Left
spinLabel.Parent = funContent

local spinToggle = Instance.new("TextButton")
spinToggle.Size = UDim2.new(0, 50, 0, 25)
spinToggle.Position = UDim2.new(0.5, 0, 0, 150)
spinToggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
spinToggle.Text = "OFF"
spinToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
spinToggle.Font = Enum.Font.Gotham
spinToggle.TextSize = 14
spinToggle.Parent = funContent

local spinToggleCorner = Instance.new("UICorner")
spinToggleCorner.CornerRadius = UDim.new(0, 4)
spinToggleCorner.Parent = spinToggle

local ultraSpinLabel = Instance.new("TextLabel")
ultraSpinLabel.Size = UDim2.new(0.5, -10, 0, 25)
ultraSpinLabel.Position = UDim2.new(0, 10, 0, 185)
ultraSpinLabel.BackgroundTransparency = 1
ultraSpinLabel.Text = "Ultra Spin (2000 RPS)"
ultraSpinLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
ultraSpinLabel.Font = Enum.Font.Gotham
ultraSpinLabel.TextSize = 14
ultraSpinLabel.TextXAlignment = Enum.TextXAlignment.Left
ultraSpinLabel.Parent = funContent

local ultraSpinToggle = Instance.new("TextButton")
ultraSpinToggle.Size = UDim2.new(0, 50, 0, 25)
ultraSpinToggle.Position = UDim2.new(0.5, 0, 0, 185)
ultraSpinToggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
ultraSpinToggle.Text = "OFF"
ultraSpinToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
ultraSpinToggle.Font = Enum.Font.Gotham
ultraSpinToggle.TextSize = 14
ultraSpinToggle.Parent = funContent

local ultraSpinToggleCorner = Instance.new("UICorner")
ultraSpinToggleCorner.CornerRadius = UDim.new(0, 4)
ultraSpinToggleCorner.Parent = ultraSpinToggle

local nickLabel = Instance.new("TextLabel")
nickLabel.Size = UDim2.new(0.5, -10, 0, 25)
nickLabel.Position = UDim2.new(0, 10, 0, 220)
nickLabel.BackgroundTransparency = 1
nickLabel.Text = "Nickname:"
nickLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
nickLabel.Font = Enum.Font.Gotham
nickLabel.TextSize = 14
nickLabel.TextXAlignment = Enum.TextXAlignment.Left
nickLabel.Parent = funContent

local nickBox = Instance.new("TextBox")
nickBox.Size = UDim2.new(0.5, -10, 0, 25)
nickBox.Position = UDim2.new(0.5, 0, 0, 220)
nickBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
nickBox.TextColor3 = Color3.fromRGB(255, 255, 255)
nickBox.Font = Enum.Font.Gotham
nickBox.TextSize = 14
nickBox.Text = ""
nickBox.PlaceholderText = "Enter nick"
nickBox.ClearTextOnFocus = false
nickBox.Parent = funContent

local nickCorner = Instance.new("UICorner")
nickCorner.CornerRadius = UDim.new(0, 4)
nickCorner.Parent = nickBox

local flingNickButton = Instance.new("TextButton")
flingNickButton.Size = UDim2.new(0.8, 0, 0, 30)
flingNickButton.Position = UDim2.new(0.1, 0, 0, 255)
flingNickButton.BackgroundColor3 = Color3.fromRGB(200, 70, 70)
flingNickButton.Text = "Fling by Nick (once)"
flingNickButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flingNickButton.Font = Enum.Font.GothamBold
flingNickButton.TextSize = 14
flingNickButton.Parent = funContent

local flingNickCorner = Instance.new("UICorner")
flingNickCorner.CornerRadius = UDim.new(0, 6)
flingNickCorner.Parent = flingNickButton

local toggleFlingNickButton = Instance.new("TextButton")
toggleFlingNickButton.Size = UDim2.new(0.8, 0, 0, 30)
toggleFlingNickButton.Position = UDim2.new(0.1, 0, 0, 295)
toggleFlingNickButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
toggleFlingNickButton.Text = "Toggle Fling Nick"
toggleFlingNickButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleFlingNickButton.Font = Enum.Font.GothamBold
toggleFlingNickButton.TextSize = 14
toggleFlingNickButton.Parent = funContent

local toggleFlingNickCorner = Instance.new("UICorner")
toggleFlingNickCorner.CornerRadius = UDim.new(0, 6)
toggleFlingNickCorner.Parent = toggleFlingNickButton

local isOpen = false
local closedPos = UDim2.new(0.5, -125, 1, 10)
local openPos = UDim2.new(0.5, -125, 0.5, -275)

local function toggleHub()
    isOpen = not isOpen
    local targetPos = isOpen and openPos or closedPos
    local tween = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = targetPos})
    tween:Play()
end

local targetWalkSpeed = 16
local targetJumpPower = 50

local function applySettings()
    local char = player.Character
    if not char then return end
    local humanoid = char:FindFirstChild("Humanoid")
    if humanoid then
        local ws = tonumber(walkSpeedBox.Text) or 16
        local jp = tonumber(jumpPowerBox.Text) or 50
        targetWalkSpeed = ws
        targetJumpPower = jp
        humanoid.WalkSpeed = targetWalkSpeed
        humanoid.JumpPower = targetJumpPower
    end
    flySpeed = tonumber(flySpeedBox.Text) or 50
end

applyButton.MouseButton1Click:Connect(applySettings)

RunService.Heartbeat:Connect(function()
    local char = player.Character
    if not char then return end
    local humanoid = char:FindFirstChild("Humanoid")
    if humanoid then
        if humanoid.WalkSpeed ~= targetWalkSpeed then
            humanoid.WalkSpeed = targetWalkSpeed
        end
        if humanoid.JumpPower ~= targetJumpPower then
            humanoid.JumpPower = targetJumpPower
        end
    end
end)

local function toggleFly()
    local char = player.Character
    if not char then return end
    local humanoid = char:FindFirstChild("Humanoid")
    local rootPart = char:FindFirstChild("HumanoidRootPart")
    if not humanoid or not rootPart then return end

    flying = not flying

    if flying then
        humanoid.PlatformStand = true

        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0,0,0)
        bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        bodyVelocity.Parent = rootPart

        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
        bodyGyro.P = 1e4
        bodyGyro.Parent = rootPart

        spawn(function()
            while flying and char and rootPart do
                local cameraDirection = camera.CFrame.LookVector
                local cameraRight = camera.CFrame.RightVector

                local moveDirection = Vector3.new()
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveDirection = moveDirection + cameraDirection
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveDirection = moveDirection - cameraDirection
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveDirection = moveDirection - cameraRight
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveDirection = moveDirection + cameraRight
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    moveDirection = moveDirection + Vector3.new(0, 1, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) or UserInputService:IsKeyDown(Enum.KeyCode.C) then
                    moveDirection = moveDirection + Vector3.new(0, -1, 0)
                end

                if bodyVelocity then
                    bodyVelocity.Velocity = moveDirection * flySpeed
                end

                if bodyGyro then
                    bodyGyro.CFrame = CFrame.new(rootPart.Position, rootPart.Position + cameraDirection)
                end

                RunService.RenderStepped:Wait()
            end
        end)
    else
        if bodyVelocity then
            bodyVelocity:Destroy()
            bodyVelocity = nil
        end
        if bodyGyro then
            bodyGyro:Destroy()
            bodyGyro = nil
        end
        humanoid.PlatformStand = false
    end
end

_G.toggleFly = toggleFly

toggleFlyButton.MouseButton1Click:Connect(function()
    toggleFly()
end)

local noclipEnabled = false
local noclipConnection

local function setNoclip(enabled)
    if enabled then
        noclipConnection = RunService.Heartbeat:Connect(function()
            local char = player.Character
            if not char then return end
            for _, descendant in ipairs(char:GetDescendants()) do
                if descendant:IsA("BasePart") then
                    descendant.CanCollide = false
                end
            end
        end)
    else
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
    end
end

noclipToggle.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    if noclipEnabled then
        noclipToggle.Text = "ON"
        noclipToggle.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    else
        noclipToggle.Text = "OFF"
        noclipToggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    end
    setNoclip(noclipEnabled)
end)

local function setSpin(enabled)
    if enabled then
        if spinBV then
            spinBV:Destroy()
            spinBV = nil
        end
        local char = player.Character
        if not char then return end
        local rootPart = char:FindFirstChild("HumanoidRootPart")
        if not rootPart then return end
        spinBV = Instance.new("BodyAngularVelocity")
        spinBV.AngularVelocity = Vector3.new(0, 10000 * (math.pi/180), 0)
        spinBV.MaxTorque = Vector3.new(0, 1e5, 0)
        spinBV.Parent = rootPart
        spinEnabled = true
    else
        if spinBV then
            spinBV:Destroy()
            spinBV = nil
        end
        spinEnabled = false
    end
end

spinToggle.MouseButton1Click:Connect(function()
    if spinToggle.Text == "OFF" then
        setSpin(true)
        spinToggle.Text = "ON"
        spinToggle.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    else
        setSpin(false)
        spinToggle.Text = "OFF"
        spinToggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    end
end)

local function setUltraSpin(enabled)
    if enabled then
        if ultraSpinBV then
            ultraSpinBV:Destroy()
            ultraSpinBV = nil
        end
        local char = player.Character
        if not char then return end
        local rootPart = char:FindFirstChild("HumanoidRootPart")
        if not rootPart then return end
        ultraSpinBV = Instance.new("BodyAngularVelocity")
        ultraSpinBV.AngularVelocity = Vector3.new(0, 2000 * 360 * (math.pi/180), 0)
        ultraSpinBV.MaxTorque = Vector3.new(0, 1e5, 0)
        ultraSpinBV.Parent = rootPart
        ultraSpinEnabled = true
    else
        if ultraSpinBV then
            ultraSpinBV:Destroy()
            ultraSpinBV = nil
        end
        ultraSpinEnabled = false
    end
end

ultraSpinToggle.MouseButton1Click:Connect(function()
    if ultraSpinToggle.Text == "OFF" then
        setUltraSpin(true)
        ultraSpinToggle.Text = "ON"
        ultraSpinToggle.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    else
        setUltraSpin(false)
        ultraSpinToggle.Text = "OFF"
        ultraSpinToggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    end
end)

local function findPlayerByName(name)
    name = name:gsub("^%s+", ""):gsub("%s+$", "")
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Name:lower() == name:lower() then
            return p
        end
    end
    for _, p in ipairs(Players:GetPlayers()) do
        if p.DisplayName:lower() == name:lower() then
            return p
        end
    end
    return nil
end

flingNickButton.MouseButton1Click:Connect(function()
    local targetPlayer = findPlayerByName(nickBox.Text)
    if not targetPlayer then
        return
    end

    local targetChar = targetPlayer.Character
    if not targetChar then return end
    local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
    if not targetRoot then return end

    local myChar = player.Character
    if not myChar then return end
    local myRoot = myChar:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end

    myRoot.CFrame = targetRoot.CFrame

    if not noclipEnabled then
        noclipEnabled = true
        noclipToggle.Text = "ON"
        noclipToggle.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        setNoclip(true)
    end

    if not spinEnabled then
        setSpin(true)
        spinToggle.Text = "ON"
        spinToggle.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    end
end)

local function startFlingNick(targetPlayer)
    if flingNickConnection then
        flingNickConnection:Disconnect()
        flingNickConnection = nil
    end

    flingNickEnabled = true
    flingNickTarget = targetPlayer

    if not noclipEnabled then
        noclipEnabled = true
        noclipToggle.Text = "ON"
        noclipToggle.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        setNoclip(true)
    end

    if not spinEnabled then
        setSpin(true)
        spinToggle.Text = "ON"
        spinToggle.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    end

    flingNickConnection = RunService.Heartbeat:Connect(function()
        if not flingNickEnabled then return end
        local targetChar = flingNickTarget and flingNickTarget.Character
        if not targetChar then
            flingNickTarget = findPlayerByName(nickBox.Text)
            if not flingNickTarget then return end
            targetChar = flingNickTarget.Character
            if not targetChar then return end
        end
        local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
        if not targetRoot then return end

        local myChar = player.Character
        if not myChar then return end
        local myRoot = myChar:FindFirstChild("HumanoidRootPart")
        if not myRoot then return end

        myRoot.CFrame = targetRoot.CFrame
    end)
end

local function stopFlingNick()
    flingNickEnabled = false
    if flingNickConnection then
        flingNickConnection:Disconnect()
        flingNickConnection = nil
    end
end

toggleFlingNickButton.MouseButton1Click:Connect(function()
    if toggleFlingNickButton.Text == "Toggle Fling Nick" then
        local targetPlayer = findPlayerByName(nickBox.Text)
        if not targetPlayer then
            return
        end
        startFlingNick(targetPlayer)
        toggleFlingNickButton.Text = "Stop Fling Nick"
        toggleFlingNickButton.BackgroundColor3 = Color3.fromRGB(200, 70, 70)
    else
        stopFlingNick()
        toggleFlingNickButton.Text = "Toggle Fling Nick"
        toggleFlingNickButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    end
end)

local fakeLagEnabled = false
local fakeLagThread = nil

local function stopFakeLag()
    if fakeLagThread then
        fakeLagEnabled = false
        fakeLagThread = nil
    end
    local char = player.Character
    if char then
        local rootPart = char:FindFirstChild("HumanoidRootPart")
        if rootPart then
            rootPart.Anchored = false
        end
    end
end

local function startFakeLag(delayMs)
    stopFakeLag()
    fakeLagEnabled = true
    fakeLagThread = task.spawn(function()
        while fakeLagEnabled do
            local char = player.Character
            if char then
                local rootPart = char:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    rootPart.Anchored = true
                    task.wait(delayMs / 1000)
                    rootPart.Anchored = false
                end
            end
            task.wait()
        end
    end)
end

fakeLagToggle.MouseButton1Click:Connect(function()
    if fakeLagToggle.Text == "OFF" then
        local delay = tonumber(fakeLagDelayBox.Text) or 500
        if delay < 1 then delay = 1 end
        startFakeLag(delay)
        fakeLagToggle.Text = "ON"
        fakeLagToggle.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    else
        stopFakeLag()
        fakeLagToggle.Text = "OFF"
        fakeLagToggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    end
end)

fakeLagDelayBox.FocusLost:Connect(function()
    if fakeLagEnabled then
        local delay = tonumber(fakeLagDelayBox.Text) or 500
        if delay < 1 then delay = 1 end
        startFakeLag(delay)
    end
end)

local delayWalkEnabled = false
local delayWalkThread = nil
local fakeLagWasEnabled = false

local function stopDelayWalk()
    if delayWalkThread then
        delayWalkEnabled = false
        delayWalkThread = nil
    end
    local char = player.Character
    if char then
        local humanoid = char:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = targetWalkSpeed
        end
    end
    if fakeLagWasEnabled then
        if not fakeLagEnabled then
            local delay = tonumber(fakeLagDelayBox.Text) or 500
            if delay < 1 then delay = 1 end
            startFakeLag(delay)
            fakeLagToggle.Text = "ON"
            fakeLagToggle.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        end
    else
        if fakeLagEnabled then
            stopFakeLag()
            fakeLagToggle.Text = "OFF"
            fakeLagToggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        end
    end
end

local function startDelayWalk(delayMs)
    stopDelayWalk()
    fakeLagWasEnabled = fakeLagEnabled
    if fakeLagWasEnabled then
        stopFakeLag()
        fakeLagToggle.Text = "OFF"
        fakeLagToggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    end

    delayWalkEnabled = true
    delayWalkThread = task.spawn(function()
        while delayWalkEnabled do
            local char = player.Character
            if char then
                local humanoid = char:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = 0
                    task.wait(delayMs / 1000)
                    if fakeLagWasEnabled and not fakeLagEnabled then
                        local fDelay = tonumber(fakeLagDelayBox.Text) or 500
                        if fDelay < 1 then fDelay = 1 end
                        startFakeLag(fDelay)
                    end
                    humanoid.WalkSpeed = targetWalkSpeed
                    task.wait(0.05)
                    if fakeLagWasEnabled and fakeLagEnabled then
                        stopFakeLag()
                    end
                else
                    task.wait(0.1)
                end
            else
                task.wait(0.1)
            end
        end
    end)
end

delayWalkToggle.MouseButton1Click:Connect(function()
    if delayWalkToggle.Text == "OFF" then
        local delay = tonumber(delayWalkDelayBox.Text) or 500
        if delay < 1 then delay = 1 end
        startDelayWalk(delay)
        delayWalkToggle.Text = "ON"
        delayWalkToggle.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    else
        stopDelayWalk()
        delayWalkToggle.Text = "OFF"
        delayWalkToggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    end
end)

delayWalkDelayBox.FocusLost:Connect(function()
    if delayWalkEnabled then
        local delay = tonumber(delayWalkDelayBox.Text) or 500
        if delay < 1 then delay = 1 end
        startDelayWalk(delay)
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.V then
        toggleHub()
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.X then
        toggleFly()
    end
end)

player.CharacterAdded:Connect(function(newChar)
    newChar:WaitForChild("Humanoid")
    applySettings()
    if noclipEnabled then
        setNoclip(true)
    end
    if spinEnabled then
        setSpin(true)
    end
    if ultraSpinEnabled then
        setUltraSpin(true)
    end
    if flingNickEnabled then
        stopFlingNick()
        task.wait(0.5)
        if flingNickTarget then
            startFlingNick(flingNickTarget)
        end
    end
end)

applySettings()

mainTabButton.MouseButton1Click:Connect(function()
    mainScrollingFrame.Visible = true
    funContent.Visible = false
    mainTabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    funTabButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
end)

funTabButton.MouseButton1Click:Connect(function()
    mainScrollingFrame.Visible = false
    funContent.Visible = true
    mainTabButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    funTabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)

local function checkForRAC()
    local racLocations = {
        workspace:FindFirstChild("RAC"),
        game:GetService("ReplicatedStorage"):FindFirstChild("RAC"),
        game:GetService("ServerStorage"):FindFirstChild("RAC"),
        game:GetService("ServerScriptService"):FindFirstChild("RAC"),
        game:GetService("Lighting"):FindFirstChild("RAC")
    }
    for _, loc in ipairs(racLocations) do
        if loc then
            local notificationGui = Instance.new("ScreenGui")
            notificationGui.Name = "RACWarning"
            notificationGui.ResetOnSpawn = false
            notificationGui.Parent = player.PlayerGui

            local notificationFrame = Instance.new("Frame")
            notificationFrame.Size = UDim2.new(0, 300, 0, 80)
            notificationFrame.Position = UDim2.new(1, -320, 0, 20)
            notificationFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            notificationFrame.BorderSizePixel = 0
            notificationFrame.ClipsDescendants = true
            notificationFrame.Parent = notificationGui

            local notificationCorner = Instance.new("UICorner")
            notificationCorner.CornerRadius = UDim.new(0, 8)
            notificationCorner.Parent = notificationFrame

            local icon = Instance.new("ImageLabel")
            icon.Size = UDim2.new(0, 50, 0, 50)
            icon.Position = UDim2.new(0, 10, 0.5, -25)
            icon.BackgroundTransparency = 1
            icon.Image = "rbxasset://textures/ui/achievement/award.png"
            icon.Parent = notificationFrame

            local textLabel = Instance.new("TextLabel")
            textLabel.Size = UDim2.new(1, -70, 1, 0)
            textLabel.Position = UDim2.new(0, 70, 0, 0)
            textLabel.BackgroundTransparency = 1
            textLabel.Text = "Be careful here RAC anticheat"
            textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            textLabel.Font = Enum.Font.GothamBold
            textLabel.TextSize = 14
            textLabel.TextWrapped = true
            textLabel.TextXAlignment = Enum.TextXAlignment.Left
            textLabel.Parent = notificationFrame

            local closeButton = Instance.new("TextButton")
            closeButton.Size = UDim2.new(0, 20, 0, 20)
            closeButton.Position = UDim2.new(1, -25, 0, 5)
            closeButton.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
            closeButton.Text = "X"
            closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            closeButton.Font = Enum.Font.GothamBold
            closeButton.TextSize = 12
            closeButton.Parent = notificationFrame

            local closeCorner = Instance.new("UICorner")
            closeCorner.CornerRadius = UDim.new(0, 4)
            closeCorner.Parent = closeButton

            closeButton.MouseButton1Click:Connect(function()
                notificationGui:Destroy()
            end)

            local slideIn = TweenService:Create(notificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(1, -320, 0, 20)})
            slideIn:Play()

            task.wait(5)
            local slideOut = TweenService:Create(notificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(1, 20, 0, 20)})
            slideOut:Play()
            slideOut.Completed:Connect(function()
                notificationGui:Destroy()
            end)
            break
        end
    end
end

checkForRAC()