-- SKN_Hub - v0.0.1

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local gui = player:WaitForChild("PlayerGui")

local currentTransparency = 0.4
local currentFontScale    = 1.0
local currentMainColor    = Color3.fromRGB(255, 255, 255)

--卡密加密

local function verifyKey(input)
    input = input:lower():gsub("%s+", "")
    
    local p1 = string.char(115) .. string.char(107) .. string.char(110)
    local p2 = string.char(49) .. string.char(49) .. string.char(52) .. string.char(53) .. string.char(49) .. string.char(52)
    local validKey = p1 .. p2
    
    local sbKey = string.char(115) .. string.char(98)
    local numKey = string.char(49) .. string.char(49) .. string.char(52) .. string.char(53) .. string.char(49) .. string.char(52)
    
    if input == validKey then return "valid" end
    if input == sbKey then return "sb" end
    if input == numKey then return "114514" end
    return "invalid"
end

--卡密输入界面

local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "KeyInputGui"
KeyGui.ResetOnSpawn = false
KeyGui.IgnoreGuiInset = true
KeyGui.Parent = gui

local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 320, 0, 180)
KeyFrame.Position = UDim2.new(0.5, -160, 0.5, -90)
KeyFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
KeyFrame.BackgroundTransparency = 0.4
KeyFrame.BorderSizePixel = 0
KeyFrame.Parent = KeyGui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 14)
KeyCorner.Parent = KeyFrame

local KeyTitleBar = Instance.new("Frame")
KeyTitleBar.Size = UDim2.new(1, 0, 0, 42)
KeyTitleBar.BackgroundColor3 = Color3.fromRGB(248, 248, 248)
KeyTitleBar.BackgroundTransparency = 0.4
KeyTitleBar.BorderSizePixel = 0
KeyTitleBar.Parent = KeyFrame

local KeyTitleBarCorner = Instance.new("UICorner")
KeyTitleBarCorner.CornerRadius = UDim.new(0, 14)
KeyTitleBarCorner.Parent = KeyTitleBar

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, -80, 1, 0)
KeyTitle.Position = UDim2.new(0, 18, 0, 0)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.Text = "输入卡密"
KeyTitle.TextColor3 = Color3.fromRGB(30, 30, 30)
KeyTitle.TextSize = 17
KeyTitle.TextXAlignment = Enum.TextXAlignment.Left
KeyTitle.Parent = KeyTitleBar

local KeyCloseBtn = Instance.new("TextButton")
KeyCloseBtn.Size = UDim2.new(0, 32, 0, 32)
KeyCloseBtn.Position = UDim2.new(1, -40, 0, 5)
KeyCloseBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
KeyCloseBtn.BorderSizePixel = 0
KeyCloseBtn.Font = Enum.Font.GothamBold
KeyCloseBtn.Text = "×"
KeyCloseBtn.TextColor3 = Color3.fromRGB(220, 60, 60)
KeyCloseBtn.TextSize = 24
KeyCloseBtn.Parent = KeyTitleBar

local KeyCloseCorner = Instance.new("UICorner")
KeyCloseCorner.CornerRadius = UDim.new(0, 8)
KeyCloseCorner.Parent = KeyCloseBtn

local KeyInputBox = Instance.new("TextBox")
KeyInputBox.Size = UDim2.new(0.85, 0, 0, 40)
KeyInputBox.Position = UDim2.new(0.075, 0, 0.32, 0)
KeyInputBox.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
KeyInputBox.BorderSizePixel = 0
KeyInputBox.Font = Enum.Font.Gotham
KeyInputBox.PlaceholderText = "输入卡密..."
KeyInputBox.Text = ""
KeyInputBox.TextColor3 = Color3.fromRGB(40, 40, 40)
KeyInputBox.TextSize = 16
KeyInputBox.ClearTextOnFocus = false
KeyInputBox.Parent = KeyFrame

local KeyInputCorner = Instance.new("UICorner")
KeyInputCorner.CornerRadius = UDim.new(0, 8)
KeyInputCorner.Parent = KeyInputBox

local KeyHintLabel = Instance.new("TextLabel")
KeyHintLabel.Size = UDim2.new(0.85, 0, 0, 30)
KeyHintLabel.Position = UDim2.new(0.075, 0, 0.55, 0)
KeyHintLabel.BackgroundTransparency = 1
KeyHintLabel.Font = Enum.Font.Gotham
KeyHintLabel.Text = ""
KeyHintLabel.TextColor3 = Color3.fromRGB(220, 60, 60)
KeyHintLabel.TextSize = 14
KeyHintLabel.TextXAlignment = Enum.TextXAlignment.Left
KeyHintLabel.Parent = KeyFrame

