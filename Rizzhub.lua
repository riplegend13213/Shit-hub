-- Test - Test Hub
-- Generated with PELI EDITOR v3

local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local VirtualUser = game:GetService("VirtualUser")
player.Idled:Connect(function() VirtualUser:CaptureController() VirtualUser:ClickButton2(Vector2.new()) end)

local CONFIG = {
    KingMode = false,
    WalkSpeed = 50,
    JumpPower = 150,
    SpeedBoost = false,
    SuperJump = false,
}

local playerESPCache = {}
local currentTab = "MAIN"
local connections = {}

local COLORS = {
    Primary = Color3.fromRGB(255, 70, 70),
    Secondary = Color3.fromRGB(200, 200, 200),
    Accent = Color3.fromRGB(180, 70, 255),
    Background = Color3.fromRGB(140, 140, 140),
    DarkBG = Color3.fromRGB(25, 25, 25),
    Frame = Color3.fromRGB(35, 35, 35),
    White = Color3.fromRGB(255, 255, 255),
    Gray = Color3.fromRGB(60, 60, 60),
    Green = Color3.fromRGB(50, 205, 50),
    Red = Color3.fromRGB(255, 50, 50)
}

local function tween(obj, props, duration, style, direction)
    if not obj or not obj.Parent then return end
    pcall(function() TweenService:Create(obj, TweenInfo.new(duration or 0.3, style or Enum.EasingStyle.Quad, direction or Enum.EasingDirection.Out), props):Play() end)
end

local function notifyImportant(text)
    pcall(function() game.StarterGui:SetCore("SendNotification", {Title = "Test", Text = text, Duration = 3}) end)
end

local function createCorner(parent, radius)
    local corner = Instance.new("UICorner", parent)
    corner.CornerRadius = UDim.new(0, radius or 10)
    return corner
end

local function createStroke(parent, color, thickness)
    local stroke = Instance.new("UIStroke", parent)
    stroke.Color = color or COLORS.Primary
    stroke.Thickness = thickness or 2
    return stroke
end

local function createGradient(parent, colors, rotation)
    local gradient = Instance.new("UIGradient", parent)
    gradient.Color = colors
    gradient.Rotation = rotation or 0
    return gradient
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "Test"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = game.CoreGui

local iconBtn = Instance.new("TextButton")
iconBtn.Name = "Icon"
iconBtn.Size = UDim2.new(0, 70, 0, 70)
iconBtn.Position = UDim2.new(0, 20, 0, 20)
iconBtn.BackgroundColor3 = COLORS.Background
iconBtn.BorderSizePixel = 0
iconBtn.Text = "T"
iconBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
iconBtn.Font = Enum.Font.GothamBlack
iconBtn.TextSize = 32
iconBtn.Active = true
iconBtn.Draggable = true
iconBtn.Parent = screenGui
createCorner(iconBtn, 14)
createStroke(iconBtn, COLORS.Primary, 3)

local topIcon = Instance.new("TextLabel")
topIcon.Size = UDim2.new(0, 35, 0, 35)
topIcon.Position = UDim2.new(0, 8, 0.5, -17.5)
topIcon.BackgroundColor3 = COLORS.Background
topIcon.Text = "T"
topIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
topIcon.Font = Enum.Font.GothamBlack
topIcon.TextSize = 18
topIcon.BorderSizePixel = 0
topIcon.Parent = topBar
createCorner(topIcon, 8)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "Main"
mainFrame.Size = UDim2.new(0, 260, 0, 240)
mainFrame.Position = UDim2.new(0.5, -130, 0.5, -120)
mainFrame.BackgroundColor3 = COLORS.Background
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Visible = false
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui
createCorner(mainFrame, 15)
createStroke(mainFrame, COLORS.Primary, 3)

local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 50)
topBar.BackgroundColor3 = COLORS.Primary
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame
createCorner(topBar, 15)
createGradient(topBar, ColorSequence.new{ColorSequenceKeypoint.new(0, COLORS.Accent), ColorSequenceKeypoint.new(1, COLORS.Secondary)}, 90)

local topCover = Instance.new("Frame")
topCover.Size = UDim2.new(1, 0, 0, 15)
topCover.Position = UDim2.new(0, 0, 1, -15)
topCover.BackgroundColor3 = COLORS.Primary
topCover.BorderSizePixel = 0
topCover.Parent = topBar
createGradient(topCover, ColorSequence.new{ColorSequenceKeypoint.new(0, COLORS.Accent), ColorSequenceKeypoint.new(1, COLORS.Secondary)}, 90)

topIcon.Parent = topBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 150, 0, 20)
titleLabel.Position = UDim2.new(0, 50, 0, 8)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Test"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 16
titleLabel.TextColor3 = COLORS.White
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = topBar

