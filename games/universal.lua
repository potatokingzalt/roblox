local AutoExecuteString = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/potatokingzalt/roblox/refs/heads/main/games/universal.lua"))()]]

local queue_on_teleport = queue_on_teleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport) or (getgenv and getgenv().queue_on_teleport)

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local MarketplaceService = game:GetService("MarketplaceService")
local lp = Players.LocalPlayer

lp.OnTeleport:Connect(function(state)
    if state == Enum.TeleportState.Started or state == Enum.TeleportState.InProgress then
        if queue_on_teleport then
            queue_on_teleport(AutoExecuteString)
        end
    end
end)

local titleName = "PotatoKing Hub"
local PotatoLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/potatokingzalt/roblox/main/library.lua?t=" .. tostring(tick())))()

local Window = PotatoLib:CreateWindow({
    Title = titleName
})

local plFrame = Instance.new("Frame")
plFrame.Size = UDim2.new(0, 220, 1, 0)
plFrame.Position = UDim2.new(1, 10, 0, 0)
plFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
plFrame.BorderSizePixel = 0
plFrame.Visible = false
plFrame:SetAttribute("ToggledOn", false)

local plTitle = Instance.new("TextLabel", plFrame)
plTitle.Size = UDim2.new(1, 0, 0, 35)
plTitle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
plTitle.BorderSizePixel = 0
plTitle.Text = "Select Target"
plTitle.TextColor3 = Color3.fromRGB(92, 225, 230)
plTitle.Font = Enum.Font.GothamBold
plTitle.TextSize = 14

local plScroll = Instance.new("ScrollingFrame", plFrame)
plScroll.Size = UDim2.new(1, 0, 1, -35)
plScroll.Position = UDim2.new(0, 0, 0, 35)
plScroll.BackgroundTransparency = 1
plScroll.BorderSizePixel = 0
plScroll.ScrollBarThickness = 4
plScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
plScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
local plLayout = Instance.new("UIListLayout", plScroll)
plLayout.SortOrder = Enum.SortOrder.Name

local svFrame = Instance.new("Frame")
svFrame.Size = UDim2.new(0, 350, 1, 0)
svFrame.Position = UDim2.new(0, -360, 0, 0)
svFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
svFrame.BorderSizePixel = 0
svFrame.Visible = false
svFrame:SetAttribute("ToggledOn", false)

local svTitle = Instance.new("TextLabel", svFrame)
svTitle.Size = UDim2.new(1, 0, 0, 35)
svTitle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
svTitle.BorderSizePixel = 0
svTitle.Text = "Server Browser"
svTitle.TextColor3 = Color3.fromRGB(92, 225, 230)
svTitle.Font = Enum.Font.GothamBold
svTitle.TextSize = 14

local svTopInfo = Instance.new("Frame", svFrame)
svTopInfo.Size = UDim2.new(1, 0, 0, 100)
svTopInfo.Position = UDim2.new(0, 0, 0, 35)
svTopInfo.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
svTopInfo.BorderSizePixel = 0

local svIcon = Instance.new("ImageLabel", svTopInfo)
svIcon.Size = UDim2.new(0, 80, 0, 80)
svIcon.Position = UDim2.new(0, 10, 0, 10)
svIcon.BackgroundTransparency = 1
svIcon.Image = "rbxthumb://type=Asset&id=" .. game.PlaceId .. "&w=150&h=150"

local svName = Instance.new("TextLabel", svTopInfo)
svName.Size = UDim2.new(1, -110, 0, 40)
svName.Position = UDim2.new(0, 100, 0, 10)
svName.BackgroundTransparency = 1
svName.TextColor3 = Color3.fromRGB(255, 255, 255)
svName.Font = Enum.Font.GothamBold
svName.TextSize = 16
svName.TextXAlignment = Enum.TextXAlignment.Left
svName.TextWrapped = true
task.spawn(function()
    pcall(function() svName.Text = MarketplaceService:GetProductInfo(game.PlaceId).Name end)
end)