local ButtonArea = Instance.new("Frame")
ButtonArea.Size = UDim2.new(0.85, 0, 0, 40)
ButtonArea.Position = UDim2.new(0.075, 0, 0.72, 0)
ButtonArea.BackgroundTransparency = 1
ButtonArea.Parent = KeyFrame

local ConfirmBtn = Instance.new("TextButton")
ConfirmBtn.Size = UDim2.new(0.48, 0, 1, 0)
ConfirmBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ConfirmBtn.BorderSizePixel = 0
ConfirmBtn.Font = Enum.Font.GothamSemibold
ConfirmBtn.Text = "确定"
ConfirmBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
ConfirmBtn.TextSize = 16
ConfirmBtn.Parent = ButtonArea

local ConfirmCorner = Instance.new("UICorner")
ConfirmCorner.CornerRadius = UDim.new(0, 8)
ConfirmCorner.Parent = ConfirmBtn

local ClearBtn = Instance.new("TextButton")
ClearBtn.Size = UDim2.new(0.48, 0, 1, 0)
ClearBtn.Position = UDim2.new(0.52, 0, 0, 0)
ClearBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ClearBtn.BorderSizePixel = 0
ClearBtn.Font = Enum.Font.GothamSemibold
ClearBtn.Text = "清空"
ClearBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
ClearBtn.TextSize = 16
ClearBtn.Parent = ButtonArea

local ClearCorner = Instance.new("UICorner")
ClearCorner.CornerRadius = UDim.new(0, 8)
ClearCorner.Parent = ClearBtn

local function checkKey()
    local input = KeyInputBox.Text:lower():gsub("%s+", "")
    KeyHintLabel.Text = ""

    local result = verifyKey(input)
    
    if result == "valid" then
        KeyGui:Destroy()
        loadMainInterface()
    elseif result == "sb" then
        KeyInputBox.Text = ""
        KeyHintLabel.Text = "操你妈😡😡😡"
        KeyHintLabel.TextColor3 = Color3.fromRGB(220, 60, 60)
    elseif result == "114514" then
        KeyInputBox.Text = ""
        KeyHintLabel.Text = "太臭力😭"
        KeyHintLabel.TextColor3 = Color3.fromRGB(100, 100, 255)
    else
        -- 只有包含 skn 和 145 但不是正确卡密时才弹窗
        if string.find(input, "skn") and string.find(input, "145") then
            showMisinputConfirm()
        else
            KeyHintLabel.Text = "卡密错误"
            KeyHintLabel.TextColor3 = Color3.fromRGB(220, 60, 60)
        end
    end
end