local subtitleLabel = Instance.new("TextLabel")
subtitleLabel.Size = UDim2.new(0, 150, 0, 16)
subtitleLabel.Position = UDim2.new(0, 50, 0, 28)
subtitleLabel.BackgroundTransparency = 1
subtitleLabel.Text = "Test Hub"
subtitleLabel.Font = Enum.Font.Gotham
subtitleLabel.TextSize = 9
subtitleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
subtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
subtitleLabel.Parent = topBar

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 25, 0, 25)
minimizeBtn.Position = UDim2.new(1, -60, 0.5, -12.5)
minimizeBtn.Text = "â€”"
minimizeBtn.BackgroundColor3 = COLORS.Background
minimizeBtn.TextColor3 = COLORS.White
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 16
minimizeBtn.BorderSizePixel = 0
minimizeBtn.Parent = topBar
createCorner(minimizeBtn, 6)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -30, 0.5, -12.5)
closeBtn.Text = "Ã—"
closeBtn.BackgroundColor3 = COLORS.Background
closeBtn.TextColor3 = COLORS.White
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
closeBtn.BorderSizePixel = 0
closeBtn.Parent = topBar
createCorner(closeBtn, 6)

local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1, -16, 0, 30)
tabContainer.Position = UDim2.new(0, 8, 0, 58)
tabContainer.BackgroundTransparency = 1
tabContainer.Parent = mainFrame

local tabButtons = {}
local tabs = {"MAIN"}
local tabWidth = (260 - 24) / #tabs

for i, tabName in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Name = tabName
    btn.Size = UDim2.new(0, tabWidth - 4, 0, 30)
    btn.Position = UDim2.new(0, (i - 1) * tabWidth + 2, 0, 0)
    btn.Text = tabName
    btn.BackgroundColor3 = (i == 1) and COLORS.Primary or COLORS.DarkBG
    btn.TextColor3 = COLORS.White
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.BorderSizePixel = 0
    btn.Parent = tabContainer
    createCorner(btn, 8)
    tabButtons[tabName] = btn
end

local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -16, 1, -100)
contentFrame.Position = UDim2.new(0, 8, 0, 92)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

local contentContainers = {}
for i, tabName in ipairs(tabs) do
    local container = Instance.new("ScrollingFrame")
    container.Name = tabName
    container.Size = UDim2.new(1, 0, 1, 0)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.ScrollBarThickness = 4
    container.ScrollBarImageColor3 = COLORS.Primary
    container.Visible = (i == 1)
    container.CanvasSize = UDim2.new(0, 0, 0, 500)
    container.Parent = contentFrame
    contentContainers[tabName] = container
end

local function createToggle(parent, text, key, posY, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -8, 0, 28)
    container.Position = UDim2.new(0, 4, 0, posY)
    container.BackgroundColor3 = COLORS.Frame
    container.BorderSizePixel = 0
    container.Parent = parent
    createCorner(container, 8)
    createStroke(container, COLORS.Primary, 1)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -50, 1, 0)
    label.Position = UDim2.new(0, 8, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 10
    label.TextColor3 = COLORS.White
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container
    local toggleBtn = Instance.new("Frame")
    toggleBtn.Size = UDim2.new(0, 40, 0, 20)
    toggleBtn.Position = UDim2.new(1, -44, 0.5, -10)
    toggleBtn.BackgroundColor3 = COLORS.Gray
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Parent = container
    createCorner(toggleBtn, 10)
    local indicator = Instance.new("Frame")
    indicator.Size = UDim2.new(0, 16, 0, 16)
    indicator.Position = UDim2.new(0, 2, 0.5, -8)
    indicator.BackgroundColor3 = COLORS.White
    indicator.BorderSizePixel = 0
    indicator.Parent = toggleBtn
    createCorner(indicator, 8)
    local clickBtn = Instance.new("TextButton")
    clickBtn.Size = UDim2.new(1, 0, 1, 0)
    clickBtn.BackgroundTransparency = 1
    clickBtn.Text = ""
    clickBtn.Parent = container
    clickBtn.MouseButton1Click:Connect(function()
        CONFIG[key] = not CONFIG[key]
        if CONFIG[key] then
            tween(indicator, {Position = UDim2.new(1, -18, 0.5, -8), BackgroundColor3 = COLORS.Primary}, 0.2)
            tween(toggleBtn, {BackgroundColor3 = COLORS.Primary}, 0.2)
        else
            tween(indicator, {Position = UDim2.new(0, 2, 0.5, -8), BackgroundColor3 = COLORS.White}, 0.2)
            tween(toggleBtn, {BackgroundColor3 = COLORS.Gray}, 0.2)
        end
        if callback then task.spawn(function() pcall(callback, CONFIG[key]) end) end
    end)
    return container
end

local function createSlider(parent, text, key, min, max, posY, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -8, 0, 50)
    container.Position = UDim2.new(0, 4, 0, posY)
    container.BackgroundColor3 = COLORS.Frame
    container.BorderSizePixel = 0
    container.Parent = parent
    createCorner(container, 8)
    createStroke(container, COLORS.Primary, 1)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -12, 0, 20)
    label.Position = UDim2.new(0, 8, 0, 4)
    label.BackgroundTransparency = 1
    label.Text = text .. ": " .. CONFIG[key]
    label.Font = Enum.Font.GothamBold
    label.TextSize = 10
    label.TextColor3 = COLORS.White
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container
    local sliderBg = Instance.new("Frame")
    sliderBg.Size = UDim2.new(1, -16, 0, 10)
    sliderBg.Position = UDim2.new(0, 8, 0, 32)
    sliderBg.BackgroundColor3 = COLORS.Gray
    sliderBg.BorderSizePixel = 0
    sliderBg.Parent = container
    createCorner(sliderBg, 5)
    local sliderFill = Instance.new("Frame")
    local percentage = (CONFIG[key] - min) / (max - min)
    sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
    sliderFill.BackgroundColor3 = COLORS.Primary
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderBg
    createCorner(sliderFill, 5)
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = UDim2.new(percentage, -8, 0.5, -8)
    knob.BackgroundColor3 = COLORS.White
    knob.BorderSizePixel = 0
    knob.Parent = sliderBg
    createCorner(knob, 8)
    createStroke(knob, COLORS.Primary, 2)
    local dragging = false
    local function update(input)
        pcall(function()
            local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
            local value = math.floor(min + (max - min) * pos)
            CONFIG[key] = value
            label.Text = text .. ": " .. value
            sliderFill.Size = UDim2.new(pos, 0, 1, 0)
            knob.Position = UDim2.new(pos, -8, 0.5, -8)
            if callback then task.spawn(function() pcall(callback, value) end) end
        end)
    end
    sliderBg.InputBegan:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = true update(input) end end)
    sliderBg.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end end)
    UserInputService.InputChanged:Connect(function(input) if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then update(input) end end)
    return container
