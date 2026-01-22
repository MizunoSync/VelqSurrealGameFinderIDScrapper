-- 🎮 Velq Surreal Game Finder ID Logger HUD
pcall(function()
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local CoreGui = game:GetService("CoreGui")

    local LocalPlayer = Players.LocalPlayer
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

    local SelectedGameGui = PlayerGui:WaitForChild("SelectedGameGui", 10)
    local Sections = SelectedGameGui:WaitForChild("Sections")
    local Top = Sections:WaitForChild("Top")
    local Info = Top:WaitForChild("Info")
    local GameIDLabel = Info:WaitForChild("GameIDLabel")
    local TitleLabel = Info:WaitForChild("TitleLabel")

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "GameIDLoggerHUD"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = CoreGui

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 350, 0, 400)
    MainFrame.Position = UDim2.new(0.5, -175, 0.5, -200)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 12)
    MainCorner.Parent = MainFrame

    local Shadow = Instance.new("Frame")
    Shadow.Name = "Shadow"
    Shadow.Size = UDim2.new(1, 8, 1, 8)
    Shadow.Position = UDim2.new(0, -4, 0, -4)
    Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.BackgroundTransparency = 0.7
    Shadow.ZIndex = MainFrame.ZIndex - 1
    Shadow.Parent = MainFrame

    local ShadowCorner = Instance.new("UICorner")
    ShadowCorner.CornerRadius = UDim.new(0, 12)
    ShadowCorner.Parent = Shadow

    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame

    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 12)
    TitleCorner.Parent = TitleBar

    local TitleLabelHUD = Instance.new("TextLabel")
    TitleLabelHUD.Name = "Title"
    TitleLabelHUD.Size = UDim2.new(1, -80, 1, 0)
    TitleLabelHUD.Position = UDim2.new(0, 10, 0, 0)
    TitleLabelHUD.BackgroundTransparency = 1
    TitleLabelHUD.Text = "Velq ID Logger v4.7 - HITS/DUPES"
    TitleLabelHUD.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabelHUD.TextScaled = true
    TitleLabelHUD.Font = Enum.Font.GothamBold
    TitleLabelHUD.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabelHUD.Parent = TitleBar

    local ToggleBtn = Instance.new("TextButton")
    ToggleBtn.Name = "Toggle"
    ToggleBtn.Size = UDim2.new(0, 70, 0, 30)
    ToggleBtn.Position = UDim2.new(1, -85, 0.5, -15)
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 80)
    ToggleBtn.BorderSizePixel = 0
    ToggleBtn.Text = "LIVE"
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleBtn.TextScaled = true
    ToggleBtn.Font = Enum.Font.GothamBold
    ToggleBtn.Parent = TitleBar

    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 6)
    ToggleCorner.Parent = ToggleBtn

    local StatusLabel = Instance.new("TextLabel")
    StatusLabel.Name = "Status"
    StatusLabel.Size = UDim2.new(0, 300, 0, 20)
    StatusLabel.Position = UDim2.new(0, 10, 1, -25)
    StatusLabel.BackgroundTransparency = 1
    StatusLabel.Text = "Loading games.txt... | Hits: 0 | Dupes: 0"
    StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
    StatusLabel.TextScaled = true
    StatusLabel.Font = Enum.Font.Gotham
    StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
    StatusLabel.Parent = MainFrame

    local IDList = Instance.new("ScrollingFrame")
    IDList.Name = "IDList"
    IDList.Size = UDim2.new(1, -20, 1, -90)
    IDList.Position = UDim2.new(0, 10, 0, 50)
    IDList.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
    IDList.BorderSizePixel = 0
    IDList.ScrollBarThickness = 8
    IDList.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 80)
    IDList.CanvasSize = UDim2.new(0, 0, 0, 0)
    IDList.Parent = MainFrame

    local IDListCorner = Instance.new("UICorner")
    IDListCorner.CornerRadius = UDim.new(0, 8)
    IDListCorner.Parent = IDList

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 5)
    UIListLayout.Parent = IDList

    UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        IDList.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 20)
    end)

    local ButtonsFrame = Instance.new("Frame")
    ButtonsFrame.Name = "Buttons"
    ButtonsFrame.Size = UDim2.new(1, -20, 0, 35)
    ButtonsFrame.Position = UDim2.new(0, 10, 1, -55)
    ButtonsFrame.BackgroundTransparency = 1
    ButtonsFrame.Parent = MainFrame

    local CopyBtn = Instance.new("TextButton")
    CopyBtn.Name = "CopyAll"
    CopyBtn.Size = UDim2.new(0.48, -5, 1, 0)
    CopyBtn.Position = UDim2.new(0, 0, 0, 0)
    CopyBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 80)
    CopyBtn.BorderSizePixel = 0
    CopyBtn.Text = "Copy All"
    CopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CopyBtn.TextScaled = true
    CopyBtn.Font = Enum.Font.GothamSemibold
    CopyBtn.Parent = ButtonsFrame

    local CopyCorner = Instance.new("UICorner")
    CopyCorner.CornerRadius = UDim.new(0, 6)
    CopyCorner.Parent = CopyBtn

    local ClearBtn = Instance.new("TextButton")
    ClearBtn.Name = "Clear"
    ClearBtn.Size = UDim2.new(0.48, -5, 1, 0)
    ClearBtn.Position = UDim2.new(0.52, 5, 0, 0)
    ClearBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    ClearBtn.BorderSizePixel = 0
    ClearBtn.Text = "Clear"
    ClearBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    ClearBtn.TextScaled = true
    ClearBtn.Font = Enum.Font.GothamSemibold
    ClearBtn.Parent = ButtonsFrame

    local ClearCorner = Instance.new("UICorner")
    ClearCorner.CornerRadius = UDim.new(0, 6)
    ClearCorner.Parent = ClearBtn

    local isListening = true
    local gameIDs = {}
    local idData = {}
    local lastText = ""
    local lastContextText = ""
    local idCounter = 0
    local hitCount = 0
    local dupeCount = 0
    local dragging, dragStart, startPos

    -- [cleanGameTitle, extractGameID, fireAllProximityPrompts - IDENTICAL]

    local function cleanGameTitle(title)
        if not title or title == "" then return "Game" end
        return title:gsub("[^%w%s-]", ""):gsub("%s+", "-")
    end

    local function extractGameID(text)
        if not text or text == "" then return nil end
        local plain = text:gsub("<.->", "")
        local numbers = plain:gsub("%D", "")
        if #numbers >= 6 then return numbers end
        return nil
    end