-- 失误
local function showMisinputConfirm()
    local MisinputGui = Instance.new("ScreenGui")
    MisinputGui.Name = "MisinputConfirmGui"
    MisinputGui.ResetOnSpawn = false
    MisinputGui.IgnoreGuiInset = true
    MisinputGui.Parent = gui

    local Overlay = Instance.new("Frame")
    Overlay.Size = UDim2.new(1, 0, 1, 0)
    Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Overlay.BackgroundTransparency = 1
    Overlay.BorderSizePixel = 0
    Overlay.Parent = MisinputGui

    local MisinputFrame = Instance.new("Frame")
    MisinputFrame.Size = UDim2.new(0, 320, 0, 160)
    MisinputFrame.Position = UDim2.new(0.5, -160, 0.5, -80)
    MisinputFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MisinputFrame.BackgroundTransparency = 1
    MisinputFrame.BorderSizePixel = 0
    MisinputFrame.Parent = MisinputGui

    local MisinputCorner = Instance.new("UICorner")
    MisinputCorner.CornerRadius = UDim.new(0, 14)
    MisinputCorner.Parent = MisinputFrame

    local MisinputTitle = Instance.new("TextLabel")
    MisinputTitle.Size = UDim2.new(1, 0, 0, 50)
    MisinputTitle.BackgroundTransparency = 1
    MisinputTitle.Font = Enum.Font.GothamBold
    MisinputTitle.Text = "是否输入失误？"
    MisinputTitle.TextColor3 = Color3.fromRGB(30, 30, 30)
    MisinputTitle.TextSize = 18
    MisinputTitle.Parent = MisinputFrame

    local BtnArea = Instance.new("Frame")
    BtnArea.Size = UDim2.new(0.9, 0, 0, 50)
    BtnArea.Position = UDim2.new(0.05, 0, 0.6, 0)
    BtnArea.BackgroundTransparency = 1
    BtnArea.Parent = MisinputFrame

    local YesBtn = Instance.new("TextButton")
    YesBtn.Size = UDim2.new(0.48, 0, 1, 0)
    YesBtn.BackgroundColor3 = Color3.fromRGB(80, 140, 255)
    YesBtn.BorderSizePixel = 0
    YesBtn.Font = Enum.Font.GothamSemibold
    YesBtn.Text = "确定"
    YesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    YesBtn.TextSize = 16
    YesBtn.Parent = BtnArea

    local YesCorner = Instance.new("UICorner")
    YesCorner.CornerRadius = UDim.new(0, 8)
    YesCorner.Parent = YesBtn

    local NoBtn = Instance.new("TextButton")
    NoBtn.Size = UDim2.new(0.48, 0, 1, 0)
    NoBtn.Position = UDim2.new(0.52, 0, 0, 0)
    NoBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    NoBtn.BorderSizePixel = 0
    NoBtn.Font = Enum.Font.GothamSemibold
    NoBtn.Text = "取消"
    NoBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    NoBtn.TextSize = 16
    NoBtn.Parent = BtnArea

    local NoCorner = Instance.new("UICorner")
    NoCorner.CornerRadius = UDim.new(0, 8)
    NoCorner.Parent = NoBtn

    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    TweenService:Create(Overlay, tweenInfo, {BackgroundTransparency = 0.4}):Play()
    TweenService:Create(MisinputFrame, tweenInfo, {BackgroundTransparency = 0}):Play()

    YesBtn.MouseButton1Click:Connect(function()
        TweenService:Create(Overlay, tweenInfo, {BackgroundTransparency = 1}):Play()
        TweenService:Create(MisinputFrame, tweenInfo, {BackgroundTransparency = 1}):Play()
        task.wait(0.3)
        MisinputGui:Destroy()
        KeyGui:Destroy()
        loadMainInterface()
    end)

    NoBtn.MouseButton1Click:Connect(function()
        TweenService:Create(Overlay, tweenInfo, {BackgroundTransparency = 1}):Play()
        TweenService:Create(MisinputFrame, tweenInfo, {BackgroundTransparency = 1}):Play()
        task.wait(0.3)
        MisinputGui:Destroy()
    end)
end

ConfirmBtn.MouseButton1Click:Connect(checkKey)
ClearBtn.MouseButton1Click:Connect(function()
    KeyInputBox.Text = ""
    KeyHintLabel.Text = ""
end)

KeyInputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then checkKey() end
end)

-- 拖拽
local dragging, dragStart, startPos

KeyTitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = KeyFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        KeyFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

KeyCloseBtn.MouseButton1Click:Connect(function()
    KeyGui:Destroy()
end)

-- 载入主界面

