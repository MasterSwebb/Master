--// Load Orion Library
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/ZeeZee2Real/shlexware-Orion-main-source/refs/heads/main/gr"))()

--// Notification
OrionLib:MakeNotification({
	Name = "Master v1",
	Content = "Coded by Master Sweb",
	Image = "rbxassetid://4483345998",
	Time = 5
})

--// Main Window
local Window = OrionLib:MakeWindow({
	Name = "Master v1 | by Master Sweb",
	HidePremium = true,
	SaveConfig = true,
	ConfigFolder = "MasterHub"
})

--// Combat Tab
local CombatTab = Window:MakeTab({Name = "Combat", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local CombatSection = CombatTab:AddSection({Name = "Aimbot Features"})

local aimbotEnabled = false
local silentAimEnabled = false
local legitAimEnabled = false
local aimLockEnabled = false
local autoHealEnabled = false
local autoShootEnabled = false
local targetPart = "Head"

--// Combat Toggles
CombatSection:AddToggle({Name = "Aimbot", Default = false, Callback = function(v)
	aimbotEnabled = v
end})

CombatSection:AddToggle({Name = "Silent Aim", Default = false, Callback = function(v)
	silentAimEnabled = v
end})

CombatSection:AddToggle({Name = "Legit Aim", Default = false, Callback = function(v)
	legitAimEnabled = v
end})

CombatSection:AddToggle({Name = "Aim Lock", Default = false, Callback = function(v)
	aimLockEnabled = v
end})

CombatSection:AddToggle({Name = "Auto Heal", Default = false, Callback = function(v)
	autoHealEnabled = v
end})

CombatSection:AddToggle({Name = "Auto Shoot", Default = false, Callback = function(v)
	autoShootEnabled = v
end})

CombatSection:AddDropdown({
	Name = "Target Part",
	Default = 1,
	Options = {"Head", "Torso", "Legs", "Arms"},
	Callback = function(v)
		targetPart = v
	end
})

--// Auto Heal Logic
local function AutoHeal()
    local player = game.Players.LocalPlayer
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") then
        local humanoid = character.Humanoid
        if humanoid.Health < humanoid.MaxHealth then
            humanoid.Health = humanoid.MaxHealth
        end
    end
end

-- Auto-Health Loop
game:GetService("RunService").Heartbeat:Connect(function()
    if autoHealEnabled then
        AutoHeal()
    end
end)

--// AutoShoot Logic
local function AutoShoot()
    -- Simple auto-shoot functionality (can be customized)
    if autoShootEnabled then
        local player = game.Players.LocalPlayer
        local mouse = player:GetMouse()
        -- Shoot at the target part of a character
        if mouse.Target then
            -- Logic to shoot at the target
        end
    end
end

-- Auto-Shoot Loop
game:GetService("RunService").Heartbeat:Connect(function()
    if autoShootEnabled then
        AutoShoot()
    end
end)

--// Visuals Tab
local VisualsTab = Window:MakeTab({Name = "Visuals", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local VisualsSection = VisualsTab:AddSection({Name = "ESP Features"})

local boxESPEnabled = false
local nameESPEnabled = false
local healthESPEnabled = false
local chamsEnabled = false
local distanceESPEnabled = false
local espColor = Color3.fromRGB(255, 0, 0)

--// ESP Toggles
VisualsSection:AddToggle({Name = "Box ESP", Default = false, Callback = function(v)
	boxESPEnabled = v
end})

VisualsSection:AddToggle({Name = "Name ESP", Default = false, Callback = function(v)
	nameESPEnabled = v
end})

VisualsSection:AddToggle({Name = "Health ESP", Default = false, Callback = function(v)
	healthESPEnabled = v
end})

VisualsSection:AddToggle({Name = "Chams", Default = false, Callback = function(v)
	chamsEnabled = v
end})

VisualsSection:AddToggle({Name = "Distance ESP", Default = false, Callback = function(v)
	distanceESPEnabled = v
end})

VisualsSection:AddColorPicker({
	Name = "ESP Color",
	Default = espColor,
	Callback = function(v)
		espColor = v
	end
})

--// Movement Tab
local MovementTab = Window:MakeTab({Name = "Movement", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local MovementSection = MovementTab:AddSection({Name = "Player Movement"})

local walkSpeed = 16
local jumpPower = 100
local speedMultiplier = 1
local flyEnabled = false
local noClipEnabled = false
local bunnyHopEnabled = false

--// Speed Multiplier and Jump Power
MovementSection:AddSlider({
	Name = "WalkSpeed",
	Min = 16,
	Max = 100,
	Default = 16,
	Color = Color3.fromRGB(255, 255, 255),
	Increment = 1,
	ValueName = "Speed",
	Callback = function(v)
		walkSpeed = v * speedMultiplier
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = walkSpeed
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
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = jumpPower
	end
})

MovementSection:AddSlider({
	Name = "Speed Multiplier",
	Min = 1,
	Max = 5,
	Default = 1,
	Color = Color3.fromRGB(255, 255, 255),
	Increment = 0.1,
	ValueName = "Multiplier",
	Callback = function(v)
		speedMultiplier = v
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = walkSpeed * v
	end
})

--// Flight & NoClip
MovementSection:AddToggle({Name = "Fly", Default = false, Callback = function(v)
	flyEnabled = v
	if flyEnabled then
		-- Flight logic here (similar to previous implementation)
	else
		-- Reset flight logic (remove BodyGyro, BodyVelocity)
	end
end})

MovementSection:AddToggle({Name = "NoClip", Default = false, Callback = function(v)
	noClipEnabled = v
	local Player = game.Players.LocalPlayer
	local Character = Player.Character or Player.CharacterAdded:Wait()
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	local RootPart = Character:FindFirstChild("HumanoidRootPart") or Character:FindFirstChild("Torso")
	if noClipEnabled then
		Humanoid.PlatformStand = true
		for _, part in pairs(Character:GetChildren()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	else
		Humanoid.PlatformStand = false
		for _, part in pairs(Character:GetChildren()) do
			if part:IsA("BasePart") then
				part.CanCollide = true
			end
		end
	end
end})

--// Gun Mods Tab
local GunTab = Window:MakeTab({Name = "Gun Mods", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local GunSection = GunTab:AddSection({Name = "Weapon Modifications"})

local noRecoilEnabled = false
local noSpreadEnabled = false
local infiniteAmmoEnabled = false
local instantReloadEnabled = false
local rapidFireEnabled = false
local reloadSpeedMultiplier = 1

--// Gun Toggles
GunSection:AddToggle({Name = "No Recoil", Default = false, Callback = function(v)
	noRecoilEnabled = v
end})

GunSection:AddToggle({Name = "No Spread", Default = false, Callback = function(v)
	noSpreadEnabled = v
end})

GunSection:AddToggle({Name = "Infinite Ammo", Default = false, Callback = function(v)
	infiniteAmmoEnabled = v
end})

GunSection:AddToggle({Name = "Instant Reload", Default = false, Callback = function(v)
	instantReloadEnabled = v
end})

GunSection:AddToggle({Name = "Rapid Fire", Default = false, Callback = function(v)
	rapidFireEnabled = v
end})

GunSection:AddSlider({
	Name = "Reload Speed Multiplier",
	Min = 1,
	Max = 5,
	Default = 1,
	Color = Color3.fromRGB(255, 255, 255),
	Increment = 0.1,
	ValueName = "Multiplier",
	Callback = function(v)
		reloadSpeedMultiplier = v
	end
})

--// Exploits Tab (Additional)
local ExploitTab = Window:MakeTab({Name = "Exploits", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local ExploitSection = ExploitTab:AddSection({Name = "Game Manipulation"})

-- Exploit Options
ExploitSection:AddButton({
	Name = "Teleport (Example)",
	Callback = function()
		local char = game.Players.LocalPlayer.Character
		if char then
			char:MoveTo(Vector3.new(0, 10, 0))
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
	end
})

ExploitSection:AddToggle({Name = "Anti-Aim", Default = false, Callback = function(v)
	antiAimEnabled = v
end})

ExploitSection:AddToggle({Name = "Fake Lag", Default = false, Callback = function(v)
	fakeLagEnabled = v
end})

--// Finalize UI
OrionLib:Init()
