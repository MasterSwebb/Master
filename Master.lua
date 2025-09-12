-- Destroy previous UI if any
if _G.OrionLib and _G.OrionLib.Destroy then
    _G.OrionLib:Destroy()
    _G.OrionLib = nil
end

-- Load fresh OrionLib forcibly to avoid cache
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/ZeeZee2Real/shlexware-Orion-main-source/refs/heads/main/gr?ts="..tick()))()
_G.OrionLib = OrionLib
assert(OrionLib, "Failed to load Orion Library")

-- Notification
OrionLib:MakeNotification({
    Name = "Master v1",
    Content = "Coded by Master Sweb",
    Image = "rbxassetid://4483345998",
    Time = 5
})

-- Main Window
local Window = OrionLib:MakeWindow({
    Name = "Master v1 | by Master Sweb",
    HidePremium = true,
    SaveConfig = true,
    ConfigFolder = "MasterHub"
})

local LocalPlayer = game.Players.LocalPlayer

-- ======= Combat Tab =======
local CombatTab = Window:MakeTab({Name = "Combat", Icon = "rbxassetid://4483345998"})
local CombatSection = CombatTab:AddSection({Name = "Aimbot Features"})

local aimbotEnabled = false
local silentAimEnabled = false
local legitAimEnabled = false
local aimLockEnabled = false

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

-- ======= Visuals Tab =======
local VisualsTab = Window:MakeTab({Name = "Visuals", Icon = "rbxassetid://4483345998"})
local VisualsSection = VisualsTab:AddSection({Name = "ESP Features"})

local boxESPEnabled = false
local nameESPEnabled = false
local healthESPEnabled = false
local chamsEnabled = false

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
    Max = 100,
    Default = 16,
    Color = Color3.fromRGB(255, 255, 255),
    Increment = 1,
    ValueName = "Speed",
    Callback = function(v)
        walkSpeed = v
        local character = LocalPlayer.Character
        if character and character:FindFirstChildOfClass("Humanoid") then
            character.Humanoid.WalkSpeed = walkSpeed
        end
        print("WalkSpeed set to", v)
    end
})

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
        local character = LocalPlayer.Character
        if character and character:FindFirstChildOfClass("Humanoid") then
            character.Humanoid.JumpPower = jumpPower
        end
        print("JumpPower set to", v)
    end
})

