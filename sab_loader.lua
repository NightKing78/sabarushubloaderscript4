local CorrectKey = "aru"

-- 1. STABLE LOADER
local KeyGui = Instance.new("ScreenGui", game.CoreGui)
local MainKey = Instance.new("Frame", KeyGui)
MainKey.Size = UDim2.new(0, 300, 0, 160)
MainKey.Position = UDim2.new(0.5, -150, 0.5, -80)
MainKey.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Instance.new("UICorner", MainKey)

local Input = Instance.new("TextBox", MainKey)
Input.PlaceholderText = "ENTER KEY: aru"
Input.Size = UDim2.new(0.8, 0, 0, 40)
Input.Position = UDim2.new(0.1, 0, 0.25, 0)
Input.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Input.TextColor3 = Color3.new(1, 1, 1)

local btn = Instance.new("TextButton", MainKey)
btn.Text = "ACTIVATE SYSTEM"
btn.Size = UDim2.new(0.8, 0, 0, 40)
btn.Position = UDim2.new(0.1, 0, 0.6, 0)
btn.BackgroundColor3 = Color3.fromRGB(180, 0, 50)
btn.TextColor3 = Color3.new(1, 1, 1)

btn.MouseButton1Click:Connect(function()
    if Input.Text == CorrectKey then
        KeyGui:Destroy()
        
        local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
        local Window = Library.CreateLib("ARHAM'S SAB PRIVATE", "DarkTheme")
        
        -- --- [ POWER ENGINE ] ---
        local RS = game:GetService("ReplicatedStorage")
        
        local function GetTradeRemote()
            -- Scans specifically for the event handling "Steal a Brainrot" trades
            return RS:FindFirstChild("Trade", true) or RS:FindFirstChild("Remote", true) or RS:FindFirstChild("TradeRemote", true)
        end

        -- --- [ DUAL PANEL ] ---
        local TradeTab = Window:NewTab("Trade Exploits")
        local TSection = TradeTab:NewSection("Universal Freeze Controls")

        TSection:NewButton("OPEN FREEZE PANEL", "Exact Red/Blue/Purple UI", function()
            local TG = Instance.new("ScreenGui", game.CoreGui)
            local TF = Instance.new("Frame", TG)
            TF.Size = UDim2.new(0, 280, 0, 250); TF.Position = UDim2.new(0.5, -140, 0.5, -125)
            TF.BackgroundColor3 = Color3.fromRGB(5, 5, 10); TF.Active = true; TF.Draggable = true
            Instance.new("UICorner", TF)

            local function CreatePowerBtn(name, col, ypos, mode)
                local b = Instance.new("TextButton", TF)
                b.Text = name; b.Size = UDim2.new(0.9, 0, 0, 50)
                b.Position = UDim2.new(0.05, 0, 0, ypos); b.BackgroundColor3 = col
                b.TextColor3 = Color3.new(1,1,1); b.Font = "SourceSansBold"
                Instance.new("UICorner", b)
                
                b.MouseButton1Click:Connect(function()
                    b.Text = "RUNNING..."
                    local remote = GetTradeRemote()
                    if remote then
                        if mode == "Freeze" then
                            -- High speed but throttled to prevent client lag
                            task.spawn(function()
                                while task.wait(0.1) do -- 0.1 is the safety limit to keep YOUR game smooth
                                    remote:FireServer("Accept", false)
                                    remote:FireServer("Update", {["Locked"] = true})
                                end
                            end)
                        elseif mode == "DualAccept" then
                            task.spawn(function()
                                while task.wait(0.1) do
                                    remote:FireServer("Accept", true)
                                    remote:FireServer("Confirm", true)
                                end
                            end)
                        end
                    end
                end)
            end

            CreatePowerBtn("AUTO TRADE", Color3.fromRGB(0, 120, 255), 20, "DualAccept")
            CreatePowerBtn("FREEZE TRADE MODE", Color3.fromRGB(220, 50, 70), 90, "Freeze")
            CreatePowerBtn("FORCE GIVE ALL", Color3.fromRGB(130, 50, 220), 160, "DualAccept")
        end)

        -- --- [ ADMIN LIST ] ---
        local AdminTab = Window:NewTab("Admin")
        AdminTab:NewSection("Player List"):NewButton("Open Admin List", "Instant Block", function()
            local AG = Instance.new("ScreenGui", game.CoreGui)
            local AF = Instance.new("Frame", AG)
            AF.Size = UDim2.new(0, 300, 0, 300); AF.Position = UDim2.new(0.5, 150, 0.5, -150)
            AF.BackgroundColor3 = Color3.fromRGB(20, 20, 25); AF.Draggable = true; AF.Active = true
            local SC = Instance.new("ScrollingFrame", AF)
            SC.Size = UDim2.new(1, -20, 1, -20); SC.Position = UDim2.new(0, 10, 0, 10)
            SC.BackgroundTransparency = 1; SC.AutomaticCanvasSize = "Y"
            Instance.new("UIListLayout", SC).Padding = UDim.new(0, 5)

            local function Refresh()
                for _, v in pairs(SC:GetChildren()) do if v:IsA("Frame") then v:Destroy() end end
                for _, p in pairs(game.Players:GetPlayers()) do
                    if p ~= game.Players.LocalPlayer then
                        local r = Instance.new("Frame", SC); r.Size = UDim2.new(1, 0, 0, 35); r.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
                        local l = Instance.new("TextLabel", r); l.Text = p.DisplayName; l.Size = UDim2.new(0.6, 0, 1, 0); l.TextColor3 = Color3.new(1,1,1); l.BackgroundTransparency = 1; l.Parent = r
                        local b = Instance.new("TextButton", r); b.Text = "BLOCK"; b.Size = UDim2.new(0.3, 0, 0.8, 0); b.Position = UDim2.new(0.65, 0, 0.1, 0); b.BackgroundColor3 = Color3.fromRGB(200, 0, 0); b.TextColor3 = Color3.new(1,1,1)
                        b.MouseButton1Click:Connect(function() game:GetService("StarterGui"):SetCore("PromptBlockPlayer", p) end)
                    end
                end
            end
            Refresh(); game.Players.PlayerAdded:Connect(Refresh)
        end)

        -- --- [ MISC ] ---
        local Misc = Window:NewTab("Misc")
        Misc:NewSection("Safety"):NewToggle("Auto-Kick on Steal", "Leave instantly", function(s)
            _G.AK = s
            game.Players.LocalPlayer.Backpack.ChildAdded:Connect(function() 
                if _G.AK then task.wait(0.05); game.Players.LocalPlayer:Kick("BRAINROT SECURED!") end 
            end)
        end)
        Misc:NewSection("Speed"):NewSlider("WalkSpeed", "Fast", 500, 16, function(s) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s end)

        Library:Notify("SYSTEM READY", "Key: aru", Color3.new(0, 1, 0))
    else
        Input.Text = ""; Input.PlaceholderText = "WRONG KEY"
    end
end)
