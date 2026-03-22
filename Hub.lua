local player = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera
local mouse = player:GetMouse()

-- --- ARAYÜZ ---
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "YNS_V2"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 480, 0, 380)
mainFrame.Position = UDim2.new(0.5, -240, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
mainFrame.Draggable = true
mainFrame.Active = true
mainFrame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "🔥 YNSKPTN SUPREHUB V2.0 - GOD MODE EDITION"
title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.Parent = mainFrame

-- --- SOL TARAF: KİŞİSEL PANEL ---
local selfFrame = Instance.new("Frame")
selfFrame.Size = UDim2.new(0.4, 0, 1, -50)
selfFrame.Position = UDim2.new(0, 10, 0, 45)
selfFrame.BackgroundTransparency = 1
selfFrame.Parent = mainFrame

local function createBtn(text, pos, color, func)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.Position = pos
    btn.Text = text
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.Parent = selfFrame
    btn.MouseButton1Click:Connect(func)
end

-- 🛡️ GÜÇLÜ ÖLÜMSÜZLÜK (V2)
createBtn("🛡️ ÖLÜMSÜZLÜK V2", UDim2.new(0, 0, 0, 0), Color3.fromRGB(180, 0, 0), function()
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") then
        -- Ölmeyi devre dışı bırakmaya çalışır
        character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
        character.Humanoid.MaxHealth = math.huge
        character.Humanoid.Health = math.huge
        print("V2 Ölümsüzlük Aktif! (Ölürsen tekrar basman gerekebilir)")
    end
end)

-- 👻 GÖRÜNMEZLİK
createBtn("👻 GÖRÜNMEZLİK", UDim2.new(0, 0, 0, 50), Color3.fromRGB(70, 70, 70), function()
    local char = player.Character
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("Decal") then
            part.Transparency = (part.Transparency == 1 and 0 or 1)
        end
    end
end)

-- 🕊️ FLY (UÇMA)
local flying = false
createBtn("🕊️ UÇMAYI AÇ/KAPAT", UDim2.new(0, 0, 0, 100), Color3.fromRGB(0, 100, 200), function()
    flying = not flying
    local char = player.Character
    local root = char:FindFirstChild("HumanoidRootPart")
    if flying then
        local bv = Instance.new("BodyVelocity")
        bv.Name = "YNS_Fly"
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.Parent = root
        task.spawn(function()
            while flying do
                bv.Velocity = camera.CFrame.LookVector * 60
                task.wait()
            end
            bv:Destroy()
        end)
    end
end)

-- 👁️ ESP
createBtn("👁️ ESP (PARLAMA)", UDim2.new(0, 0, 0, 150), Color3.fromRGB(100, 0, 150), function()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character then
            if not v.Character:FindFirstChild("Highlight") then
                local h = Instance.new("Highlight", v.Character)
                h.FillColor = Color3.new(1, 0, 0)
            else
                v.Character.Highlight:Destroy()
            end
        end
    end
end)

-- --- SAĞ TARAF: OYUNCU LİSTESİ ---
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(0.55, 0, 1, -50)
scroll.Position = UDim2.new(0.43, 0, 0, 45)
scroll.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
scroll.BorderSizePixel = 0
scroll.Parent = mainFrame

local list = Instance.new("UIListLayout", scroll)
list.Padding = UDim.new(0, 5)

local function updateList()
    for _, c in pairs(scroll:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player then
            local f = Instance.new("Frame")
            f.Size = UDim2.new(1, -10, 0, 40)
            f.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            f.Parent = scroll
            
            local l = Instance.new("TextLabel")
            l.Size = UDim2.new(0.4, 0, 1, 0)
            l.Text = v.DisplayName
            l.TextColor3 = Color3.new(1, 1, 1)
            l.BackgroundTransparency = 1
            l.TextScaled = true
            l.Parent = f
            
            local function btn(txt, pos, col, func)
                local b = Instance.new("TextButton")
                b.Size = UDim2.new(0.18, 0, 0.8, 0)
                b.Position = pos
                b.Text = txt
                b.BackgroundColor3 = col
                b.TextColor3 = Color3.new(1, 1, 1)
                b.Parent = f
                b.MouseButton1Click:Connect(func)
            end
            
            btn("G", UDim2.new(0.42, 0, 0.1, 0), Color3.new(0, 0.5, 0), function() player.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0) end)
            btn("Ç", UDim2.new(0.61, 0, 0.1, 0), Color3.new(0.5, 0, 0), function() v.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0) end)
            btn("İ", UDim2.new(0.8, 0, 0.1, 0), Color3.new(0, 0.3, 0.8), function() camera.CameraSubject = (camera.CameraSubject == v.Character.Humanoid and player.Character.Humanoid or v.Character.Humanoid) end)
        end
    end
end

game.Players.PlayerAdded:Connect(updateList)
game.Players.PlayerRemoving:Connect(updateList)
updateList()
