--------------------------------------- Wait until game load ---------------------------------------------------

if not game:IsLoaded() then
    game.Loaded:Wait()
end

--------------------------------------- Anti-UI Duplication ---------------------------------------------------

for h, b in ipairs(game.CoreGui:GetChildren()) do
    if b.Name == "MadeByLumine" then
        b:Destroy()
    end
end

--------------------------------------- UI Menu ---------------------------------------------------

local i = Instance.new("ScreenGui")
i.Parent = game.CoreGui
i.Name = "MadeByLumine"
i.ScreenInsets = Enum.ScreenInsets.None
local j = Instance.new("Frame")
j.Size = UDim2.new(1, 0, 1, 0)
j.BackgroundTransparency = 0.3
j.BackgroundColor3 = Color3.new(0, 0, 0)
j.Parent = i
local k = Instance.new("TextLabel")
k.BackgroundTransparency = 1
k.TextStrokeTransparency = 0.5
k.Position = UDim2.new(0.265, 0, 0.23, 0)
k.Size = UDim2.new(0.17, 0, 0.04, 0)
k.TextColor3 = Color3.fromRGB(255, 255, 255)
k.Text = "Creature Of Sonaria"
k.TextScaled = true
k.Font = Enum.Font.FredokaOne
k.Parent = i
local l = Instance.new("TextLabel")
l.BackgroundTransparency = 1
l.TextStrokeTransparency = 0.5
l.Position = UDim2.new(0.23, 0, 0, 7)
l.Size = UDim2.new(0.5, 0, 0.2, 0)
l.TextColor3 = Color3.fromRGB(0, 255, 0)
l.Text = "00:00:00:00"
l.TextScaled = true
l.Font = Enum.Font.FredokaOne
l.Parent = i
local m = Instance.new("TextLabel")
m.BackgroundTransparency = 1
m.TextStrokeTransparency = 0.5
m.Position = UDim2.new(0.39, 0, 0.23, 0)
m.Size = UDim2.new(0.35, 0, 0.04, 0)
m.TextColor3 = Color3.fromRGB(116, 116, 116)
m.Text = "Auto Farm made by Luminex"
m.TextScaled = true
m.Font = Enum.Font.FredokaOne
m.Parent = i
local n = Instance.new("ImageLabel")
n.Position = UDim2.new(0.36, 0, 0.4, 0)
n.Size = UDim2.new(0.3, 0, 0.15, 0)
n.Image = "rbxassetid://6936545322"
n.BackgroundTransparency = 1
n.Parent = i
local o = Instance.new("ImageLabel")
o.Position = UDim2.new(-0.2, 0, -0.4, 0)
o.Size = UDim2.new(0.43, 0, 1.5, 0)
o.Image = "rbxassetid://9009086352"
o.BackgroundTransparency = 1
o.Rotation = -35
o.Parent = n
local p = Instance.new("TextLabel")
p.Font = Enum.Font.FredokaOne
p.BackgroundTransparency = 1
p.TextScaled = true
p.Text = 0
p.TextColor3 = Color3.fromRGB(0, 0, 0)
p.Position = UDim2.new(0.3, -16, 0.1, 2)
p.Size = UDim2.new(0.7, 0, 0.8, 0)
p.Parent = n
p.TextXAlignment = Enum.TextXAlignment.Left
local q = Instance.new("TextLabel")
q.Font = Enum.Font.FredokaOne
q.BackgroundTransparency = 1
q.TextScaled = true
q.Text = 0
q.TextColor3 = Color3.fromRGB(193, 192, 196)
q.Position = UDim2.new(0.3, -17, 0.1, 0)
q.Size = UDim2.new(0.7, 0, 0.8, 0)
q.Parent = n
q.TextXAlignment = Enum.TextXAlignment.Left

--------------------------------------- White Screen ---------------------------------------------------

game:GetService("RunService"):Set3dRenderingEnabled(true)

--------------------------------------- Timer ---------------------------------------------------