local svDetails = Instance.new("TextLabel", svTopInfo)
svDetails.Size = UDim2.new(1, -110, 0, 40)
svDetails.Position = UDim2.new(0, 100, 0, 50)
svDetails.BackgroundTransparency = 1
svDetails.TextColor3 = Color3.fromRGB(200, 200, 200)
svDetails.Font = Enum.Font.Gotham
svDetails.TextSize = 12
svDetails.TextXAlignment = Enum.TextXAlignment.Left
svDetails.Text = "Place ID: " .. game.PlaceId

local svScroll = Instance.new("ScrollingFrame", svFrame)
svScroll.Size = UDim2.new(1, 0, 1, -135)
svScroll.Position = UDim2.new(0, 0, 0, 135)
svScroll.BackgroundTransparency = 1
svScroll.BorderSizePixel = 0
svScroll.ScrollBarThickness = 4
svScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
svScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
local svLayout = Instance.new("UIListLayout", svScroll)
svLayout.Padding = UDim.new(0, 5)

task.spawn(function()
    local pGui
    pcall(function() pGui = game:GetService("CoreGui") end)
    if not pGui then pGui = lp:WaitForChild("PlayerGui") end
    
    local sgName = string.gsub(titleName, "%s+", "") .. "UI"
    local sg = pGui:WaitForChild(sgName, 10)
    if not sg then return end
    
    local mf
    for _, child in ipairs(sg:GetChildren()) do
        if child:IsA("Frame") and child:FindFirstChildOfClass("UISizeConstraint") then
            mf = child
            break
        end
    end
    
    if mf then
        plFrame.Parent = mf
        svFrame.Parent = mf

        local uisize = mf:FindFirstChildOfClass("UISizeConstraint")
        if uisize then
            uisize.MinSize = Vector2.new(500, 45)
        end
        
        local credText, tabCont, pageCont
        for _, child in ipairs(mf:GetChildren()) do
            if child:IsA("TextLabel") and string.find(child.Text, "Made by") then
                credText = child
            elseif child:IsA("Frame") and child.Position.Y.Offset == 55 then
                if child.Size.X.Offset == 130 then
                    tabCont = child
                else
                    pageCont = child
                end
            end
        end
        
        mf:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
            local isMinimized = mf.AbsoluteSize.Y <= 50
            if credText then credText.Visible = not isMinimized end
            if tabCont then tabCont.Visible = not isMinimized end
            if pageCont then pageCont.Visible = not isMinimized end
            
            plFrame.Visible = (not isMinimized) and (plFrame:GetAttribute("ToggledOn") == true)
            svFrame.Visible = (not isMinimized) and (svFrame:GetAttribute("ToggledOn") == true)
        end)
    else
        plFrame.Parent = sg
        svFrame.Parent = sg
    end
end)

local hiddenfling = false
local flingToggle = false
local flingAllToggle = false
local orbitToggle = false
local attachToggle = false
local annoyToggle = false
local viewToggle = false
local spinToggle = false
local spamJumpToggle = false
local flingPower = 10000
local targetPlayer = nil

local function refreshPlayerList()
    for _, v in ipairs(plScroll:GetChildren()) do
        if v:IsA("Frame") then v:Destroy() end
    end
    
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= lp then
            local pRow = Instance.new("Frame", plScroll)
            pRow.Size = UDim2.new(1, 0, 0, 45)
            pRow.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            pRow.BorderSizePixel = 0
            
            local pIcon = Instance.new("ImageLabel", pRow)
            pIcon.Size = UDim2.new(0, 35, 0, 35)
            pIcon.Position = UDim2.new(0, 5, 0, 5)
            pIcon.BackgroundTransparency = 1
            pIcon.Image = "rbxthumb://type=AvatarHeadShot&id=" .. p.UserId .. "&w=48&h=48"
            
            local pBtn = Instance.new("TextButton", pRow)
            pBtn.Size = UDim2.new(1, -50, 1, 0)
            pBtn.Position = UDim2.new(0, 45, 0, 0)
            pBtn.BackgroundTransparency = 1
            pBtn.Text = p.Name
            pBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            pBtn.Font = Enum.Font.Gotham
            pBtn.TextSize = 13
            pBtn.TextXAlignment = Enum.TextXAlignment.Left
            
            pBtn.MouseButton1Click:Connect(function()
                targetPlayer = p
                Window:Notify("Target Set", "Targeted: " .. p.Name, 2)
            end)
        end
    end
