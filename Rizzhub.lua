--[[
    Modern UI Hub - Beautiful UI Template
    Clean, professional interface with smooth animations
]]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Color Theme
local COLORS = {
    Primary = Color3.fromRGB(120, 80, 255),      -- Purple accent
    Secondary = Color3.fromRGB(255, 100, 150),   -- Pink accent
    Background = Color3.fromRGB(25, 25, 35),     -- Dark background
    Frame = Color3.fromRGB(35, 35, 50),          -- Slightly lighter
    White = Color3.fromRGB(255, 255, 255),
    Gray = Color3.fromRGB(80, 80, 100),
    DarkGray = Color3.fromRGB(50, 50, 65),
    Success = Color3.fromRGB(80, 220, 120),      -- Green
    Warning = Color3.fromRGB(255, 180, 50),      -- Orange
}

-- Settings storage
local Settings = {
    MusicEnabled = false,
    Notifications = true,
    DarkMode = true,
    AutoSave = false,
    Volume = 75,
    Brightness = 50,
    UIScale = 100,
}

-- Utility Functions
local function tween(obj, props, duration, style, direction)
    if not obj or not obj.Parent then return end
    pcall(function()
        TweenService:Create(obj, TweenInfo.new(
            duration or 0.3,
            style or Enum.EasingStyle.Quad,
            direction or Enum.EasingDirection.Out
        ), props):Play()
    end)
end

local function createCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = parent
    return corner
end

local function createStroke(parent, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or COLORS.Primary
    stroke.Thickness = thickness or 1
    stroke.Parent = parent
    return stroke
end

local function createGradient(parent, color1, color2, rotation)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, color1),
        ColorSequenceKeypoint.new(1, color2)
    })
    gradient.Rotation = rotation or 90
    gradient.Parent = parent
    return gradient
end

local function createPadding(parent, left, top, right, bottom)
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, left or 10)
    padding.PaddingTop = UDim.new(0, top or 10)
    padding.PaddingRight = UDim.new(0, right or 10)
    padding.PaddingBottom = UDim.new(0, bottom or 10)
    padding.Parent = parent
    return padding
end

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ModernUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = game.CoreGui

-- Floating Toggle Button
local toggleButton = Instance.new("Frame")
toggleButton.Name = "ToggleIcon"
toggleButton.Size = UDim2.new(0, 60, 0, 60)
toggleButton.Position = UDim2.new(0, 25, 0.5, -30)
toggleButton.BackgroundColor3 = COLORS.Frame
toggleButton.BorderSizePixel = 0
toggleButton.Parent = screenGui
createCorner(toggleButton, 16)
createStroke(toggleButton, COLORS.Primary, 2)

local toggleGradient = createGradient(toggleButton, COLORS.Primary, COLORS.Secondary, 45)

local toggleIcon = Instance.new("ImageLabel")
toggleIcon.Size = UDim2.new(0, 28, 0, 28)
toggleIcon.Position = UDim2.new(0.5, -14, 0.5, -14)
toggleIcon.BackgroundTransparency = 1
toggleIcon.Image = "rbxassetid://6034255768" -- Settings/gear icon
toggleIcon.ImageColor3 = COLORS.White
toggleIcon.Parent = toggleButton

local toggleClick = Instance.new("TextButton")
toggleClick.Size = UDim2.new(1, 0, 1, 0)
toggleClick.BackgroundTransparency = 1
toggleClick.Text = ""
toggleClick.Parent = toggleButton

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 320, 0, 420)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -210)
mainFrame.BackgroundColor3 = COLORS.Background
mainFrame.BorderSizePixel = 0
mainFrame.Visible = false
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui
createCorner(mainFrame, 16)
createStroke(mainFrame, COLORS.Primary, 2)

local mainShadow = Instance.new("ImageLabel")
mainShadow.Name = "Shadow"
mainShadow.AnchorPoint = Vector2.new(0.5, 0.5)
mainShadow.BackgroundTransparency = 1
mainShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
mainShadow.Size = UDim2.new(1, 30, 1, 30)
mainShadow.ZIndex = -1
mainShadow.Image = "rbxassetid://6014261993"
mainShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
mainShadow.ImageTransparency = 0.6
mainShadow.ScaleType = Enum.ScaleType.Slice
mainShadow.SliceCenter = Rect.new(49, 49, 450, 450)
mainShadow.Parent = mainFrame

