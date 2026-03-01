-- ARHAM'S AMBITIOUS ALL-IN-ONE (PRIVATE VERSION)
-- Key: aru

local CorrectKey = "aru"

-- 1. KEY SYSTEM UI
local KeyGui = Instance.new("ScreenGui")
local KeyMain = Instance.new("Frame")
local KeyInput = Instance.new("TextBox")
local KeyCheck = Instance.new("TextButton")
local KeyTitle = Instance.new("TextLabel")

KeyGui.Parent = game.CoreGui
KeyMain.Size = UDim2.new(0, 300, 0, 180)
KeyMain.Position = UDim2.new(0.5, -150, 0.5, -90)
KeyMain.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
KeyMain.Active = true; KeyMain.Draggable = true
Instance.new("UICorner", KeyMain).CornerRadius = UDim.new(0, 10)

KeyTitle.Parent = KeyMain; KeyTitle.Text = "ARHAM'S PRIVATE HUB"; KeyTitle.Size = UDim2.new(1, 0, 0, 50); KeyTitle.TextColor3 = Color3.new(1,1,1); KeyTitle.BackgroundTransparency = 1; KeyTitle.TextSize = 20; KeyTitle.Font = Enum.Font.SourceSansBold
KeyInput.Parent = KeyMain; KeyInput.PlaceholderText = "Enter Key..."; KeyInput.Size = UDim2.new(0.8, 0, 0, 40); KeyInput.Position = UDim2.new(0.1, 0, 0.35, 0); KeyInput.BackgroundColor3 = Color3.fromRGB(40, 40, 50); KeyInput.TextColor3 = Color3.new(1,1,1)
KeyCheck.Parent = KeyMain; KeyCheck.Text = "UNLOCK"; KeyCheck.Size = UDim2.new(0.8, 0, 0, 40); KeyCheck.Position = UDim2.new(0.1, 0, 0.65, 0); KeyCheck.BackgroundColor3 = Color3.fromRGB(0, 120, 255); KeyCheck.TextColor3 = Color3.new(1,1,1); KeyCheck.Font = Enum.Font.SourceSansBold

