local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "Cryless Hub | Roblox Edition", 
    HidePremium = true, 
    SaveConfig = false, 
    IntroText = "Loading Cryless Hub..."
})

_G.AutoClick = false
local ClickDelay = 0.1
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local MainTab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998"
})

local function startAutoClicker()
    task.spawn(function()
        while _G.AutoClick do
            if LocalPlayer.Character then
                local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
                if tool then
                    tool:Activate()
                end
            end
            task.wait(ClickDelay)
        end
    end)
end

MainTab:AddToggle({
    Name = "Auto-Clicker (Hold Tool)",
    Default = false,
    Callback = function(Value)
        _G.AutoClick = Value
        if Value then
            startAutoClicker()
            OrionLib:MakeNotification({
                Name = "Cryless Hub",
                Content = "Auto-Clicker Enabled (Equip a Tool)",
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

local PlayerTab = Window:MakeTab({
    Name = "Player",
    Icon = "rbxassetid://4483345998"
})

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