function loadMainInterface()
    local LoadingGui = Instance.new("ScreenGui")
    LoadingGui.Name = "SKNLoading"
    LoadingGui.ResetOnSpawn = false
    LoadingGui.IgnoreGuiInset = true
    LoadingGui.Parent = gui

    local LoadingFrame = Instance.new("Frame")
    LoadingFrame.Size = UDim2.new(0, 280, 0, 140)
    LoadingFrame.Position = UDim2.new(0.5, -140, 0.5, -70)
    LoadingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    LoadingFrame.BackgroundTransparency = 1
    LoadingFrame.BorderSizePixel = 0
    LoadingFrame.Parent = LoadingGui

    local LoadCorner = Instance.new("UICorner")
    LoadCorner.CornerRadius = UDim.new(0, 12)
    LoadCorner.Parent = LoadingFrame

    local LoadTitle = Instance.new("TextLabel")
    LoadTitle.Size = UDim2.new(1, 0, 0, 40)
    LoadTitle.BackgroundTransparency = 1
    LoadTitle.Font = Enum.Font.GothamSemibold
    LoadTitle.Text = "SKN Hub"
    LoadTitle.TextColor3 = Color3.fromRGB(40, 40, 40)
    LoadTitle.TextTransparency = 1
    LoadTitle.TextSize = 20
    LoadTitle.Parent = LoadingFrame

    local LoadSpinner = Instance.new("ImageLabel")
    LoadSpinner.Size = UDim2.new(0, 48, 0, 48)
    LoadSpinner.Position = UDim2.new(0.5, -24, 0.5, -30)
    LoadSpinner.BackgroundTransparency = 1
    LoadSpinner.ImageTransparency = 1
    LoadSpinner.Image = "rbxassetid://6034833295"
    LoadSpinner.ImageColor3 = Color3.fromRGB(90, 140, 255)
    LoadSpinner.Parent = LoadingFrame

    local LoadText = Instance.new("TextLabel")
    LoadText.Size = UDim2.new(1, -40, 0, 30)
    LoadText.Position = UDim2.new(0, 20, 1, -45)
    LoadText.BackgroundTransparency = 1
    LoadText.Font = Enum.Font.Gotham
    LoadText.Text = "正在初始化界面..."
    LoadText.TextColor3 = Color3.fromRGB(100, 100, 100)
    LoadText.TextTransparency = 1
    LoadText.TextSize = 14
    LoadText.Parent = LoadingFrame

    local spinConn = RunService.RenderStepped:Connect(function(dt)
        if LoadSpinner.Parent then
            LoadSpinner.Rotation = (LoadSpinner.Rotation + dt * 400) % 360
        end
    end)

    task.spawn(function()
        local tweenInfoIn = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        TweenService:Create(LoadingFrame, tweenInfoIn, {BackgroundTransparency = 0.15}):Play()
        TweenService:Create(LoadTitle, tweenInfoIn, {TextTransparency = 0}):Play()
        TweenService:Create(LoadSpinner, tweenInfoIn, {ImageTransparency = 0}):Play()
        TweenService:Create(LoadText, tweenInfoIn, {TextTransparency = 0}):Play()
    end)

    local MainGui = Instance.new("ScreenGui")
    MainGui.Name = "SKN_Hub v0.0.1(test)"
    MainGui.ResetOnSpawn = false
    MainGui.Parent = gui

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "Main"
    MainFrame.Size = UDim2.new(0, 440, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -220, 0.5, -150)
    MainFrame.BackgroundColor3 = currentMainColor
    MainFrame.BackgroundTransparency = currentTransparency
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Visible = false
    MainFrame.Parent = MainGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 14)
    MainCorner.Parent = MainFrame

    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 42)
    TitleBar.BackgroundColor3 = Color3.fromRGB(248, 248, 248)
    TitleBar.BackgroundTransparency = currentTransparency
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame

    local TitleBarCorner = Instance.new("UICorner")
    TitleBarCorner.CornerRadius = UDim.new(0, 14)
    TitleBarCorner.Parent = TitleBar

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -90, 1, 0)
    Title.Position = UDim2.new(0, 18, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.GothamBold
    Title.Text = "SKN Hub"
    Title.TextColor3 = Color3.fromRGB(30, 30, 30)
    Title.TextSize = 17 * currentFontScale
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TitleBar

    local MinimizeBtn = Instance.new("TextButton")
    MinimizeBtn.Size = UDim2.new(0, 32, 0, 32)
    MinimizeBtn.Position = UDim2.new(1, -78, 0, 5)
    MinimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeBtn.BorderSizePixel = 0
    MinimizeBtn.Font = Enum.Font.GothamSemibold
    MinimizeBtn.Text = "−"
    MinimizeBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    MinimizeBtn.TextSize = 22
    MinimizeBtn.Parent = TitleBar

    local MinCorner = Instance.new("UICorner")
    MinCorner.CornerRadius = UDim.new(0, 8)
    MinCorner.Parent = MinimizeBtn

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 32, 0, 32)
    CloseBtn.Position = UDim2.new(1, -40, 0, 5)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.BorderSizePixel = 0
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Text = "×"
    CloseBtn.TextColor3 = Color3.fromRGB(220, 60, 60)
    CloseBtn.TextSize = 24
    CloseBtn.Parent = TitleBar

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 8)
    CloseCorner.Parent = CloseBtn

    local TabBar = Instance.new("Frame")
    TabBar.Name = "TabBar"
    TabBar.Size = UDim2.new(0, 110, 1, -42)
    TabBar.Position = UDim2.new(0, 0, 0, 42)
    TabBar.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
    TabBar.BackgroundTransparency = currentTransparency
    TabBar.BorderSizePixel = 0
    TabBar.Parent = MainFrame

    local ContentArea = Instance.new("ScrollingFrame")
    ContentArea.Name = "ContentArea"
    ContentArea.Size = UDim2.new(1, -110, 1, -42)
    ContentArea.Position = UDim2.new(0, 110, 0, 42)
    ContentArea.BackgroundTransparency = 1
    ContentArea.ScrollBarThickness = 6
    ContentArea.ScrollBarImageColor3 = Color3.fromRGB(220, 220, 220)
    ContentArea.ScrollBarImageTransparency = currentTransparency
    ContentArea.ScrollingDirection = Enum.ScrollingDirection.Y
    ContentArea.CanvasSize = UDim2.new(0, 0, 0, 0)
    ContentArea.Parent = MainFrame

    -- 玩家资料（DisplayName + Username）
    local PlayerThumbnail = Instance.new("ImageLabel")
    PlayerThumbnail.AnchorPoint = Vector2.new(0, 1)
    PlayerThumbnail.Position = UDim2.new(0, 12, 1, -12)
    PlayerThumbnail.Size = UDim2.new(0, 40, 0, 40)
    PlayerThumbnail.BackgroundTransparency = 1
    PlayerThumbnail.Image = Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size48x48)
    PlayerThumbnail.Parent = MainFrame

    local ThumbCorner = Instance.new("UICorner")
    ThumbCorner.CornerRadius = UDim.new(1, 0)
    ThumbCorner.Parent = PlayerThumbnail

    local PlayerNameLabel = Instance.new("TextLabel")
    PlayerNameLabel.AnchorPoint = Vector2.new(0, 1)
    PlayerNameLabel.Position = UDim2.new(0, 58, 1, -18)
    PlayerNameLabel.Size = UDim2.new(0, 140, 0, 24)
    PlayerNameLabel.BackgroundTransparency = 1
    PlayerNameLabel.Font = Enum.Font.GothamSemibold
    PlayerNameLabel.Text = player.DisplayName
    PlayerNameLabel.TextColor3 = Color3.fromRGB(30, 30, 30)
    PlayerNameLabel.TextSize = 15 * currentFontScale
    PlayerNameLabel.TextXAlignment = Enum.TextXAlignment.Left
    PlayerNameLabel.Parent = MainFrame

    local PlayerUsernameLabel = Instance.new("TextLabel")
    PlayerUsernameLabel.AnchorPoint = Vector2.new(0, 1)
    PlayerUsernameLabel.Position = UDim2.new(0, 58, 1, -2)
    PlayerUsernameLabel.Size = UDim2.new(0, 140, 0, 18)
    PlayerUsernameLabel.BackgroundTransparency = 1
    PlayerUsernameLabel.Font = Enum.Font.Gotham
    PlayerUsernameLabel.Text = player.Name
    PlayerUsernameLabel.TextColor3 = Color3.fromRGB(100, 100, 100)
    PlayerUsernameLabel.TextSize = 10.5 * currentFontScale
    PlayerUsernameLabel.TextXAlignment = Enum.TextXAlignment.Left
    PlayerUsernameLabel.Parent = MainFrame

    -- Tab 切换
    local currentTab = nil

    local function createTab(name, index)
        local tab = Instance.new("TextButton")
        tab.Name = name
        tab.Size = UDim2.new(1, -16, 0, 42)
        tab.Position = UDim2.new(0, 8, 0, 8 + (index-1)*50)
        tab.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
        tab.BackgroundTransparency = currentTransparency + 0.1
        tab.BorderSizePixel = 0
        tab.Font = Enum.Font.GothamSemibold
        tab.Text = name
        tab.TextColor3 = Color3.fromRGB(60, 60, 60)
        tab.TextSize = 15 * currentFontScale
        tab.AutoButtonColor = false
        tab.Parent = TabBar

        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 10)
        tabCorner.Parent = tab

        local function selectThis()
            if currentTab == tab then return end

            if currentTab then
                TweenService:Create(currentTab, TweenInfo.new(0.25), {
                    BackgroundColor3 = Color3.fromRGB(230, 230, 230),
                    BackgroundTransparency = currentTransparency + 0.1
                }):Play()
            end

            TweenService:Create(tab, TweenInfo.new(0.25), {
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                BackgroundTransparency = currentTransparency - 0.05
            }):Play()

            currentTab = tab

            for _, child in ipairs(ContentArea:GetChildren()) do
                if child:IsA("GuiObject") then
                    child.Visible = (child.Name == name .. "Content")
                end
            end
        end

        tab.MouseButton1Click:Connect(selectThis)
        return tab, selectThis
    end

    local mainTab, selectMain = createTab("通用功能", 1)
    local settingsTab, selectSettings = createTab("设置", 2)

    local MainContent = Instance.new("Frame")
    MainContent.Name = "通用功能Content"
    MainContent.Size = UDim2.new(1,0,1,0)
    MainContent.BackgroundTransparency = 1
    MainContent.Visible = true
    MainContent.Parent = ContentArea

    local mainLabel = Instance.new("TextLabel")
    mainLabel.Size = UDim2.new(1,-32,0,40)
    mainLabel.Position = UDim2.new(0,16,0,16)
    mainLabel.BackgroundTransparency = 1
    mainLabel.Font = Enum.Font.GothamSemibold
    mainLabel.Text = "通用功能区（你应该庆幸目前这里没有石给你赤）"
    mainLabel.TextColor3 = Color3.fromRGB(45, 45, 45)
    mainLabel.TextSize = 18 * currentFontScale
    mainLabel.TextXAlignment = Enum.TextXAlignment.Left
    mainLabel.Parent = MainContent

    local SettingsContent = Instance.new("Frame")
    SettingsContent.Name = "设置Content"
    SettingsContent.Size = UDim2.new(1,0,1,0)
    SettingsContent.BackgroundTransparency = 1
    SettingsContent.Visible = false
    SettingsContent.Parent = ContentArea

    local settingsTitle = Instance.new("TextLabel")
    settingsTitle.Size = UDim2.new(1,-32,0,40)
    settingsTitle.Position = UDim2.new(0,16,0,16)
    settingsTitle.BackgroundTransparency = 1
    settingsTitle.Font = Enum.Font.GothamSemibold
    settingsTitle.Text = "设置区域"
    settingsTitle.TextColor3 = Color3.fromRGB(45, 45, 45)
    settingsTitle.TextSize = 18 * currentFontScale
    settingsTitle.TextXAlignment = Enum.TextXAlignment.Left
    settingsTitle.Parent = SettingsContent

    -- 设置项目
    local function createSettingRow(labelText, defaultVal, yPos, placeholder, onApply)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1,-40,0,50)
        frame.Position = UDim2.new(0,20,0,yPos)
        frame.BackgroundTransparency = 1
        frame.Parent = SettingsContent

        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(0.45,0,1,0)
        lbl.BackgroundTransparency = 1
        lbl.Font = Enum.Font.GothamSemibold
        lbl.Text = labelText
        lbl.TextColor3 = Color3.fromRGB(50,50,50)
        lbl.TextSize = 15 * currentFontScale
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = frame

        local box = Instance.new("TextBox")
        box.Size = UDim2.new(0,100,0,36)
        box.Position = UDim2.new(0.48,0,0,7)
        box.BackgroundColor3 = Color3.fromRGB(245,245,245)
        box.BorderSizePixel = 0
        box.Font = Enum.Font.Gotham
        box.PlaceholderText = placeholder or "输入数值"
        box.Text = tostring(defaultVal)
        box.TextColor3 = Color3.fromRGB(40,40,40)
        box.TextSize = 15 * currentFontScale
        box.ClearTextOnFocus = false
        box.Parent = frame

        local boxCr = Instance.new("UICorner", box)
        boxCr.CornerRadius = UDim.new(0,6)

        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0,80,0,36)
        btn.Position = UDim2.new(0.78,0,0,7)
        btn.BackgroundColor3 = Color3.fromRGB(255,255,255)
        btn.BorderSizePixel = 0
        btn.Font = Enum.Font.GothamSemibold
        btn.Text = "应用"
        btn.TextColor3 = Color3.fromRGB(0,0,0)
        btn.TextSize = 15 * currentFontScale
        btn.Parent = frame

        local btnCr = Instance.new("UICorner", btn)
        btnCr.CornerRadius = UDim.new(0,6)

        btn.MouseButton1Click:Connect(function()
            onApply(box)
        end)

        return box
    end

    createSettingRow("主界面透明度", currentTransparency, 70, "0.2 ~ 0.7", function(box)
        local val = tonumber(box.Text)
        if val and val >= 0.15 and val <= 0.85 then
            currentTransparency = val
            MainFrame.BackgroundTransparency = val
            TitleBar.BackgroundTransparency = val
            TabBar.BackgroundTransparency = val
            ContentArea.ScrollBarImageTransparency = val
            if currentTab then currentTab.BackgroundTransparency = val - 0.05 end
            for _, child in ipairs(TabBar:GetChildren()) do
                if child:IsA("TextButton") and child ~= currentTab then
                    child.BackgroundTransparency = val + 0.1
                end
            end
        else
            box.Text = tostring(currentTransparency)
        end
    end)

    createSettingRow("全局字体大小", currentFontScale, 135, "0.8 ~ 1.5", function(box)
        local val = tonumber(box.Text)
        if val and val >= 0.7 and val <= 1.8 then
            currentFontScale = val
            Title.TextSize = 17 * val
            mainLabel.TextSize = 18 * val
            settingsTitle.TextSize = 20 * val
            PlayerNameLabel.TextSize = 15 * val
            PlayerUsernameLabel.TextSize = 10.5 * val
            for _, child in ipairs(TabBar:GetChildren()) do
                if child:IsA("TextButton") then
                    child.TextSize = 15 * val
                end
            end
        else
            box.Text = tostring(currentFontScale)
        end
    end)

    createSettingRow("主界面颜色 (RGB)", "255,255,255", 200, "例如 255,100,80", function(box)
        local r, g, b = box.Text:match("(%d+)%s*,%s*(%d+)%s*,%s*(%d+)")
        r, g, b = tonumber(r), tonumber(g), tonumber(b)
        if r and g and b and r >= 0 and r <= 255 and g >= 0 and g <= 255 and b >= 0 and b <= 255 then
            currentMainColor = Color3.fromRGB(r, g, b)
            MainFrame.BackgroundColor3 = currentMainColor
        else
            box.Text = string.format("%d,%d,%d", 
                math.floor(currentMainColor.R*255 + 0.5),
                math.floor(currentMainColor.G*255 + 0.5),
                math.floor(currentMainColor.B*255 + 0.5))
        end
    end)

    -- 分隔
    local function createDivider(y)
        local div = Instance.new("Frame")
        div.Size = UDim2.new(1,-40,0,1)
        div.Position = UDim2.new(0,20,0,y)
        div.BackgroundColor3 = Color3.fromRGB(255,255,255)
        div.BackgroundTransparency = currentTransparency
        div.BorderSizePixel = 0
        div.Parent = SettingsContent
    end

    createDivider(65)
    createDivider(130)
    createDivider(195)

    -- 動態 CanvasSize
    ContentArea.ChildAdded:Connect(function()
        local h = 0
        for _, c in ipairs(ContentArea:GetChildren()) do
            if c:IsA("GuiObject") and c.Visible then
                h = h + c.AbsoluteSize.Y + (c.Position.Y.Offset or 0) + 20
            end
        end
        ContentArea.CanvasSize = UDim2.new(0,0,0,h + 60)
    end)

    task.defer(function()
        ContentArea.CanvasSize = UDim2.new(0,0,0,400)
    end)

    selectMain()

    -- 拖拽
    local dragging, dragStart, startPos

    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- 最小化小Ul
    local MiniUI = Instance.new("TextButton")
    MiniUI.Name = "MiniUI"
    MiniUI.Size = UDim2.new(0, 100, 0, 36)
    MiniUI.Position = UDim2.new(1, -120, 1, -50)
    MiniUI.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MiniUI.BackgroundTransparency = 1
    MiniUI.BorderSizePixel = 0
    MiniUI.Font = Enum.Font.GothamBold
    MiniUI.Text = "SKN"
    MiniUI.TextColor3 = Color3.fromRGB(0, 0, 0)
    MiniUI.TextSize = 16
    MiniUI.Visible = false
    MiniUI.Parent = MainGui

    local MiniUICorner = Instance.new("UICorner")
    MiniUICorner.CornerRadius = UDim.new(0, 18)
    MiniUICorner.Parent = MiniUI

    -- 小UI 拖動
    local miniDragging, miniDragStart, miniStartPos

    MiniUI.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            miniDragging = true
            miniDragStart = input.Position
            miniStartPos = MiniUI.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    miniDragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if miniDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - miniDragStart
            MiniUI.Position = UDim2.new(miniStartPos.X.Scale, miniStartPos.X.Offset + delta.X, miniStartPos.Y.Scale, miniStartPos.Y.Offset + delta.Y)
        end
    end)

    -- 最小化
    MinimizeBtn.MouseButton1Click:Connect(function()
        local tweenOut = TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        TweenService:Create(MainFrame, tweenOut, {BackgroundTransparency = 1}):Play()
        TweenService:Create(TitleBar, tweenOut, {BackgroundTransparency = 1}):Play()
        TweenService:Create(TabBar, tweenOut, {BackgroundTransparency = 1}):Play()

        task.wait(0.4)
        MainFrame.Visible = false
        MiniUI.BackgroundTransparency = 1
        MiniUI.Visible = true
        TweenService:Create(MiniUI, tweenOut, {BackgroundTransparency = 0}):Play()
    end)

    -- 小UI
    MiniUI.MouseButton1Click:Connect(function()
        local tweenIn = TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
        TweenService:Create(MiniUI, tweenIn, {BackgroundTransparency = 1}):Play()

        task.wait(0.4)
        MiniUI.Visible = false
        MainFrame.Visible = true
        TweenService:Create(MainFrame, tweenIn, {BackgroundTransparency = currentTransparency}):Play()
        TweenService:Create(TitleBar, tweenIn, {BackgroundTransparency = currentTransparency}):Play()
        TweenService:Create(TabBar, tweenIn, {BackgroundTransparency = currentTransparency}):Play()
    end)

    -- 关闭确认弹窗
    local function showCloseConfirm()
        local ConfirmGui = Instance.new("ScreenGui")
        ConfirmGui.Name = "CloseConfirmGui"
        ConfirmGui.ResetOnSpawn = false
        ConfirmGui.IgnoreGuiInset = true
        ConfirmGui.Parent = gui

        local Overlay = Instance.new("Frame")
        Overlay.Size = UDim2.new(1, 0, 1, 0)
        Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        Overlay.BackgroundTransparency = 1
        Overlay.BorderSizePixel = 0
        Overlay.Parent = ConfirmGui

        local ConfirmFrame = Instance.new("Frame")
        ConfirmFrame.Size = UDim2.new(0, 320, 0, 160)
        ConfirmFrame.Position = UDim2.new(0.5, -160, 0.5, -80)
        ConfirmFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ConfirmFrame.BackgroundTransparency = 1
        ConfirmFrame.BorderSizePixel = 0
        ConfirmFrame.Parent = ConfirmGui

        local ConfirmCorner = Instance.new("UICorner")
        ConfirmCorner.CornerRadius = UDim.new(0, 14)
        ConfirmCorner.Parent = ConfirmFrame

        local ConfirmTitle = Instance.new("TextLabel")
        ConfirmTitle.Size = UDim2.new(1, 0, 0, 50)
        ConfirmTitle.BackgroundTransparency = 1
        ConfirmTitle.Font = Enum.Font.GothamBold
        ConfirmTitle.Text = "真的要關閉此腳本嗎？"
        ConfirmTitle.TextColor3 = Color3.fromRGB(30, 30, 30)
        ConfirmTitle.TextSize = 18
        ConfirmTitle.Parent = ConfirmFrame

        local BtnArea = Instance.new("Frame")
        BtnArea.Size = UDim2.new(0.9, 0, 0, 50)
        BtnArea.Position = UDim2.new(0.05, 0, 0.6, 0)
        BtnArea.BackgroundTransparency = 1
        BtnArea.Parent = ConfirmFrame

        local YesBtn = Instance.new("TextButton")
        YesBtn.Size = UDim2.new(0.48, 0, 1, 0)
        YesBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
        YesBtn.BorderSizePixel = 0
        YesBtn.Font = Enum.Font.GothamSemibold
        YesBtn.Text = "确定"
        YesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        YesBtn.TextSize = 16
        YesBtn.Parent = BtnArea

        local YesCorner = Instance.new("UICorner")
        YesCorner.CornerRadius = UDim.new(0, 8)
        YesCorner.Parent = YesBtn

        local NoBtn = Instance.new("TextButton")
        NoBtn.Size = UDim2.new(0.48, 0, 1, 0)
        NoBtn.Position = UDim2.new(0.52, 0, 0, 0)
        NoBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NoBtn.BorderSizePixel = 0
        NoBtn.Font = Enum.Font.GothamSemibold
        NoBtn.Text = "取消"
        NoBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        NoBtn.TextSize = 16
        NoBtn.Parent = BtnArea

        local NoCorner = Instance.new("UICorner")
        NoCorner.CornerRadius = UDim.new(0, 8)
        NoCorner.Parent = NoBtn

        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        TweenService:Create(Overlay, tweenInfo, {BackgroundTransparency = 0.4}):Play()
        TweenService:Create(ConfirmFrame, tweenInfo, {BackgroundTransparency = 0}):Play()

        YesBtn.MouseButton1Click:Connect(function()
            TweenService:Create(Overlay, tweenInfo, {BackgroundTransparency = 1}):Play()
            TweenService:Create(ConfirmFrame, tweenInfo, {BackgroundTransparency = 1}):Play()
            task.wait(0.3)
            ConfirmGui:Destroy()
            MainGui:Destroy()
            LoadingGui:Destroy()
        end)

        NoBtn.MouseButton1Click:Connect(function()
            TweenService:Create(Overlay, tweenInfo, {BackgroundTransparency = 1}):Play()
            TweenService:Create(ConfirmFrame, tweenInfo, {BackgroundTransparency = 1}):Play()
            task.wait(0.3)
            ConfirmGui:Destroy()
        end)
    end

    CloseBtn.MouseButton1Click:Connect(showCloseConfirm)

    -- 淡出
    task.delay(2.0, function()
        local tweenInfoOut = TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.In)
        TweenService:Create(LoadingFrame, tweenInfoOut, {BackgroundTransparency = 1}):Play()
        TweenService:Create(LoadTitle, tweenInfoOut, {TextTransparency = 1}):Play()
        TweenService:Create(LoadText, tweenInfoOut, {TextTransparency = 1}):Play()
        TweenService:Create(LoadSpinner, tweenInfoOut, {ImageTransparency = 1}):Play()

        task.wait(0.8)
        MainFrame.Visible = true

        task.delay(0.4, function()
            LoadingGui:Destroy()
            spinConn:Disconnect()
        end)
    end)
end

print("SKN_Hub 已启动，请输入卡密")