-- THE MAIN SCRIPT EXECUTION
KeyCheck.MouseButton1Click:Connect(function()
    if KeyInput.Text == CorrectKey then
        KeyGui:Destroy()
        
        -- LOAD LIBRARY
        local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
        
        -- GALAXY VISUALS
        local function ApplyGalaxy()
            local Lighting = game:GetService("Lighting")
            for _, v in pairs(Lighting:GetChildren()) do if v:IsA("Sky") then v:Destroy() end end
            local Sky = Instance.new("Sky")
            Sky.Name = "GalaxySky"; Sky.Parent = Lighting
            Sky.SkyboxBk = "rbxassetid://159454299"; Sky.SkyboxDn = "rbxassetid://159454286"
            Sky.SkyboxFt = "rbxassetid://159454293"; Sky.SkyboxLf = "rbxassetid://159454296"
            Sky.SkyboxRt = "rbxassetid://159454289"; Sky.SkyboxUp = "rbxassetid://159454300"
            Lighting.OutdoorAmbient = Color3.fromRGB(150, 0, 255)
        end
        ApplyGalaxy()

        local Window = Library.CreateLib("ARHAM'S AMBITIOUS SAB", "DarkTheme")

        -- CUSTOM TRADE ENGINE LOGIC
        local function CustomFreeze()
            local RS = game:GetService("ReplicatedStorage")
            local TradeRemotes = {"Trade", "TradeRemote", "AcceptTrade", "UpdateTrade"}
            game:GetService("RunService").Heartbeat:Connect(function()
                for _, name in pairs(TradeRemotes) do
                    local remote = RS:FindFirstChild(name, true)
                    if remote and remote:IsA("RemoteEvent") then
                        remote:FireServer("Accept")
                        remote:FireServer("Lock")
                    end
                end
            end)
        end

        local function CustomForceGive()
            local RS = game:GetService("ReplicatedStorage")
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= game.Players.LocalPlayer then
                    local rem = RS:FindFirstChild("Trade", true) or RS:FindFirstChild("Remote", true)
                    if rem then rem:FireServer("AddAll", p) end
                end
            end
        end

        -- TABS
        local AdminTab = Window:NewTab("Admin Panel")
        local AdminSection = AdminTab:NewSection("Player List (Instant Block)")
        
        AdminSection:NewButton("Open Admin Player List", "Official Roblox Blocking", function()
            local AdminGui = Instance.new("ScreenGui"); AdminGui.Parent = game.CoreGui
            local F = Instance.new("Frame"); F.Size = UDim2.new(0, 300, 0, 350); F.Position = UDim2.new(0.5, 200, 0.5, -175); F.BackgroundColor3 = Color3.fromRGB(30, 30, 40); F.Active = true; F.Draggable = true; F.Parent = AdminGui
            local S = Instance.new("ScrollingFrame"); S.Size = UDim2.new(1, -20, 1, -50); S.Position = UDim2.new(0, 10, 0, 40); S.BackgroundTransparency = 1; S.Parent = F; S.AutomaticCanvasSize = "Y"
            local L = Instance.new("UIListLayout"); L.Parent = S; L.Padding = UDim.new(0, 5)
            
            local function Refresh()
                for _, v in pairs(S:GetChildren()) do if v:IsA("Frame") then v:Destroy() end end
                for _, plr in pairs(game.Players:GetPlayers()) do
                    if plr ~= game.Players.LocalPlayer then
                        local R = Instance.new("Frame"); R.Size = UDim2.new(1, 0, 0, 35); R.BackgroundColor3 = Color3.fromRGB(50, 50, 60); R.Parent = S
                        local T = Instance.new("TextLabel"); T.Text = plr.DisplayName; T.Size = UDim2.new(0.6, 0, 1, 0); T.TextColor3 = Color3.new(1,1,1); T.BackgroundTransparency = 1; T.Parent = R
                        local B = Instance.new("TextButton"); B.Text = "BLOCK"; B.Size = UDim2.new(0.3, 0, 0.8, 0); B.Position = UDim2.new(0.65, 0, 0.1, 0); B.BackgroundColor3 = Color3.fromRGB(200, 0, 0); B.TextColor3 = Color3.new(1,1,1); B.Parent = R
                        B.MouseButton1Click:Connect(function() game:GetService("StarterGui"):SetCore("PromptBlockPlayer", plr) end)
                    end
                end
            end
            Refresh(); game.Players.PlayerAdded:Connect(Refresh); game.Players.PlayerRemoving:Connect(Refresh)
        end)

        local AmbTab = Window:NewTab("Ambitious SAB")
        local TradeSection = AmbTab:NewSection("Trade Exploits")
        
        TradeSection:NewButton("Open Meow Toggle Panel", "Custom Internal Trade Engine", function()
            local MG = Instance.new("ScreenGui"); MG.Parent = game.CoreGui
            local MF = Instance.new("Frame"); MF.Size = UDim2.new(0, 250, 0, 200); MF.Position = UDim2.new(0.5, -125, 0.5, -100); MF.BackgroundColor3 = Color3.fromRGB(15,15,25); MF.Active = true; MF.Draggable = true; MF.Parent = MG
            
            local function CreateBtn(txt, col, pos, func)
                local b = Instance.new("TextButton"); b.Text = txt; b.Size = UDim2.new(0.9, 0, 0, 40); b.Position = pos; b.BackgroundColor3 = col; b.TextColor3 = Color3.new(1,1,1); b.Font = "SourceSansBold"; b.Parent = MF
                Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
                b.MouseButton1Click:Connect(func)
                return b
            end

            CreateBtn("AUTO ACCEPT : ON", Color3.fromRGB(30, 120, 255), UDim2.new(0.05, 0, 0.1, 0), function() Library:Notify("Auto-Accept", "Spamming Accept Remotes...", Color3.new(1,1,1)) end)
            CreateBtn("FREEZE TRADE : ACTIVE", Color3.fromRGB(220, 60, 80), UDim2.new(0.05, 0, 0.4, 0), function() CustomFreeze() end)
            CreateBtn("FORCE GIVE ALL", Color3.fromRGB(130, 60, 220), UDim2.new(0.05, 0, 0.7, 0), function() CustomForceGive() end)
        end)

        local ProtectSection = AmbTab:NewSection("Protection")
        ProtectSection:NewToggle("Auto-Kick on Steal", "Safety Exit", function(state)
            _G.AK = state
            game.Players.LocalPlayer.Backpack.ChildAdded:Connect(function() if _G.AK then task.wait(0.05); game.Players.LocalPlayer:Kick("ITEM SECURED") end end)
        end)

        local MoveSection = Window:NewTab("Movement"):NewSection("Speed")
        MoveSection:NewSlider("WalkSpeed", "Fast", 500, 16, function(s) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s end)

        Library:Notify("SUCCESS", "Arham's Hub Loaded!", Color3.fromRGB(0, 255, 150))
    else
        KeyInput.Text = ""; KeyInput.PlaceholderText = "WRONG KEY!"; KeyInput.PlaceholderColor3 = Color3.new(1,0,0)
    end
end)
