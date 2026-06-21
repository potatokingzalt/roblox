local PotatoLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/potatokingzalt/roblox/main/library.lua?t=" .. tostring(tick())))()

local Window = PotatoLib:CreateWindow({
    Title = "Potato Kingdom - Universal"
})

local PlayerTab = Window:CreateTab("Local Player")

PlayerTab:CreateToggle("Infinite Jump", function(state)
    _G.InfJump = state
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
    if _G.InfJump then
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

PlayerTab:CreateSlider("Walk Speed", 16, 250, function(value)
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = value
    end
end)

PlayerTab:CreateSlider("Jump Power", 50, 500, function(value)
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.JumpPower = value
    end
end)

local MiscTab = Window:CreateTab("Misc")

MiscTab:CreateTextBox("Teleport To Player", function(text)
    local targetName = string.lower(text)
    for _, v in pairs(game.Players:GetPlayers()) do
        if string.lower(string.sub(v.Name, 1, #targetName)) == targetName then
            local localChar = game.Players.LocalPlayer.Character
            local targetChar = v.Character
            if localChar and targetChar and localChar:FindFirstChild("HumanoidRootPart") and targetChar:FindFirstChild("HumanoidRootPart") then
                localChar.HumanoidRootPart.CFrame = targetChar.HumanoidRootPart.CFrame
                Window:Notify("Teleported", "Teleported to " .. v.Name, 3)
            end
            break
        end
    end
end)

MiscTab:CreateToggle("ESP", function(state)
    _G.ESP = state
    while _G.ESP do
        task.wait(1)
        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr ~= game.Players.LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
                if not plr.Character.Head:FindFirstChild("PotatoESP") then
                    local hl = Instance.new("Highlight")
                    hl.Name = "PotatoESP"
                    hl.FillColor = Color3.fromRGB(92, 225, 230)
                    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                    hl.Parent = plr.Character
                end
            end
        end
    end
    
    if not _G.ESP then
        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr.Character and plr.Character:FindFirstChild("Head") and plr.Character:FindFirstChild("PotatoESP") then
                plr.Character.PotatoESP:Destroy()
            end
        end
    end
end)
