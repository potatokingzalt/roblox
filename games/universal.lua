local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local MarketplaceService = game:GetService("MarketplaceService")
local tS = game:GetService("TweenService")
local uIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local lp = Players.LocalPlayer

local AutoExecuteString = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/potatokingzalt/roblox/refs/heads/main/games/universal.lua"))()]]
local qot = queue_on_teleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport)
if qot then
    pcall(function() qot(AutoExecuteString) end)
end

local settingsFile = "PotatoKingHub_Settings.json"
local savedSettings = {}

pcall(function()
    if readfile then
        local content = readfile(settingsFile)
        if content then
            savedSettings = HttpService:JSONDecode(content)
        end
    end
end)

local function saveConfig()
    pcall(function()
        if writefile then
            writefile(settingsFile, HttpService:JSONEncode(savedSettings))
        end
    end)
end

local pGui
pcall(function() pGui = game:GetService("CoreGui") end)
if not pGui then pGui = lp:WaitForChild("PlayerGui") end

local c1 = Color3.fromRGB(22, 22, 22)
local c2 = Color3.fromRGB(32, 32, 32)
local c3 = Color3.fromRGB(92, 225, 230)
local c4 = Color3.fromRGB(255, 255, 255)
local c5 = Color3.fromRGB(45, 45, 45)
local fC = Enum.Font.FredokaOne

local PotatoLib = {}

