if not game:IsLoaded() then game.Loaded:Wait() end

local PotatoLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/potatokingzalt/roblox/main/library.lua"))()

local Window = PotatoLib:CreateWindow({
    Title = "Potato Kingdom"
})

local MainTab = Window:CreateTab("Main")
local PlayerTab = Window:CreateTab("Player")
local MiscTab = Window:CreateTab("Misc")

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

local Network = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Packages"):WaitForChild("Network")

local WeightsList = {
    "Bone Barbell", "Stone Block", "Copper Plate", "Iron Plate",
    "Ice Barbell", "Donut Barbell", "Golden Barbell", "Heaven Plate",
    "Mega Golden Barbell", "Neon Pulse", "Giant Gold Star Barbell",
    "Emerald Barbell", "Planet Barbell"
}

local Settings = {
    AutoFarm = false,
    AutoTrain = false,
    AutoCollect = false,
    AutoAdBypass = true,
    AntiAFK = true,
    WeightIndex = 1,
    KickCooldown = 8.5
}

local isCollecting = false 
local isTweening = false   
local isKicking = false    

local mt = getrawmetatable(game)
local oldNewIndex = mt.__newindex
if setreadonly then setreadonly(mt, false) end

mt.__newindex = newcclosure(function(t, k, v)
    if not checkcaller() and Settings.AutoTrain then
        if t:IsA("Humanoid") and k == "WalkSpeed" then
            if type(v) == "number" and v < 16 then
                return oldNewIndex(t, k, 16)
            end
        end
    end
    return oldNewIndex(t, k, v)
end)

if setreadonly then setreadonly(mt, true) end

LocalPlayer.Idled:Connect(function()
    if Settings.AntiAFK then
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end
end)

local function ExecuteAdBypass()
    if Network:FindFirstChild("rev_requestAd") then Network.rev_requestAd:FireServer("x3Offline") end
    for _, remote in ipairs(Network:GetChildren()) do
        if remote:IsA("RemoteEvent") then
            local name = string.lower(remote.Name)
            if (string.find(name, "ad") or string.find(name, "reward") or string.find(name, "claim") or string.find(name, "offline")) and not string.find(name, "speed") then
                pcall(function()
                    remote:FireServer("x3Offline")
                    remote:FireServer(true)
                    remote:FireServer(1)
                    remote:FireServer()
                end)
            end
        end
    end
end

if Settings.AutoAdBypass then task.spawn(ExecuteAdBypass) end

local function GetPlayerPlotCFrame()
    local plotsFolder = workspace:FindFirstChild("Plots")
    if plotsFolder then
        for _, plot in ipairs(plotsFolder:GetChildren()) do
            local ownerLabel = plot:FindFirstChild("Decorations")
            if ownerLabel then ownerLabel = ownerLabel:FindFirstChild("PlotOwner") end
            if ownerLabel then ownerLabel = ownerLabel:FindFirstChild("OwnerGUI") end
            if ownerLabel then ownerLabel = ownerLabel:FindFirstChild("TextLabel") end
            
            if ownerLabel and ownerLabel.Text == LocalPlayer.Name then
                local spawnPart = plot:FindFirstChild("SpawnPart")
                if spawnPart then
                    return spawnPart.CFrame
                else
                    return plot:GetPivot()
                end
            end
        end
    end
    return nil
end

MainTab:CreateToggle("Auto Farm (Fly & Kick Loop)", function(state)
    Settings.AutoFarm = state
end)

MainTab:CreateToggle("Auto Collect Coins (Teleports)", function(state)
    Settings.AutoCollect = state
end)

MainTab:CreateToggle("Auto Train & Upgrade Weights", function(state)
    Settings.AutoTrain = state
end)

PlayerTab:CreateSlider("WalkSpeed", 16, 250, function(value)
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
end)

PlayerTab:CreateSlider("JumpPower", 50, 300, function(value)
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
    end
end)

MiscTab:CreateSlider("Kick Cooldown (Delay)", 1, 25, function(value)
    Settings.KickCooldown = value
end)

MiscTab:CreateToggle("Auto Ad Bypass", function(state)
    Settings.AutoAdBypass = state
    if state then ExecuteAdBypass() end
end)

MiscTab:CreateToggle("Anti-AFK", function(state)
    Settings.AntiAFK = state
end)

local lastCollectTime = 0

