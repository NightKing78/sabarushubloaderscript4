-- ARHAM'S PRIVATE INTERNAL HUB
-- Key: aru

local CorrectKey = "aru"

-- 1. KEY SYSTEM
local KeyGui = Instance.new("ScreenGui")
local KeyMain = Instance.new("Frame")
local KeyInput = Instance.new("TextBox")
local KeyCheck = Instance.new("TextButton")
local KeyTitle = Instance.new("TextLabel")

KeyGui.Parent = game.CoreGui
KeyMain.Size = UDim2.new(0, 300, 0, 180)
KeyMain.Position = UDim2.new(0.5, -150, 0.5, -90)
KeyMain.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
KeyMain.Active = true; KeyMain.Draggable = true
Instance.new("UICorner", KeyMain)

KeyTitle.Parent = KeyMain; KeyTitle.Text = "SYSTEM ACCESS"; KeyTitle.Size = UDim2.new(1, 0, 0, 50); KeyTitle.TextColor3 = Color3.new(1,1,1); KeyTitle.TextSize = 20; KeyTitle.Font = Enum.Font.SourceSansBold; KeyTitle.BackgroundTransparency = 1
KeyInput.Parent = KeyMain; KeyInput.PlaceholderText = "Enter Key..."; KeyInput.Size = UDim2.new(0.8, 0, 0, 40); KeyInput.Position = UDim2.new(0.1, 0, 0.35, 0); KeyInput.BackgroundColor3 = Color3.fromRGB(35, 35, 40); KeyInput.TextColor3 = Color3.new(1,1,1)
KeyCheck.Parent = KeyMain; KeyCheck.Text = "VERIFY"; KeyCheck.Size = UDim2.new(0.8, 0, 0, 40); KeyCheck.Position = UDim2.new(0.1, 0, 0.65, 0); KeyCheck.BackgroundColor3 = Color3.fromRGB(0, 150, 255); KeyCheck.TextColor3 = Color3.new(1,1,1); KeyCheck.Font = Enum.Font.SourceSansBold