local function fireAllProximityPrompts()
    if fireproximityprompt then
        for _, descendant in ipairs(workspace:GetDescendants()) do
            if descendant:IsA("ProximityPrompt") then
                fireproximityprompt(descendant)
            end
        end
    end
end

    -- 🔥 ENHANCED addID WITH DUPE DETECTION + COLOR CODING
    local function addID(gameID, gameTitle)
        local isDuplicate = gameIDs[gameID] ~= nil
        
        if isDuplicate then
            dupeCount = dupeCount + 1
        else
            hitCount = hitCount + 1
            gameIDs[gameID] = true
            idData[gameID] = {gameID = gameID, gameTitle = gameTitle}
        end
        
        idCounter = idCounter + 1
        
        local IDFrame = Instance.new("Frame")
        IDFrame.Name = "IDFrame_" .. idCounter
        IDFrame.Size = UDim2.new(1, -10, 0, 35)
        IDFrame.BackgroundTransparency = 1
        IDFrame.LayoutOrder = idCounter
        IDFrame.Parent = IDList
        
        local IDLabel = Instance.new("TextLabel")
        IDLabel.Name = "IDLabel"
        IDLabel.Size = UDim2.new(1, -10, 1, 0)
        IDLabel.Position = UDim2.new(0, 5, 0, 0)
        
        if isDuplicate then
            IDLabel.BackgroundColor3 = Color3.fromRGB(80, 20, 20) -- RED for dupes
            IDLabel.Text = "🔴 DUPE #" .. dupeCount .. ": " .. gameID .. " (" .. gameTitle .. ")"
            IDLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        else
            IDLabel.BackgroundColor3 = Color3.fromRGB(20, 80, 20) -- GREEN for hits
            IDLabel.Text = "🟢 HIT #" .. hitCount .. ": " .. gameID .. " (" .. gameTitle .. ")"
            IDLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        end
        
        IDLabel.BorderSizePixel = 0
        IDLabel.TextScaled = true
        IDLabel.Font = Enum.Font.GothamSemibold
        IDLabel.TextXAlignment = Enum.TextXAlignment.Left
        IDLabel.TextTruncate = Enum.TextTruncate.AtEnd
        IDLabel.Parent = IDFrame
        
        local IDCorner = Instance.new("UICorner")
        IDCorner.CornerRadius = UDim.new(0, 6)
        IDCorner.Parent = IDLabel
        
        StatusLabel.Text = "Hits: " .. hitCount .. " | Dupes: " .. dupeCount .. " | LIVE"
    end

    local function loadSavedGames()
        if isfile and isfile("games.txt") then
            pcall(function()
                local content = readfile("games.txt")
                print("First line from games.txt:", content:match("([^\r\n]*)"))
                
                local lineCount = 0
                for line in content:gmatch("[^\r\n]+") do
                    lineCount = lineCount + 1
                    line = line:gsub("^%s*(.-)%s*$", "%1")
                    
                    if line ~= "" and not line:match("^#") then
                        local displayID = line:match("%d+") or "line_" .. lineCount
                        addID(displayID, line)
                    end
                end
                
                StatusLabel.Text = "LOADED " .. lineCount .. " | Hits: " .. hitCount .. " | Dupes: " .. dupeCount
                print("✅ LOADED", lineCount, "LINES WITH HIT/DUPE TRACKING!")
            end)
        else
            StatusLabel.Text = "No games.txt - LIVE CAPTURE ONLY"
        end
    end

    loadSavedGames()

    -- [Draggable, ToggleBtn, CopyBtn, ClearBtn - IDENTICAL with updated status]
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    ToggleBtn.MouseButton1Click:Connect(function()
        isListening = not isListening
        if isListening then
            ToggleBtn.Text = "LIVE"
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 80)
            StatusLabel.Text = "Hits: " .. hitCount .. " | Dupes: " .. dupeCount .. " | LIVE"
            StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
        else
            ToggleBtn.Text = "PAUSED"
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            StatusLabel.Text = "PAUSED | Hits: " .. hitCount .. " | Dupes: " .. dupeCount
            StatusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
        end
    end)

    CopyBtn.MouseButton1Click:Connect(function()
        local copyText = "🟢 HITS (" .. hitCount .. "):\n"
        local dupeText = "\n🔴 DUPES (" .. dupeCount .. "):\n"
        local hitList = ""
        local dupeList = ""
        
        for id, data in pairs(idData) do
            hitList = hitList .. data.gameTitle .. "\n"
        end
        
        copyText = copyText .. (hitList ~= "" and hitList or "None") .. dupeText .. "Duplicates tracked only"
        setclipboard(copyText)
        StatusLabel.Text = "Copied Hits(" .. hitCount .. ")/Dupes(" .. dupeCount .. ")"
        StatusLabel.TextColor3 = Color3.fromRGB(0, 150, 255)
    end)

    ClearBtn.MouseButton1Click:Connect(function()
        for _, child in pairs(IDList:GetChildren()) do
            if child.Name:find("IDFrame_") then child:Destroy() end
        end
        gameIDs, idData = {}, {}
        idCounter, hitCount, dupeCount = 0, 0, 0
        StatusLabel.Text = "Cleared - Hits: 0 | Dupes: 0"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 150, 0)
    end)

    local function monitorGameID()
        if not isListening then return end
        local currentText = GameIDLabel.Text
        local currentContextText = GameIDLabel.RichText or ""
        local currentTitle = cleanGameTitle(TitleLabel.Text or TitleLabel.RichText or "Game")
        
        if currentText ~= lastText then
            local gameID = extractGameID(currentText)
            if gameID then
                addID(gameID, gameID .. " (" .. currentTitle .. ")")
            end
            fireAllProximityPrompts()
            lastText = currentText
        end
        
        if currentContextText ~= lastContextText then
            local gameID = extractGameID(currentContextText)
            if gameID then
                addID(gameID, gameID .. " (" .. currentTitle .. ")")
            end
            fireAllProximityPrompts()
            lastContextText = currentContextText
        end
    end

    spawn(function() while true do monitorGameID() wait(0.1) end end)
    GameIDLabel:GetPropertyChangedSignal("Text"):Connect(monitorGameID)
    GameIDLabel:GetPropertyChangedSignal("RichText"):Connect(monitorGameID)
end)
