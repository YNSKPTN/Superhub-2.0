-- Modded X PLS DONATE - Fake Robux Katlama Scripti
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Oyundaki olası para verme fonksiyonlarını (Remote) otomatik bulmaya çalışır
local function findRemote()
    -- Yaygın kullanılan isimleri tarar
    local names = {"AddRobux", "GiveRobux", "ClaimRobux", "GetRobux", "AddFakeRobux", "UpdateCash", "Reward"}
    for _, name in ipairs(names) do
        local found = ReplicatedStorage:FindFirstChild(name, true)
        if found and found:IsA("RemoteEvent") then
            return found
        end
    end
    return nil
end

local Remote = findRemote()

if Remote then
    print("Çalışan sistem bulundu! Sahte Robuxlar katlanıyor...")
    -- Sonsuz döngü: Saniyede binlerce kez para sinyali gönderir
    while task.wait() do
        Remote:FireServer() -- Sunucuya sürekli 'bana para ver' sinyali yollar
    end
else
    -- Eğer özel bir isim koydularsa oyunun içindeki tüm RemoteEvent'leri spamlar
    print("Özel sistem bulunamadı, genel tarama yapılıyor...")
    while task.wait() do
        for _, v in pairs(ReplicatedStorage:GetDescendants()) do
            if v:IsA("RemoteEvent") then
                v:FireServer()
            end
        end
    end
end