-- Top Bar
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 55)
topBar.BackgroundColor3 = COLORS.Frame
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame
createCorner(topBar, 16)

local topGradient = createGradient(topBar, COLORS.Primary, COLORS.Secondary, 90)

-- Cover bottom corners of topbar
local topBarCover = Instance.new("Frame")
topBarCover.Size = UDim2.new(1, 0, 0, 20)
topBarCover.Position = UDim2.new(0, 0, 1, -20)
topBarCover.BackgroundColor3 = COLORS.Frame
topBarCover.BorderSizePixel = 0
topBarCover.Parent = topBar

-- Logo
local logoFrame = Instance.new("Frame")
logoFrame.Size = UDim2.new(0, 36, 0, 36)
logoFrame.Position = UDim2.new(0, 12, 0.5, -18)
logoFrame.BackgroundColor3 = COLORS.Background
logoFrame.BorderSizePixel = 0
logoFrame.Parent = topBar
createCorner(logoFrame, 10)

local logoIcon = Instance.new("ImageLabel")
logoIcon.Size = UDim2.new(0, 20, 0, 20)
logoIcon.Position = UDim2.new(0.5, -10, 0.5, -10)
logoIcon.BackgroundTransparency = 1
logoIcon.Image = "rbxassetid://6034255768"
logoIcon.ImageColor3 = COLORS.Primary
logoIcon.Parent = logoFrame

-- Title
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(0, 180, 0, 24)
titleLabel.Position = UDim2.new(0, 56, 0, 8)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Modern UI Hub"
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 16
titleLabel.TextColor3 = COLORS.White
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = topBar

local subtitleLabel = Instance.new("TextLabel")
subtitleLabel.Size = UDim2.new(0, 180, 0, 18)
subtitleLabel.Position = UDim2.new(0, 56, 0, 30)
subtitleLabel.BackgroundTransparency = 1
subtitleLabel.Text = "Settings Panel v1.0"
subtitleLabel.Font = Enum.Font.Gotham
subtitleLabel.TextSize = 11
subtitleLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
subtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
subtitleLabel.Parent = topBar

-- Close Button
local closeBtn = Instance.new("TextButton")
closeBtn.Name = "CloseBtn"
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -38, 0.5, -14)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
closeBtn.BorderSizePixel = 0
closeBtn.Text = ""
closeBtn.Parent = topBar
createCorner(closeBtn, 8)

local closeIcon = Instance.new("ImageLabel")
closeIcon.Size = UDim2.new(0, 14, 0, 14)
closeIcon.Position = UDim2.new(0.5, -7, 0.5, -7)
closeIcon.BackgroundTransparency = 1
closeIcon.Image = "rbxassetid://6034255768" -- X icon substitute
closeIcon.ImageColor3 = COLORS.White
closeIcon.Parent = closeBtn

-- Content Area
local contentArea = Instance.new("ScrollingFrame")
contentArea.Name = "Content"
contentArea.Size = UDim2.new(1, -24, 1, -70)
contentArea.Position = UDim2.new(0, 12, 0, 62)
contentArea.BackgroundTransparency = 1
contentArea.BorderSizePixel = 0
contentArea.ScrollBarThickness = 4
contentArea.ScrollBarImageColor3 = COLORS.Primary
contentArea.CanvasSize = UDim2.new(0, 0, 0, 600)
contentArea.Parent = mainFrame

local contentLayout = Instance.new("UIListLayout")
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Padding = UDim.new(0, 10)
contentLayout.Parent = contentArea

-- Section Header Function
local function createSectionHeader(parent, text, order)
    local header = Instance.new("TextLabel")
    header.Size = UDim2.new(1, 0, 0, 24)
    header.BackgroundTransparency = 1
    header.Text = text
    header.Font = Enum.Font.GothamBold
    header.TextSize = 12
    header.TextColor3 = COLORS.Primary
    header.TextXAlignment = Enum.TextXAlignment.Left
    header.LayoutOrder = order
    header.Parent = parent
    return header
end

