--[[
    Shakshoka Universal Hub 🌍
    UI Inspired by No-Lag Hub (No Shadow)
    Includes Minimize Button + All Tabs + Key System
    Made by ecstacyV2
]]--

local KEY = "shakshokahubsotuffomg54" -- تم تغيير المفتاح هنا
local KEY_LINK = "https://link-center.net/1352313/shubkeyc1" -- رابط المفتاح
local DISCORD_LINK = "https://discord.gg/XyBr7cM77h" -- رابط الديسكورد

local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Create ScreenGui for the whole hub
local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "ShakshokaUniversalHub"
gui.ResetOnSpawn = false

--- Key System UI
local keyFrame = Instance.new("Frame", gui)
keyFrame.Size = UDim2.new(0, 400, 0, 220)
keyFrame.Position = UDim2.new(0.5, -200, 0.5, -110)
keyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
keyFrame.BorderSizePixel = 0
keyFrame.Active = true
keyFrame.Draggable = true
Instance.new("UICorner", keyFrame).CornerRadius = UDim.new(0, 10)

local title = Instance.new("TextLabel", keyFrame)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "Shakshoka Hub - Key System"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextColor3 = Color3.fromRGB(255, 255, 255)

local keyBox = Instance.new("TextBox", keyFrame)
keyBox.Size = UDim2.new(1, -40, 0, 40)
keyBox.Position = UDim2.new(0, 20, 0, 60)
keyBox.PlaceholderText = "Enter your key..."
keyBox.Text = ""
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 14
keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBox.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0, 8)

local getKeyBtn = Instance.new("TextButton", keyFrame)
getKeyBtn.Size = UDim2.new(0.45, -10, 0, 35)
getKeyBtn.Position = UDim2.new(0.05, 0, 0, 120)
getKeyBtn.Text = "Get Key"
getKeyBtn.Font = Enum.Font.GothamBold
getKeyBtn.TextSize = 14
getKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
getKeyBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
Instance.new("UICorner", getKeyBtn).CornerRadius = UDim.new(0, 8)

local submitBtn = Instance.new("TextButton", keyFrame)
submitBtn.Size = UDim2.new(0.45, -10, 0, 35)
submitBtn.Position = UDim2.new(0.5, 10, 0, 120)
submitBtn.Text = "Submit"
submitBtn.Font = Enum.Font.GothamBold
submitBtn.TextSize = 14
submitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
submitBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 60)
Instance.new("UICorner", submitBtn).CornerRadius = UDim.new(0, 8)

-- نسخ رابط المفتاح عند الضغط على "Get Key"
getKeyBtn.MouseButton1Click:Connect(function()
    setclipboard(KEY_LINK)
    StarterGui:SetCore("SendNotification", {
        Title = "Shakshoka Hub",
        Text = "Key link copied to clipboard!",
        Duration = 3
    })
end)

--- Main Hub UI (initially hidden)
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 640, 0, 420)
main.Position = UDim2.new(0.5, -320, 0.5, -210)
main.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Visible = false -- Hidden until key is correct

Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

-- Title Bar
local hubTitle = Instance.new("TextLabel", main)
hubTitle.Size = UDim2.new(1, -90, 0, 50)
hubTitle.Position = UDim2.new(0, 20, 0, 10)
hubTitle.BackgroundTransparency = 1
hubTitle.Text = "Shakshoka Universal Hub"
hubTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
hubTitle.Font = Enum.Font.GothamBlack
hubTitle.TextSize = 22
hubTitle.TextXAlignment = Enum.TextXAlignment.Left

-- Close Button
local closeBtn = Instance.new("TextButton", main)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -40, 0, 10)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 8)
closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Minimize Button
local minimizeBtn = Instance.new("TextButton", main)
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -80, 0, 10)
minimizeBtn.Text = "-"
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0, 8)

local minimized = false
local notificationShown = false -- New variable to track if notification was shown

minimizeBtn.MouseButton1Click:Connect(function()
    minimized = true
    main.Visible = false
    if not notificationShown then -- Show notification only if not already shown
        StarterGui:SetCore("SendNotification", {
            Title = "Shakshoka Hub",
            Text = "Press K to reopen the hub",
            Duration = 4
        })
        notificationShown = true
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.K then
        minimized = not minimized
        main.Visible = not minimized
        if minimized then
            if not notificationShown then -- Show notification only if not already shown
                StarterGui:SetCore("SendNotification", {
                    Title = "Shakshoka Hub",
                    Text = "Press K to reopen the hub",
                    Duration = 4
                })
                notificationShown = true
            end
        else
            notificationShown = false -- Reset when hub is reopened
        end
    end
end)

