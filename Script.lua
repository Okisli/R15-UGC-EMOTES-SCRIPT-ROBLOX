-- creator MyNicknameIsOwner oh my god
-- telegram @owner_scripts

if getgenv().Emotesbruh == true then
    return 
end
getgenv().Emotesbruh = true

-- Key system
local correctKey = "TGBR65K"
local keyGui = Instance.new("ScreenGui")
keyGui.Name = "KeyGui"
keyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = keyGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Text = "Введите ключ доступа"
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 10)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.Parent = mainFrame

local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(0.8, 0, 0, 40)
inputBox.Position = UDim2.new(0.1, 0, 0.3, 0)
inputBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
inputBox.TextColor3 = Color3.new(1, 1, 1)
inputBox.PlaceholderText = "Введите ключ..."
inputBox.Font = Enum.Font.Gotham
inputBox.TextSize = 16
inputBox.Parent = mainFrame

local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 4)
inputCorner.Parent = inputBox

local checkButton = Instance.new("TextButton")
checkButton.Size = UDim2.new(0.8, 0, 0, 40)
checkButton.Position = UDim2.new(0.1, 0, 0.55, 0)
checkButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
checkButton.TextColor3 = Color3.new(1, 1, 1)
checkButton.Text = "Проверить"
checkButton.Font = Enum.Font.GothamBold
checkButton.TextSize = 16
checkButton.Parent = mainFrame

local checkCorner = Instance.new("UICorner")
checkCorner.CornerRadius = UDim.new(0, 4)
checkCorner.Parent = checkButton

local getKeyButton = Instance.new("TextButton")
getKeyButton.Size = UDim2.new(0.8, 0, 0, 30)
getKeyButton.Position = UDim2.new(0.1, 0, 0.8, 0)
getKeyButton.BackgroundTransparency = 1
getKeyButton.TextColor3 = Color3.fromRGB(0, 162, 255)
getKeyButton.Text = "Получить ключ"
getKeyButton.Font = Enum.Font.Gotham
getKeyButton.TextSize = 14
getKeyButton.Parent = mainFrame

local messageLabel = Instance.new("TextLabel")
messageLabel.Size = UDim2.new(0.8, 0, 0, 20)
messageLabel.Position = UDim2.new(0.1, 0, 0.45, 0)
messageLabel.BackgroundTransparency = 1
messageLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
messageLabel.Font = Enum.Font.Gotham
messageLabel.TextSize = 14
messageLabel.Text = ""
messageLabel.Parent = mainFrame

-- Add to coregui
if syn and syn.protect_gui then
    syn.protect_gui(keyGui)
    keyGui.Parent = game.CoreGui
elseif gethui then
    keyGui.Parent = gethui()
else
    keyGui.Parent = game.CoreGui
end

-- Button functions
checkButton.MouseButton1Click:Connect(function()
    if inputBox.Text == correctKey then
        keyGui:Destroy()
        loadMainScript()
    else
        messageLabel.Text = "Неверный ключ!"
        task.wait(2)
        messageLabel.Text = ""
    end
end)

getKeyButton.MouseButton1Click:Connect(function()
    setclipboard("https://t.me/owner_scriptsbot")
    messageLabel.TextColor3 = Color3.fromRGB(50, 255, 50)
    messageLabel.Text = "Ссылка скопирована!"
    task.wait(2)
    messageLabel.Text = ""
    messageLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
end)

