--[[ ============================================================
     F-HUB STYLE UI
     Cole este código no arquivo main.lua do GitHub
     ============================================================ ]]

local Players          = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")
local RunService       = game:GetService("RunService")
local LP = Players.LocalPlayer

-- ============================================================
-- TEMA
-- ============================================================
local Theme = {
    Bg         = Color3.fromRGB(18, 18, 22),
    Sidebar    = Color3.fromRGB(22, 22, 28),
    Panel      = Color3.fromRGB(28, 28, 36),
    PanelAlt   = Color3.fromRGB(34, 34, 44),
    Divider    = Color3.fromRGB(45, 45, 58),
    Text       = Color3.fromRGB(235, 235, 245),
    TextDim    = Color3.fromRGB(150, 150, 165),
    Accent     = Color3.fromRGB(160, 100, 255),
    AccentDark = Color3.fromRGB(120, 70, 210),
    Font       = Enum.Font.Gotham,
    FontBold   = Enum.Font.GothamBold,
}

-- Limpa instância antiga
pcall(function()
    if _G.FHub and _G.FHub.ScreenGui then _G.FHub.ScreenGui:Destroy() end
    local old = LP.PlayerGui:FindFirstChild("FHub")
    if old then old:Destroy() end
end)

-- ============================================================
-- JANELA
-- ============================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LP:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 780, 0, 460)
Main.Position = UDim2.new(0.5, -390, 0.5, -230)
Main.BackgroundColor3 = Theme.Bg
Main.BorderSizePixel = 0
Main.Parent = ScreenGui
local MC = Instance.new("UICorner") MC.CornerRadius = UDim.new(0, 10) MC.Parent = Main
local MS = Instance.new("UIStroke") MS.Color = Theme.Divider MS.Thickness = 1 MS.Parent = Main

-- TOPBAR
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 42)
TopBar.BackgroundColor3 = Theme.Bg
TopBar.BorderSizePixel = 0
TopBar.Parent = Main

local DiscordLabel = Instance.new("TextLabel")
DiscordLabel.Size = UDim2.new(1, 0, 1, 0)
DiscordLabel.BackgroundTransparency = 1
DiscordLabel.Text = "discord for suport vzh2"
DiscordLabel.Font = Theme.FontBold
DiscordLabel.TextSize = 13
DiscordLabel.TextColor3 = Theme.Accent
DiscordLabel.Parent = TopBar

local VersionLabel = Instance.new("TextLabel")
VersionLabel.Size = UDim2.new(0, 200, 1, 0)
VersionLabel.Position = UDim2.new(0, 14, 0, 0)
VersionLabel.BackgroundTransparency = 1
VersionLabel.Text = "Versao beta\nQuarta-feira - 23/09/2026"
VersionLabel.Font = Theme.Font
VersionLabel.TextSize = 11
VersionLabel.TextColor3 = Theme.Accent
VersionLabel.TextXAlignment = Enum.TextXAlignment.Left
VersionLabel.TextYAlignment = Enum.TextYAlignment.Center
VersionLabel.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 26, 0, 26)
CloseBtn.Position = UDim2.new(1, -34, 0.5, -13)
CloseBtn.BackgroundColor3 = Theme.PanelAlt
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "X"
CloseBtn.Font = Theme.FontBold
CloseBtn.TextSize = 13
CloseBtn.TextColor3 = Theme.Text
CloseBtn.AutoButtonColor = false
CloseBtn.Parent = TopBar
local CC = Instance.new("UICorner") CC.CornerRadius = UDim.new(0,6) CC.Parent = CloseBtn
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- SIDEBAR + CONTENT
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 175, 1, -42)
Sidebar.Position = UDim2.new(0, 0, 0, 42)
Sidebar.BackgroundColor3 = Theme.Sidebar
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main
local SC = Instance.new("UICorner") SC.CornerRadius = UDim.new(0, 10) SC.Parent = Sidebar

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -185, 1, -54)
Content.Position = UDim2.new(0, 180, 0, 48)
Content.BackgroundColor3 = Theme.Panel
Content.BorderSizePixel = 0
Content.Parent = Main
local CC2 = Instance.new("UICorner") CC2.CornerRadius = UDim.new(0, 8) CC2.Parent = Content

-- DRAG
do
    local dragging, dragStart, startPos
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = Main.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if not dragging then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
            local d = input.Position - dragStart
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X,
                                       startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end)