KeyCheck.MouseButton1Click:Connect(function()
    if KeyInput.Text == CorrectKey then
        KeyGui:Destroy()
        
        -- START MAIN SCRIPT
        local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
        
        -- GALAXY VISUALS
        local function ApplyGalaxy()
            local L = game:GetService("Lighting")
            for _, v in pairs(L:GetChildren()) do if v:IsA("Sky") then v:Destroy() end end
            local S = Instance.new("Sky")
            S.Parent = L; S.SkyboxBk = "rbxassetid://159454299"; S.SkyboxDn = "rbxassetid://159454286"; S.SkyboxFt = "rbxassetid://159454293"; S.SkyboxLf = "rbxassetid://159454296"; S.SkyboxRt = "rbxassetid://159454289"; S.SkyboxUp = "rbxassetid://159454300"
            L.OutdoorAmbient = Color3.fromRGB(150, 0, 255)
        end
        ApplyGalaxy()

        local Window = Library.CreateLib("ARHAM'S AMBITIOUS SAB", "DarkTheme")

        -- --- INTERNAL TRADE EXPLOIT LOGIC ---
        local function FireTrade(action)
            local RS = game:GetService("ReplicatedStorage")
            -- Scans for any remote with "Trade" in the name
            for _, v in pairs(RS:GetDescendants()) do
                if v:IsA("RemoteEvent") and (v.Name:find("Trade") or v.Name:find("Remote")) then
                    if action == "Freeze" then
                        game:GetService("RunService").Heartbeat:Connect(function() v:FireServer("Accept", true) end)
                    elseif action == "Force" then
                        v:FireServer("AddAll")
                        v:FireServer("Confirm")
                    end
                end
            end
        end

        -- TABS
        local ExpTab = Window:NewTab("Exploits")
        local ExpSection = ExpTab:NewSection("Trade Control Panel")

        ExpSection:NewButton("OPEN TRADE CONTROL PANEL", "Original Blue/Red/Purple Layout", function()
            local TradeGui = Instance.new("ScreenGui"); TradeGui.Parent = game.CoreGui
            local Frame = Instance.new("Frame"); Frame.Size = UDim2.new(0, 260, 0, 220); Frame.Position = UDim2.new(0.5, -130, 0.5, -110); Frame.BackgroundColor3 = Color3.fromRGB(10, 10, 15); Frame.Active = true; Frame.Draggable = true; Frame.Parent = TradeGui
            Instance.new("UICorner", Frame)

            local function NewBtn(txt, col, pos, act)
                local b = Instance.new("TextButton"); b.Text = txt; b.Size = UDim2.new(0.9, 0, 0, 45); b.Position = pos; b.BackgroundColor3 = col; b.TextColor3 = Color3.new(1,1,1); b.Font = "SourceSansBold"; b.Parent = Frame
                Instance.new("UICorner", b)
                b.MouseButton1Click:Connect(function() 
                    b.Text = txt .. " : ACTIVE"
                    FireTrade(act) 
                end)
            end

            NewBtn("AUTO ACCEPT", Color3.fromRGB(0, 100, 255), UDim2.new(0.05, 0, 0.1, 0), "Force")
            NewBtn("FREEZE TRADE MODE", Color3.fromRGB(200, 40, 60), UDim2.new(0.05, 0, 0.4, 0), "Freeze")
            NewBtn("FORCE GIVE ALL BRAINROT", Color3.fromRGB(120, 40, 200), UDim2.new(0.05, 0, 0.7, 0), "Force")
        end)

        local AdminTab = Window:NewTab("Admin")
        AdminTab:NewSection("Player Selection"):NewButton("Open Admin List", "Instant Block players", function()
            local AG = Instance.new("ScreenGui"); AG.Parent = game.CoreGui
            local AF = Instance.new("Frame"); AF.Size = UDim2.new(0, 300, 0, 300); AF.Position = UDim2.new(0.5, 150, 0.5, -150); AF.BackgroundColor3 = Color3.fromRGB(25, 25, 30); AF.Active = true; AF.Draggable = true; AF.Parent = AG
            local AS = Instance.new("ScrollingFrame"); AS.Size = UDim2.new(1, -20, 1, -50); AS.Position = UDim2.new(0, 10, 0, 40); AS.BackgroundTransparency = 1; AS.Parent = AF; AS.AutomaticCanvasSize = "Y"
            local AL = Instance.new("UIListLayout"); AL.Parent = AS; AL.Padding = UDim.new(0, 5)

            local function Refresh()
                for _, v in pairs(AS:GetChildren()) do if v:IsA("Frame") then v:Destroy() end end
                for _, p in pairs(game.Players:GetPlayers()) do
                    if p ~= game.Players.LocalPlayer then
                        local r = Instance.new("Frame"); r.Size = UDim2.new(1, 0, 0, 35); r.BackgroundColor3 = Color3.fromRGB(40, 40, 45); r.Parent = AS
                        local l = Instance.new("TextLabel"); l.Text = p.DisplayName; l.Size = UDim2.new(0.6, 0, 1, 0); l.TextColor3 = Color3.new(1,1,1); l.BackgroundTransparency = 1; l.Parent = r
                        local b = Instance.new("TextButton"); b.Text = "BLOCK"; b.Size = UDim2.new(0.3, 0, 0.8, 0); b.Position = UDim2.new(0.65, 0, 0.1, 0); b.BackgroundColor3 = Color3.fromRGB(180, 0, 0); b.TextColor3 = Color3.new(1,1,1); b.Parent = r
                        b.MouseButton1Click:Connect(function() game:GetService("StarterGui"):SetCore("PromptBlockPlayer", p) end)
                    end
                end
            end
            Refresh(); game.Players.PlayerAdded:Connect(Refresh)
        end)

        local ProtSection = ExpTab:NewSection("Protection")
        ProtSection:NewToggle("Auto-Kick on Steal", "Safety Exit", function(s)
            _G.AutoK = s
            game.Players.LocalPlayer.Backpack.ChildAdded:Connect(function() if _G.AutoK then task.wait(0.05); game.Players.LocalPlayer:Kick("SECURED") end end)
        end)

        Window:NewTab("Movement"):NewSection("Speed"):NewSlider("Speed", "WalkSpeed", 500, 16, function(s) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s end)

        Library:Notify("ARHAM PRIVATE", "Hub Loaded. Access Granted.", Color3.fromRGB(0, 255, 100))
    else
        KeyInput.Text = ""; KeyInput.PlaceholderText = "INVALID KEY"; KeyInput.PlaceholderColor3 = Color3.new(1, 0, 0)
    end
end)
