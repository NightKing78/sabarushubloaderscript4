-- [[ XENO V8.7 - RE-DESIGNED EDITION ]] --
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- EXPLOIT DETECTION POPUP
local function ShowDetectionPopup()
    local executor = (identifyexecutor and identifyexecutor()) or "Delta"
    local screen = Instance.new("ScreenGui", player.PlayerGui)
    local popup = Instance.new("TextLabel", screen)
    popup.Size = UDim2.new(0, 300, 0, 50)
    popup.Position = UDim2.new(0.5, -150, 0, -60)
    popup.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    popup.TextColor3 = Color3.new(1, 1, 1)
    popup.Text = executor .. " Detected! Loading Xeno..."
    popup.Font = Enum.Font.GothamBold
    popup.TextSize = 16
    Instance.new("UICorner", popup)
    Instance.new("UIStroke", popup).Color = Color3.fromRGB(218, 165, 32)
    
    popup:TweenPosition(UDim2.new(0.5, -150, 0.1, 0), "Out", "Back", 0.5)
    task.wait(2)
    popup:TweenPosition(UDim2.new(0.5, -150, 0, -60), "In", "Quad", 0.5)
    task.delay(0.6, function() screen:Destroy() end)
end

ShowDetectionPopup()

-- UI CLEANING
if player.PlayerGui:FindFirstChild("XenoUltimate") then player.PlayerGui.XenoUltimate:Destroy() end
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "XenoUltimate"
gui.ResetOnSpawn = false

-- MAIN FRAME (CHILLI HUB STYLE)
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 550, 0, 380)
main.Position = UDim2.new(0.5, -275, 0.5, -190)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 8)
local mainStroke = Instance.new("UIStroke", main)
mainStroke.Color = Color3.fromRGB(45, 45, 45)
mainStroke.Thickness = 1.5

-- SIDEBAR (NAVIGATION)
local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0, 150, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel", sidebar)
title.Text = "Xeno V8.7"
title.Size = UDim2.new(1, 0, 0, 50)
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.BackgroundTransparency = 1

-- POPUP NOTIFICATION SYSTEM
local function ShowStatusPopup(name, state)
    local p = Instance.new("Frame", main)
    p.Size = UDim2.new(0, 200, 0, 40)
    p.Position = UDim2.new(0.5, -100, 0.5, -20)
    p.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    p.ZIndex = 10
    Instance.new("UICorner", p)
    local l = Instance.new("TextLabel", p)
    l.Size = UDim2.new(1, 0, 1, 0)
    l.BackgroundTransparency = 1
    l.TextColor3 = state and Color3.new(0.2, 1, 0.2) or Color3.new(1, 0.2, 0.2)
    l.Text = name .. (state and " Enabled!" or " Disabled!")
    l.Font = Enum.Font.GothamBold
    task.delay(1, function() p:Destroy() end)
end

-- CONTAINER FOR CONTENT
local container = Instance.new("ScrollingFrame", main)
container.Size = UDim2.new(1, -160, 1, -20)
container.Position = UDim2.new(0, 155, 0, 10)
container.BackgroundTransparency = 1
container.CanvasSize = UDim2.new(0, 0, 2, 0)
container.ScrollBarThickness = 0
local list = Instance.new("UIListLayout", container)
list.Padding = UDim.new(0, 10)