function PotatoLib:CreateWindow(config)
    local titleTextStr = config.Title or "Potato Kingdom"
    
    local sg = Instance.new("ScreenGui")
    sg.Name = titleTextStr:gsub("%s+", "") .. "UI"
    sg.ResetOnSpawn = false
    sg.Parent = pGui

    local notifCont = Instance.new("Frame")
    notifCont.Size = UDim2.new(0, 220, 1, -40)
    notifCont.Position = UDim2.new(1, -15, 0, 20)
    notifCont.AnchorPoint = Vector2.new(1, 0)
    notifCont.BackgroundTransparency = 1
    notifCont.Parent = sg

    local notifList = Instance.new("UIListLayout")
    notifList.Padding = UDim.new(0, 10)
    notifList.VerticalAlignment = Enum.VerticalAlignment.Bottom
    notifList.HorizontalAlignment = Enum.HorizontalAlignment.Right
    notifList.SortOrder = Enum.SortOrder.LayoutOrder
    notifList.Parent = notifCont

    local WindowObj = {}

    function WindowObj:Notify(titleText, descText, duration)
        local nF = Instance.new("Frame")
        nF.Size = UDim2.new(0, 0, 0, 55)
        nF.BackgroundColor3 = c2
        nF.ClipsDescendants = true
        nF.Parent = notifCont
        
        Instance.new("UICorner", nF).CornerRadius = UDim.new(0, 10)
        local nS = Instance.new("UIStroke", nF)
        nS.Color = c3
        nS.Thickness = 2
        nS.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        
        local nT = Instance.new("TextLabel")
        nT.Size = UDim2.new(1, -10, 0, 22)
        nT.Position = UDim2.new(0, 10, 0, 4)
        nT.BackgroundTransparency = 1
        nT.Text = titleText
        nT.TextColor3 = c3
        nT.Font = fC
        nT.TextSize = 14
        nT.TextXAlignment = Enum.TextXAlignment.Left
        nT.Parent = nF
        
        local nD = Instance.new("TextLabel")
        nD.Size = UDim2.new(1, -10, 0, 18)
        nD.Position = UDim2.new(0, 10, 0, 28)
        nD.BackgroundTransparency = 1
        nD.Text = descText
        nD.TextColor3 = c4
        nD.Font = Enum.Font.GothamBold
        nD.TextSize = 11
        nD.TextXAlignment = Enum.TextXAlignment.Left
        nD.Parent = nF

        tS:Create(nF, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 55)}):Play()
        
        task.delay(duration or 3, function()
            local tw = tS:Create(nF, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 55)})
            tw:Play()
            tw.Completed:Connect(function() nF:Destroy() end)
        end)
    end

    local lF = Instance.new("Frame")
    lF.Size = UDim2.new(0, 260, 0, 100)
    lF.Position = UDim2.new(0.5, 0, 0.5, 0)
    lF.AnchorPoint = Vector2.new(0.5, 0.5)
    lF.BackgroundColor3 = c1
    lF.Parent = sg

    Instance.new("UICorner", lF).CornerRadius = UDim.new(0, 14)
    local lS = Instance.new("UIStroke", lF)
    lS.Color = c3
    lS.Thickness = 3
    lS.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local lT = Instance.new("TextLabel")
    lT.Size = UDim2.new(1, 0, 0, 35)
    lT.Position = UDim2.new(0, 0, 0, 15)
    lT.BackgroundTransparency = 1
    lT.Text = "Loading " .. titleTextStr .. "..."
    lT.TextColor3 = c3
    lT.Font = fC
    lT.TextSize = 16
    lT.Parent = lF

    local lBg = Instance.new("Frame")
    lBg.Size = UDim2.new(0.8, 0, 0, 12)
    lBg.Position = UDim2.new(0.1, 0, 0.65, 0)
    lBg.BackgroundColor3 = c2
    lBg.Parent = lF
    Instance.new("UICorner", lBg).CornerRadius = UDim.new(1, 0)
    local lBgS = Instance.new("UIStroke", lBg)
    lBgS.Color = c4
    lBgS.Thickness = 2
    lBgS.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local lBar = Instance.new("Frame")
    lBar.Size = UDim2.new(0, 0, 1, 0)
    lBar.BackgroundColor3 = c3
    lBar.Parent = lBg
    Instance.new("UICorner", lBar).CornerRadius = UDim.new(1, 0)

    local mf = Instance.new("Frame")
    mf.Size = UDim2.new(0, 0, 0, 0)
    mf.Position = UDim2.new(0.5, 0, 0.5, 0)
    mf.AnchorPoint = Vector2.new(0.5, 0.5)
    mf.BackgroundColor3 = c1
    mf.ClipsDescendants = true
    mf.Visible = false
    mf.Parent = sg

    local uisize = Instance.new("UISizeConstraint")
    uisize.MaxSize = Vector2.new(500, 330)
    uisize.MinSize = Vector2.new(500, 45)
    uisize.Parent = mf

    local uic = Instance.new("UICorner")
    uic.CornerRadius = UDim.new(0, 14)
    uic.Parent = mf

    local uis = Instance.new("UIStroke")
    uis.Color = c3
    uis.Thickness = 3
    uis.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    uis.Parent = mf

    local topBar = Instance.new("Frame")
    topBar.Size = UDim2.new(1, 0, 0, 45)
    topBar.BackgroundTransparency = 1
    topBar.Parent = mf

    local dragInput, dragStart, startPos

    topBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragStart = input.Position
            startPos = mf.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragStart = nil
                end
            end)
        end
    end)

    topBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    uIS.InputChanged:Connect(function(input)
        if input == dragInput and dragStart then
            local delta = input.Position - dragStart
            mf.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -100, 1, 0)
    title.Position = UDim2.new(0, 15, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = titleTextStr
    title.TextColor3 = c3
    title.Font = fC
    title.TextSize = 18
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = topBar

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 28, 0, 28)
    closeBtn.Position = UDim2.new(1, -38, 0, 8)
    closeBtn.BackgroundColor3 = Color3.fromRGB(235, 64, 52)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = c4
    closeBtn.Font = fC
    closeBtn.TextSize = 14
    closeBtn.Parent = topBar
    Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)
    local clsStroke = Instance.new("UIStroke", closeBtn)
    clsStroke.Color = c1
    clsStroke.Thickness = 2
    clsStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    closeBtn.MouseEnter:Connect(function() tS:Create(closeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 80, 80)}):Play() end)
    closeBtn.MouseLeave:Connect(function() tS:Create(closeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(235, 64, 52)}):Play() end)

    closeBtn.MouseButton1Click:Connect(function()
        tS:Create(mf, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        task.wait(0.3)
        sg:Destroy()
    end)

    local minBtn = Instance.new("TextButton")
    minBtn.Size = UDim2.new(0, 28, 0, 28)
    minBtn.Position = UDim2.new(1, -74, 0, 8)
    minBtn.BackgroundColor3 = Color3.fromRGB(235, 195, 52)
    minBtn.Text = "-"
    minBtn.TextColor3 = c4
    minBtn.Font = fC
    minBtn.TextSize = 20
    minBtn.Parent = topBar
    Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)
    local minStroke = Instance.new("UIStroke", minBtn)
    minStroke.Color = c1
    minStroke.Thickness = 2
    minStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    minBtn.MouseEnter:Connect(function() tS:Create(minBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 215, 70)}):Play() end)
    minBtn.MouseLeave:Connect(function() tS:Create(minBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(235, 195, 52)}):Play() end)

    local minimized = false
    minBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            tS:Create(mf, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 500, 0, 45)}):Play()
        else
            tS:Create(mf, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 500, 0, 330)}):Play()
        end
    end)

    local div = Instance.new("Frame")
    div.Size = UDim2.new(1, -30, 0, 2)
    div.Position = UDim2.new(0, 15, 1, -2)
    div.BackgroundColor3 = c3
    div.BorderSizePixel = 0
    div.Parent = topBar
    Instance.new("UICorner", div).CornerRadius = UDim.new(1, 0)

    local tabCont = Instance.new("Frame")
    tabCont.Size = UDim2.new(0, 130, 1, -90)
    tabCont.Position = UDim2.new(0, 12, 0, 55)
    tabCont.BackgroundColor3 = c2
    tabCont.Parent = mf

    Instance.new("UICorner", tabCont).CornerRadius = UDim.new(0, 10)
    local tcs = Instance.new("UIStroke", tabCont)
    tcs.Color = c5
    tcs.Thickness = 2
    tcs.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local tabList = Instance.new("UIListLayout")
    tabList.Padding = UDim.new(0, 8)
    tabList.SortOrder = Enum.SortOrder.LayoutOrder
    tabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    tabList.Parent = tabCont

    Instance.new("UIPadding", tabCont).PaddingTop = UDim.new(0, 8)

    local credText = Instance.new("TextLabel")
    credText.Size = UDim2.new(0, 130, 0, 20)
    credText.Position = UDim2.new(0, 12, 1, -28)
    credText.BackgroundTransparency = 1
    credText.Text = "Made by PotatoKing"
    credText.TextColor3 = Color3.fromRGB(150, 150, 150)
    credText.Font = Enum.Font.GothamBold
    credText.TextSize = 11
    credText.TextXAlignment = Enum.TextXAlignment.Center
    credText.Parent = mf

    local pageCont = Instance.new("Frame")
    pageCont.Size = UDim2.new(1, -164, 1, -65)
    pageCont.Position = UDim2.new(0, 152, 0, 55)
    pageCont.BackgroundTransparency = 1
    pageCont.Parent = mf

    mf:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        local isMinimized = mf.AbsoluteSize.Y <= 50
        credText.Visible = not isMinimized
        tabCont.Visible = not isMinimized
        pageCont.Visible = not isMinimized
    end)

    local pages = {}
    local tabs = {}
    local activeTab = nil

    local function switchTab(name)
        activeTab = name
        for n, p in pairs(pages) do
            if n == name then
                p.Visible = true
                p.Position = UDim2.new(0, 10, 0, 0)
                tS:Create(p, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()
            else
                p.Visible = false
            end
        end
        for n, t in pairs(tabs) do
            tS:Create(t, TweenInfo.new(0.2), {BackgroundColor3 = (n == name) and c3 or c5}):Play()
            tS:Create(t, TweenInfo.new(0.2), {TextColor3 = (n == name) and c1 or c4}):Play()
        end
    end

    function WindowObj:CreateTab(name)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -16, 0, 32)
        btn.BackgroundColor3 = c5
        btn.TextColor3 = c4
        btn.Font = fC
        btn.TextSize = 13
        btn.Text = name
        btn.AutoButtonColor = false
        btn.Parent = tabCont
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
        
        local bs = Instance.new("UIStroke", btn)
        bs.Color = c1
        bs.Thickness = 2
        bs.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

        btn.MouseEnter:Connect(function()
            if activeTab ~= name then
                tS:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(65, 65, 65)}):Play()
            end
        end)
        btn.MouseLeave:Connect(function()
            if activeTab ~= name then
                tS:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = c5}):Play()
            end
        end)

        local page = Instance.new("ScrollingFrame")
        page.Size = UDim2.new(1, 0, 1, 0)
        page.BackgroundTransparency = 1
        page.ScrollBarThickness = 4
        page.ScrollBarImageColor3 = c3
        page.BorderSizePixel = 0
        page.Visible = false
        page.Parent = pageCont
        
        local pll = Instance.new("UIListLayout", page)
        pll.Padding = UDim.new(0, 8)
        pll.SortOrder = Enum.SortOrder.LayoutOrder
        pll.HorizontalAlignment = Enum.HorizontalAlignment.Center
        
        Instance.new("UIPadding", page).PaddingTop = UDim.new(0, 2)
        
        pll:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            page.CanvasSize = UDim2.new(0, 0, 0, pll.AbsoluteContentSize.Y + 10)
        end)

        pages[name] = page
        tabs[name] = btn

        btn.MouseButton1Click:Connect(function()
            switchTab(name)
        end)

        if not activeTab then
            switchTab(name)
        end

        local TabObj = {}

        function TabObj:CreateLabel(text)
            local lBg = Instance.new("Frame")
            lBg.Size = UDim2.new(1, -10, 0, 25)
            lBg.BackgroundTransparency = 1
            lBg.Parent = page

            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, 0, 1, 0)
            lbl.BackgroundTransparency = 1
            lbl.Text = text
            lbl.TextColor3 = Color3.fromRGB(180, 180, 180)
            lbl.Font = Enum.Font.GothamBold
            lbl.TextSize = 12
            lbl.Parent = lBg
        end

        function TabObj:CreateButton(text, callback)
            local bBg = Instance.new("Frame")
            bBg.Size = UDim2.new(1, -10, 0, 38)
            bBg.BackgroundColor3 = c2
            bBg.Parent = page
            Instance.new("UICorner", bBg).CornerRadius = UDim.new(0, 8)
            local bBgS = Instance.new("UIStroke", bBg)
            bBgS.Color = c5
            bBgS.Thickness = 2
            bBgS.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

            local tBtn = Instance.new("TextButton")
            tBtn.Size = UDim2.new(1, 0, 1, 0)
            tBtn.BackgroundTransparency = 1
            tBtn.Text = text
            tBtn.TextColor3 = c4
            tBtn.Font = fC
            tBtn.TextSize = 14
            tBtn.Parent = bBg

            tBtn.MouseEnter:Connect(function() tS:Create(bBg, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(42, 42, 42)}):Play() end)
            tBtn.MouseLeave:Connect(function() tS:Create(bBg, TweenInfo.new(0.2), {BackgroundColor3 = c2}):Play() end)
            tBtn.MouseButton1Click:Connect(callback)
        end

        function TabObj:CreateCustomFrame(height)
            local fBg = Instance.new("Frame")
            fBg.Size = UDim2.new(1, -10, 0, height)
            fBg.BackgroundColor3 = c2
            fBg.Parent = page
            Instance.new("UICorner", fBg).CornerRadius = UDim.new(0, 10)
            local fBgS = Instance.new("UIStroke", fBg)
            fBgS.Color = c5
            fBgS.Thickness = 2
            fBgS.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            return fBg
        end

        function TabObj:CreateToggle(text, defaultState, callback)
            local tBg = Instance.new("Frame")
            tBg.Size = UDim2.new(1, -10, 0, 42)
            tBg.BackgroundColor3 = c2
            tBg.Parent = page
            Instance.new("UICorner", tBg).CornerRadius = UDim.new(0, 10)
            local tBgS = Instance.new("UIStroke", tBg)
            tBgS.Color = c5
            tBgS.Thickness = 2
            tBgS.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

            tBg.MouseEnter:Connect(function() tS:Create(tBg, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(42, 42, 42)}):Play() end)
            tBg.MouseLeave:Connect(function() tS:Create(tBg, TweenInfo.new(0.2), {BackgroundColor3 = c2}):Play() end)

            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(0.7, 0, 1, 0)
            lbl.Position = UDim2.new(0, 12, 0, 0)
            lbl.BackgroundTransparency = 1
            lbl.Text = text
            lbl.TextColor3 = c4
            lbl.Font = fC
            lbl.TextSize = 14
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.Parent = tBg

            local tBtn = Instance.new("TextButton")
            tBtn.Size = UDim2.new(0, 42, 0, 22)
            tBtn.Position = UDim2.new(1, -54, 0.5, -11)
            tBtn.BackgroundColor3 = c5
            tBtn.Text = ""
            tBtn.AutoButtonColor = false
            tBtn.Parent = tBg
            Instance.new("UICorner", tBtn).CornerRadius = UDim.new(1, 0)
            local btnS = Instance.new("UIStroke", tBtn)
            btnS.Color = c1
            btnS.Thickness = 2
            btnS.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

            local ind = Instance.new("Frame")
            ind.Size = UDim2.new(0, 18, 0, 18)
            ind.Position = UDim2.new(0, 2, 0.5, -9)
            ind.BackgroundColor3 = c4
            ind.Parent = tBtn
            Instance.new("UICorner", ind).CornerRadius = UDim.new(1, 0)

            local state = defaultState or false
            if state then
                tBtn.BackgroundColor3 = c3
                ind.Position = UDim2.new(1, -20, 0.5, -9)
            end

            task.spawn(function()
                callback(state)
            end)

            tBtn.MouseButton1Click:Connect(function()
                state = not state
                tS:Create(tBtn, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundColor3 = state and c3 or c5}):Play()
                
                tS:Create(ind, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {Size = UDim2.new(0, 14, 0, 14), Position = state and UDim2.new(1, -18, 0.5, -7) or UDim2.new(0, 4, 0.5, -7)}):Play()
                task.wait(0.1)
                tS:Create(ind, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 18, 0, 18), Position = state and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)}):Play()
                
                callback(state)
            end)
        end

        function TabObj:CreateTextBox(text, callback)
            local tBg = Instance.new("Frame")
            tBg.Size = UDim2.new(1, -10, 0, 42)
            tBg.BackgroundColor3 = c2
            tBg.Parent = page
            Instance.new("UICorner", tBg).CornerRadius = UDim.new(0, 10)
            local tBgS = Instance.new("UIStroke", tBg)
            tBgS.Color = c5
            tBgS.Thickness = 2
            tBgS.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

            tBg.MouseEnter:Connect(function() tS:Create(tBg, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(42, 42, 42)}):Play() end)
            tBg.MouseLeave:Connect(function() tS:Create(tBg, TweenInfo.new(0.2), {BackgroundColor3 = c2}):Play() end)

            local box = Instance.new("TextBox")
            box.Size = UDim2.new(1, -24, 1, 0)
            box.Position = UDim2.new(0, 12, 0, 0)
            box.BackgroundTransparency = 1
            box.PlaceholderText = text
            box.Text = ""
            box.TextColor3 = c3
            box.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
            box.Font = fC
            box.TextSize = 14
            box.TextXAlignment = Enum.TextXAlignment.Left
            box.ClearTextOnFocus = false
            box.Parent = tBg

            box.FocusLost:Connect(function()
                callback(box.Text)
                WindowObj:Notify("Input Updated", "Set to: " .. box.Text, 2)
            end)
        end

        function TabObj:CreateSlider(text, min, max, defaultVal, callback)
            local tBg = Instance.new("Frame")
            tBg.Size = UDim2.new(1, -10, 0, 56)
            tBg.BackgroundColor3 = c2
            tBg.Parent = page
            Instance.new("UICorner", tBg).CornerRadius = UDim.new(0, 10)
            local tBgS = Instance.new("UIStroke", tBg)
            tBgS.Color = c5
            tBgS.Thickness = 2
            tBgS.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, -24, 0, 20)
            lbl.Position = UDim2.new(0, 12, 0, 6)
            lbl.BackgroundTransparency = 1
            lbl.Text = text .. ": " .. tostring(defaultVal or min)
            lbl.TextColor3 = c4
            lbl.Font = fC
            lbl.TextSize = 14
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.Parent = tBg

            local hitBox = Instance.new("TextButton")
            hitBox.Size = UDim2.new(1, -24, 0, 26)
            hitBox.Position = UDim2.new(0, 12, 0, 26)
            hitBox.BackgroundTransparency = 1
            hitBox.Text = ""
            hitBox.Parent = tBg

            local sBg = Instance.new("Frame")
            sBg.Size = UDim2.new(1, 0, 0, 6)
            sBg.Position = UDim2.new(0, 0, 0.5, -3)
            sBg.BackgroundColor3 = c5
            sBg.Parent = hitBox
            Instance.new("UICorner", sBg).CornerRadius = UDim.new(1, 0)

            local sFill = Instance.new("Frame")
            local startPos = math.clamp(((defaultVal or min) - min) / (max - min), 0, 1)
            sFill.Size = UDim2.new(startPos, 0, 1, 0)
            sFill.BackgroundColor3 = c3
            sFill.Parent = sBg
            Instance.new("UICorner", sFill).CornerRadius = UDim.new(1, 0)

            local sDrag = Instance.new("Frame")
            sDrag.Size = UDim2.new(0, 14, 0, 14)
            sDrag.Position = UDim2.new(1, -7, 0.5, -7)
            sDrag.BackgroundColor3 = c4
            sDrag.Parent = sFill
            Instance.new("UICorner", sDrag).CornerRadius = UDim.new(1, 0)

            local dragging = false
            local function update(input)
                local pos = math.clamp((input.Position.X - sBg.AbsolutePosition.X) / sBg.AbsoluteSize.X, 0, 1)
                local val = math.floor(min + ((max - min) * pos))
                lbl.Text = text .. ": " .. tostring(val)
                tS:Create(sFill, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {Size = UDim2.new(pos, 0, 1, 0)}):Play()
                callback(val)
            end

            hitBox.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    tS:Create(sDrag, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 18, 0, 18), Position = UDim2.new(1, -9, 0.5, -9)}):Play()
                    update(input)
                end
            end)
            
            uIS.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    if dragging then
                        dragging = false
                        tS:Create(sDrag, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(1, -7, 0.5, -7)}):Play()
                    end
                end
            end)
            
            uIS.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    update(input)
                end
            end)

            task.spawn(function() callback(defaultVal or min) end)
        end

        return TabObj
    end

    task.spawn(function()
        local twLoad = tS:Create(lBar, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 1, 0)})
        twLoad:Play()
        twLoad.Completed:Wait()
        
        tS:Create(lF, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        task.wait(0.3)
        lF:Destroy()
        
        mf.Visible = true
        tS:Create(mf, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 500, 0, 330)}):Play()
        WindowObj:Notify("Welcome!", titleTextStr .. " successfully loaded.", 4)
    end)

    return WindowObj