end

-- ABAS
local Tabs = {}
local ActiveTab = nil
local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.Padding = UDim.new(0, 2)
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SidebarLayout.Parent = Sidebar
local SP = Instance.new("UIPadding") SP.PaddingTop = UDim.new(0, 10) SP.Parent = Sidebar

local ICONS = {
    AutoFarm="AF", Lixeiro="LX", Pesca="PS",
    Combat="CB", ESP="ESP", Armas="AR", Aimbot="AB",
    Troll="TR", Diversos="DV", Players="PL",
    Emprego="EM", Veiculo="VC", Tempo="TP",
    TP="TPV", Config="CFG",
}

local function RegisterTab(name, isHeader)
    if isHeader then
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, -20, 0, 22)
        lbl.BackgroundTransparency = 1
        lbl.Text = name
        lbl.Font = Theme.Font
        lbl.TextSize = 12
        lbl.TextColor3 = Theme.TextDim
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = Sidebar
        return
    end

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -16, 0, 30)
    btn.BackgroundColor3 = Theme.Sidebar
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    btn.Text = ""
    btn.Parent = Sidebar
    local bc = Instance.new("UICorner") bc.CornerRadius = UDim.new(0,6) bc.Parent = btn

    local icon = Instance.new("TextLabel")
    icon.Size = UDim2.new(0, 26, 1, 0)
    icon.Position = UDim2.new(0, 6, 0, 0)
    icon.BackgroundTransparency = 1
    icon.Text = ICONS[name] or "•"
    icon.Font = Theme.FontBold
    icon.TextSize = 11
    icon.TextColor3 = Theme.Accent
    icon.Parent = btn

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -38, 1, 0)
    label.Position = UDim2.new(0, 32, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.Font = Theme.Font
    label.TextSize = 13
    label.TextColor3 = Theme.Text
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = btn

    local indicator = Instance.new("Frame")
    indicator.Size = UDim2.new(0, 3, 0.6, 0)
    indicator.Position = UDim2.new(1, -3, 0.2, 0)
    indicator.BackgroundColor3 = Theme.Accent
    indicator.BorderSizePixel = 0
    indicator.Visible = false
    indicator.Parent = btn

    local frame = Instance.new("ScrollingFrame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    frame.ScrollBarThickness = 4
    frame.ScrollBarImageColor3 = Theme.Accent
    frame.CanvasSize = UDim2.new(0, 0, 0, 0)
    frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    frame.Visible = false
    frame.Parent = Content
    local pad = Instance.new("UIPadding")
    pad.PaddingTop = UDim.new(0, 10)
    pad.PaddingLeft = UDim.new(0, 12)
    pad.PaddingRight = UDim.new(0, 12)
    pad.PaddingBottom = UDim.new(0, 10)
    pad.Parent = frame
    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = frame

    local function select()
        if ActiveTab then
            ActiveTab.frame.Visible = false
            ActiveTab.btn.BackgroundColor3 = Theme.Sidebar
            ActiveTab.indicator.Visible = false
        end
        frame.Visible = true
        btn.BackgroundColor3 = Theme.PanelAlt
        indicator.Visible = true
        ActiveTab = { frame = frame, btn = btn, indicator = indicator }
    end

    btn.MouseEnter:Connect(function()
        if not ActiveTab or ActiveTab.btn ~= btn then
            TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = Theme.Panel }):Play()
        end
    end)
    btn.MouseLeave:Connect(function()
        if not ActiveTab or ActiveTab.btn ~= btn then
            TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = Theme.Sidebar }):Play()
        end
    end)
    btn.MouseButton1Click:Connect(select)
    Tabs[name] = { button = btn, frame = frame, select = select }
    return frame
end

-- COMPONENTES
local C = {}

function C.Section(parent, text, order)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 26)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.Font = Theme.FontBold
    lbl.TextSize = 13
    lbl.TextColor3 = Theme.Text
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.LayoutOrder = order or 0
    lbl.Parent = parent
end

