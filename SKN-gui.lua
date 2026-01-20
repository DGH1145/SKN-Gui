-- SKN hub ui  
-- 我是傻逼

repeat task.wait() until game:IsLoaded()

local library = {}
local ToggleUI = false
library.currentTab = nil
library.flags = {}

local services = setmetatable({}, {
    __index = function(t, k)
        return game:GetService(k)
    end
})

local mouse = services.Players.LocalPlayer:GetMouse()

local function Tween(obj, t, data)
    services.TweenService:Create(obj, TweenInfo.new(t[1], Enum.EasingStyle[t[2]], Enum.EasingDirection[t[3]]), data):Play()
    return true
end

local function Ripple(obj)
    task.spawn(function()
        if not obj.ClipsDescendants then
            obj.ClipsDescendants = true
        end
        
        local Ripple = Instance.new("ImageLabel")
        Ripple.Name = "Ripple"
        Ripple.Parent = obj
        Ripple.BackgroundTransparency = 1
        Ripple.ZIndex = 8
        Ripple.Image = "rbxassetid://16060333448"
        Ripple.ImageTransparency = 0.8
        Ripple.ScaleType = Enum.ScaleType.Fit
        Ripple.ImageColor3 = Color3.fromRGB(255, 255, 255)
        
        Ripple.Position = UDim2.new(
            (mouse.X - Ripple.AbsolutePosition.X) / obj.AbsoluteSize.X, 0,
            (mouse.Y - Ripple.AbsolutePosition.Y) / obj.AbsoluteSize.Y, 0
        )
        
        Tween(Ripple, {0.3, "Linear", "InOut"}, {
            Position = UDim2.new(-5.5, 0, -5.5, 0),
            Size = UDim2.new(12, 0, 12, 0)
        })
        
        task.wait(0.15)
        Tween(Ripple, {0.3, "Linear", "InOut"}, {ImageTransparency = 1})
        task.wait(0.3)
        Ripple:Destroy()
    end)
end

local toggled = false
local switchingTabs = false

local function switchTab(new)
    if switchingTabs then return end
    
    local old = library.currentTab
    if not old then
        new[2].Visible = true
        library.currentTab = new
        Tween(new[1], {0.1}, {ImageTransparency = 0})
        Tween(new[1].TabText, {0.1}, {TextTransparency = 0})
        return
    end
    
    if old[1] == new[1] then return end
    
    switchingTabs = true
    library.currentTab = new
    
    Tween(old[1], {0.1}, {ImageTransparency = 0.2})
    Tween(new[1], {0.1}, {ImageTransparency = 0})
    Tween(old[1].TabText, {0.1}, {TextTransparency = 0.2})
    Tween(new[1].TabText, {0.1}, {TextTransparency = 0})
    
    old[2].Visible = false
    new[2].Visible = true
    
    task.wait(0.1)
    switchingTabs = false
end

local function drag(frame, hold)
    hold = hold or frame
    
    local dragging, dragInput, dragStart, startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
    
    hold.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    services.UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

library.new = function(_, name, theme)
    -- 去你妈的舊版UI
    for _, v in next, services.CoreGui:GetChildren() do
        if v.Name == "SKN" then
            v:Destroy()
        end
    end
    
    local MainColor = Color3.fromRGB(25, 25, 25)
    local Background = Color3.fromRGB(25, 25, 25)
    local zyColor    = Color3.fromRGB(30, 30, 30)
    local beijingColor = Color3.fromRGB(255, 255, 255)
    
    if theme == "light" then
        -- 暗死你妈逼
    end
    
    local skn = Instance.new("ScreenGui")
    skn.Name = "SKN"
    skn.Parent = services.CoreGui
    if syn and syn.protect_gui then syn.protect_gui(skn) end
    
    local function UiDestroy()
        skn:Destroy()
    end
    
    local function ToggleUILib()
        ToggleUI = not ToggleUI
        skn.Enabled = not ToggleUI
    end
    
    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = skn
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Background
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0, 572, 0, 353)
    Main.Active = true
    
    drag(Main)
    
    local UICornerMain = Instance.new("UICorner", Main)
    UICornerMain.CornerRadius = UDim.new(0, 3)
    
    -- Drop shadow (彩虹旋轉邊框)
    local DropShadowHolder = Instance.new("Frame", Main)
    DropShadowHolder.BackgroundTransparency = 1
    DropShadowHolder.Size = UDim2.new(1,0,1,0)
    DropShadowHolder.ZIndex = 0
    
    local DropShadow = Instance.new("ImageLabel", DropShadowHolder)
    DropShadow.BackgroundTransparency = 1
    DropShadow.Position = UDim2.new(0.5,0,0.5,0)
    DropShadow.AnchorPoint = Vector2.new(0.5,0.5)
    DropShadow.Size = UDim2.new(1,43,1,43)
    DropShadow.Image = "rbxassetid://16060333448"
    DropShadow.ImageColor3 = Color3.fromRGB(255,255,255)
    DropShadow.ImageTransparency = 0.5
    DropShadow.ScaleType = Enum.ScaleType.Slice
    DropShadow.SliceCenter = Rect.new(49,49,450,450)
    
    local UIGradient = Instance.new("UIGradient", DropShadow)
    UIGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0.0, Color3.fromRGB(255,0,0)),
        ColorSequenceKeypoint.new(0.1, Color3.fromRGB(255,127,0)),
        -- ... (原彩虹序列保持不變)
        ColorSequenceKeypoint.new(1.0, Color3.fromRGB(0,255,0))
    }
    
    local ts = game:GetService("TweenService")
    ts:Create(UIGradient, TweenInfo.new(7, Enum.EasingStyle.Linear, Enum.EasingDirection.In, -1), {Rotation = 360}):Play()
    
    -- 我不知道啊
    -- 真的
    
    local Open = Instance.new("TextButton")
    Open.Name = "Open"
    Open.Parent = skn
    Open.BackgroundColor3 = Color3.fromRGB(25,25,25)
    Open.Position = UDim2.new(0.008,0,0.311,0)
    Open.Size = UDim2.new(0,61,0,32)
    Open.Font = Enum.Font.SourceSans
    Open.Text = "SKN"           -- ← 這裡改為 SKN
    Open.TextColor3 = Color3.fromRGB(255,255,255)
    Open.TextSize = 14
    Open.Draggable = true
    
    Open.MouseButton1Click:Connect(function()
        Main.Visible = not Main.Visible
    end)
    
    -- 快捷鍵顯示/隱藏 (LeftControl)
    services.UserInputService.InputEnded:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.LeftControl then
            Main.Visible = not Main.Visible
        end
    end)
    
    -- window 與 tab 建立函數 
    local window = {}
    
    window.Tab = function(_, tabName, iconId)
        -- ...  tab 建立邏輯 ...
        -- 顯示文字與實例名稱
        
        local TabBtn = -- ... 
        -- TabBtn.MouseButton1Click 內的 Ripple(TabBtn) 保持不變
        
        -- 其他 section.Button / Toggle / Slider / Dropdown 等方法保持
        -- 没了
        
        return tab
    end
    
    return window
end

return library