local r = 0
local s = 0
local t = 0
local u = 0
local function v()
    local w = string.format("%02d", r)
    local x = string.format("%02d", s)
    local y = string.format("%02d", t)
    local z = string.format("%02d", u)
    l.Text = w .. ":" .. x .. ":" .. y .. ":" .. z
end
local function A()
    u = u + 1
    if u >= 60 then
        u = 0
        t = t + 1
    end
    if t >= 60 then
        t = 0
        s = s + 1
    end
    if s >= 24 then
        s = 0
        r = r + 1
    end
    v()
end

--------------------------------------- Variables ---------------------------------------------------

local LP = game:GetService("Players").LocalPlayer
local PG = LP.PlayerGui
local TweenService = game:GetService("TweenService")
local RE = game:GetService("ReplicatedStorage").Remotes
local SF = PG.SaveSelectionGui.ContainerFrame.AllSlotsFrame.SlotsFrame["1"].InnerFrame.CreatureFrame
local PlayButton = SF.ButtonsFrame.PlayButton
local ClaimButton = PG.DeathGui.ContainerFrame.BottomFrame.ButtonsFrame.Return

--------------------------------------- Anti Negative effects and Anti-Afk ---------------------------------------------------

local mt = getrawmetatable(game)
setreadonly(mt, false)
local RB = {"OxygenRemote", "DrownRemote","AFKEvent", "GameAnalyticsError","MeteorSelfDamage","RequestMeteors","MeteorFlySelfDamage","TornadoSelfDamage"}
local __namecall = mt.__namecall
mt.__namecall =
    newcclosure(function(self, ...)
        if getnamecallmethod() == "FireServer" and table.find(RB, tostring(self)) then
            return
        end
        return __namecall(self, table.unpack({...}))
    end
)

for a, b in ipairs(getconnections(LP.Idled)) do
    b:Disable()
end

--------------------------------------- Functions ---------------------------------------------------

task.spawn(
    function()
        pcall(
            function()
                while true do
                    task.wait(1)
                    if PG and PG:FindFirstChild("Data")
                     then
                        q.Text = PG.Data.Coins.Value
                        p.Text = PG.Data.Coins.Value
                        A()
                    end
                end
            end
        )
    end
)

local function AutoSpawn()
    if SF.NameLabel.Text == "Kiiwin" then
        if SF.ButtonsFrame.RestartButton.Visible then
            task.wait(5)
            RE.RestartSlotRemote:InvokeServer("Slot1",false)
        elseif PlayButton.Visible then
            RE:WaitForChild("SpawnRemote"):InvokeServer("Slot1")  
            task.wait(1)
            PG.SaveSelectionGui.Enabled = false             
        end
    else
        RE.DeleteSlotRemote:InvokeServer("Slot1", false)
        RE.DeleteSlotRemote:InvokeServer("Slot2", false)
        RE.DeleteSlotRemote:InvokeServer("Slot3", false)
        for _, v in ipairs(PG.Data.Slots:GetChildren()) do
            RE.DeleteSlotRemote:InvokeServer(v.Name,false)
        end
        task.wait(1)
        RE.PurchaseCreatureRemote:InvokeServer("TrialCreatures","Kiiwin",false)
    end
end

local function AutoClaimDeathRewards()
    if PG.DeathGui.Enabled and ClaimButton.Visible then
        RE:WaitForChild("ClaimDeathRewardsRemote"):InvokeServer()
        task.wait(1)
        RE:WaitForChild("DespawnRemote"):InvokeServer()
        task.wait(1)
        PG.DeathGui.Enabled = false 
    end
end

local function CheckDeathPoints()
    PG.PromptGui.PromptFrame.Visible = false
    if LP.Character and tonumber(PG.CreatureInfoGui.ContainerFrame.TabFrames.SurvivalStats.GeneralFrame.StatsFrame.DeathPoints.Actual.Text) >= 1200 then
        RE:WaitForChild("CharactersDamageRemote"):FireServer({LP.Character})  
    end
end

local RoundCompleted = false
local RadiusStuds = 100
local Steps = 36
local Duration = 0.1
local OriginalPositionBFT
local Waypoints = {}
local PlayerData = nil