function C.Button(parent, text, callback, order)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.BackgroundColor3 = Theme.PanelAlt
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    btn.Text = text
    btn.Font = Theme.Font
    btn.TextSize = 13
    btn.TextColor3 = Theme.Text
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.LayoutOrder = order or 0
    btn.Parent = parent
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0,6) c.Parent = btn
    local p = Instance.new("UIPadding") p.PaddingLeft = UDim.new(0, 12) p.Parent = btn
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = Theme.AccentDark }):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), { BackgroundColor3 = Theme.PanelAlt }):Play()
    end)
    btn.MouseButton1Click:Connect(function() if callback then callback() end end)
end

function C.Toggle(parent, text, default, callback, order)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 32)
    row.BackgroundTransparency = 1
    row.LayoutOrder = order or 0
    row.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -60, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.Font = Theme.Font
    lbl.TextSize = 13
    lbl.TextColor3 = Theme.Text
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = row

    local switch = Instance.new("Frame")
    switch.Size = UDim2.new(0, 40, 0, 20)
    switch.Position = UDim2.new(1, -40, 0.5, -10)
    switch.BackgroundColor3 = Theme.PanelAlt
    switch.BorderSizePixel = 0
    switch.Parent = row
    local sc2 = Instance.new("UICorner") sc2.CornerRadius = UDim.new(1,0) sc2.Parent = switch

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = UDim2.new(0, 2, 0.5, -8)
    knob.BackgroundColor3 = Color3.fromRGB(230,230,235)
    knob.BorderSizePixel = 0
    knob.Parent = switch
    local kc = Instance.new("UICorner") kc.CornerRadius = UDim.new(1,0) kc.Parent = knob

    local state = default and true or false
    local function render()
        TweenService:Create(switch, TweenInfo.new(0.2), {
            BackgroundColor3 = state and Theme.Accent or Theme.PanelAlt
        }):Play()
        TweenService:Create(knob, TweenInfo.new(0.2), {
            Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
        }):Play()
    end
    render()

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.Parent = row
    btn.MouseButton1Click:Connect(function()
        state = not state
        render()
        if callback then callback(state) end
    end)
end

function C.Slider(parent, text, minV, maxV, default, callback, order)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 44)
    row.BackgroundTransparency = 1
    row.LayoutOrder = order or 0
    row.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -60, 0, 18)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.Font = Theme.Font
    lbl.TextSize = 13
    lbl.TextColor3 = Theme.Text
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = row

    local valLbl = Instance.new("TextLabel")
    valLbl.Size = UDim2.new(0, 50, 0, 18)
    valLbl.Position = UDim2.new(1, -50, 0, 0)
    valLbl.BackgroundTransparency = 1
    valLbl.Text = tostring(default)
    valLbl.Font = Theme.Font
    valLbl.TextSize = 13
    valLbl.TextColor3 = Theme.Text
    valLbl.TextXAlignment = Enum.TextXAlignment.Right
    valLbl.Parent = row

    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, 0, 0, 6)
    track.Position = UDim2.new(0, 0, 1, -14)
    track.BackgroundColor3 = Theme.PanelAlt
    track.BorderSizePixel = 0
    track.Parent = row
    local tc = Instance.new("UICorner") tc.CornerRadius = UDim.new(1,0) tc.Parent = track

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(0, 0, 1, 0)
    fill.BackgroundColor3 = Theme.Accent
    fill.BorderSizePixel = 0
    fill.Parent = track
    local fc = Instance.new("UICorner") fc.CornerRadius = UDim.new(1,0) fc.Parent = fill

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.AnchorPoint = Vector2.new(0.5, 0.5)
    knob.Position = UDim2.new(0, 0, 0.5, 0)
    knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
    knob.BorderSizePixel = 0
    knob.Parent = track
    local kc2 = Instance.new("UICorner") kc2.CornerRadius = UDim.new(1,0) kc2.Parent = knob

    local value = default
    local function setValue(v, fire)
        value = math.clamp(v, minV, maxV)
        local alpha = (value - minV) / (maxV - minV)
        fill.Size = UDim2.new(alpha, 0, 1, 0)
        knob.Position = UDim2.new(alpha, 0, 0.5, 0)
        valLbl.Text = tostring(math.floor(value))
        if fire and callback then callback(value) end
    end
    setValue(default, false)

    local dragging = false
    local function updateFromInput(input)
        local rel = (input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X
        setValue(minV + rel * (maxV - minV), true)
    end
    track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateFromInput(input)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then
            updateFromInput(input)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end)
end

