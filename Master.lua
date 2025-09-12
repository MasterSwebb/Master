-- Minimal working Orion UI example

-- Wait for the game to load and the LocalPlayer character to exist
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    Players.PlayerAdded:Wait()
    LocalPlayer = Players.LocalPlayer
end

-- Load Orion library (make sure the URL is correct, raw source)
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/ZeeZee2Real/shlexware-Orion-main-source/refs/heads/main/gr"))()
if not OrionLib then
    warn("Failed to load OrionLib")
    return
end

-- Create the main window
local Window = OrionLib:MakeWindow({
    Name = "Master v1 | by Master Sweb",
    HidePremium = true,
    SaveConfig = true,
    ConfigFolder = "MasterHub"
})

-- Example Tab 1: Combat
local CombatTab = Window:MakeTab({
    Name = "Combat",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})
local CombatSection = CombatTab:AddSection({Name = "Combat Options"})

-- Example Toggle
local aimbotEnabled = false
CombatSection:AddToggle({
    Name = "Aimbot",
    Default = false,
    Callback = function(v)
        aimbotEnabled = v
        print("Aimbot toggled:", v)
    end
})

-- Example Button
CombatSection:AddButton({
    Name = "Test Combat Button",
    Callback = function()
        print("Combat Button Pressed")
    end
})

-- Example Tab 2: Movement
local MovementTab = Window:MakeTab({
    Name = "Movement",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})
local MovementSection = MovementTab:AddSection({Name = "Movement Options"})

-- Example Slider
MovementSection:AddSlider({
    Name = "WalkSpeed",
    Min = 16,
    Max = 100,
    Default = 16,
    Color = Color3.fromRGB(255, 255, 255),
    Increment = 1,
    ValueName = "Speed",
    Callback = function(v)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = v
        end
        print("WalkSpeed set to:", v)
    end
})

-- Example Toggle for Jump Power
local jumpPower = 50
MovementSection:AddSlider({
    Name = "JumpPower",
    Min = 50,
    Max = 200,
    Default = 100,
    Color = Color3.fromRGB(255, 255, 255),
    Increment = 5,
    ValueName = "Power",
    Callback = function(v)
        jumpPower = v
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = v
        end
        print("JumpPower set to:", v)
    end
})

-- Finalize init Orion UI
OrionLib:Init()

print("Orion UI should now be visible")
