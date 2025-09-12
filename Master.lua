--// Load Orion
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/ZeeZee2Real/shlexware-Orion-main-source/refs/heads/main/gr')))()

local OrionLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/ZeeZee2Real/shlexware-Orion-main-source/refs/heads/main/gr'))()
OrionLib:MakeNotification({
    Name = "SwebHub",
    Content = "SwebHub Loaded",
    Image = "rbxassetid://4483345998",
    Time = 5
})

local Window = OrionLib:MakeWindow({Name = "SwebHub", HidePremium = false, SaveConfig = true, ConfigFolder = "SwebHub"})

-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local Workspace = game:GetService("Workspace")
local HttpService = game:GetService("HttpService")
local Camera = Workspace.CurrentCamera

-- Helper Functions
local function getCharacter(plr) return plr.Character or plr.CharacterAdded:Wait() end
local function createESPBillboard(plr, textContent, color)
    if plr.Character and plr.Character:FindFirstChild("Head") then
        if plr.Character.Head:FindFirstChild("ESP") then return end
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "ESP"
        billboard.Size = UDim2.new(0,200,0,50)
        billboard.AlwaysOnTop = true
        billboard.Adornee = plr.Character.Head
        billboard.Parent = plr.Character.Head

        local text = Instance.new("TextLabel", billboard)
        text.Size = UDim2.new(1,0,1,0)
        text.Text = textContent
        text.TextColor3 = color or Color3.new(1,0,0)
        text.BackgroundTransparency = 1
    end
end

-- Keybind to open/close menu
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightShift then
        Window:Toggle()
    end
end)

--// PLAYER TAB
-- =============================
-- Player Tab
-- =============================
local PlayerTab = Window:MakeTab({Name = "Player", Icon = "rbxassetid://4483345998"})
local PlayerSection = PlayerTab:AddSection({Name = "Player Mods"})

-- WalkSpeed
local defaultWS = 16
PlayerSection:AddSlider({
    Name = "Walkspeed",
    Min = 16,
    Max = 500,
    Default = defaultWS,
    Increment = 1,
    Callback = function(v)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = v
        end
PlayerSection:AddSlider({Name = "Walkspeed", Min = 16, Max = 500, Default = defaultWS, Increment = 1, Callback = function(v)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = v
    end
})
end})

-- JumpPower
local defaultJP = 50
PlayerSection:AddSlider({
    Name = "JumpPower",
    Min = 50,
    Max = 500,
    Default = defaultJP,
    Increment = 1,
    Callback = function(v)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = v
        end
PlayerSection:AddSlider({Name = "JumpPower", Min = 50, Max = 500, Default = defaultJP, Increment = 1, Callback = function(v)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = v
    end
})
end})

-- Gravity
PlayerSection:AddSlider({
    Name = "Gravity",
    Min = 0,
    Max = 500,
    Default = workspace.Gravity,
    Increment = 1,
    Callback = function(v)
        workspace.Gravity = v
    end
})
PlayerSection:AddSlider({Name = "Gravity", Min = 0, Max = 500, Default = workspace.Gravity, Increment = 1, Callback = function(v)
    workspace.Gravity = v
end})

-- Infinite Jump
local infJump = false
PlayerSection:AddToggle({
    Name = "Infinite Jump",
    Default = false,
    Callback = function(val)
        infJump = val
    end
})
PlayerSection:AddToggle({Name = "Infinite Jump", Default = false, Callback = function(val) infJump = val end})
UserInputService.JumpRequest:Connect(function()
    if infJump and LocalPlayer.Character then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
@@ -109,19 +58,11 @@ end)