end

Players.PlayerAdded:Connect(refreshPlayerList)
Players.PlayerRemoving:Connect(refreshPlayerList)
refreshPlayerList()

local function populateServers()
    for _, v in ipairs(svScroll:GetChildren()) do
        if v:IsA("Frame") then v:Destroy() end
    end

    local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    local s, r = pcall(function() return game:HttpGet(url) end)
    if s and r then
        local data = HttpService:JSONDecode(r)
        if data and data.data then
            for _, v in ipairs(data.data) do
                if v.playing < v.maxPlayers and v.id ~= game.JobId then
                    local row = Instance.new("Frame", svScroll)
                    row.Size = UDim2.new(1, -10, 0, 40)
                    row.Position = UDim2.new(0, 5, 0, 0)
                    row.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    row.BorderSizePixel = 0

                    local info = Instance.new("TextLabel", row)
                    info.Size = UDim2.new(0, 200, 1, 0)
                    info.Position = UDim2.new(0, 10, 0, 0)
                    info.BackgroundTransparency = 1
                    info.TextColor3 = Color3.fromRGB(255, 255, 255)
                    info.Font = Enum.Font.Gotham
                    info.TextSize = 13
                    info.TextXAlignment = Enum.TextXAlignment.Left
                    info.Text = "Players: " .. v.playing .. "/" .. v.maxPlayers .. " | Ping: " .. tostring(v.ping)

                    local joinBtn = Instance.new("TextButton", row)
                    joinBtn.Size = UDim2.new(0, 80, 0, 26)
                    joinBtn.Position = UDim2.new(1, -90, 0.5, -13)
                    joinBtn.BackgroundColor3 = Color3.fromRGB(92, 225, 230)
                    joinBtn.BorderSizePixel = 0
                    joinBtn.Text = "Join"
                    joinBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
                    joinBtn.Font = Enum.Font.GothamBold
                    joinBtn.TextSize = 12

                    joinBtn.MouseButton1Click:Connect(function()
                        TeleportService:TeleportToPlaceInstance(game.PlaceId, v.id, lp)
                    end)
                end
            end
        end
    end
end

local function addSection(tab, name)
    local s1 = pcall(function() tab:CreateLabel("--- " .. name .. " ---") end)
    if not s1 then
        pcall(function() tab:CreateButton("--- " .. name .. " ---", function() end) end)
    end
end

local TrollTab = Window:CreateTab("Troll")

addSection(TrollTab, "Player")

TrollTab:CreateToggle("Show Player List GUI", function(state)
    plFrame:SetAttribute("ToggledOn", state)
    plFrame.Visible = state
end)

TrollTab:CreateTextBox("Manual Player Name", function(text)
    targetPlayer = nil
    if not text or text == "" then return end
    local targetName = string.lower(text)
    for _, v in ipairs(Players:GetPlayers()) do
        if string.lower(string.sub(v.Name, 1, #targetName)) == targetName or string.lower(string.sub(v.DisplayName, 1, #targetName)) == targetName then
            targetPlayer = v
            Window:Notify("Target Set", "Targeted: " .. v.Name, 2)
            break
        end
    end
end)

TrollTab:CreateToggle("Fling Target", function(state)
    flingToggle = state
    hiddenfling = flingToggle or flingAllToggle
end)

TrollTab:CreateToggle("Fling Whole Server", function(state)
    flingAllToggle = state
    hiddenfling = flingToggle or flingAllToggle
end)

TrollTab:CreateToggle("Orbit Target", function(state)
    orbitToggle = state
end)

addSection(TrollTab, "Annoy")

TrollTab:CreateToggle("Attach To Target", function(state)
    attachToggle = state
end)

TrollTab:CreateToggle("Annoy Target (Teleport)", function(state)
    annoyToggle = state
end)

addSection(TrollTab, "Fun & Movement")

TrollTab:CreateToggle("View Target", function(state)
    viewToggle = state
    if not state then
        if lp.Character and lp.Character:FindFirstChild("Humanoid") then
            workspace.CurrentCamera.CameraSubject = lp.Character.Humanoid
        end
    end
end)

TrollTab:CreateToggle("Spin Character", function(state)
    spinToggle = state
end)

TrollTab:CreateToggle("Spam Jump", function(state)
    spamJumpToggle = state
end)

local ServerTab = Window:CreateTab("Server")

addSection(ServerTab, "Information")

ServerTab:CreateToggle("Show Server Browser GUI", function(state)
    svFrame:SetAttribute("ToggledOn", state)
    svFrame.Visible = state
    if state then
        task.spawn(populateServers)
    end
end)

addSection(ServerTab, "Quick Actions")

ServerTab:CreateButton("Server Hop", function()
    local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    local s, r = pcall(function() return game:HttpGet(url) end)
    if s and r then
        local data = HttpService:JSONDecode(r)
        if data and data.data then
            for _, v in ipairs(data.data) do
                if v.playing < v.maxPlayers and v.id ~= game.JobId then
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, v.id, lp)
                    break
                end
            end
        end
    end
end)

ServerTab:CreateButton("Rejoin Current Server", function()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, lp)
end)