-- Toggle Component
local function createToggle(parent, text, settingKey, order, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 44)
    container.BackgroundColor3 = COLORS.Frame
    container.BorderSizePixel = 0
    container.LayoutOrder = order
    container.Parent = parent
    createCorner(container, 10)
    createStroke(container, COLORS.DarkGray, 1)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -70, 1, 0)
    label.Position = UDim2.new(0, 14, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 13
    label.TextColor3 = COLORS.White
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    -- Toggle switch background
    local switchBg = Instance.new("Frame")
    switchBg.Size = UDim2.new(0, 48, 0, 26)
    switchBg.Position = UDim2.new(1, -58, 0.5, -13)
    switchBg.BackgroundColor3 = Settings[settingKey] and COLORS.Primary or COLORS.DarkGray
    switchBg.BorderSizePixel = 0
    switchBg.Parent = container
    createCorner(switchBg, 13)

    -- Toggle indicator
    local indicator = Instance.new("Frame")
    indicator.Size = UDim2.new(0, 20, 0, 20)
    indicator.Position = UDim2.new(Settings[settingKey] and 1 or 0, Settings[settingKey] and -22 or 3, 0.5, -10)
    indicator.BackgroundColor3 = COLORS.White
    indicator.BorderSizePixel = 0
    indicator.Parent = switchBg
    createCorner(indicator, 10)

    -- Click detector
    local clickBtn = Instance.new("TextButton")
    clickBtn.Size = UDim2.new(1, 0, 1, 0)
    clickBtn.BackgroundTransparency = 1
    clickBtn.Text = ""
    clickBtn.Parent = container

    clickBtn.MouseButton1Click:Connect(function()
        Settings[settingKey] = not Settings[settingKey]
        local isOn = Settings[settingKey]

        tween(indicator, {
            Position = UDim2.new(isOn and 1 or 0, isOn and -22 or 3, 0.5, -10)
        }, 0.2, Enum.EasingStyle.Quad)

        tween(switchBg, {
            BackgroundColor3 = isOn and COLORS.Primary or COLORS.DarkGray
        }, 0.2)

        if callback then
            task.spawn(function() pcall(callback, isOn) end)
        end
    end)

    return container
end

-- Slider Component
local function createSlider(parent, text, settingKey, min, max, order, callback)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 60)
    container.BackgroundColor3 = COLORS.Frame
    container.BorderSizePixel = 0
    container.LayoutOrder = order
    container.Parent = parent
    createCorner(container, 10)
    createStroke(container, COLORS.DarkGray, 1)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -60, 0, 20)
    label.Position = UDim2.new(0, 14, 0, 8)
    label.BackgroundTransparency = 1
    label.Text = text
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 13
    label.TextColor3 = COLORS.White
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = container

    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0, 50, 0, 20)
    valueLabel.Position = UDim2.new(1, -60, 0, 8)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(Settings[settingKey])
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextSize = 13
    valueLabel.TextColor3 = COLORS.Primary
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.Parent = container

    -- Slider track
    local sliderTrack = Instance.new("Frame")
    sliderTrack.Size = UDim2.new(1, -28, 0, 8)
    sliderTrack.Position = UDim2.new(0, 14, 0, 38)
    sliderTrack.BackgroundColor3 = COLORS.DarkGray
    sliderTrack.BorderSizePixel = 0
    sliderTrack.Parent = container
    createCorner(sliderTrack, 4)

    -- Slider fill
    local percentage = (Settings[settingKey] - min) / (max - min)
    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
    sliderFill.BackgroundColor3 = COLORS.Primary
    sliderFill.BorderSizePixel = 0
    sliderFill.Parent = sliderTrack
    createCorner(sliderFill, 4)

    local fillGradient = createGradient(sliderFill, COLORS.Primary, COLORS.Secondary, 0)

    -- Slider knob
    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = UDim2.new(percentage, -8, 0.5, -8)
    knob.BackgroundColor3 = COLORS.White
    knob.BorderSizePixel = 0
    knob.Parent = sliderTrack
    createCorner(knob, 8)
    createStroke(knob, COLORS.Primary, 2)

    -- Dragging logic
    local dragging = false

    local function updateSlider(input)
        local relPos = math.clamp(
            (input.Position.X - sliderTrack.AbsolutePosition.X) / sliderTrack.AbsoluteSize.X,
            0, 1
        )
        local value = math.floor(min + (max - min) * relPos)
        Settings[settingKey] = value

        valueLabel.Text = tostring(value)
        sliderFill.Size = UDim2.new(relPos, 0, 1, 0)
        knob.Position = UDim2.new(relPos, -8, 0.5, -8)

        if callback then
            task.spawn(function() pcall(callback, value) end)
        end
    end

    local dragBtn = Instance.new("TextButton")
    dragBtn.Size = UDim2.new(1, 0, 1, 0)
    dragBtn.BackgroundTransparency = 1
    dragBtn.Text = ""
    dragBtn.Parent = sliderTrack

    dragBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateSlider(input)
        end
    end)

    dragBtn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch) then
            updateSlider(input)
        end
    end)

    return container
