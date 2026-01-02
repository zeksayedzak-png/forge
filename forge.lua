-- 🎄 FREE CHRISTMAS PICKAXE HACK
-- ⚠️ FOR EDUCATIONAL PURPOSES ONLY

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- تنظيف
for _, gui in pairs(CoreGui:GetChildren()) do
    if gui.Name == "XmasPickaxeHack" then
        gui:Destroy()
    end
end

-- واجهة صغيرة للموبايل
local gui = Instance.new("ScreenGui")
gui.Name = "XmasPickaxeHack"
gui.Parent = CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 180)
frame.Position = UDim2.new(0.1, 0, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 50, 40)
frame.BorderSizePixel = 0
frame.Parent = gui

-- تحريك بالإصبع
local dragging = false
local dragStart, startPos

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)

frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

frame.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.Touch then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

local title = Instance.new("TextLabel")
title.Text = "🎄 FREE XMAS PICKAXE"
title.Size = UDim2.new(1, 0, 0, 25)
title.BackgroundColor3 = Color3.fromRGB(200, 0, 50)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 13
title.Parent = frame

-- البحث عن زر الشراء
local function findBuyButton()
    local path = {
        "ChristmasEventShop", "Frame", "Main", "List", 
        "ChristmasPickaxe", "Main", "BuyFrameHandler", 
        "BuyFrame", "Buy"
    }
    
    local current = player.PlayerGui
    
    for _, folder in ipairs(path) do
        current = current:FindFirstChild(folder)
        if not current then
            return nil
        end
    end
    
    return current
end

-- زر البحث
local findBtn = Instance.new("TextButton")
findBtn.Text = "🔍 FIND BUY BUTTON"
findBtn.Size = UDim2.new(0.9, 0, 0, 30)
findBtn.Position = UDim2.new(0.05, 0, 0.2, 0)
findBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
findBtn.TextColor3 = Color3.new(1, 1, 1)
findBtn.Font = Enum.Font.SourceSansBold
findBtn.TextSize = 12
findBtn.Parent = frame

-- زر الشراء المجاني
local freeBuyBtn = Instance.new("TextButton")
freeBuyBtn.Text = "💰 BUY FOR FREE"
freeBuyBtn.Size = UDim2.new(0.9, 0, 0, 35)
freeBuyBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
freeBuyBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
freeBuyBtn.TextColor3 = Color3.new(1, 1, 1)
freeBuyBtn.Font = Enum.Font.SourceSansBold
freeBuyBtn.TextSize = 13
freeBuyBtn.Parent = frame

-- النتائج
local resultBox = Instance.new("TextLabel")
resultBox.Text = "👉 اضغط FIND أولاً"
resultBox.Size = UDim2.new(0.9, 0, 0, 50)
resultBox.Position = UDim2.new(0.05, 0, 0.65, 0)
resultBox.BackgroundColor3 = Color3.fromRGB(40, 60, 50)
resultBox.TextColor3 = Color3.new(1, 1, 1)
resultBox.TextWrapped = true
resultBox.Font = Enum.Font.SourceSans
resultBox.TextSize = 11
resultBox.Parent = frame

-- متغيرات
local buyButton = nil
local originalConnections = {}

-- البحث عن الزر
findBtn.MouseButton1Click:Connect(function()
    resultBox.Text = "🔍 جاري البحث عن زر الشراء..."
    
    buyButton = findBuyButton()
    
    if buyButton then
        resultBox.Text = "✅ وجدت زر الشراء!\n"
        resultBox.Text = resultBox.Text .. "📍 " .. buyButton:GetFullName()
        freeBuyBtn.Text = "💰 BUY FOR FREE (جاهز)"
        freeBuyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    else
        resultBox.Text = "❌ ما لقيت الزر\n"
        resultBox.Text = resultBox.Text .. "🔍 افتح متجر الكريسماس أولاً"
        freeBuyBtn.Text = "💰 BUY FOR FREE"
        freeBuyBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end
end)