task.spawn(function()
    local movel = 0.1
    while true do
        RunService.Heartbeat:Wait()
        if hiddenfling then
            local c = lp.Character
            local hrp = c and c:FindFirstChild("HumanoidRootPart")
            
            if c and hrp and hrp.Parent then
                local vel = hrp.AssemblyLinearVelocity
                hrp.AssemblyLinearVelocity = vel * flingPower + Vector3.new(0, flingPower, 0)
                RunService.RenderStepped:Wait()
                if c and hrp and hrp.Parent then
                    hrp.AssemblyLinearVelocity = vel
                end
                RunService.Stepped:Wait()
                if c and hrp and hrp.Parent then
                    hrp.AssemblyLinearVelocity = vel + Vector3.new(0, movel, 0)
                    movel = movel * -1
                end
            end
        end
    end
end)

task.spawn(function()
    local angle = 0
    while true do
        task.wait()
        
        local myChar = lp.Character
        local mHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
        local mHum = myChar and myChar:FindFirstChild("Humanoid")
        
        if viewToggle then
            if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Humanoid") then
                workspace.CurrentCamera.CameraSubject = targetPlayer.Character.Humanoid
            elseif mHum then
                workspace.CurrentCamera.CameraSubject = mHum
            end
        end

        if spamJumpToggle and mHum then
            mHum:ChangeState(Enum.HumanoidStateType.Jumping)
        end

        if spinToggle and mHRP then
            mHRP.CFrame = mHRP.CFrame * CFrame.Angles(0, math.rad(30), 0)
        end
        
        if flingAllToggle and mHRP then
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= lp and flingAllToggle then
                    local tChar = p.Character
                    local tHRP = tChar and tChar:FindFirstChild("HumanoidRootPart")
                    if tHRP then
                        local start = tick()
                        while tick() - start < 1.5 and flingAllToggle and p.Character and p.Character:FindFirstChild("HumanoidRootPart") do
                            task.wait()
                            if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                                lp.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame
                            else
                                break
                            end
                        end
                    end
                end
            end
        elseif targetPlayer and mHRP then
            local tChar = targetPlayer.Character
            local tHRP = tChar and tChar:FindFirstChild("HumanoidRootPart")
            if tHRP then
                if flingToggle then
                    mHRP.CFrame = tHRP.CFrame
                elseif orbitToggle then
                    angle = angle + 0.1
                    mHRP.CFrame = tHRP.CFrame * CFrame.new(math.sin(angle) * 6, 0, math.cos(angle) * 6)
                elseif attachToggle then
                    mHRP.CFrame = tHRP.CFrame * CFrame.new(0, 2.5, 0)
                elseif annoyToggle then
                    mHRP.CFrame = tHRP.CFrame * CFrame.new(math.random(-3, 3), math.random(0, 3), math.random(-3, 3))
                end
            end
        end
    end
end)