end

local Window = PotatoLib:CreateWindow({
    Title = "PotatoKing Hub"
})

local flingToggle = false
local flingAllToggle = false
local orbitToggle = false
local attachToggle = false
local annoyToggle = false
local viewToggle = false
local spinToggle = false
local spamJumpToggle = false
local noclipToggle = false
local infJumpToggle = false
local espToggle = false
local fullbrightToggle = false
local loopWSToggle = false
local loopJPToggle = false
local currentWS = 16
local currentJP = 50
local targetPlayer = nil

local TrollTab = Window:CreateTab("Troll")
TrollTab:CreateLabel("--- Player ---")

local playerListBg = TrollTab:CreateCustomFrame(150)
playerListBg.Visible = false

local plScroll = Instance.new("ScrollingFrame", playerListBg)
plScroll.Size = UDim2.new(1, -10, 1, -10)
plScroll.Position = UDim2.new(0, 5, 0, 5)
plScroll.BackgroundTransparency = 1
plScroll.BorderSizePixel = 0
plScroll.ScrollBarThickness = 4
local plLayout = Instance.new("UIListLayout", plScroll)
plLayout.SortOrder = Enum.SortOrder.Name
plLayout.Padding = UDim.new(0, 4)

local function refreshPlayerList()
    for _, v in ipairs(plScroll:GetChildren()) do
        if v:IsA("Frame") then v:Destroy() end
    end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= lp then
            local pRow = Instance.new("Frame", plScroll)
            pRow.Size = UDim2.new(1, 0, 0, 36)
            pRow.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            Instance.new("UICorner", pRow).CornerRadius = UDim.new(0, 4)
            
            local pIcon = Instance.new("ImageLabel", pRow)
            pIcon.Size = UDim2.new(0, 26, 0, 26)
            pIcon.Position = UDim2.new(0, 6, 0.5, -13)
            pIcon.BackgroundTransparency = 1
            pIcon.Image = "rbxthumb://type=AvatarHeadShot&id=" .. p.UserId .. "&w=48&h=48"
            Instance.new("UICorner", pIcon).CornerRadius = UDim.new(1, 0)

            local pBtn = Instance.new("TextButton", pRow)
            pBtn.Size = UDim2.new(1, -40, 1, 0)
            pBtn.Position = UDim2.new(0, 38, 0, 0)
            pBtn.BackgroundTransparency = 1
            pBtn.Text = p.Name
            pBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
            pBtn.Font = Enum.Font.Gotham
            pBtn.TextSize = 13
            pBtn.TextXAlignment = Enum.TextXAlignment.Left
            
            pBtn.MouseButton1Click:Connect(function()
                targetPlayer = p
                Window:Notify("Target Set", "Targeted: " .. p.Name, 2)
            end)
        end
    end
    plScroll.CanvasSize = UDim2.new(0, 0, 0, plLayout.AbsoluteContentSize.Y)