-- NoClip
local noclip = false
PlayerSection:AddToggle({
    Name = "NoClip",
    Default = false,
    Callback = function(val)
        noclip = val
    end
})
PlayerSection:AddToggle({Name = "NoClip", Default = false, Callback = function(val) noclip = val end})
RunService.Stepped:Connect(function()
    if noclip and LocalPlayer.Character then
        for _,v in pairs(LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
end)
@@ -130,13 +71,7 @@ end)
local flyEnabled = false
local flySpeed = 60
local flyBV, flyBG
PlayerSection:AddToggle({
    Name = "Fly (E/Q Speed Control)",
    Default = false,
    Callback = function(val)
        flyEnabled = val
    end
})
PlayerSection:AddToggle({Name = "Fly (E/Q Speed Control)", Default = false, Callback = function(val) flyEnabled = val end})
RunService.RenderStepped:Connect(function()
    if flyEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local HRP = LocalPlayer.Character.HumanoidRootPart
@@ -147,7 +82,7 @@ RunService.RenderStepped:Connect(function()
            flyBG.MaxTorque = Vector3.new(1e5,1e5,1e5)
        end
        local move = Vector3.zero
        local cam = workspace.CurrentCamera.CFrame
        local cam = Camera.CFrame
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + cam.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move - cam.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move - cam.RightVector end
@@ -172,75 +107,47 @@ if LocalPlayer.Character then
        if part:IsA("BasePart") then defaultSizes[part] = part.Size end
    end
end
PlayerSection:AddSlider({
    Name = "Body Scale",
    Min = 0.5,
    Max = 5,
    Default = 1,
    Increment = 0.1,
    Callback = function(v)
        if LocalPlayer.Character then
            for part, size in pairs(defaultSizes) do
                if part.Parent then
                    part.Size = size * v
                end
            end
PlayerSection:AddSlider({Name = "Body Scale", Min = 0.5, Max = 5, Default = 1, Increment = 0.1, Callback = function(v)
    if LocalPlayer.Character then
        for part,size in pairs(defaultSizes) do
            if part.Parent then part.Size = size*v end
        end
    end
})
end})

-- Teleport to CFrame
PlayerSection:AddTextbox({
    Name = "Teleport to CFrame (x,y,z)",
    Default = "0,0,0",
    TextDisappear = false,
    Callback = function(txt)
        local x,y,z = txt:match("([^,]+),([^,]+),([^,]+)")
        x,y,z = tonumber(x), tonumber(y), tonumber(z)
        if x and y and z and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(x,y,z)
        end
PlayerSection:AddTextbox({Name = "Teleport to CFrame (x,y,z)", Default = "0,0,0", TextDisappear = false, Callback = function(txt)
    local x,y,z = txt:match("([^,]+),([^,]+),([^,]+)")
    x,y,z = tonumber(x), tonumber(y), tonumber(z)
    if x and y and z and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(x,y,z)
    end
})
end})

--// COMBAT TAB
-- =============================
-- Combat Tab
-- =============================
local CombatTab = Window:MakeTab({Name = "Combat", Icon = "rbxassetid://4483345998"})
local CombatSection = CombatTab:AddSection({Name = "Combat"})

-- Hitbox Expander
local hitboxSize = 10
CombatSection:AddSlider({
    Name = "Hitbox Expander Size",
    Min = 5,
    Max = 50,
    Default = 10,
    Increment = 1,
    Callback = function(v)
        hitboxSize = v
    end
})
CombatSection:AddButton({
    Name = "Expand Hitboxes",
    Callback = function()
        for _,plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local HRP = plr.Character.HumanoidRootPart
                HRP.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                HRP.Transparency = 0.7
                HRP.Material = Enum.Material.Neon
            end
CombatSection:AddSlider({Name = "Hitbox Expander Size", Min = 5, Max = 50, Default = hitboxSize, Increment = 1, Callback = function(v) hitboxSize = v end})
CombatSection:AddButton({Name = "Expand Hitboxes", Callback = function()
    for _,plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local HRP = plr.Character.HumanoidRootPart
            HRP.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
            HRP.Transparency = 0.7
            HRP.Material = Enum.Material.Neon
        end
    end
})
end})

-- Kill Aura
local killAura = false
local killRadius = 20
CombatSection:AddToggle({
    Name = "Kill Aura",
    Default = false,
    Callback = function(val) killAura = val end
})
CombatSection:AddToggle({Name = "Kill Aura", Default = false, Callback = function(val) killAura = val end})
RunService.RenderStepped:Connect(function()
    if killAura and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        for _,plr in pairs(Players:GetPlayers()) do
@@ -252,162 +159,134 @@ RunService.RenderStepped:Connect(function()
            end
        end
    end
end)

-- Auto Farm
local autoFarm = false
CombatSection:AddToggle({
    Name = "Auto Farm",
    Default = false,
    Callback = function(val) autoFarm = val end
})
RunService.RenderStepped:Connect(function()
    if autoFarm and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        for _,obj in pairs(Workspace:GetChildren()) do
            if obj:IsA("Part") and obj.Name == "FarmableObject" then
                LocalPlayer.Character:MoveTo(obj.Position)
end})

-- Aimbot
local aimbotEnabled = false
local aimbotFOV = 100
local aimbotSmooth = 0.2
local aimbotTargetPart = "Head" -- Head/Torso
CombatSection:AddToggle({Name = "Aimbot", Default = false, Callback = function(val) aimbotEnabled = val end})
CombatSection:AddSlider({Name = "Aimbot FOV", Min = 10, Max = 300, Default = aimbotFOV, Increment = 1, Callback = function(v) aimbotFOV = v end})
CombatSection:AddSlider({Name = "Aimbot Smooth", Min = 0.01, Max = 1, Default = aimbotSmooth, Increment = 0.01, Callback = function(v) aimbotSmooth = v end})
CombatSection:AddDropdown({Name = "Aim Part", Options = {"Head","Torso"}, Default = "Head", Callback = function(v) aimbotTargetPart = v end})

local function getClosestPlayerToCursor()
    local closestDist = aimbotFOV
    local target = nil
    for _,plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild(aimbotTargetPart) then
            local screenPos, vis = Camera:WorldToViewportPoint(plr.Character[aimbotTargetPart].Position)
            local mouse = UserInputService:GetMouseLocation()
            local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(mouse.X, mouse.Y)).Magnitude
            if dist < closestDist then
                closestDist = dist
                target = plr
            end
        end
    end
end)
    return target
