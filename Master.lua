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

CombatSection:AddToggle({Name = "Aimbot", Default = false, Callback = function(v) end})
CombatSection:AddToggle({Name = "Silent Aim", Default = false, Callback = function(v) end})
CombatSection:AddToggle({Name = "Legit Aim", Default = false, Callback = function(v) end})
CombatSection:AddToggle({Name = "Aim Lock", Default = false, Callback = function(v) end})

--// Visuals Tab
local VisualsTab = Window:MakeTab({Name = "Visuals", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local VisualsSection = VisualsTab:AddSection({Name = "ESP Features"})

VisualsSection:AddToggle({Name = "Box ESP", Default = false, Callback = function(v) end})
VisualsSection:AddToggle({Name = "Name ESP", Default = false, Callback = function(v) end})
VisualsSection:AddToggle({Name = "Health ESP", Default = false, Callback = function(v) end})
VisualsSection:AddToggle({Name = "Chams", Default = false, Callback = function(v) end})

--// Movement Tab
local MovementTab = Window:MakeTab({Name = "Movement", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local MovementSection = MovementTab:AddSection({Name = "Player Movement"})

MovementSection:AddSlider({
	Name = "WalkSpeed",
	Min = 16,
	Max = 100,
	Default = 16,
	Color = Color3.fromRGB(255, 255, 255),
	Increment = 1,
	ValueName = "Speed",
	Callback = function(v) end
})

MovementSection:AddSlider({
	Name = "JumpPower",
	Min = 50,
	Max = 200,
	Default = 100,
	Color = Color3.fromRGB(255, 255, 255),
	Increment = 5,
	ValueName = "Power",
	Callback = function(v) end
})

MovementSection:AddToggle({Name = "Fly", Default = false, Callback = function(v) end})
MovementSection:AddToggle({Name = "NoClip", Default = false, Callback = function(v) end})
MovementSection:AddToggle({Name = "Bunny Hop", Default = false, Callback = function(v) end})

--// Gun Mods Tab
local GunTab = Window:MakeTab({Name = "Gun Mods", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local GunSection = GunTab:AddSection({Name = "Weapon Modifications"})

GunSection:AddToggle({Name = "No Recoil", Default = false, Callback = function(v) end})
GunSection:AddToggle({Name = "No Spread", Default = false, Callback = function(v) end})
GunSection:AddToggle({Name = "Infinite Ammo", Default = false, Callback = function(v) end})
GunSection:AddToggle({Name = "Instant Reload", Default = false, Callback = function(v) end})
GunSection:AddToggle({Name = "Rapid Fire", Default = false, Callback = function(v) end})

--// Exploits Tab
local ExploitTab = Window:MakeTab({Name = "Exploits", Icon = "rbxassetid://4483345998", PremiumOnly = false})
local ExploitSection = ExploitTab:AddSection({Name = "Game Manipulation"})

ExploitSection:AddButton({
	Name = "Teleport (Example)",
	Callback = function()
		-- Replace with actual location logic
		local char = game.Players.LocalPlayer.Character
		if char then
			char:MoveTo(Vector3.new(0, 10, 0))
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
	Callback = function(v) end
})

ExploitSection:AddToggle({Name = "Anti-Aim", Default = false, Callback = function(v) end})
ExploitSection:AddToggle({Name = "Fake Lag", Default = false, Callback = function(v) end})

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