task.spawn(function()
    while task.wait(1) do
        if Settings.AutoCollect and Network:FindFirstChild("rev_B_Collect") then
            if tick() - lastCollectTime >= 300 then
                lastCollectTime = tick()
                
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                
                if hrp then
                    local baseCFrame = GetPlayerPlotCFrame()
                    if baseCFrame then
                        local dist = (hrp.Position - baseCFrame.Position).Magnitude
                        if dist > 30 and not isTweening and not isKicking then
                            isCollecting = true
                            
                            if char:FindFirstChild("Humanoid") then
                                char.Humanoid:UnequipTools()
                            end
                            
                            local oldCF = char:GetPivot()
                            char:PivotTo(baseCFrame * CFrame.new(0, 5, 0))
                            hrp.Anchored = true
                            task.wait(0.2) 
                            
                            for i = 1, 10 do 
                                local args = {i}
                                Network.rev_B_Collect:FireServer(unpack(args))
                            end
                            task.wait(0.1)
                            
                            hrp.Anchored = false
                            char:PivotTo(oldCF)
                            isCollecting = false
                        elseif dist <= 30 then
                            for i = 1, 10 do 
                                local args = {i}
                                Network.rev_B_Collect:FireServer(unpack(args))
                            end
                        end
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.3) do
        pcall(function()
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChild("Humanoid")
            if not char or not hrp or not hum then return end

            local isMoving = hum.MoveDirection.Magnitude > 0

            if Settings.AutoTrain and not isCollecting and not isTweening and not isKicking then
                if isMoving then
                    local currentTool = char:FindFirstChildWhichIsA("Tool")
                    if currentTool and table.find(WeightsList, currentTool.Name) then
                        hum:UnequipTools()
                    end
                else
                    local targetWeight = WeightsList[Settings.WeightIndex]
                    if targetWeight and Network:FindFirstChild("rev_Shop_Buy") and Network:FindFirstChild("rev_WeightEquip") then
                        Network.rev_Shop_Buy:FireServer("WeightShop", targetWeight)
                        Network.rev_WeightEquip:FireServer(targetWeight)
                        
                        local weightTool = char:FindFirstChild(targetWeight) or LocalPlayer.Backpack:FindFirstChild(targetWeight)
                        if not weightTool then
                            for _, t in ipairs(char:GetChildren()) do
                                if t:IsA("Tool") and table.find(WeightsList, t.Name) then weightTool = t break end
                            end
                            if not weightTool then
                                for _, t in ipairs(LocalPlayer.Backpack:GetChildren()) do
                                    if t:IsA("Tool") and table.find(WeightsList, t.Name) then weightTool = t break end
                                end
                            end
                        end

                        if weightTool then
                            if not char:FindFirstChild(weightTool.Name) then
                                hum:EquipTool(weightTool)
                                task.wait(0.1)
                            end
                            weightTool:Activate()
                            
                            if weightTool.Name == targetWeight and Settings.WeightIndex < #WeightsList then
                                Settings.WeightIndex = Settings.WeightIndex + 1
                            end
                        end
                    end
                end
            end

            if Settings.AutoFarm then
                local targetPos = CFrame.new(700.11, 3.00, 231.58)
                local dist = (hrp.Position - targetPos.Position).Magnitude
                
                if dist > 10 and not isCollecting and not isKicking then
                    isTweening = true
                    hum:UnequipTools() 
                    
                    local speed = 40
                    local tweenInfo = TweenInfo.new(dist / speed, Enum.EasingStyle.Linear)
                    local tween = TweenService:Create(hrp, tweenInfo, {CFrame = targetPos})
                    
                    hrp.Anchored = true
                    tween:Play()
                    
                    while tween.PlaybackState == Enum.PlaybackState.Playing and not isCollecting and not isKicking do
                        task.wait(0.1)
                    end
                    if isCollecting or isKicking then tween:Cancel() end
                    
                    hrp.Anchored = false
                    isTweening = false
                    task.wait(0.2) 
                    
                elseif dist <= 10 and not isCollecting and not isTweening and not isKicking then
                    if Network:FindFirstChild("rev_KickEvent") then
                        Network.rev_KickEvent:FireServer(1, 1)
                    end
                    
                    isKicking = true
                    local actualDelay = Settings.KickCooldown + (math.random(-5, 5) / 10)
                    
                    task.delay(actualDelay, function()
                        isKicking = false
                    end)
                end
            end
        end)
    end
end)