end

-- Auto Clicker
local autoClicker = false
CombatSection:AddToggle({
    Name = "Auto Clicker",
    Default = false,
    Callback = function(val) autoClicker = val end
})
local vu = game:GetService("VirtualUser")
RunService.RenderStepped:Connect(function()
    if autoClicker then
        vu:Button1Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        vu:Button1Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    if aimbotEnabled then
        local target = getClosestPlayerToCursor()
        if target and target.Character and target.Character:FindFirstChild(aimbotTargetPart) then
            local targetPos = target.Character[aimbotTargetPart].Position
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position:Lerp(targetPos, aimbotSmooth))
        end
    end
end)

--// VISUALS TAB
-- =============================
-- Visuals Tab
-- =============================
local VisualsTab = Window:MakeTab({Name = "Visuals", Icon = "rbxassetid://4483345998"})
local VisualsSection = VisualsTab:AddSection({Name = "ESP"})

-- Simple Nametag ESP
-- ESP options
local espEnabled = false
local espPlayers = {}
local function addESP(plr)
    if plr ~= LocalPlayer then
        plr.CharacterAdded:Connect(function(char)
            wait(0.1)
            if espEnabled then createESPBillboard(plr, plr.Name, Color3.new(1,0,0)) end
        end)
        if plr.Character and espEnabled then
            createESPBillboard(plr, plr.Name, Color3.new(1,0,0))
local espBox = true
local espTracer = true
local espHealth = true
local espDistance = true
local espColor = Color3.fromRGB(255,0,0)

local function drawESP(plr)
    if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
        -- Billboard / Nametag
        if espEnabled then
            createESPBillboard(plr, plr.Name, espColor)
        end
    end
end
for _,p in pairs(Players:GetPlayers()) do addESP(p) end
Players.PlayerAdded:Connect(addESP)

VisualsSection:AddToggle({
    Name = "Simple Nametag ESP",
    Default = false,
    Callback = function(val)
        espEnabled = val
        for _,plr in pairs(Players:GetPlayers()) do
            if plr.Character and plr.Character:FindFirstChild("Head") and plr.Character.Head:FindFirstChild("ESP") then
                if not val then plr.Character.Head.ESP:Destroy() end
            elseif val then
                createESPBillboard(plr, plr.Name, Color3.new(1,0,0))
            end
        end
    end
})

--// TELEPORT TAB
for _,p in pairs(Players:GetPlayers()) do drawESP(p) end
Players.PlayerAdded:Connect(drawESP)

VisualsSection:AddToggle({Name = "Enable ESP", Default = false, Callback = function(val) espEnabled = val end})
VisualsSection:AddColorPicker({Name = "ESP Color", Default = espColor, Callback = function(c) espColor = c end})

-- =============================
-- Teleports Tab
-- =============================
local TeleTab = Window:MakeTab({Name = "Teleports", Icon = "rbxassetid://4483345998"})
local TeleSection = TeleTab:AddSection({Name = "Teleport"})