function C.TextBox(parent, placeholder, default, callback, order)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(1, 0, 0, 32)
    box.BackgroundColor3 = Theme.PanelAlt
    box.BorderSizePixel = 0
    box.Text = default or ""
    box.PlaceholderText = placeholder or ""
    box.PlaceholderColor3 = Theme.TextDim
    box.Font = Theme.Font
    box.TextSize = 13
    box.TextColor3 = Theme.Text
    box.TextXAlignment = Enum.TextXAlignment.Left
    box.ClearTextOnFocus = false
    box.LayoutOrder = order or 0
    box.Parent = parent
    local c = Instance.new("UICorner") c.CornerRadius = UDim.new(0,6) c.Parent = box
    local p = Instance.new("UIPadding") p.PaddingLeft = UDim.new(0, 10) p.Parent = box
    box.FocusLost:Connect(function()
        if callback then callback(box.Text) end
    end)
end

function C.Dropdown(parent, text, options, defaultIdx, callback, order)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 0, 32)
    row.BackgroundTransparency = 1
    row.LayoutOrder = order or 0
    row.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.5, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.Font = Theme.Font
    lbl.TextSize = 13
    lbl.TextColor3 = Theme.Text
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = row

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.5, 0, 1, 0)
    btn.Position = UDim2.new(0.5, 0, 0, 0)
    btn.BackgroundColor3 = Theme.PanelAlt
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    btn.Text = options[defaultIdx or 1]
    btn.Font = Theme.Font
    btn.TextSize = 12
    btn.TextColor3 = Theme.Text
    btn.Parent = row
    local bc = Instance.new("UICorner") bc.CornerRadius = UDim.new(0,6) bc.Parent = btn

    local idx = defaultIdx or 1
    local open = false
    local list

    local function close()
        if list then list:Destroy(); list = nil end
        open = false
    end

    btn.MouseButton1Click:Connect(function()
        if open then close() return end
        open = true
        list = Instance.new("Frame")
        list.Size = UDim2.new(0.5, 0, 0, #options * 22 + 6)
        list.Position = UDim2.new(0.5, 0, 1, 2)
        list.BackgroundColor3 = Theme.Panel
        list.BorderSizePixel = 0
        list.ZIndex = 10
        list.Parent = row
        local lc = Instance.new("UICorner") lc.CornerRadius = UDim.new(0,6) lc.Parent = list
        local ll = Instance.new("UIListLayout") ll.Padding = UDim.new(0,2) ll.Parent = list
        local lp = Instance.new("UIPadding") lp.PaddingTop = UDim.new(0,3) lp.Parent = list

        for i, opt in ipairs(options) do
            local o = Instance.new("TextButton")
            o.Size = UDim2.new(1, 0, 0, 20)
            o.BackgroundColor3 = Theme.Panel
            o.BorderSizePixel = 0
            o.Text = opt
            o.Font = Theme.Font
            o.TextSize = 12
            o.TextColor3 = Theme.Text
            o.ZIndex = 11
            o.Parent = list
            o.MouseButton1Click:Connect(function()
                idx = i
                btn.Text = opt
                close()
                if callback then callback(opt, i) end
            end)
        end
    end)
end

-- RESPONSIVIDADE
local function ApplyResponsive()
    local vp = workspace.CurrentCamera.ViewportSize
    local isMobile = UserInputService.TouchEnabled and (vp.X < 900 or vp.Y < 500)
    if isMobile then
        Main.Size = UDim2.new(0, math.min(440, vp.X - 20), 0, math.min(360, vp.Y - 20))
        Main.Position = UDim2.new(0.5, -Main.Size.X.Offset/2, 0.5, -Main.Size.Y.Offset/2)
        Sidebar.Size = UDim2.new(0, 130, 1, -42)
        Content.Size = UDim2.new(1, -140, 1, -54)
        Content.Position = UDim2.new(0, 135, 0, 48)
    else
        Main.Size = UDim2.new(0, 780, 0, 460)
        Main.Position = UDim2.new(0.5, -390, 0.5, -230)
        Sidebar.Size = UDim2.new(0, 175, 1, -42)
        Content.Size = UDim2.new(1, -185, 1, -54)
        Content.Position = UDim2.new(0, 180, 0, 48)
    end
end
ApplyResponsive()
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(ApplyResponsive)

-- ============================================================
-- ABAS
-- ============================================================

Regi
