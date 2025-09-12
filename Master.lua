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

--// Init UI
OrionLib:Init()
