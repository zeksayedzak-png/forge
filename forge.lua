-- ⚡ RAPID CLICK AUTOCLICKER
-- ⚠️ FOR EDUCATIONAL PURPOSES ONLY

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- تنظيف
for _, gui in pairs(CoreGui:GetChildren()) do
    if gui.Name == "RapidClicker" then
        gui:Destroy()
    end
end

-- واجهة صغيرة
local gui = Instance.new("ScreenGui")
gui.Name = "RapidClicker"
gui.Parent = CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 200)
frame.Position = UDim2.new(0.1, 0, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
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
title.Text = "⚡ RAPID CLICKER (اسحبني)"
title.Size = UDim2.new(1, 0, 0, 25)
title.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 12
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
findBtn.TextSize = 11
findBtn.Parent = frame

-- زر تشغيل الضغط السريع
local rapidBtn = Instance.new("TextButton")
rapidBtn.Text = "⚡ START RAPID CLICK"
rapidBtn.Size = UDim2.new(0.9, 0, 0, 35)
rapidBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
rapidBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
rapidBtn.TextColor3 = Color3.new(1, 1, 1)
rapidBtn.Font = Enum.Font.SourceSansBold
rapidBtn.TextSize = 12
rapidBtn.Parent = frame

-- تعديل السرعة
local speedLabel = Instance.new("TextLabel")
speedLabel.Text = "سرعة الضغط: 100/ثانية"
speedLabel.Size = UDim2.new(0.9, 0, 0, 20)
speedLabel.Position = UDim2.new(0.05, 0, 0.65, 0)
speedLabel.BackgroundTransparency = 1
speedLabel.TextColor3 = Color3.new(1, 1, 1)
speedLabel.Font = Enum.Font.SourceSans
speedLabel.TextSize = 11
speedLabel.Parent = frame

-- زيادة السرعة
local speedUpBtn = Instance.new("TextButton")
speedUpBtn.Text = "➕ زيادة السرعة"
speedUpBtn.Size = UDim2.new(0.44, 0, 0, 25)
speedUpBtn.Position = UDim2.new(0.05, 0, 0.72, 0)
speedUpBtn.BackgroundColor3 = Color3.fromRGB(60, 80, 100)
speedUpBtn.TextColor3 = Color3.new(1, 1, 1)
speedUpBtn.Font = Enum.Font.SourceSans
speedUpBtn.TextSize = 10
speedUpBtn.Parent = frame

-- تقليل السرعة
local speedDownBtn = Instance.new("TextButton")
speedDownBtn.Text = "➖ تقليل السرعة"
speedDownBtn.Size = UDim2.new(0.44, 0, 0, 25)
speedDownBtn.Position = UDim2.new(0.51, 0, 0.72, 0)
speedDownBtn.BackgroundColor3 = Color3.fromRGB(60, 80, 100)
speedDownBtn.TextColor3 = Color3.new(1, 1, 1)
speedDownBtn.Font = Enum.Font.SourceSans
speedDownBtn.TextSize = 10
speedDownBtn.Parent = frame

-- النتائج
local resultBox = Instance.new("TextLabel")
resultBox.Text = "👉 ابحث عن الزر أولاً"
resultBox.Size = UDim2.new(0.9, 0, 0, 40)
resultBox.Position = UDim2.new(0.05, 0, 0.85, 0)
resultBox.BackgroundColor3 = Color3.fromRGB(30, 40, 50)
resultBox.TextColor3 = Color3.new(1, 1, 1)
resultBox.TextWrapped = true
resultBox.Font = Enum.Font.SourceSans
resultBox.TextSize = 10
resultBox.Parent = frame

-- متغيرات
local buyButton = nil
local isClicking = false
local clicksPerSecond = 100
local totalClicks = 0

-- البحث عن الزر
findBtn.MouseButton1Click:Connect(function()
    resultBox.Text = "🔍 جاري البحث..."
    
    buyButton = findBuyButton()
    
    if buyButton then
        resultBox.Text = "✅ وجدت زر الشراء!\n"
        resultBox.Text = resultBox.Text .. "📍 " .. buyButton.Name
        rapidBtn.Text = "⚡ START RAPID CLICK"
        rapidBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    else
        resultBox.Text = "❌ ما لقيت الزر\n"
        resultBox.Text = resultBox.Text .. "🔍 افتح المتجر أولاً"
        rapidBtn.Text = "⚡ START RAPID CLICK"
        rapidBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end
end)

-- دالة الضغط السريع
local function rapidClick()
    if not buyButton then
        resultBox.Text = "❌ ما فيش زر!"
        return
    end
    
    resultBox.Text = "⚡ بدأ الضغط السريع...\n"
    resultBox.Text = resultBox.Text .. "سرعة: " .. clicksPerSecond .. "/ثانية\n"
    
    local startTime = tick()
    local clicksThisSecond = 0
    local secondStart = tick()
    
    while isClicking do
        -- التحقق من الوقت
        local currentTime = tick()
        
        -- إذا مرت ثانية، نبدأ عداد جديد
        if currentTime - secondStart >= 1 then
            clicksThisSecond = 0
            secondStart = currentTime
            resultBox.Text = "⚡ سرعة: " .. clicksPerSecond .. "/ثانية\n"
            resultBox.Text = resultBox.Text .. "🔄 كليكات: " .. totalClicks
        end
        
        -- إذا وصلنا للسرعة المحددة، ننتظر
        if clicksThisSecond >= clicksPerSecond then
            task.wait(0.01) -- انتظار قصير
            continue
        end
        
        -- الضغط على الزر
        pcall(function()
            if buyButton:IsA("TextButton") or buyButton:IsA("ImageButton") then
                -- طريقة 1: Fire click event
                buyButton:Fire("click")
                
                -- طريقة 2: MouseButton1Click events
                for _, event in pairs(getconnections(buyButton.MouseButton1Click) or {}) do
                    pcall(function()
                        event:Fire()
                    end)
                end
                
                -- طريقة 3: تغيير الـ Text مؤقتاً للإيهام بالضغط
                local originalText = buyButton.Text
                buyButton.Text = "⚡..."
                task.wait(0.01)
                buyButton.Text = originalText
            end
        end)
        
        clicksThisSecond = clicksThisSecond + 1
        totalClicks = totalClicks + 1
        
        -- تأخير بين الضغطات حسب السرعة
        local delay = 1 / clicksPerSecond
        if delay > 0.001 then -- لا تقل عن 1ms
            task.wait(delay)
        end
        
        -- تحديث العداد كل 50 ضغطة
        if totalClicks % 50 == 0 then
            resultBox.Text = "⚡ سرعة: " .. clicksPerSecond .. "/ثانية\n"
            resultBox.Text = resultBox.Text .. "🔄 كليكات: " .. totalClicks
        end
    end
    
    local elapsedTime = tick() - startTime
    resultBox.Text = "✅ توقف الضغط!\n"
    resultBox.Text = resultBox.Text .. "⏱️ الوقت: " .. math.floor(elapsedTime) .. " ثانية\n"
    resultBox.Text = resultBox.Text .. "🔄 إجمالي الكليكات: " .. totalClicks
end

-- تشغيل/إيقاف الضغط السريع
rapidBtn.MouseButton1Click:Connect(function()
    if not buyButton then
        resultBox.Text = "❌ ابحث عن الزر أولاً!"
        return
    end
    
    if isClicking then
        -- إيقاف الضغط
        isClicking = false
        rapidBtn.Text = "⚡ START RAPID CLICK"
        rapidBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        resultBox.Text = "⏹️ توقف الضغط..."
    else
        -- بدء الضغط
        isClicking = true
        rapidBtn.Text = "⏹️ STOP CLICKING"
        rapidBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
        
        -- بدء الضغط في thread منفصل
        spawn(function()
            rapidClick()
        end)
    end
end)

-- زيادة السرعة
speedUpBtn.MouseButton1Click:Connect(function()
    if clicksPerSecond < 500 then -- حد أقصى 500/ثانية
        clicksPerSecond = clicksPerSecond + 10
        speedLabel.Text = "سرعة الضغط: " .. clicksPerSecond .. "/ثانية"
        resultBox.Text = "📈 السرعة: " .. clicksPerSecond .. "/ثانية"
    else
        resultBox.Text = "⚠️ السرعة القصوى: 500/ثانية"
    end
end)

-- تقليل السرعة
speedDownBtn.MouseButton1Click:Connect(function()
    if clicksPerSecond > 10 then -- حد أدنى 10/ثانية
        clicksPerSecond = clicksPerSecond - 10
        speedLabel.Text = "سرعة الضغط: " .. clicksPerSecond .. "/ثانية"
        resultBox.Text = "📉 السرعة: " .. clicksPerSecond .. "/ثانية"
    else
        resultBox.Text = "⚠️ السرعة الدنيا: 10/ثانية"
    end
end)

-- زر إعادة الضبط
local resetBtn = Instance.new("TextButton")
resetBtn.Text = "🔄 RESET COUNTER"
resetBtn.Size = UDim2.new(0.9, 0, 0, 25)
resetBtn.Position = UDim2.new(0.05, 0, 0.58, 0)
resetBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 120)
resetBtn.TextColor3 = Color3.new(1, 1, 1)
resetBtn.Font = Enum.Font.SourceSans
resetBtn.TextSize = 10
resetBtn.Parent = frame

