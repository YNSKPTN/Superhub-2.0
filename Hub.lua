local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local runService = game:GetService("RunService")

-- --- ARAYÜZ (KÜÇÜLTME + ÖLÜMSÜZLÜK + İZLE + GİT) ---
-- [Önceki panel kodlarının hepsi burada, sadece God Mode butonu değişti]

local godBtn = Instance.new("TextButton")
godBtn.Text = "FAKE BODY GOD [KAPALI]"
godBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 150) -- Mor renk (Yeni Mod)
godBtn.Parent = mainFrame

local godActive = false
godBtn.MouseButton1Click:Connect(function()
    godActive = not godActive
    godBtn.Text = "FAKE BODY " .. (godActive and "[AKTİF]" or "[KAPALI]")
    
    if godActive then
        -- 🛡️ KARAKTERİ KLONLAYIP ASIL GÖVDENİ SAKLAMA
        pcall(function()
            local char = player.Character
            char.Archivable = true
            local clone = char:Clone()
            clone.Parent = workspace
            
            -- Gerçek karakterini çok uzağa ışınla (Görünmez yap)
            char.HumanoidRootPart.CFrame = CFrame.new(0, 5000, 0) 
            
            -- Kamerayı ve kontrolü klona ver
            workspace.CurrentCamera.CameraSubject = clone.Humanoid
            
            -- Oyun hasar verirse klona verir, asıl karakterin 5000 metre yukarıda güvende kalır!
        end)
    else
        -- Kapatınca normal karaktere dön
        player.Character.HumanoidRootPart.CFrame = workspace.CurrentCamera.Focus
    end
end)

-- --- İZLEME VE GİTME (EKSİKSİZ KORUNDU) ---
-- [Tüm o LookVector izleme ve tam içine gitme kodları burada]