MovementSection:AddToggle({Name = "Fly", Default = false, Callback = function(v)
    flyEnabled = v
    print("Fly:", v)
    local character = LocalPlayer.Character
    if not character then return end
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end

    if flyEnabled then
        local BodyGyro = Instance.new("BodyGyro")
        local BodyVelocity = Instance.new("BodyVelocity")

        BodyGyro.P = 90000
        BodyGyro.maxTorque = Vector3.new(4000,4000,4000)
        BodyGyro.cframe = rootPart.CFrame
        BodyGyro.Parent = rootPart

        BodyVelocity.velocity = Vector3.new(0,0,0)
        BodyVelocity.maxForce = Vector3.new(4000,4000,4000)
        BodyVelocity.Parent = rootPart

        local UserInputService = game:GetService("UserInputService")
        local RunService = game:GetService("RunService")

        local function flyUpdate()
            local camera = workspace.CurrentCamera
            local moveDirection = Vector3.new(0,0,0)

            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                moveDirection = moveDirection + camera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                moveDirection = moveDirection - camera.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                moveDirection = moveDirection - camera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                moveDirection = moveDirection + camera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                moveDirection = moveDirection + Vector3.new(0,1,0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                moveDirection = moveDirection - Vector3.new(0,1,0)
            end

            BodyVelocity.velocity = moveDirection.Unit * 50
            BodyGyro.cframe = camera.CFrame
        end

        MovementTab.FlyConnection = RunService.Heartbeat:Connect(flyUpdate)
    else
        if MovementTab.FlyConnection then
            MovementTab.FlyConnection:Disconnect()
            MovementTab.FlyConnection = nil
        end

        if rootPart:FindFirstChild("BodyGyro") then
            rootPart.BodyGyro:Destroy()
        end
        if rootPart:FindFirstChild("BodyVelocity") then
            rootPart.BodyVelocity:Destroy()
        end
    end
end})

MovementSection:AddToggle({Name = "NoClip", Default = false, Callback = function(v)
    noClipEnabled = v
    print("NoClip:", v)
    local character = LocalPlayer.Character
    if not character then return end

    if noClipEnabled then
        local function setCanCollideFalse()
            for _, part in pairs(character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end

        setCanCollideFalse()
        MovementTab.NoClipConnection = game:GetService("RunService").Stepped:Connect(setCanCollideFalse)
    else
        if MovementTab.NoClipConnection then
            MovementTab.NoClipConnection:Disconnect()
            MovementTab.NoClipConnection = nil
        end
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end})

MovementSection:AddToggle({Name = "Bunny Hop", Default = false, Callback = function(v)
    bunnyHopEnabled = v
    print("Bunny Hop:", v)
    local character = LocalPlayer.Character
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    if bunnyHopEnabled then
        MovementTab.BunnyHopConnection = humanoid.Jumping:Connect(function()
            humanoid.Jump = true
        end)
    else
        if MovementTab.BunnyHopConnection then
            MovementTab.BunnyHopConnection:Disconnect()
            MovementTab.BunnyHopConnection = nil
        end
    end
end})

-- ======= Gun Mods Tab =======
local GunTab = Window:MakeTab({Name = "Gun Mods", Icon = "rbxassetid://4483345998"})
local GunSection = GunTab:AddSection({Name = "Weapon Modifications"})

local noRecoilEnabled = false
local noSpreadEnabled = false
local infiniteAmmoEnabled = false
local instantReloadEnabled = false
local rapidFireEnabled = false

GunSection:AddToggle({Name = "No Recoil", Default = false, Callback = function(v)
    noRecoilEnabled = v
    print("No Recoil:", v)
end})

GunSection:AddToggle({Name = "No Spread", Default = false, Callback = function(v)
    noSpreadEnabled = v
    print("No Spread:", v)
end})

GunSection:AddToggle({Name = "Infinite Ammo", Default = false, Callback = function(v)
    infiniteAmmoEnabled = v
    print("Infinite Ammo:", v)
end})

GunSection:AddToggle({Name = "Instant Reload", Default = false, Callback = function(v)
    instantReloadEnabled = v
    print("Instant Reload:", v)
end})

GunSection:AddToggle({Name = "Rapid Fire", Default = false, Callback = function(v)
    rapidFireEnabled = v
    print("Rapid Fire:", v)
end})

-- ======= Exploits Tab =======
local ExploitTab = Window:MakeTab({Name = "Exploits", Icon = "rbxassetid://4483345998"})
local ExploitSection = ExploitTab:AddSection({Name = "Game Manipulation"})

ExploitSection:AddButton({
    Name = "Teleport (Example)",
    Callback = function()
        local char = LocalPlayer.Character
        if char then
            char:MoveTo(Vector3.new(0, 10, 0))
            print("Teleported to (0,10,0)")
        end
    end
})

local hitboxExpanderValue = 1

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
        print("Hitbox Expander set to", v)
    end
})

local antiAimEnabled = false
local fakeLagEnabled = false

ExploitSection:AddToggle({Name = "Anti-Aim", Default = false, Callback = function(v)
    antiAimEnabled = v
    print("Anti-Aim:", v)
end})

ExploitSection:AddToggle({Name = "Fake Lag", Default = false, Callback = function(v)
    fakeLagEnabled = v
    print("Fake Lag:", v)
end})

-- ======= Settings Tab =======
local SettingsTab = Window:MakeTab({Name = "Settings", Icon = "rbxassetid://4483345998"})
local SettingsSection = SettingsTab:AddSection({Name = "General Settings"})

SettingsSection:AddButton({
    Name = "Unload UI",
    Callback = function()
        OrionLib:Destroy()
        _G.OrionLib = nil
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