-- Sidebar
local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0, 150, 1, -70)
sidebar.Position = UDim2.new(0, 0, 0, 60)
sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
sidebar.BorderSizePixel = 0
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 8)

local layout = Instance.new("UIListLayout", sidebar)
layout.Padding = UDim.new(0, 5)
layout.SortOrder = Enum.SortOrder.Name

-- Content Frame
local content = Instance.new("Frame", main)
content.Size = UDim2.new(1, -160, 1, -70)
content.Position = UDim2.new(0, 160, 0, 60)
content.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
content.BorderSizePixel = 0
Instance.new("UICorner", content).CornerRadius = UDim.new(0, 8)

-- Welcome Frame
local welcome = Instance.new("Frame", content)
welcome.Size = UDim2.new(1, 0, 1, 0)
welcome.BackgroundTransparency = 1
welcome.Name = "Welcome"

local wText = Instance.new("TextLabel", welcome)
wText.Size = UDim2.new(1, 0, 0, 50)
wText.Position = UDim2.new(0, 0, 0.4, -30)
wText.Text = "Welcome to Shakshoka Hub!"
wText.TextColor3 = Color3.fromRGB(255, 255, 255)
wText.Font = Enum.Font.GothamBlack
wText.TextSize = 24
wText.BackgroundTransparency = 1

local hint = Instance.new("TextLabel", welcome)
hint.Size = UDim2.new(1, 0, 0, 30)
hint.Position = UDim2.new(0, 0, 0.4, 10)
hint.Text = "(press on the game you want a script for)"
hint.TextColor3 = Color3.fromRGB(180, 180, 180)
hint.Font = Enum.Font.Gotham
hint.TextSize = 14
hint.BackgroundTransparency = 1

-- Button Maker
local function createScriptButton(parent, y, label, link)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Text = label
    btn.AutoButtonColor = true
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    btn.MouseButton1Click:Connect(function()
        StarterGui:SetCore("SendNotification", {
            Title = "Shakshoka Hub",
            Text = "Loading: " .. label,
            Duration = 3
        })
        loadstring(game:HttpGet(link))()
    end)
end

-- All Tabs Data (Alphabetical order)
local tabsData = {
    ["Blade Ball"] = {
        { "British X (keyless)", "https://raw.githubusercontent.com/luascriptsROBLOX/BritishX/refs/heads/main/BladeBall" },
        { "Op Auto Parry (keyless)", "https://raw.githubusercontent.com/SoulSociety982/Voltriage_0.1/refs/heads/main/Best_BladeBall_Script.lua.txt" },
        { "Star Hub (keysystem)", "https://api.luarmor.net/files/v3/loaders/bc25e1f8ef8aa59092de8f8f4c4fb95c.lua" }
    },
    ["Blox Fruits"] = {
        { "Naoki Hub (Keysystem)", "http://45.134.39.193:6324/script" },
        { "Survive Hub (Keysystem)", "https://raw.githubusercontent.com/NUTellaVING/Survive/main/Loader.lua" }
    },
    ["Dead Rails"] = {
        { "Hub (Keysystem)", "https://raw.githubusercontent.com/uniquearchive/railstp/refs/heads/main/luafile" },
        { "Rift Hub (keysystem)", "https://rifton.top/loader.lua" }
    },
    ["Doors"] = {
        { "Doors script (keysystem)", "https://raw.githubusercontent.com/NebulaHubOfc/Public/refs/heads/main/Loader.lua" },
        { "FFJ Hub (keysystem)", "https://raw.githubusercontent.com/FFJ1/Roblox-Exploits/main/scripts/Loader.lua" }
    },
    ["Da Hood"] = {
        { "Azure Modded (keyless)", "https://raw.githubusercontent.com/Actyrn/Scripts/main/AzureModded" }
    },
    ["Grow a Garden"] = {
        { "No-Lag Hub (Keyless)", "https://raw.githubusercontent.com/NoLag-id/No-Lag-HUB/main/Loader/LoaderV1.lua" },
        { "Polleser Hub (Keysystem)", "https://raw.githubusercontent.com/Thebestofhack123/2.0/refs/heads/main/Scripts/GaG" },
        { "Resonance Hub (Keyless)", "https://raw.githubusercontent.com/KaspikScriptsRb/garden/main/.lua" },
        { "Grow a garden script (Keysystem)", "https://raw.githubusercontent.com/stylemakeritosh/Ace/refs/heads/main/Growagarden" },
        { "Shakshoka Hub (Keysystem)", "https://raw.githubusercontent.com/shakshokahubb/Shakshoka/main/loader.lua" }
    }
}