-- Teleport to Player
local plrList = {}
for _,p in pairs(Players:GetPlayers()) do table.insert(plrList,p.Name) end
local selectedPlr = LocalPlayer.Name
TeleSection:AddDropdown({
    Name = "Teleport to Player",
    Options = plrList,
    Callback = function(v) selectedPlr = v end
})
TeleSection:AddButton({
    Name = "Teleport",
    Callback = function()
        local target = Players:FindFirstChild(selectedPlr)
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character:MoveTo(target.Character.HumanoidRootPart.Position + Vector3.new(0,3,0))
        end
TeleSection:AddDropdown({Name = "Teleport to Player", Options = plrList, Callback = function(v) selectedPlr = v end})
TeleSection:AddButton({Name = "Teleport", Callback = function()
    local target = Players:FindFirstChild(selectedPlr)
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character:MoveTo(target.Character.HumanoidRootPart.Position + Vector3.new(0,3,0))
    end
})
end})

-- Click TP
local clickTP = false
TeleSection:AddToggle({
    Name = "Click Teleport",
    Default = false,
    Callback = function(v) clickTP = v end
})
TeleSection:AddToggle({Name = "Click Teleport", Default = false, Callback = function(v) clickTP = v end})
LocalPlayer:GetMouse().Button1Down:Connect(function()
    if clickTP and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) and LocalPlayer.Character then
        LocalPlayer.Character:MoveTo(LocalPlayer:GetMouse().Hit.p)
    end
end)

--// MISC TAB
-- =============================
-- Misc Tab
-- =============================
local MiscTab = Window:MakeTab({Name = "Misc", Icon = "rbxassetid://4483345998"})
local MiscSection = MiscTab:AddSection({Name = "Misc"})

MiscSection:AddButton({
    Name = "Rejoin",
    Callback = function()
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end
})

MiscSection:AddButton({
    Name = "ServerHop",
    Callback = function()
        local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
        for _,s in pairs(servers.data) do
            if s.playing < s.maxPlayers then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, s.id)
                break
            end
MiscSection:AddButton({Name = "Rejoin", Callback = function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end})
MiscSection:AddButton({Name = "ServerHop", Callback = function()
    local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
    for _,s in pairs(servers.data) do
        if s.playing < s.maxPlayers then
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, s.id)
            break
        end
    end
})

MiscSection:AddButton({
    Name = "Infinite Yield (Admin)",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end
})

MiscSection:AddButton({
    Name = "Anti-AFK",
    Callback = function()
        local vu = game:GetService("VirtualUser")
        LocalPlayer.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            wait(1)
            vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        end)
    end
})
end})
MiscSection:AddButton({Name = "Infinite Yield (Admin)", Callback = function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end})
MiscSection:AddButton({Name = "Anti-AFK", Callback = function()
    local vu = game:GetService("VirtualUser")
    LocalPlayer.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
end})

-- Speed Hack
local speedHack = false
MiscSection:AddToggle({
    Name = "Speed Hack",
    Default = false,
    Callback = function(val) speedHack = val end
})
MiscSection:AddToggle({Name = "Speed Hack", Default = false, Callback = function(val) speedHack = val end})
RunService.Stepped:Connect(function()
    if speedHack and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 100
@@ -416,11 +295,7 @@ end)

-- No Fall Damage
local noFallDamage = false
MiscSection:AddToggle({
    Name = "No Fall Damage",
    Default = false,
    Callback = function(val) noFallDamage = val end
})
MiscSection:AddToggle({Name = "No Fall Damage", Default = false, Callback = function(val) noFallDamage = val end})
LocalPlayer.CharacterAdded:Connect(function(char)
    local humanoid = char:WaitForChild("Humanoid")
    humanoid.StateChanged:Connect(function(_, new)
@@ -432,27 +307,21 @@ end)

-- Auto Respawn
local autoRespawn = false
MiscSection:AddToggle({
    Name = "Auto Respawn",
    Default = false,
    Callback = function(val) autoRespawn = val end
})
MiscSection:AddToggle({Name = "Auto Respawn", Default = false, Callback = function(val) autoRespawn = val end})
LocalPlayer.CharacterAdded:Connect(function(char)
    if autoRespawn then
        char:WaitForChild("Humanoid").Health = 0
    end
end)

--// SETTINGS TAB
-- =============================
-- Settings Tab
-- =============================
local SettingsTab = Window:MakeTab({Name = "Settings", Icon = "rbxassetid://4483345998"})
local SettingsSection = SettingsTab:AddSection({Name = "Settings"})
SettingsSection:AddButton({Name = "Destroy UI", Callback = function() OrionLib:Destroy() end})

SettingsSection:AddButton({
    Name = "Destroy UI",
    Callback = function()
        OrionLib:Destroy()
    end
})

--// INIT
-- =============================
-- Init
-- =============================
OrionLib:Init()