end

Players.PlayerAdded:Connect(refreshPlayerList)
Players.PlayerRemoving:Connect(refreshPlayerList)
refreshPlayerList()

TrollTab:CreateToggle("Show Player List GUI", savedSettings["Show Player List GUI"], function(state)
    savedSettings["Show Player List GUI"] = state
    saveConfig()
    playerListBg.Visible = state
end)

TrollTab:CreateTextBox("Manual Player Name", function(text)
    targetPlayer = nil
    local targetName = string.lower(text)
    for _, v in ipairs(Players:GetPlayers()) do
        if string.lower(string.sub(v.Name, 1, #targetName)) == targetName or string.lower(string.sub(v.DisplayName, 1, #targetName)) == targetName then
            targetPlayer = v
            Window:Notify("Target Set", "Targeted: " .. v.Name, 2)
            break
        end
    end
end)

TrollTab:CreateToggle("Fling Target", savedSettings["Fling Target"], function(state)
    savedSettings["Fling Target"] = state
    saveConfig()
    flingToggle = state
end)

TrollTab:CreateToggle("Fling Whole Server", savedSettings["Fling Whole Server"], function(state)
    savedSettings["Fling Whole Server"] = state
    saveConfig()
    flingAllToggle = state
end)

TrollTab:CreateToggle("Orbit Target", savedSettings["Orbit Target"], function(state)
    savedSettings["Orbit Target"] = state
    saveConfig()
    orbitToggle = state
end)

TrollTab:CreateLabel("--- Annoy ---")

TrollTab:CreateToggle("Attach To Target", savedSettings["Attach To Target"], function(state)
    savedSettings["Attach To Target"] = state
    saveConfig()
    attachToggle = state
end)

TrollTab:CreateToggle("Annoy Target (Teleport)", savedSettings["Annoy Target (Teleport)"], function(state)
    savedSettings["Annoy Target (Teleport)"] = state
    saveConfig()
    annoyToggle = state
end)

local LocalTab = Window:CreateTab("Local")
LocalTab:CreateLabel("--- Movement ---")

LocalTab:CreateSlider("WalkSpeed", 16, 250, savedSettings["WalkSpeed"] or 16, function(val)
    savedSettings["WalkSpeed"] = val
    saveConfig()
    currentWS = val
    if lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
        lp.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = val
    end
end)

LocalTab:CreateToggle("Loop WalkSpeed", savedSettings["Loop WS"], function(state)
    savedSettings["Loop WS"] = state
    saveConfig()
    loopWSToggle = state
end)

LocalTab:CreateSlider("JumpPower", 50, 500, savedSettings["JumpPower"] or 50, function(val)
    savedSettings["JumpPower"] = val
    saveConfig()
    currentJP = val
    if lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
        lp.Character:FindFirstChildOfClass("Humanoid").JumpPower = val
    end
end)

LocalTab:CreateToggle("Loop JumpPower", savedSettings["Loop JP"], function(state)
    savedSettings["Loop JP"] = state
    saveConfig()
    loopJPToggle = state
end)

LocalTab:CreateToggle("Infinite Jump", savedSettings["Infinite Jump"], function(state)
    savedSettings["Infinite Jump"] = state
    saveConfig()
    infJumpToggle = state
end)

LocalTab:CreateToggle("Noclip", savedSettings["Noclip"], function(state)
    savedSettings["Noclip"] = state
    saveConfig()
    noclipToggle = state
end)

LocalTab:CreateLabel("--- Fun ---")

LocalTab:CreateToggle("Spin Character", savedSettings["Spin Character"], function(state)
    savedSettings["Spin Character"] = state
    saveConfig()
    spinToggle = state
end)

LocalTab:CreateToggle("Spam Jump", savedSettings["Spam Jump"], function(state)
    savedSettings["Spam Jump"] = state
    saveConfig()
    spamJumpToggle = state
end)

local VisualsTab = Window:CreateTab("Visuals")
VisualsTab:CreateLabel("--- View ---")

VisualsTab:CreateToggle("Player ESP", savedSettings["Player ESP"], function(state)
    savedSettings["Player ESP"] = state
    saveConfig()
    espToggle = state
end)

VisualsTab:CreateToggle("Fullbright", savedSettings["Fullbright"], function(state)
    savedSettings["Fullbright"] = state
    saveConfig()
    fullbrightToggle = state
    if state then
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.ColorShift_Bottom = Color3.new(1, 1, 1)
        Lighting.ColorShift_Top = Color3.new(1, 1, 1)
    end
end)

VisualsTab:CreateToggle("View Target", savedSettings["View Target"], function(state)
    savedSettings["View Target"] = state
    saveConfig()
    viewToggle = state
    if not state then
        if lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
            workspace.CurrentCamera.CameraSubject = lp.Character:FindFirstChildOfClass("Humanoid")
        end
    end
end)

local UtilityTab = Window:CreateTab("Utility")
UtilityTab:CreateLabel("--- Teleport ---")

UtilityTab:CreateButton("Teleport to Target", function()
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
            lp.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
        end
    else
        Window:Notify("Error", "Target player or character not found.", 2)
    end
end)

local ServerTab = Window:CreateTab("Server")
ServerTab:CreateLabel("--- Information ---")

local serverListBg = ServerTab:CreateCustomFrame(180)
serverListBg.Visible = false

local svScroll = Instance.new("ScrollingFrame", serverListBg)
svScroll.Size = UDim2.new(1, -10, 1, -10)
svScroll.Position = UDim2.new(0, 5, 0, 5)
svScroll.BackgroundTransparency = 1
svScroll.BorderSizePixel = 0
svScroll.ScrollBarThickness = 4
local svLayout = Instance.new("UIListLayout", svScroll)
svLayout.Padding = UDim.new(0, 5)

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
                    row.Size = UDim2.new(1, -10, 0, 35)
                    row.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 4)
                    
                    local info = Instance.new("TextLabel", row)
                    info.Size = UDim2.new(0, 200, 1, 0)
                    info.Position = UDim2.new(0, 10, 0, 0)
                    info.BackgroundTransparency = 1
                    info.TextColor3 = Color3.fromRGB(220, 220, 220)
                    info.Font = Enum.Font.Gotham
                    info.TextSize = 12
                    info.TextXAlignment = Enum.TextXAlignment.Left
                    info.Text = "Players: " .. v.playing .. "/" .. v.maxPlayers .. " | Ping: " .. tostring(v.ping)

                    local joinBtn = Instance.new("TextButton", row)
                    joinBtn.Size = UDim2.new(0, 60, 0, 24)
                    joinBtn.Position = UDim2.new(1, -70, 0.5, -12)
                    joinBtn.BackgroundColor3 = Color3.fromRGB(92, 225, 230)
                    joinBtn.Text = "Join"
                    joinBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
                    joinBtn.Font = Enum.Font.GothamBold
                    joinBtn.TextSize = 12
                    Instance.new("UICorner", joinBtn).CornerRadius = UDim.new(0, 4)

                    joinBtn.MouseButton1Click:Connect(function()
                        if qot then pcall(function() qot(AutoExecuteString) end) end
                        TeleportService:TeleportToPlaceInstance(game.PlaceId, v.id, lp)
                    end)
                end
            end
            svScroll.CanvasSize = UDim2.new(0, 0, 0, svLayout.AbsoluteContentSize.Y)
        end
    end
end

ServerTab:CreateToggle("Show Server Browser GUI", savedSettings["Show Server Browser GUI"], function(state)
    savedSettings["Show Server Browser GUI"] = state
    saveConfig()
    serverListBg.Visible = state
    if state then
        task.spawn(populateServers)
    end
end)

ServerTab:CreateLabel("--- Quick Actions ---")

ServerTab:CreateButton("Server Hop", function()
    local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    local s, r = pcall(function() return game:HttpGet(url) end)
    if s and r then
        local data = HttpService:JSONDecode(r)
        if data and data.data then
            for _, v in ipairs(data.data) do
                if v.playing < v.maxPlayers and v.id ~= game.JobId then
                    if qot then pcall(function() qot(AutoExecuteString) end) end
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, v.id, lp)
                    break
                end
            end
        end
    end
end)