-- شراء ببلاش
freeBuyBtn.MouseButton1Click:Connect(function()
    if not buyButton then
        resultBox.Text = "❌ ابحث عن الزر أولاً!"
        return
    end
    
    resultBox.Text = "🎄 جاري الشراء ببلاش...\n"
    
    -- الطريقة 1: تعطيل الزر الأصلي وإضافة زر جديد
    if getconnections then
        -- حفظ الوصلات الأصلية
        local connections = getconnections(buyButton.MouseButton1Click)
        originalConnections = connections
        
        -- تعطيلها
        for _, conn in pairs(connections) do
            conn:Disable()
        end
        
        resultBox.Text = resultBox.Text .. "⚡ عطلت الوظيفة الأصلية\n"
    end
    
    -- إضافة وظيفة جديدة
    local newConnection = buyButton.MouseButton1Click:Connect(function()
        resultBox.Text = resultBox.Text .. "🛒 تم النقر على الزر المخترق\n"
        
        -- بيانات الشراء المزورة
        local fakeData = {
            itemName = "ChristmasPickaxe",
            itemId = "xmas_pickaxe_2024",
            price = 0,  -- ⭐ السعر صفر!
            originalPrice = 999,  -- السعر الأصلي (للإظهار فقط)
            currency = "ROBUX",
            playerId = player.UserId,
            shopType = "ChristmasEvent",
            receipt = "FREE_XMAS_" .. os.time() .. "_" .. math.random(1000, 9999),
            timestamp = os.time()
        }
        
        -- إرسال لجميع Remotes المحتملة
        local remoteCount = 0
        
        -- البحث عن RemoteEvents
        for _, remote in pairs(game:GetDescendants()) do
            if remote:IsA("RemoteEvent") then
                local remoteName = remote.Name:lower()
                if remoteName:find("purchase") or 
                   remoteName:find("buy") or 
                   remoteName:find("shop") or
                   remoteName:find("christmas") then
                    
                    pcall(function()
                        remote:FireServer(fakeData)
                        remote:FireServer("PurchaseItem", fakeData)
                        remote:FireServer("BuyChristmasItem", fakeData)
                        remoteCount = remoteCount + 1
                    end)
                end
            end
        end
        
        -- البحث عن RemoteFunctions
        for _, remote in pairs(game:GetDescendants()) do
            if remote:IsA("RemoteFunction") then
                local remoteName = remote.Name:lower()
                if remoteName:find("purchase") or remoteName:find("buy") then
                    pcall(function()
                        remote:InvokeServer(fakeData)
                        remoteCount = remoteCount + 1
                    end)
                end
            end
        end
        
        resultBox.Text = resultBox.Text .. "📤 أرسلت لـ " .. remoteCount .. " Remote\n"
        
        -- محاولة فتح نافذة شراء حقيقية (لكن بالسعر 0)
        task.wait(0.1)
        
        -- البحث عن MarketplaceService
        pcall(function()
            local MarketplaceService = game:GetService("MarketplaceService")
            -- تحقق من وجود منتج
            local productInfo = MarketplaceService:GetProductInfo(123456)  -- ID مؤقت
            resultBox.Text = resultBox.Text .. "🛍️ جربت فتح متجر\n"
        end)
    end)
    
    -- حفظ الـ Connection للتعديل لاحقاً
    buyButton:SetAttribute("HackedConnection", newConnection)
    
    -- النقر التلقائي على الزر (اختياري)
    resultBox.Text = resultBox.Text .. "🔄 جرب النقر التلقائي...\n"
    
    for i = 1, 3 do
        pcall(function()
            buyButton:Fire("click")
            resultBox.Text = resultBox.Text .. i .. ". نقرت تلقائياً\n"
        end)
        task.wait(0.2)
    end
    
    resultBox.Text = resultBox.Text .. "\n✅ الزر جاهز! اضغط عليه في المتجر"
    
    -- إضافة زر للاختبار المباشر
    local testBuyBtn = Instance.new("TextButton")
    testBuyBtn.Text = "🛒 TEST DIRECT BUY"
    testBuyBtn.Size = UDim2.new(0.9, 0, 0, 25)
    testBuyBtn.Position = UDim2.new(0.05, 0, 1.1, 0)
    testBuyBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
    testBuyBtn.TextColor3 = Color3.new(1, 1, 1)
    testBuyBtn.Visible = false
    testBuyBtn.Parent = frame
    
    testBuyBtn.MouseButton1Click:Connect(function()
        -- محاولة شراء مباشرة بدون فتح المتجر
        resultBox.Text = "🎯 جربة شراء مباشر...\n"
        
        local directPurchase = {
            productId = "christmas_pickaxe",
            price = 0,
            player = player,
            forcePurchase = true,
            bypassCheck = true
        }
        
        -- البحث عن متجر الكريسماس
        local christmasShop = player.PlayerGui:FindFirstChild("ChristmasEventShop")
        if christmasShop then
            resultBox.Text = resultBox.Text .. "🏪 متجر الكريسماس موجود\n"
            
            -- البحث عن Remote في المتجر
            for _, remote in pairs(christmasShop:GetDescendants()) do
                if remote:IsA("RemoteEvent") then
                    pcall(function()
                        remote:FireServer(directPurchase)
                        resultBox.Text = resultBox.Text .. "📤 أرسلت للمتجر\n"
                    end)
                end
            end
        end
        
        resultBox.Text = resultBox.Text .. "✅ انتهت المحاولة"
    end)
    
    testBuyBtn.Visible = true
end)