local TI = TweenInfo.new(Duration / Steps, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut)

local function TweenTo(A)
    if LP.Character then
        local B = {CFrame = A}
        local Tween = TweenService:Create(LP.Character:WaitForChild("HumanoidRootPart"), TI, B)
        Tween:Play()
        return Tween
    end
end

local function SetupWaypoints()
    Waypoints = {}
    for i = 1, Steps do
        local angle = math.rad((360 / Steps) * i)
        local x = OriginalPositionBFT.Position.X + RadiusStuds * math.cos(angle)
        local z = OriginalPositionBFT.Position.Z + RadiusStuds * math.sin(angle)
        table.insert(Waypoints, CFrame.new(x, OriginalPositionBFT.Position.Y, z))
    end
end

local function FakeMovement()
    local index = 1
    local function TweenCompleted()
        if index >= #Waypoints then
            RoundCompleted = false
            return
        end
        index += 1
        local tween = TweenTo(Waypoints[index])
        tween.Completed:Connect(TweenCompleted)
    end

    RoundCompleted = true
    local tween = TweenTo(Waypoints[index])
    tween.Completed:Connect(TweenCompleted)
end


local function AutoMud()
    local Target, MaxDistance = nil, math.huge
    for _, v in ipairs(workspace.Interactions:GetChildren()) do
        if v.Name == "Mud" then
            local distance = (LP.Character.HumanoidRootPart.Position - v.Position).Magnitude
            if distance < MaxDistance then
                MaxDistance = distance
                Target = v
            end
        end
    end

    if Target then
        local mudPosition = Target.Position + Vector3.new(0, Target.Size.Y / 2, 0)
        for _ = 1, 10 do
            LP.Character.HumanoidRootPart.CFrame = CFrame.new(mudPosition)
            RE.Mud:FireServer(Target)
        end
        task.wait()
    end
end

local function HandleMission(Mission, Type)
    if not Mission[Type].Value then
        repeat
            RE.SetRegionRemote:FireServer(Mission.Name)
            if Type == "ConcealScent" then
                AutoMud()
            elseif Type == "EatFoodDrinkWater" then
                if PG.HUDGui.BottomFrame.Other.Thirst.HoverLabel.Text ~= "100%" then
                    RE.DrinkRemote:FireServer(workspace.Interactions.Lakes.Lake)
                end
            elseif Type == "DistanceTravelled" then
                if not RoundCompleted then
                    FakeMovement()
                end
            end
            task.wait(1)
        until Mission[Type].Value
    end
end

local function AutoMissions()
    if not LP.Character then return end
    OriginalPositionBFT = LP.Character.HumanoidRootPart.CFrame
    SetupWaypoints()

    for _, v in ipairs(PG.Data.Missions.RegionMissions:GetChildren()) do
        task.spawn(function() HandleMission(v, "TimePlayed") end)
        task.spawn(function() HandleMission(v, "Sniff") end)
        task.spawn(function() HandleMission(v, "ConcealScent") end)
        task.spawn(function() HandleMission(v, "EatFoodDrinkWater") end)
        task.spawn(function() HandleMission(v, "DistanceTravelled") end)

        if not v.AttackOrHealCreature.Value then
            repeat
                local Health = PlayerData:GetAttribute("h")
                local MaxHealth = PlayerData:GetAttribute("mh")
                if Health < MaxHealth * 0.4 then else
                    RE.SetRegionRemote:FireServer(v.Name)
                    RE.CharactersDamageRemote:FireServer({LP.Character})
                end
                task.wait(1)
            until v.AttackOrHealCreature.Value
        end

        repeat task.wait(1) until
            v.TimePlayed.Value and
            v.Sniff.Value and
            v.ConcealScent.Value and
            v.EatFoodDrinkWater.Value and
            v.DistanceTravelled.Value and
            v.AttackOrHealCreature.Value
    end
end

-- start autofarm

while true do
    task.wait(0.1)
    pcall(function()
        AutoSpawn()
        AutoClaimDeathRewards()
        if LP.Character then
            AutoMissions()
            CheckDeathPoints()
        end
    end)
end