-- Main script function
function loadMainScript()
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "Wait!",
        Text = "Please Wait, it just loading the button",
        Duration = 15
    })

    if game:GetService("CoreGui"):FindFirstChild("Emotes") then
        game:GetService("CoreGui"):FindFirstChild("Emotes"):Destroy()
    end

    wait(1)

    local ContextActionService = game:GetService("ContextActionService")
    local HttpService = game:GetService("HttpService")
    local GuiService = game:GetService("GuiService")
    local CoreGui = game:GetService("CoreGui")
    local Open = Instance.new("TextButton")
    UICorner = Instance.new("UICorner")
    local MarketplaceService = game:GetService("MarketplaceService")
    local Players = game:GetService("Players")
    local StarterGui = game:GetService("StarterGui")
    local UserInputService = game:GetService("UserInputService")

    local LoadedEmotes, Emotes = {}, {}

    local function AddEmote(name: string, id: number, price: number?)
        LoadedEmotes[id] = false
        task.spawn(function()
            if not (name and id) then return end

            local success, date = pcall(function()
                local info = MarketplaceService:GetProductInfo(id)
                local updated = info.Updated
                return DateTime.fromIsoDate(updated):ToUniversalTime()
            end)

            if not success or not date then
                task.wait(10)
                AddEmote(name, id, price)
                return
            end

            local unix = os.time({
                year = date.Year,
                month = date.Month,
                day = date.Day,
                hour = date.Hour,
                min = date.Minute,
                sec = date.Second
            })

            LoadedEmotes[id] = true

            local emoteData = {
                name = name,
                id = id,
                icon = "rbxthumb://type=Asset&id=".. id .."&w=150&h=150",
                price = price or 0,
                lastupdated = unix,
                sort = {}
            }
            table.insert(Emotes, emoteData)
        end)
    end

    local function CreateButtonFromEmoteInfo(emote)
        local button = Instance.new("TextButton")
        button.Name = tostring(emote.id)
        button.Text = emote.name .. " - $" .. emote.price
        button.Size = UDim2.new(0, 200, 0, 50)
        button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        button.TextColor3 = Color3.new(1, 1, 1)
        button.MouseButton1Click:Connect(function()
            print("Selected Emote: " .. emote.name .. ", ID: " .. emote.id)
        end)
        return button
    end

    local CurrentSort = "recentfirst"

    local FavoriteOff = "rbxassetid://10651060677"
    local FavoriteOn = "rbxassetid://10651061109"
    local FavoritedEmotes = {}

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Emotes"
    ScreenGui.DisplayOrder = 2
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Enabled = true

    local BackFrame = Instance.new("Frame")
    BackFrame.Size = UDim2.new(0.9, 0, 0.5, 0)
    BackFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    BackFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    BackFrame.SizeConstraint = Enum.SizeConstraint.RelativeYY
    BackFrame.BackgroundTransparency = 1
    BackFrame.BorderSizePixel = 0
    BackFrame.Parent = ScreenGui

    Open.Name = "Open"
    Open.Parent = ScreenGui
    Open.Draggable = true
    Open.Size = UDim2.new(0.05,0,0.114,0)
    Open.Position = UDim2.new(0.05, 0, 0.25, 0)
    Open.Text = "Close"
    Open.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Open.TextColor3 = Color3.fromRGB(255, 255, 255)
    Open.TextScaled = true
    Open.TextSize = 20
    Open.Visible = true
    Open.BackgroundTransparency = .5
    Open.MouseButton1Up:Connect(function()
        if Open.Text == "Open" then
            Open.Text = "Close"
            BackFrame.Visible = true
        else
            if Open.Text == "Close" then
                Open.Text = "Open"
                BackFrame.Visible = false
            end
        end
    end)

    UICorner.Name = "UICorner"
    UICorner.Parent = Open
    UICorner.CornerRadius = UDim.new(1, 0)

    local EmoteName = Instance.new("TextLabel")
    EmoteName.Name = "EmoteName"
    EmoteName.TextScaled = true
    EmoteName.AnchorPoint = Vector2.new(0.5, 0.5)
    EmoteName.Position = UDim2.new(-0.1, 0, 0.5, 0)
    EmoteName.Size = UDim2.new(0.2, 0, 0.2, 0)
    EmoteName.SizeConstraint = Enum.SizeConstraint.RelativeYY
    EmoteName.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    EmoteName.TextColor3 = Color3.new(1, 1, 1)
    EmoteName.BorderSizePixel = 0
    EmoteName.Parent = BackFrame

    local Corner = Instance.new("UICorner")
    Corner.Parent = EmoteName

    local Loading = Instance.new("TextLabel", BackFrame)
    Loading.AnchorPoint = Vector2.new(0.5, 0.5)
    Loading.Text = "Fixing.."
    Loading.TextColor3 = Color3.new(1, 1, 1)
    Loading.BackgroundColor3 = Color3.new(0, 0, 0)
    Loading.TextScaled = true
    Loading.BackgroundTransparency = 0.5
    Loading.Size = UDim2.fromScale(0.2, 0.1)
    Loading.Position = UDim2.fromScale(0.5, 0.2)
    Corner:Clone().Parent = Loading

    local Frame = Instance.new("ScrollingFrame")
    Frame.Size = UDim2.new(1, 0, 1, 0)
    Frame.CanvasSize = UDim2.new(0, 0, 0, 0)
    Frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Frame.ScrollingDirection = Enum.ScrollingDirection.Y
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    Frame.BackgroundTransparency = 1
    Frame.ScrollBarThickness = 5
    Frame.BorderSizePixel = 0
    Frame.MouseLeave:Connect(function()
        EmoteName.Text = "Select an Emote"
    end)
    Frame.Parent = BackFrame

    local Grid = Instance.new("UIGridLayout")
    Grid.CellSize = UDim2.new(0.105, 0, 0, 0)
    Grid.CellPadding = UDim2.new(0.006, 0, 0.006, 0)
    Grid.SortOrder = Enum.SortOrder.LayoutOrder
    Grid.Parent = Frame

    local SortFrame = Instance.new("Frame")
    SortFrame.Visible = false
    SortFrame.BorderSizePixel = 0
    SortFrame.Position = UDim2.new(1, 5, -0.125, 0)
    SortFrame.Size = UDim2.new(0.2, 0, 0, 0)
    SortFrame.AutomaticSize = Enum.AutomaticSize.Y
    SortFrame.BackgroundTransparency = 1
    Corner:Clone().Parent = SortFrame
    SortFrame.Parent = BackFrame

    local SortList = Instance.new("UIListLayout")
    SortList.Padding = UDim.new(0.02, 0)
    SortList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    SortList.VerticalAlignment = Enum.VerticalAlignment.Top
    SortList.SortOrder = Enum.SortOrder.LayoutOrder
    SortList.Parent = SortFrame

    local function SortEmotes()
        for i,Emote in pairs(Emotes) do
            local EmoteButton = Frame:FindFirstChild(Emote.id)
            if not EmoteButton then
                continue
            end
            local IsFavorited = table.find(FavoritedEmotes, Emote.id)
            EmoteButton.LayoutOrder = Emote.sort[CurrentSort] + ((IsFavorited and 0) or #Emotes)
            EmoteButton.number.Text = Emote.sort[CurrentSort]
        end
    end

    local function createsort(order, text, sort)
        local CreatedSort = Instance.new("TextButton")
        CreatedSort.SizeConstraint = Enum.SizeConstraint.RelativeXX
        CreatedSort.Size = UDim2.new(1, 0, 0.2, 0)
        CreatedSort.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        CreatedSort.LayoutOrder = order
        CreatedSort.TextColor3 = Color3.new(1, 1, 1)
        CreatedSort.Text = text
        CreatedSort.TextScaled = true
        CreatedSort.BorderSizePixel = 0
        Corner:Clone().Parent = CreatedSort
        CreatedSort.Parent = SortFrame
        CreatedSort.MouseButton1Click:Connect(function()
            SortFrame.Visible = false
            Open.Text = "Open"
            CurrentSort = sort
            SortEmotes()
        end)
        return CreatedSort
    end

    createsort(1, "Recently Updated First", "recentfirst")
    createsort(2, "Recently Updated Last", "recentlast")
    createsort(3, "Alphabetically First", "alphabeticfirst")
    createsort(4, "Alphabetically Last", "alphabeticlast")
    createsort(5, "Highest Price", "highestprice")
    createsort(6, "Lowest Price", "lowestprice")

    local SortButton = Instance.new("TextButton")
    SortButton.BorderSizePixel = 0
    SortButton.AnchorPoint = Vector2.new(0.5, 0.5)
    SortButton.Position = UDim2.new(0.925, -5, -0.075, 0)
    SortButton.Size = UDim2.new(0.15, 0, 0.1, 0)
    SortButton.TextScaled = true
    SortButton.TextColor3 = Color3.new(1, 1, 1)
    SortButton.BackgroundColor3 = Color3.new(0, 0, 0)
    SortButton.BackgroundTransparency = 0.3
    SortButton.Text = "Sort"
    SortButton.MouseButton1Click:Connect(function()
        SortFrame.Visible = not SortFrame.Visible
        Open.Text = "Open"
    end)
    Corner:Clone().Parent = SortButton
    SortButton.Parent = BackFrame

    local CloseButton = Instance.new("TextButton")
    CloseButton.BorderSizePixel = 0
    CloseButton.AnchorPoint = Vector2.new(0.5, 0.5)
    CloseButton.Position = UDim2.new(0.075, 0, -0.075, 0)
    CloseButton.Size = UDim2.new(0.15, 0, 0.1, 0)
    CloseButton.TextScaled = true
    CloseButton.TextColor3 = Color3.new(1, 1, 1)
    CloseButton.BackgroundColor3 = Color3.new(0.5, 0, 0)
    CloseButton.BackgroundTransparency = 0.3
    CloseButton.Text = "Kill Gui"
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
        getgenv().Emotesbruh = false
    end)
    Corner:Clone().Parent = CloseButton
    CloseButton.Parent = BackFrame

    local SearchBar = Instance.new("TextBox")
    SearchBar.BorderSizePixel = 0
    SearchBar.AnchorPoint = Vector2.new(0.5, 0.5)
    SearchBar.Position = UDim2.new(0.5, 0, -0.075, 0)
    SearchBar.Size = UDim2.new(0.55, 0, 0.1, 0)
    SearchBar.TextScaled = true
    SearchBar.PlaceholderText = "Search"
    SearchBar.TextColor3 = Color3.new(1, 1, 1)
    SearchBar.BackgroundColor3 = Color3.new(0, 0, 0)
    SearchBar.BackgroundTransparency = 0.3
    SearchBar:GetPropertyChangedSignal("Text"):Connect(function()
        local text = SearchBar.Text:lower()
        local buttons = Frame:GetChildren()
        if text ~= text:sub(1,50) then
            SearchBar.Text = SearchBar.Text:sub(1,50)
            text = SearchBar.Text:lower()
        end
        if text ~= ""  then
            for i,button in pairs(buttons) do
                if button:IsA("GuiButton") then
                    local name = button:GetAttribute("name"):lower()
                    if name:match(text) then
                        button.Visible = true
                    else
                        button.Visible = false
                    end
                end
            end
        else
            for i,button in pairs(buttons) do
                if button:IsA("GuiButton") then
                    button.Visible = true
                end
            end
        end
    end)
    Corner:Clone().Parent = SearchBar
    SearchBar.Parent = BackFrame

    local function openemotes(name, state, input)
        if state == Enum.UserInputState.Begin then
            BackFrame.Visible = not BackFrame.Visible
            Open.Text = "Open"
        end
    end

    ContextActionService:BindCoreActionAtPriority(
        "Emote Menu",
        openemotes,
        true,
        2001,
        Enum.KeyCode.Comma
    )

    local inputconnect
    ScreenGui:GetPropertyChangedSignal("Enabled"):Connect(function()
        if BackFrame.Visible == false then
            EmoteName.Text = "Select an Emote"
            SearchBar.Text = ""
            SortFrame.Visible = false
            GuiService:SetEmotesMenuOpen(false)
            inputconnect = UserInputService.InputBegan:Connect(function(input, processed)
                if not processed then
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        BackFrame.Visible = false
                        Open.Text = "Open"
                    end
                end
            end)
        else
            if inputconnect then
                inputconnect:Disconnect()
            end
        end
    end)

    GuiService.EmotesMenuOpenChanged:Connect(function(isopen)
        if isopen then
            BackFrame.Visible = false
            Open.Text = "Open"
        end
    end)

    GuiService.MenuOpened:Connect(function()
        BackFrame.Visible = false
        Open.Text = "Open"
    end)

    if not game:IsLoaded() then
        game.Loaded:Wait()
    end

    --thanks inf yield
    local SynV3 = syn and DrawingImmediate
    if (not is_sirhurt_closure) and (not SynV3) and (syn and syn.protect_gui) then
        syn.protect_gui(ScreenGui)
        ScreenGui.Parent = CoreGui
    elseif get_hidden_gui or gethui then
        local hiddenUI = get_hidden_gui or gethui
        ScreenGui.Parent = hiddenUI()
    else
        ScreenGui.Parent = CoreGui
    end

    local function SendNotification(title, text)
        if syn and syn.toast_notification then
            syn.toast_notification({
                Type = ToastType.Error,
                Title = title,
                Content = text
            })
        else
            StarterGui:SetCore("SendNotification", {
                Title = title,
                Text = text
            })
        end
    end

    local LocalPlayer = Players.LocalPlayer

    local function PlayEmote(name: string, id: IntValue)
        BackFrame.Visible = false
        Open.Text = "Open"
        SearchBar.Text = ""
        local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        local Description = Humanoid and Humanoid:FindFirstChildOfClass("HumanoidDescription")
        if not Description then
            return
        end
        if LocalPlayer.Character.Humanoid.RigType ~= Enum.HumanoidRigType.R6 then
            local succ, err = pcall(function()
                Humanoid:PlayEmoteAndGetAnimTrackById(id)
            end)
            if not succ then
                Description:AddEmote(name, id)
                Humanoid:PlayEmoteAndGetAnimTrackById(id)
            end
        else
            SendNotification(
                "r6? lol",
                "you gotta be r15 dude"
            )
        end
    end

    local function WaitForChildOfClass(parent, class)
        local child = parent:FindFirstChildOfClass(class)
        while not child or child.ClassName ~= class do
            child = parent.ChildAdded:Wait()
        end
        return child
    end

    local Emotes = {
        { name = "Around Town", id = 3576747102, icon = "rbxthumb://type=Asset&id=3576747102&w=150&h=150", price = 1000, lastupdated = 1663264200, sort = {} },
        { name = "TWICE TAKEDOWN DANCE 2", id = 85623000473425, icon = "rbxthumb://type=Asset&id=85623000473425&w=150&h=150", price = 100, lastupdated = 1752192000, sort = {} },
        -- ... (все остальные эмоции из вашего оригинального скрипта)
    }

    local function addEmote(name, id, price, date)
        local months = {
            Jan = 1, Feb = 2, Mar = 3, Apr = 4, May = 5, Jun = 6,
            Jul = 7, Aug = 8, Sep = 9, Oct = 10, Nov = 11, Dec = 12
        }
        local function dateToUnix(d)
            local mon, day, year = d:match("(%a+)%s+(%d+),%s*(%d+)")
            return os.time({
                year = tonumber(year),
                month = months[mon],
                day = tonumber(day),
                hour = 0,
                min = 0,
                sec = 0
            })
        end
        
        table.insert(Emotes, {
            name = name,
            id = id,
            icon = "rbxthumb://type=Asset&id=" .. id .. "&w=150&h=150",
            price = price,
            lastupdated = dateToUnix(date),
            sort = {}
        })
    end

    -- Добавление новых эмоций
    addEmote("PARROT PARTY DANCE", 121067808279598, 39, "Aug 08, 2025")
    addEmote("Dance n' Prance", 99031916674986, 39, "Aug 08, 2025")
    -- ... (все остальные новые эмоции)

    local function EmotesLoaded()
        for i, loaded in pairs(LoadedEmotes) do
            if not loaded then
                return false
            end
        end
        return true
    end

    while not EmotesLoaded() do
        task.wait()
    end

    Loading:Destroy()

    --sorting options setup
    table.sort(Emotes, function(a, b)
        return a.lastupdated > b.lastupdated
    end)
    for i,v in pairs(Emotes) do
        v.sort.recentfirst = i
    end

    table.sort(Emotes, function(a, b)
        return a.lastupdated < b.lastupdated
    end)
    for i,v in pairs(Emotes) do
        v.sort.recentlast = i
    end

    table.sort(Emotes, function(a, b)
        return a.name:lower() < b.name:lower()
    end)
    for i,v in pairs(Emotes) do
        v.sort.alphabeticfirst = i
    end

    table.sort(Emotes, function(a, b)
        return a.name:lower() > b.name:lower()
    end)
    for i,v in pairs(Emotes) do
        v.sort.alphabeticlast = i
    end

    table.sort(Emotes, function(a, b)
        return a.price < b.price
    end)
    for i,v in pairs(Emotes) do
        v.sort.lowestprice = i
    end

    table.sort(Emotes, function(a, b)
        return a.price > b.price
    end)
    for i,v in pairs(Emotes) do
        v.sort.highestprice = i
    end

    if isfile("FavoritedEmotes.txt") then
        if not pcall(function()
            FavoritedEmotes = HttpService:JSONDecode(readfile("FavoritedEmotes.txt"))
        end) then
            FavoritedEmotes = {}
        end
    else
        writefile("FavoritedEmotes.txt", HttpService:JSONEncode(FavoritedEmotes))
    end

    local UpdatedFavorites = {}
    for i,name in pairs(FavoritedEmotes) do
        if typeof(name) == "string" then
            for i,emote in pairs(Emotes) do
                if emote.name == name then
                    table.insert(UpdatedFavorites, emote.id)
                    break
                end
            end
        end
    end
    if #UpdatedFavorites ~= 0 then
        FavoritedEmotes = UpdatedFavorites
        writefile("FavoritedEmotes.txt", HttpService:JSONEncode(FavoritedEmotes))
    end

    local function CharacterAdded(Character)
        for i,v in pairs(Frame:GetChildren()) do
            if not v:IsA("UIGridLayout") then
                v:Destroy()
            end
        end
        local Humanoid = WaitForChildOfClass(Character, "Humanoid")
        local Description = Humanoid:WaitForChild("HumanoidDescription", 5) or Instance.new("HumanoidDescription", Humanoid)
        local random = Instance.new("TextButton")
        local Ratio = Instance.new("UIAspectRatioConstraint")
        Ratio.AspectType = Enum.AspectType.ScaleWithParentSize
        Ratio.Parent = random
        random.LayoutOrder = 0
        random.TextColor3 = Color3.new(1, 1, 1)
        random.BorderSizePixel = 0
        random.BackgroundTransparency = 0.5
        random.BackgroundColor3 = Color3.new(0, 0, 0)
        random.TextScaled = true
        random.Text = "Random"
        random:SetAttribute("name", "")
        Corner:Clone().Parent = random
        random.MouseButton1Click:Connect(function()
            local randomemote = Emotes[math.random(1, #Emotes)]
            PlayEmote(randomemote.name, randomemote.id)
        end)
        random.MouseEnter:Connect(function()
            EmoteName.Text = "Random"
        end)
        random.Parent = Frame

        for i,Emote in pairs(Emotes) do
            Description:AddEmote(Emote.name, Emote.id)
            local EmoteButton = Instance.new("ImageButton")
            local IsFavorited = table.find(FavoritedEmotes, Emote.id)
            EmoteButton.LayoutOrder = Emote.sort[CurrentSort] + ((IsFavorited and 0) or #Emotes)
            EmoteButton.Name = Emote.id
            EmoteButton:SetAttribute("name", Emote.name)
            Corner:Clone().Parent = EmoteButton
            EmoteButton.Image = Emote.icon
            EmoteButton.BackgroundTransparency = 0.5
            EmoteButton.BackgroundColor3 = Color3.new(0, 0, 0)
            EmoteButton.BorderSizePixel = 0
            Ratio:Clone().Parent = EmoteButton
            local EmoteNumber = Instance.new("TextLabel")
            EmoteNumber.Name = "number"
            EmoteNumber.TextScaled = true
            EmoteNumber.BackgroundTransparency = 1
            EmoteNumber.TextColor3 = Color3.new(1, 1, 1)
            EmoteNumber.BorderSizePixel = 0
            EmoteNumber.AnchorPoint = Vector2.new(0.5, 0.5)
            EmoteNumber.Size = UDim2.new(0.2, 0, 0.2, 0)
            EmoteNumber.Position = UDim2.new(0.1, 0, 0.9, 0)
            EmoteNumber.Text = Emote.sort[CurrentSort]
            EmoteNumber.TextXAlignment = Enum.TextXAlignment.Center
            EmoteNumber.TextYAlignment = Enum.TextYAlignment.Center
            local UIStroke = Instance.new("UIStroke")
            UIStroke.Transparency = 0.5
            UIStroke.Parent = EmoteNumber
            EmoteNumber.Parent = EmoteButton
            EmoteButton.Parent = Frame
            EmoteButton.MouseButton1Click:Connect(function()
                PlayEmote(Emote.name, Emote.id)
            end)
            EmoteButton.MouseEnter:Connect(function()
                EmoteName.Text = Emote.name
            end)
            local Favorite = Instance.new("ImageButton")
            Favorite.Name = "favorite"
            if table.find(FavoritedEmotes, Emote.id) then
                Favorite.Image = FavoriteOn
            else
                Favorite.Image = FavoriteOff
            end
            Favorite.AnchorPoint = Vector2.new(0.5, 0.5)
            Favorite.Size = UDim2.new(0.2, 0, 0.2, 0)
            Favorite.Position = UDim2.new(0.9, 0, 0.9, 0)
            Favorite.BorderSizePixel = 0
            Favorite.BackgroundTransparency = 1
            Favorite.Parent = EmoteButton
            Favorite.MouseButton1Click:Connect(function()
                local index = table.find(FavoritedEmotes, Emote.id)
                if index then
                    table.remove(FavoritedEmotes, index)
                    Favorite.Image = FavoriteOff
                    EmoteButton.LayoutOrder = Emote.sort[CurrentSort] + #Emotes
                else
                    table.insert(FavoritedEmotes, Emote.id)
                    Favorite.Image = FavoriteOn
                    EmoteButton.LayoutOrder = Emote.sort[CurrentSort]
                end
                writefile("FavoritedEmotes.txt", HttpService:JSONEncode(FavoritedEmotes))
            end)
        end

        for i=1,9 do
            local EmoteButton = Instance.new("Frame")
            EmoteButton.LayoutOrder = 2147483647
            EmoteButton.Name = "filler"
            EmoteButton.BackgroundTransparency = 1
            EmoteButton.BorderSizePixel = 0
            Ratio:Clone().Parent = EmoteButton
            EmoteButton.Visible = true
            EmoteButton.Parent = Frame
            EmoteButton.MouseEnter:Connect(function()
                EmoteName.Text = "Select an Emote"
            end)
        end
    end

    if LocalPlayer.Character then
        CharacterAdded(LocalPlayer.Character)
    end
    LocalPlayer.CharacterAdded:Connect(CharacterAdded)

    wait(1)
    game.CoreGui.Emotes.Enabled = true

    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "Done!",
        Text = "Emotes gui is here!",
        Duration = 10
    })

    game.Players.LocalPlayer.PlayerGui.ContextActionGui:Destroy()
end