end

-- Button Component
local function createButton(parent, text, order, callback)
    local container = Instance.new("TextButton")
    container.Size = UDim2.new(1, 0, 0, 44)
    container.BackgroundColor3 = COLORS.Frame
    container.BorderSizePixel = 0
    container.Text = ""
    container.LayoutOrder = order
    container.Parent = parent
    createCorner(container, 10)
    createStroke(container, COLORS.Primary, 1)

    local btnGradient = createGradient(container, COLORS.Primary, COLORS.Secondary, 90)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.Font = Enum.Font.GothamBold
    label.TextSize = 13
    label.TextColor3 = COLORS.White
    label.Parent = container

    container.MouseButton1Click:Connect(function()
        tween(container, {BackgroundColor3 = COLORS.Secondary}, 0.1)
        task.wait(0.1)
        tween(container, {BackgroundColor3 = COLORS.Frame}, 0.1)
        if callback then pcall(callback) end
    end)

    return container
end

-- Build Content
createSectionHeader(contentArea, "⚙️ GENERAL", 1)
createToggle(contentArea, "🔊 Music Enabled", "MusicEnabled", 2)
createToggle(contentArea, "🔔 Notifications", "Notifications", 3)
createToggle(contentArea, "🌙 Dark Mode", "DarkMode", 4)
createToggle(contentArea, "💾 Auto Save", "AutoSave", 5)

createSectionHeader(contentArea, "🎚️ AUDIO", 21)
createSlider(contentArea, "Volume", "Volume", 0, 100, 22)
createSlider(contentArea, "Brightness", "Brightness", 0, 100, 23)

createSectionHeader(contentArea, "🖼️ DISPLAY", 41)
createSlider(contentArea, "UI Scale", "UIScale", 50, 150, 42)

createSectionHeader(contentArea, "📋 ACTIONS", 61)
createButton(contentArea, "🔄 Reset Settings", 62, function()
    Settings.Volume = 75
    Settings.Brightness = 50
    Settings.UIScale = 100
    print("Settings reset!")
end)

createButton(contentArea, "💾 Save Changes", 63, function()
    print("Settings saved!")
end)

-- Draggable Logic
local dragging = false
local dragInput
local dragStart
local startPos

local function updateDrag(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
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
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateDrag(input)
    end
end)

-- Toggle Button Animation
local menuOpen = false

local function openMenu()
    menuOpen = true
    mainFrame.Size = UDim2.new(0, 0, 0, 0)
    mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    mainFrame.Visible = true

    tween(mainFrame, {
        Size = UDim2.new(0, 320, 0, 420),
        Position = UDim2.new(0.5, -160, 0.5, -210)
    }, 0.4, Enum.EasingStyle.Back)

    tween(toggleButton, {Rotation = 180}, 0.4)
end

local function closeMenu()
    menuOpen = false

    tween(mainFrame, {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }, 0.3, Enum.EasingStyle.Back)

    tween(toggleButton, {Rotation = 0}, 0.3)

    task.wait(0.3)
    mainFrame.Visible = false
end

toggleClick.MouseButton1Click:Connect(function()
    if menuOpen then
        closeMenu()
    else
        openMenu()
    end
end)

closeBtn.MouseButton1Click:Connect(function()
    closeMenu()
end)

-- Hover effects
toggleClick.MouseEnter:Connect(function()
    tween(toggleButton, {Size = UDim2.new(0, 66, 0, 66), Position = UDim2.new(0, 22, 0.5, -33)}, 0.2)
end)

toggleClick.MouseLeave:Connect(function()
    tween(toggleButton, {Size = UDim2.new(0, 60, 0, 60), Position = UDim2.new(0, 25, 0.5, -30)}, 0.2)
end)

closeBtn.MouseEnter:Connect(function()
    tween(closeBtn, {Size = UDim2.new(0, 32, 0, 32), Position = UDim2.new(1, -40, 0.5, -16)}, 0.15)
end)

closeBtn.MouseLeave:Connect(function()
    tween(closeBtn, {Size = UDim2.new(0, 28, 0, 28), Position = UDim2.new(1, -38, 0.5, -14)}, 0.15)
end)

print("✨ Modern UI Hub Loaded!")
