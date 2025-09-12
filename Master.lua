-- Wait for game and player to load
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer or Players.PlayerAdded:Wait()

-- Load Orion library
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/ZeeZee2Real/shlexware-Orion-main-source/refs/heads/main/gr"))()
assert(OrionLib, "Failed to load Orion Library")

-- Main Window
local Window = OrionLib:MakeWindow({
    Name = "Master v1 | by Master Sweb",
    HidePremium = true,
    SaveConfig = true,
    ConfigFolder = "MasterHub"
})

-- ======= Combat Tab =======
local CombatTab = Window:MakeTab({Name = "Combat", Icon = "rbxassetid://4483345998"})
local CombatSection = CombatTab:AddSection({Name = "Aimbot Features"})

local aimbotEnabled = false
local silentAimEnabled = false
local legitAimEnabled = false
local aimLockEnabled = false
local autoShootEnabled = false
local autoHealEnabled = false
local targetPart = "Head"

CombatSection:AddToggle({Name = "Aimbot", Default = false, Callback = function(v)
    aimbotEnabled = v
    print("Aimbot:", v)
end})

CombatSection:AddToggle({Name = "Silent Aim", Default = false, Callback = function(v)
    silentAimEnabled = v
    print("Silent Aim:", v)
end})

CombatSection:AddToggle({Name = "Legit Aim", Default = false, Callback = function(v)
    legitAimEnabled = v
    print("Legit Aim:", v)
end})

CombatSection:AddToggle({Name = "Aim Lock", Default = false, Callback = function(v)
    aimLockEnabled = v
    print("Aim Lock:", v)
end})

CombatSection:AddToggle({Name = "Auto Shoot", Default = false, Callback = function(v)
    autoShootEnabled = v
    print("Auto Shoot:", v)
end})

CombatSection:AddToggle({Name = "Auto Heal", Default = false, Callback = function(v)
    autoHealEnabled = v
    print("Auto Heal:", v)
end})

CombatSection:AddDropdown({
    Name = "Target Part",
    Default = "Head",
    Options = {"Head", "Torso", "HumanoidRootPart"},
    Callback = function(v)
        targetPart = v
        print("Target Part:", v)
    end
})

-- ======= Visuals Tab =======
local VisualsTab = Window:MakeTab({Name = "Visuals", Icon = "rbxassetid://4483345998"})
local VisualsSection = VisualsTab:AddSection({Name = "ESP Features"})

local boxESPEnabled = false
local nameESPEnabled = false
local healthESPEnabled = false
local chamsEnabled = false
local distanceESPEnabled = false
local espColor = Color3.fromRGB(255, 255, 255)

VisualsSection:AddToggle({Name = "Box ESP", Default = false, Callback = function(v)
    boxESPEnabled = v
    print("Box ESP:", v)
end})

VisualsSection:AddToggle({Name = "Name ESP", Default = false, Callback = function(v)
    nameESPEnabled = v
    print("Name ESP:", v)
end})

VisualsSection:AddToggle({Name = "Health ESP", Default = false, Callback = function(v)
    healthESPEnabled = v
    print("Health ESP:", v)
end})

VisualsSection:AddToggle({Name = "Chams", Default = false, Callback = function(v)
    chamsEnabled = v
    print("Chams:", v)
end})

VisualsSection:AddToggle({Name = "Distance ESP", Default = false, Callback = function(v)
    distanceESPEnabled = v
    print("Distance ESP:", v)
end})

VisualsSection:AddColorPicker({
    Name = "ESP Color",
    Default = espColor,
    Callback = function(color)
        espColor = color
        print("ESP Color:", color)
    end
})

-- ======= Movement Tab =======
local MovementTab = Window:MakeTab({Name = "Movement", Icon = "rbxassetid://4483345998"})
local MovementSection = MovementTab:AddSection({Name = "Player Movement"})

local walkSpeed = 16
local jumpPower = 100
local flyEnabled = false
local noClipEnabled = false
local bunnyHopEnabled = false

MovementSection:AddSlider({
    Name = "WalkSpeed",
    Min = 16,
    Max = 150,
    Default = 16,
    Color = Color3.fromRGB(255, 255, 255),
    Increment = 1,
    ValueName = "Speed",
    Callback = function(v)
        walkSpeed = v
        local char = LocalPlayer.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            char.Humanoid.WalkSpeed = walkSpeed
        end
        print("WalkSpeed:", v)
    end
})

MovementSection:AddSlider({
    Name = "JumpPower",
    Min = 50,
    Max = 300,
    Default = 100,
    Color = Color3.fromRGB(255, 255, 255),
    Increment = 5,
    ValueName = "Power",
    Callback = function(v)
        jumpPower = v
        local char = LocalPlayer.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            char.Humanoid.JumpPower = jumpPower
        end
        print("JumpPower:", v)
    end
})

