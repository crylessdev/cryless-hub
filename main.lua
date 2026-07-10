local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "Cryless Hub | Roblox Edition", 
    HidePremium = true, 
    SaveConfig = false, 
    IntroText = "Loading Cryless Hub..."
})

-- VARIABLES
_G.AutoClick = false
local ClickDelay = 0.1
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- TAB 1: MAIN
local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998"
})

local function startAutoClicker()
    local VirtualInputManager = game:GetService("VirtualInputManager")
    task.spawn(function()
        while _G.AutoClick do
            local camera = workspace.CurrentCamera
            if camera then
                local viewportSize = camera.ViewportSize
                local x = viewportSize.X / 2
                local y = viewportSize.Y / 2

                VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, game, 1)
                task.wait(0.01)
                VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, game, 1)
            end
            task.wait(ClickDelay)
        end
    end)
end

MainTab:AddToggle({
    Name = "Auto-Clicker (Center Screen)",
    Default = false,
    Callback = function(Value)
        _G.AutoClick = Value
        if Value then
            startAutoClicker()
            OrionLib:MakeNotification({
                Name = "Cryless Hub",
                Content = "Auto-Clicker Enabled",
                Image = "rbxassetid://4483345998",
                Time = 2
            })
        else
            OrionLib:MakeNotification({
                Name = "Cryless Hub",
                Content = "Auto-Clicker Disabled",
                Image = "rbxassetid://4483345998",
                Time = 2
            })
        end
    end    
})

-- TAB 2: PLAYER
local PlayerTab = Window:MakeTab({
    Name = "Player",
    Icon = "rbxassetid://4483345998"
})

-- WalkSpeed Slider
PlayerTab:AddSlider({
    Name = "WalkSpeed",
    Min = 16,
    Max = 500,
    Default = 16,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "speed",
    Callback = function(Value)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = Value
        end
    end    
})

-- JumpPower Slider
PlayerTab:AddSlider({
    Name = "JumpPower",
    Min = 50,
    Max = 500,
    Default = 50,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "power",
    Callback = function(Value)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            humanoid.UseJumpPower = true
            humanoid.JumpPower = Value
        end
    end    
})

OrionLib:Init()