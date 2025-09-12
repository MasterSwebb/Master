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

--// Visuals Tab
local VisualsTab = Window:MakeTab({Name = "Visuals", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local VisualsSection = VisualsTab:AddSection({Name = "ESP Features"})

local boxESPEnabled = false
local nameESPEnabled = false
local healthESPEnabled = false
local chamsEnabled = false

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

--// Movement Tab
local MovementTab = Window:MakeTab({Name = "Movement", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local MovementSection = MovementTab:AddSection({Name = "Player Movement"})

local walkSpeed = 16
local jumpPower = 100

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

local flyEnabled = false
local noClipEnabled = false
local bunnyHopEnabled = false

MovementSection:AddToggle({Name = "Fly", Default = false, Callback = function(v)
	flyEnabled = v
	if flyEnabled then
		local Player = game.Players.LocalPlayer
		local Mouse = Player:GetMouse()
		local UIS = game:GetService("UserInputService")
		local RunService = game:GetService("RunService")

		local function fly()
			local BodyGyro = Instance.new("BodyGyro")
			local BodyVelocity = Instance.new("BodyVelocity")
			local RootPart = Player.Character.HumanoidRootPart
			BodyGyro.P = 9e4
			BodyGyro.maxTorque = Vector3.new(4000, 4000, 4000)
			BodyGyro.cframe = RootPart.CFrame
			BodyGyro.Parent = RootPart

			BodyVelocity.velocity = Vector3.new(0, 0, 0)
			BodyVelocity.maxForce = Vector3.new(4000, 4000, 4000)
			BodyVelocity.Parent = RootPart

			local function update()
				BodyGyro.cframe = RootPart.CFrame * CFrame.Angles(-Math.rad(Mouse.Y - UIS:GetMouseLocation().Y), 0, 0)
				BodyVelocity.velocity = (RootPart.CFrame.lookVector * Mouse.X - RootPart.Velocity).unit * 50
			end

			RunService.Stepped:Connect(update)
		end

		fly()
	else
		local Player = game.Players.LocalPlayer
		local RootPart = Player.Character.HumanoidRootPart
		RootPart.BodyGyro:Destroy()
		RootPart.BodyVelocity:Destroy()
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
		local function NoClip()
			for _, v in pairs(Character:GetChildren()) do
				if v:IsA("BasePart") then
					v.CanCollide = false
				end
			end
		end

		NoClip()
	else
		Humanoid.PlatformStand = false
		for _, v in pairs(Character:GetChildren()) do
			if v:IsA("BasePart") then
				v.CanCollide = true
			end
		end
	end
end})

MovementSection:AddToggle({Name = "Bunny Hop", Default = false, Callback = function(v)
	bunnyHopEnabled = v
	if bunnyHopEnabled then
		local Player = game.Players.LocalPlayer
		local Character = Player.Character or Player.CharacterAdded:Wait()
		local Humanoid = Character:FindFirstChildOfClass("Humanoid")

		local function onJump()
			Humanoid.Jump = true
			wait(0.1)
			Humanoid.Jump = false
		end

		Humanoid.Jumping:Connect(onJump)
	else
		local Player = game.Players.LocalPlayer
		local Character = Player.Character or Player.CharacterAdded:Wait()
		local Humanoid = Character:FindFirstChildOfClass("Humanoid")

		Humanoid.Jumping:Disconnect()
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

--// Exploits Tab
local ExploitTab = Window:MakeTab({Name = "Exploits", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local ExploitSection = ExploitTab:AddSection({Name = "Game Manipulation"})

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

local antiAimEnabled = false
local fakeLagEnabled = false

ExploitSection:AddToggle({Name = "Anti-Aim", Default = false, Callback = function(v)
	antiAimEnabled = v
end})

ExploitSection:AddToggle({Name = "Fake Lag", Default = false, Callback = function(v)
	fakeLagEnabled = v
end})

--// Settings Tab
local SettingsTab = Window:MakeTab({Name = "UI Settings", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local SettingsSection = SettingsTab:AddSection({Name = "General"})

SettingsSection:AddBind({
	Name = "Toggle Menu Keybind",
	Default = Enum.KeyCode.RightShift,
	Hold = false,
	Callback = function()
		-- OrionLib toggles automatically, this is placeholder
	end
})

SettingsSection:AddButton({
	Name = "Destroy UI",
	Callback = function()
		OrionLib:Destroy()
	end
})

--// Finalize UI
OrionLib:Init()
