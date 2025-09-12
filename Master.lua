-- Load OrionLib
local OrionLib = https://raw.githubusercontent.com/ZeeZee2Real/shlexware-Orion-main-source/refs/heads/main/gr"))()

-- Create Window with config saving
local Window = OrionLib:MakeWindow({
    Name = "Master v1 | by Master Sweb",
    HidePremium = true,
    SaveConfig = true,
    ConfigFolder = "MasterHub"
})

-- Combat Tab
local CombatTab = Window:MakeTab({
    Name = "Combat",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local CombatSection = CombatTab:AddSection({Name = "Aimbot Features"})

CombatTab:AddToggle({
    Name = "Aimbot",
    Default = false,
    Save = true,
    Flag = "aimbotEnabled",
    Callback = function(value)
        print("Aimbot:", value)
        -- Your aimbot logic here
    end
})

CombatTab:AddToggle({
    Name = "Silent Aim",
    Default = false,
    Save = true,
    Flag = "silentAimEnabled",
    Callback = function(value)
        print("Silent Aim:", value)
    end
})

CombatTab:AddToggle({
    Name = "Legit Aim",
    Default = false,
    Save = true,
    Flag = "legitAimEnabled",
    Callback = function(value)
        print("Legit Aim:", value)
    end
})

CombatTab:AddToggle({
    Name = "Aim Lock",
    Default = false,
    Save = true,
    Flag = "aimLockEnabled",
    Callback = function(value)
        print("Aim Lock:", value)
    end
})

-- Visuals Tab
local VisualsTab = Window:MakeTab({
    Name = "Visuals",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local VisualsSection = VisualsTab:AddSection({Name = "ESP Features"})

VisualsTab:AddToggle({
    Name = "Box ESP",
    Default = false,
    Save = true,
    Flag = "boxESPEnabled",
    Callback = function(value)
        print("Box ESP:", value)
    end
})

VisualsTab:AddToggle({
    Name = "Name ESP",
    Default = false,
    Save = true,
    Flag = "nameESPEnabled",
    Callback = function(value)
        print("Name ESP:", value)
    end
})

VisualsTab:AddToggle({
    Name = "Health ESP",
    Default = false,
    Save = true,
    Flag = "healthESPEnabled",
    Callback = function(value)
        print("Health ESP:", value)
    end
})

VisualsTab:AddToggle({
    Name = "Chams",
    Default = false,
    Save = true,
    Flag = "chamsEnabled",
    Callback = function(value)
        print("Chams:", value)
    end
})

-- Movement Tab
local MovementTab = Window:MakeTab({
    Name = "Movement",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local MovementSection = MovementTab:AddSection({Name = "Player Movement"})

MovementTab:AddSlider({
    Name = "WalkSpeed",
    Min = 16,
    Max = 100,
    Default = 16,
    Increment = 1,
    Save = true,
    Flag = "walkSpeed",
    ValueName = "Speed",
    Callback = function(value)
        print("WalkSpeed:", value)
        local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = value
        end
    end
})

MovementTab:AddSlider({
    Name = "JumpPower",
    Min = 50,
    Max = 200,
    Default = 100,
    Increment = 5,
    Save = true,
    Flag = "jumpPower",
    ValueName = "Power",
    Callback = function(value)
        print("JumpPower:", value)
        local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.JumpPower = value
        end
    end
})

MovementTab:AddToggle({
    Name = "Fly",
    Default = false,
    Save = true,
    Flag = "flyEnabled",
    Callback = function(enabled)
        print("Fly enabled:", enabled)
        -- Add your fly logic here or call a function
    end
})

MovementTab:AddToggle({
    Name = "NoClip",
    Default = false,
    Save = true,
    Flag = "noClipEnabled",
    Callback = function(enabled)
        print("NoClip enabled:", enabled)
        -- Add your noclip logic here or call a function
    end
})

MovementTab:AddToggle({
    Name = "Bunny Hop",
    Default = false,
    Save = true,
    Flag = "bunnyHopEnabled",
    Callback = function(enabled)
        print("BunnyHop enabled:", enabled)
        -- Add your bunny hop logic here or call a function
    end
})

-- Gun Mods Tab
local GunTab = Window:MakeTab({
    Name = "Gun Mods",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local GunSection = GunTab:AddSection({Name = "Weapon Modifications"})

GunTab:AddToggle({
    Name = "No Recoil",
    Default = false,
    Save = true,
    Flag = "noRecoilEnabled",
    Callback = function(value)
        print("No Recoil:", value)
    end
})

GunTab:AddToggle({
    Name = "No Spread",
    Default = false,
    Save = true,
    Flag = "noSpreadEnabled",
    Callback = function(value)
        print("No Spread:", value)
    end
})

GunTab:AddToggle({
    Name = "Infinite Ammo",
    Default = false,
    Save = true,
    Flag = "infiniteAmmoEnabled",
    Callback = function(value)
        print("Infinite Ammo:", value)
    end
})

GunTab:AddToggle({
    Name = "Instant Reload",
    Default = false,
    Save = true,
    Flag = "instantReloadEnabled",
    Callback = function(value)
        print("Instant Reload:", value)
    end
})

GunTab:AddToggle({
    Name = "Rapid Fire",
    Default = false,
    Save = true,
    Flag = "rapidFireEnabled",
    Callback = function(value)
        print("Rapid Fire:", value)
    end
})

-- Exploits Tab
local ExploitTab = Window:MakeTab({
    Name = "Exploits",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local ExploitSection = ExploitTab:AddSection({Name = "Game Manipulation"})

ExploitTab:AddButton({
    Name = "Teleport to Origin",
    Callback = function()
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0)
        end
    end
})

ExploitTab:AddSlider({
    Name = "Hitbox Expander",
    Min = 1,
    Max = 10,
    Default = 1,
    Increment = 1,
    Save = true,
    Flag = "hitboxExpanderValue",
    ValueName = "Size",
    Callback = function(value)
        print("Hitbox Expander Size:", value)
        -- Add your hitbox logic here
    end
})

ExploitTab:AddToggle({
    Name = "Anti-Aim",
    Default = false,
    Save = true,
    Flag = "antiAimEnabled",
    Callback = function(value)
        print("Anti-Aim:", value)
    end
})

ExploitTab:AddToggle({
    Name = "Fake Lag",
    Default = false,
    Save = true,
    Flag = "fakeLagEnabled",
    Callback = function(value)
        print("Fake Lag:", value)
    end
})

-- UI Settings Tab
local SettingsTab = Window:MakeTab({
    Name = "UI Settings",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local SettingsSection = SettingsTab:AddSection({Name = "General"})

SettingsTab:AddBind({
    Name = "Toggle Menu Keybind",
    Default = Enum.KeyCode.RightShift,
    Hold = false,
    Save = true,
    Flag = "toggleMenuKeybind",
    Callback = function()
        Window:Toggle()
    end
})

SettingsTab:AddButton({
    Name = "Destroy UI",
    Callback = function()
        OrionLib:Destroy()
    end
})

-- Initialize UI
OrionLib:Init()

print("Master v1 UI Loaded! Press RightShift to toggle menu")