end

local mainContent = contentContainers["MAIN"]
createToggle(mainContent, "Speed Boost", "SpeedBoost", 6)
createToggle(mainContent, "Super Jump", "SuperJump", 40)
createSlider(mainContent, "Walk Speed", "WalkSpeed", 16, 200, 74)
createSlider(mainContent, "Jump Power", "JumpPower", 50, 300, 130)

for tabName, btn in pairs(tabButtons) do
    btn.MouseButton1Click:Connect(function()
        currentTab = tabName
        for name, button in pairs(tabButtons) do button.BackgroundColor3 = (name == tabName) and COLORS.Primary or COLORS.DarkBG end
        for name, container in pairs(contentContainers) do container.Visible = (name == tabName) end
    end)
end

local menuOpen = false
iconBtn.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    if menuOpen then
        mainFrame.Size = UDim2.new(0, 0, 0, 0)
        mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        mainFrame.Visible = true
        tween(mainFrame, {Size = UDim2.new(0, 260, 0, 240), Position = UDim2.new(0.5, -130, 0.5, -120)}, 0.4, Enum.EasingStyle.Back)
        notifyImportant("Menu Opened!")
    else
        tween(mainFrame, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}, 0.3)
        task.wait(0.3)
        mainFrame.Visible = false
    end
end)

minimizeBtn.MouseButton1Click:Connect(function()
    menuOpen = false
    tween(mainFrame, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}, 0.3)
    task.wait(0.3)
    mainFrame.Visible = false
end)

closeBtn.MouseButton1Click:Connect(function()
    notifyImportant("Closed!")
    tween(mainFrame, {Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(0.5, 0, 0.5, 0)}, 0.3)
        tween(iconBtn, {Size = UDim2.new(0, 0, 0, 0)}, 0.3)
    task.wait(0.4)
    for _, conn in pairs(connections) do if conn then pcall(function() conn:Disconnect() end) end end
    pcall(function() screenGui:Destroy() end)
end)

connections.main = RunService.Heartbeat:Connect(function()
    pcall(function()
        local char = player.Character
        if not char then return end
        local hum = char:FindFirstChildWhichIsA("Humanoid")
        if not hum then return end        if CONFIG.KingMode then hum.Health = hum.MaxHealth hum.MaxHealth = 999999 end        if CONFIG.SpeedBoost then hum.WalkSpeed = CONFIG.WalkSpeed end    end)
end)
connections.superJump = UserInputService.JumpRequest:Connect(function()
    if not CONFIG.SuperJump then return end
    pcall(function()
        local char = player.Character
        if char then
            local hum = char:FindFirstChildWhichIsA("Humanoid")
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hum and hrp then
                hum:ChangeState(Enum.HumanoidStateType.Jumping)
                task.wait(0.05)
                hrp.Velocity = Vector3.new(hrp.Velocity.X, CONFIG.JumpPower, hrp.Velocity.Z)
            end
        end
    end)
end)
print("Test Loaded!")
notifyImportant("Loaded!")