-- زر إرجاع الزر لطبيعته
local restoreBtn = Instance.new("TextButton")
restoreBtn.Text = "🔄 RESTORE BUTTON"
restoreBtn.Size = UDim2.new(0.9, 0, 0, 25)
restoreBtn.Position = UDim2.new(0.05, 0, 0.85, 0)
restoreBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
restoreBtn.TextColor3 = Color3.new(1, 1, 1)
restoreBtn.Font = Enum.Font.SourceSans
restoreBtn.TextSize = 11
restoreBtn.Parent = frame

restoreBtn.MouseButton1Click:Connect(function()
    if buyButton then
        -- إرجاع الوصلات الأصلية
        if #originalConnections > 0 then
            for _, conn in pairs(originalConnections) do
                conn:Enable()
            end
        end
        
        -- إزالة الـ Connection المخترق
        local hackedConn = buyButton:GetAttribute("HackedConnection")
        if hackedConn then
            hackedConn:Disconnect()
        end
        
        resultBox.Text = "✅ أرجعت الزر لطبيعته"
        freeBuyBtn.Text = "💰 BUY FOR FREE"
        freeBuyBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end
end)

-- زر إغلاق
local closeBtn = Instance.new("TextButton")
closeBtn.Text = "✕"
closeBtn.Size = UDim2.new(0, 20, 0, 20)
closeBtn.Position = UDim2.new(1, -20, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Parent = frame

closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- اكتشاف تلقائي
spawn(function()
    wait(2)
    resultBox.Text = "🔍 فحص تلقائي..."
    
    local tempButton = findBuyButton()
    if tempButton then
        resultBox.Text = "✅ زر الشراء موجود!\n"
        resultBox.Text = resultBox.Text .. "👉 اضغط FIND للتأكيد"
        buyButton = tempButton
    else
        resultBox.Text = "❌ الزر مش موجود\n"
        resultBox.Text = resultBox.Text .. "🔍 افتح متجر الكريسماس أولاً"
    end
end)

print("========================================")
print("🎄 FREE CHRISTMAS PICKAXE HACK LOADED")
print("💰 Buy ChristmasPickaxe for 0 ROBUX")
print("⚠️  FOR EDUCATIONAL PURPOSES ONLY")
print("========================================")