ServerTab:CreateButton("Rejoin Current Server", function()
    if qot then pcall(function() qot(AutoExecuteString) end) end
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, lp)
end)

Lighting.Changed:Connect(function()
    if fullbrightToggle then
        Lighting.Ambient = Color3.new(1, 1, 1)
        Lighting.ColorShift_Bottom = Color3.new(1, 1, 1)
        Lighting.ColorShift_Top = Color3.new(1, 1, 1)
    end
end)

local function updateESP()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= lp then
            local char = p.Character
            if char then
                local hl = char:FindFirstChild("PotatoESP")
                if espToggle then
                    if not hl then
                        hl = Instance.new("Highlight")
                        hl.Name = "PotatoESP"
                        hl.FillColor = Color3.fromRGB(255, 0, 0)
                        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                        hl.FillTransparency = 0.5
                        hl.OutlineTransparency = 0
                        hl.Parent = char
                    end
                else
                    if hl then hl:Destroy() end
                end
            end
        end
    end
end

uIS.JumpRequest:Connect(function()
    if infJumpToggle and lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
        lp.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

RunService.Stepped:Connect(function()
    if noclipToggle and lp.Character then
        for _, v in ipairs(lp.Character:GetDescendants()) do
            if v:IsA("BasePart") and v.CanCollide then
                v.CanCollide = false
            end
        end
    end
end)

local angle = 0

RunService.Heartbeat:Connect(function()
    local myChar = lp.Character
    local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
    local myHum = myChar and myChar:FindFirstChildOfClass("Humanoid")
    
    updateESP()

    if loopWSToggle and myHum then
        myHum.WalkSpeed = currentWS
    end
    if loopJPToggle and myHum then
        myHum.JumpPower = currentJP
    end

    if viewToggle then
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChildOfClass("Humanoid") then
            workspace.CurrentCamera.CameraSubject = targetPlayer.Character:FindFirstChildOfClass("Humanoid")
        elseif myHum then
            workspace.CurrentCamera.CameraSubject = myHum
        end
    end

    if myHum and spamJumpToggle then
        myHum:ChangeState(Enum.HumanoidStateType.Jumping)
    end

    if myHrp and spinToggle then
        myHrp.CFrame = myHrp.CFrame * CFrame.Angles(0, math.rad(45), 0)
    end

    local tHrp = nil
    if targetPlayer and targetPlayer.Character then
        tHrp = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
    end

    if myHrp and tHrp then
        if flingToggle then
            myHrp.RotVelocity = Vector3.new(0, 50000, 0)
            myHrp.CFrame = tHrp.CFrame
        elseif orbitToggle then
            angle = angle + 0.1
            myHrp.Velocity = Vector3.new(0, 0, 0)
            myHrp.CFrame = tHrp.CFrame * CFrame.new(math.sin(angle) * 6, 0, math.cos(angle) * 6)
        elseif attachToggle then
            myHrp.Velocity = Vector3.new(0, 0, 0)
            myHrp.CFrame = tHrp.CFrame * CFrame.new(0, 2.5, 0)
        elseif annoyToggle then
            myHrp.Velocity = Vector3.new(0, 0, 0)
            myHrp.CFrame = tHrp.CFrame * CFrame.new(math.random(-3, 3), math.random(0, 3), math.random(-3, 3))
        end
    end

    if flingAllToggle and myHrp then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local ptHrp = p.Character.HumanoidRootPart
                myHrp.RotVelocity = Vector3.new(0, 50000, 0)
                myHrp.CFrame = ptHrp.CFrame
                task.wait(0.05)
            end
        end
    end
end)