-- [[ TOGGLE BUTTON BUILDER (CHILLI HUB STYLE) ]] --
local Toggles = {}
local function CreateToggle(name, defaultKey)
    local frame = Instance.new("Frame", container)
    frame.Size = UDim2.new(0.95, 0, 0, 50)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Instance.new("UICorner", frame)

    local label = Instance.new("TextLabel", frame)
    label.Text = "  " .. name .. (defaultKey and " ["..defaultKey.."]" or "")
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.TextColor3 = Color3.new(0.8, 0.8, 0.8)
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = "Left"
    label.BackgroundTransparency = 1

    local switch = Instance.new("TextButton", frame)
    switch.Size = UDim2.new(0, 40, 0, 20)
    switch.Position = UDim2.new(1, -50, 0.5, -10)
    switch.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    switch.Text = ""
    Instance.new("UICorner", switch).CornerRadius = UDim.new(1, 0)

    local circle = Instance.new("Frame", switch)
    circle.Size = UDim2.new(0, 16, 0, 16)
    circle.Position = UDim2.new(0, 2, 0.5, -8)
    circle.BackgroundColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)

    local function toggle()
        Toggles[name] = not Toggles[name]
        ShowStatusPopup(name, Toggles[name])
        TweenService:Create(circle, TweenInfo.new(0.2), {Position = Toggles[name] and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)}):Play()
        TweenService:Create(switch, TweenInfo.new(0.2), {BackgroundColor3 = Toggles[name] and Color3.fromRGB(0, 120, 255) or Color3.fromRGB(60, 60, 60)}):Play()
    end
    switch.MouseButton1Click:Connect(toggle)
    if defaultKey then
        UIS.InputBegan:Connect(function(i, c) if not c and i.KeyCode == Enum.KeyCode[defaultKey] then toggle() end end)
    end
end

-- [[ RE-ORGANIZED SECTIONS ]] --
CreateToggle("Smooth Fly", "K")
CreateToggle("Speed Hack", "J")
CreateToggle("Infinite Jump")
CreateToggle("Noclip", "N")

-- GAMEPASS FUCKER
local gpf = Instance.new("TextButton", container)
gpf.Size = UDim2.new(0.95, 0, 0, 50)
gpf.BackgroundColor3 = Color3.fromRGB(40, 20, 20)
gpf.Text = "LOAD GAMEPASS FUCKER"
gpf.TextColor3 = Color3.new(1, 0.3, 0.3)
gpf.Font = Enum.Font.GothamBold
Instance.new("UICorner", gpf)
gpf.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/IcantAffordSynapse/productfka/refs/heads/main/works.lua"))()
end)

-- HUB BUTTONS
local function CreateHub(name, url)
    local b = Instance.new("TextButton", container)
    b.Size = UDim2.new(0.95, 0, 0, 45)
    b.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    b.Text = "Load " .. name
    b.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() loadstring(game:HttpGet(url))() end)
end

CreateHub("SPONGE DUEL", "https://raw.githubusercontent.com/SpongeScriptsorg/Sponge-hub-duel/refs/heads/main/Sponge%20hub%20duel")
CreateHub("VINX DUEL", "https://raw.githubusercontent.com/Vinx-Hub/SAB/refs/heads/main/loader")

-- [[ UPGRADED FLY & LOGIC ]] --
local flySpeed = 50
RunService.RenderStepped:Connect(function()
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    local root = player.Character.HumanoidRootPart
    
    if Toggles["Speed Hack"] then player.Character.Humanoid.WalkSpeed = 100 end
    
    if Toggles["Smooth Fly"] then
        root.Velocity = Vector3.new(0, 0.1, 0) -- Anti-Fall
        local move = Vector3.new(0,0,0)
        if UIS:IsKeyDown(Enum.KeyCode.W) then move = move + camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then move = move - camera.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then move = move - camera.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then move = move + camera.CFrame.RightVector end
        root.CFrame = root.CFrame + (move * (flySpeed/100))
    end

    if Toggles["Noclip"] then
        for _, v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)

UIS.JumpRequest:Connect(function()
    if Toggles["Infinite Jump"] then player.Character.Humanoid:ChangeState(3) end
end)

-- DRAG & TOGGLE [Z]
local dragging, dragInput, dragStart, startPos
main.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true; dragStart = i.Position; startPos = main.Position end end)
UIS.InputChanged:Connect(function(i) if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
    local delta = i.Position - dragStart
    main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end end)
UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
UIS.InputBegan:Connect(function(i, c) if not c and i.KeyCode == Enum.KeyCode.Z then main.Visible = not main.Visible end end)