-- Create Tabs & Buttons
for tabName, scripts in pairs(tabsData) do
    local tabFrame = Instance.new("Frame", content)
    tabFrame.Name = tabName
    tabFrame.Size = UDim2.new(1, 0, 1, 0)
    tabFrame.BackgroundTransparency = 1
    tabFrame.Visible = false

    -- Tab Title
    local tabTitle = Instance.new("TextLabel", tabFrame)
    tabTitle.Size = UDim2.new(1, 0, 0, 40)
    tabTitle.Position = UDim2.new(0, 0, 0, 0)
    tabTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    tabTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabTitle.Font = Enum.Font.GothamBold
    tabTitle.TextSize = 18
    tabTitle.Text = tabName
    tabTitle.TextXAlignment = Enum.TextXAlignment.Left
    local padding = Instance.new("UIPadding", tabTitle)
    padding.PaddingLeft = UDim.new(0, 10)

    -- Scrolling Frame for buttons
    local scroll = Instance.new("ScrollingFrame", tabFrame)
    scroll.Position = UDim2.new(0, 0, 0, 40)
    scroll.Size = UDim2.new(1, 0, 1, -40)
    scroll.CanvasSize = UDim2.new(0, 0, 0, (#scripts * 50))
    scroll.ScrollBarThickness = 6
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0

    local y = 10
    for _, scriptInfo in ipairs(scripts) do
        createScriptButton(scroll, y, scriptInfo[1], scriptInfo[2])
        y = y + 50
    end

    local tabBtn = Instance.new("TextButton", sidebar)
    tabBtn.Size = UDim2.new(1, -10, 0, 40)
    tabBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    tabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabBtn.Font = Enum.Font.GothamBold
    tabBtn.TextSize = 16
    tabBtn.Text = tabName
    tabBtn.AutoButtonColor = true
    Instance.new("UICorner", tabBtn).CornerRadius = UDim.new(0, 6)

    tabBtn.MouseButton1Click:Connect(function()
        -- Hide all tabs
        for _, frame in pairs(content:GetChildren()) do
            if frame:IsA("Frame") and frame ~= welcome then
                frame.Visible = false
            end
        end
        welcome.Visible = false
        tabFrame.Visible = true
    end)
end

-- وظيفة لفتح الـ Hub الرئيسي بعد التحقق من المفتاح
local function openMainHub()
    keyFrame:Destroy() -- Destroy the key system UI
    main.Visible = true -- Make the main hub UI visible
    welcome.Visible = true -- Show the welcome tab by default
    StarterGui:SetCore("SendNotification", {
        Title = "Shakshoka Hub",
        Text = "Loaded successfully! Welcome :)",
        Duration = 5
    })
end

-- التحقق من المفتاح عند الضغط على زر Submit
submitBtn.MouseButton1Click:Connect(function()
    if keyBox.Text == KEY then
        StarterGui:SetCore("SendNotification", {
            Title = "Access Granted",
            Text = "Welcome to Shakshoka Hub!",
            Duration = 3
        })
        openMainHub()
    else
        StarterGui:SetCore("SendNotification", {
            Title = "Invalid Key",
            Text = "The key you entered is incorrect.",
            Duration = 3
        })
    end
end)

-- عرض نظام المفتاح بشكل افتراضي عند تشغيل السكربت
keyFrame.Visible = true

-- نسخ رابط الديسكورد عند تنفيذ السكربت لأول مرة
-- هذا الجزء سيعمل مرة واحدة عند بدء تشغيل السكربت
local discordLinkCopiedAtStart = false
if not discordLinkCopiedAtStart then
    setclipboard(DISCORD_LINK)
    StarterGui:SetCore("SendNotification", {
        Title = "Shakshoka Hub",
        Text = "Discord server link copied!",
        Duration = 4
    })
    discordLinkCopiedAtStart = true
end