resetBtn.MouseButton1Click:Connect(function()
    totalClicks = 0
    resultBox.Text = "🔄 عداد الكليكات: 0"
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
    isClicking = false
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
        rapidBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    else
        resultBox.Text = "❌ الزر مش موجود\n"
        resultBox.Text = resultBox.Text .. "🔍 افتح المتجر أولاً"
    end
end)

-- كليكات شبحية (خيار إضافي)
local ghostBtn = Instance.new("TextButton")
ghostBtn.Text = "👻 GHOST CLICKS"
ghostBtn.Size = UDim2.new(0.9, 0, 0, 25)
ghostBtn.Position = UDim2.new(0.05, 0, 0.78, 0)
ghostBtn.BackgroundColor3 = Color3.fromRGB(80, 60, 100)
ghostBtn.TextColor3 = Color3.new(1, 1, 1)
ghostBtn.Font = Enum.Font.SourceSans
ghostBtn.TextSize = 10
ghostBtn.Parent = frame

ghostBtn.MouseButton1Click:Connect(function()
    if not buyButton then return end
    
    resultBox.Text = "👻 بدأ الضغط الشبحى...\n"
    
    spawn(function()
        for i = 1, 1000 do
            if not isClicking then break end
            
            -- ضغط بدون تغيير مرئي
            pcall(function()
                -- استدعاء events مباشرة
                for _, event in pairs(getconnections(buyButton.MouseButton1Click) or {}) do
                    pcall(function()
                        event:Fire()
                    end)
                end
                
                -- إرسال RemoteEvents
                for _, remote in pairs(game:GetDescendants()) do
                    if remote:IsA("RemoteEvent") and remote.Name:find("Buy") then
                        pcall(function()
                            remote:FireServer({
                                item = "ChristmasPickaxe",
                                silent = true
                            })
                        end)
                    end
                end
            end)
            
            task.wait(0.01) -- 100 ضغطة/ثانية
        end
        
        resultBox.Text = "👻 انتهى الضغط الشبحى!"
    end)
end)

print("========================================")
print("⚡ RAPID CLICK AUTOCLICKER LOADED")
print("🎯 100 clicks per second")
print("⚠️  FOR EDUCATIONAL PURPOSES ONLY")
print("========================================")
