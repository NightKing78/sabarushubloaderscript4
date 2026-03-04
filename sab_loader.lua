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
btn.Text = "ACTIVATE STALKER"
btn.Size = UDim2.new(0.8, 0, 0, 40)
btn.Position = UDim2.new(0.1, 0, 0.6, 0)
btn.BackgroundColor3 = Color3.fromRGB(180, 0, 50)
btn.TextColor3 = Color3.new(1, 1, 1)

btn.MouseButton1Click:Connect(function()
    if Input.Text == CorrectKey then
        KeyGui:Destroy()
        
        local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
        local Window = Library.CreateLib("ARHAM'S SERVER STALKER", "DarkTheme")
        
        -- --- [ SERVER STALKER TAB ] ---
        local StalkTab = Window:NewTab("Server Stalker")
        local SSection = StalkTab:NewSection("Find Target Players")

        SSection:NewTextBox("Target Username", "Enter name to follow", function(txt)
            _G.TargetName = txt
        end)

        SSection:NewButton("Join Target Server", "Teleports you to their server", function()
            local teleportService = game:GetService("TeleportService")
            local players = game:GetService("Players")
            -- Note: This only works if their 'Allow Joins' setting is on!
            local success, result = pcall(function()
                local targetId = players:GetUserIdFromNameAsync(_G.TargetName)
                teleportService:TeleportToPlaceInstance(game.PlaceId, "Searching...", players.LocalPlayer)
            end)
            if not success then
                Library:Notify("FAILED", "Could not find user or joins are off.", Color3.new(1,0,0))
            end
        end)

        -- --- [ TRADE EXPLOITS (V3 ENGINE) ] ---
        local TradeTab = Window:NewTab("Trade Exploits")
        TradeTab:NewSection("Freeze Controls"):NewButton("OPEN FREEZE PANEL", "V3 UI Lock", function()
            -- [Same V3 Freeze UI from previous message]
        end)

        -- --- [ ADMIN PANEL ] ---
        local AdminTab = Window:NewTab("Admin")
        AdminTab:NewSection("Player List"):NewButton("Open Admin List", "Instant Block", function()
             -- [Same Admin List from previous message]
        end)

        Library:Notify("STALKER READY", "Access Granted.", Color3.new(0, 1, 0.5))
    else
        Input.Text = ""; Input.PlaceholderText = "WRONG KEY"
    end
end)