MovementSection:AddToggle({
    Name = "Fly",
    Default = false,
    Callback = function(v)
        flyEnabled = v
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        if flyEnabled then
            local BodyGyro = Instance.new("BodyGyro", hrp)
            local BodyVelocity = Instance.new("BodyVelocity", hrp)
            BodyGyro.P = 9000
            BodyGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
            BodyGyro.CFrame = hrp.CFrame
            BodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
            BodyVelocity.Velocity = Vector3.new(0, 0, 0)

            local UIS = game:GetService("UserInputService")
            local RunService = game:GetService("RunService")

            local function FlyUpdate()
                local moveDir = Vector3.new()
                if UIS:IsKeyDown(Enum.KeyCode.W) then
                    moveDir = moveDir + hrp.CFrame.LookVector
                end
                if UIS:IsKeyDown(Enum.KeyCode.S) then
                    moveDir = moveDir - hrp.CFrame.LookVector
                end
                if UIS:IsKeyDown(Enum.KeyCode.A) then
                    moveDir = moveDir - hrp.CFrame.RightVector
                end
                if UIS:IsKeyDown(Enum.KeyCode.D) then
                    moveDir = moveDir + hrp.CFrame.RightVector
                end
                if UIS:IsKeyDown(Enum.KeyCode.Space) then
                    moveDir = moveDir + Vector3.new(0,1,0)
                end
                if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then
                    moveDir = moveDir - Vector3.new(0,1,0)
                end

                BodyVelocity.Velocity = moveDir.Unit * 50
                BodyGyro.CFrame = hrp.CFrame
            end

            local conn
            conn = RunService.Heartbeat:Connect(FlyUpdate)
            -- Store connection and parts to disable fly later
            flyEnabled = {BodyGyro=BodyGyro, BodyVelocity=BodyVelocity, Connection=conn}
            print("Fly Enabled")
        else
            if type(flyEnabled) == "table" then
                flyEnabled.BodyGyro:Destroy()
                flyEnabled.BodyVelocity:Destroy()
                flyEnabled.Connection:Disconnect()
                flyEnabled = false
                print("Fly Disabled")
            end
        end
    end
})

MovementSection:AddToggle({
    Name = "NoClip",
    Default = false,
    Callback = function(v)
        noClipEnabled = v
        local char = LocalPlayer.Character
        if not char then return end
        for _, part in pairs(char:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = not noClipEnabled
            end
        end
        print("NoClip:", v)
    end
})

local bunnyHopConn
MovementSection:AddToggle({
    Name = "Bunny Hop",
    Default = false,
    Callback = function(v)
        bunnyHopEnabled = v
        local char = LocalPlayer.Character
        if not char then return end
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if not humanoid then return end

        if v then
            bunnyHopConn = humanoid.Jumping:Connect(function()
                wait(0.1)
                humanoid.Jump = true
            end)
            print("Bunny Hop Enabled")
        else
            if bunnyHopConn then
                bunnyHopConn:Disconnect()
                bunnyHopConn = nil
            end
            print("Bunny Hop Disabled")
        end
    end
})

-- ======= Gun Mods Tab =======
local GunTab = Window:MakeTab({Name = "Gun Mods", Icon = "rbxassetid://4483345998"})
local GunSection = GunTab:AddSection({Name = "Weapon Modifications"})

local noRecoilEnabled = false
local noSpreadEnabled = false
local infiniteAmmoEnabled = false
local instantReloadEnabled = false
local rapidFireEnabled = false

GunSection:AddToggle({
    Name = "No Recoil",
    Default = false,
    Callback = function(v)
        noRecoilEnabled = v
        print("No Recoil:", v)
    end
})

GunSection:AddToggle({
    Name = "No Spread",
    Default = false,
    Callback = function(v)
        noSpreadEnabled = v
        print("No Spread:", v)
    end
})

GunSection:AddToggle({
    Name = "Infinite Ammo",
    Default = false,
    Callback = function(v)
        infiniteAmmoEnabled = v
        print("Infinite Ammo:", v)
    end
})

GunSection:AddToggle({
    Name = "Instant Reload",
    Default = false,
    Callback = function(v)
        instantReloadEnabled = v
        print("Instant Reload:", v)
    end
})

GunSection:AddToggle({
    Name = "Rapid Fire",
    Default = false,
    Callback = function(v)
        rapidFireEnabled = v
        print("Rapid Fire:", v)
    end
})

-- ======= Exploits Tab =======
local ExploitTab = Window:MakeTab({Name = "Exploits", Icon = "rbxassetid://4483345998"})
local ExploitSection = ExploitTab:AddSection({Name = "Game Manipulation"})

local hitboxExpanderValue = 1
local antiAimEnabled = false
local fakeLagEnabled = false

ExploitSection:AddButton({
    Name = "Teleport to Spawn",
    Callback = function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = CFrame.new(0,10,0)
            print("Teleported to spawn")
        end
    end
})

ExploitSection:AddSlider({
    Name = "Hitbox Expander",
    Min = 1,
    Max = 10,
    Default = 1,
    Color = Color3.fromRGB(255,255,255),
    Increment = 1,
    ValueName = "Size",
    Callback = function(v)
        hitboxExpanderValue = v
        print("Hitbox Expander:", v)
    end
})

ExploitSection:AddToggle({
    Name = "Anti-Aim",
    Default = false,
    Callback = function(v)
        antiAimEnabled = v
        print("Anti-Aim:", v)
    end
})

ExploitSection:AddToggle({
    Name = "Fake Lag",
    Default = false,
    Callback = function(v)
        fakeLagEnabled = v
        print("Fake Lag:", v)
    end
})

-- ======= Settings Tab =======
local SettingsTab = Window:MakeTab({Name = "Settings", Icon = "rbxassetid://4483345998"})
local SettingsSection = SettingsTab:AddSection({Name = "General Settings"})

SettingsSection:AddButton({
    Name = "Unload UI",
    Callback = function()
        OrionLib:Destroy()
        print("UI unloaded")
    end
})

SettingsSection:AddButton({
    Name = "Rejoin Game",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
    end
})

SettingsSection:AddKeybind({
    Name = "Toggle UI",
    Default = Enum.KeyCode.RightShift,
    Hold = false,
    Callback = function()
        Window:Toggle()
    end
})

-- Initialize the UI
OrionLib:Init()

print("Full UI loaded! Use RightShift to toggle")
