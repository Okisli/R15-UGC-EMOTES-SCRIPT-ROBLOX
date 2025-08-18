-- creator MyNicknameIsOwner oh my god
-- telegram @owner_scripts

if getgenv().Emotesbruh == true then
    return 
end
getgenv().Emotesbruh = true

-- Key system
local correctKey = "HelloWorld"
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
title.Text = "Enter the key..."
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
inputBox.PlaceholderText = "Key..."
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
checkButton.Text = "Check key"
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
getKeyButton.Text = "Get key"
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
        messageLabel.Text = "invalid key!"
        task.wait(2)
        messageLabel.Text = ""
    end
end)

getKeyButton.MouseButton1Click:Connect(function()
    setclipboard("https://t.me/owner_scriptsbot")
    messageLabel.TextColor3 = Color3.fromRGB(50, 255, 50)
    messageLabel.Text = "the link is copied !"
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
        { name = "Jumping Cheer", id = 5895009708, icon = "rbxthumb://type=Asset&id=5895009708&w=150&h=150", price = 50, lastupdated = 1604988014, sort = {} },
        { name = "Sleep", id = 4689362868, icon = "rbxthumb://type=Asset&id=4689362868&w=150&h=150", price = 50, lastupdated = 1663281651, sort = {} },
        { name = "ericdoa - dance", id = 15698510244, icon = "rbxthumb://type=Asset&id=15698510244&w=150&h=150", price = 50, lastupdated = 1703220462, sort = {} },
        { name = "Disagree", id = 4849495710, icon = "rbxthumb://type=Asset&id=4849495710&w=150&h=150", price = 50, lastupdated = 1663281649, sort = {} },
        { name = "Happy", id = 4849499887, icon = "rbxthumb://type=Asset&id=4849499887&w=150&h=150", price = 50, lastupdated = 1663281650, sort = {} },
        { name = "Bored", id = 5230661597, icon = "rbxthumb://type=Asset&id=5230661597&w=150&h=150", price = 50, lastupdated = 1663281649, sort = {} },
        { name = "High Wave", id = 5915776835, icon = "rbxthumb://type=Asset&id=5915776835&w=150&h=150", price = 50, lastupdated = 1663281650, sort = {} },
        { name = "Alo Yoga Pose - Warrior II", id = 12507106431, icon = "rbxthumb://type=Asset&id=12507106431&w=150&h=150", price = 50, lastupdated = 1677711229, sort = {} },
        { name = "Cower", id = 4940597758, icon = "rbxthumb://type=Asset&id=4940597758&w=150&h=150", price = 50, lastupdated = 1591404331, sort = {} },
        { name = "Wisp - air guitar", id = 17370797454, icon = "rbxthumb://type=Asset&id=17370797454&w=150&h=150", price = 50, lastupdated = 1714753031, sort = {} },
        { name = "Alo Yoga Pose - Triangle", id = 12507120275, icon = "rbxthumb://type=Asset&id=12507120275&w=150&h=150", price = 50, lastupdated = 1677711156, sort = {} },
        { name = "Cuco - Levitate", id = 15698511500, icon = "rbxthumb://type=Asset&id=15698511500&w=150&h=150", price = 50, lastupdated = 1708707329, sort = {} },
        { name = "Rock n Roll", id = 15506496093, icon = "rbxthumb://type=Asset&id=15506496093&w=150&h=150", price = 50, lastupdated = 1705451701, sort = {} },
        { name = "Shy", id = 3576717965, icon = "rbxthumb://type=Asset&id=3576717965&w=150&h=150", price = 50, lastupdated = 1663281651, sort = {} },
        { name = "Alo Yoga Pose - Lotus Position", id = 12507097350, icon = "rbxthumb://type=Asset&id=12507097350&w=150&h=150", price = 50, lastupdated = 1677711092, sort = {} },
        { name = "Curtsy", id = 4646306583, icon = "rbxthumb://type=Asset&id=4646306583&w=150&h=150", price = 50, lastupdated = 1663281649, sort = {} },
        { name = "Celebrate", id = 3994127840, icon = "rbxthumb://type=Asset&id=3994127840&w=150&h=150", price = 50, lastupdated = 1663281649, sort = {} },
        { name = "Yungblud Happier Jump", id = 15610015346, icon = "rbxthumb://type=Asset&id=15610015346&w=150&h=150", price = 50, lastupdated = 1702326238, sort = {} },
        { name = "Baby Queen - Face Frame", id = 14353421343, icon = "rbxthumb://type=Asset&id=14353421343&w=150&h=150", price = 50, lastupdated = 1692371043, sort = {} },
        { name = "Confused", id = 4940592718, icon = "rbxthumb://type=Asset&id=4940592718&w=150&h=150", price = 50, lastupdated = 1590791657, sort = {} },
        { name = "Beckon", id = 5230615437, icon = "rbxthumb://type=Asset&id=5230615437&w=150&h=150", price = 50, lastupdated = 1663281649, sort = {} },
        { name = "Secret Handshake Dance", id = 120642514156293, icon = "rbxthumb://type=Asset&id=120642514156293&w=150&h=150", price = 50, lastupdated = 1733254849, sort = {} },
        { name = "Baby Queen - Air Guitar & Knee Slide", id = 14353417553, icon = "rbxthumb://type=Asset&id=14353417553&w=150&h=150", price = 50, lastupdated = 1692371054, sort = {} },
        { name = "Baby Queen - Bouncy Twirl", id = 14353423348, icon = "rbxthumb://type=Asset&id=14353423348&w=150&h=150", price = 50, lastupdated = 1692371037, sort = {} },
        { name = "Baby Queen - Strut", id = 14353425085, icon = "rbxthumb://type=Asset&id=14353425085&w=150&h=150", price = 50, lastupdated = 1692371026, sort = {} },
        { name = "Baby Queen - Dramatic Bow", id = 14353419229, icon = "rbxthumb://type=Asset&id=14353419229&w=150&h=150", price = 50, lastupdated = 1692371048, sort = {} },
        { name = "Sad", id = 4849502101, icon = "rbxthumb://type=Asset&id=4849502101&w=150&h=150", price = 50, lastupdated = 1663281651, sort = {} },
        { name = "Robot M3GAN", id = 90569436057900, icon = "rbxthumb://type=Asset&id=90569436057900&w=150&h=150", price = 1, lastupdated = 1749316525, sort = {} },
        { name = "Nicki Minaj Anaconda", id = 15571539403, icon = "rbxthumb://type=Asset&id=15571539403&w=150&h=150", price = 0, lastupdated = 1702052956, sort = {} },
        { name = "Cha-Cha", id = 3696764866, icon = "rbxthumb://type=Asset&id=3696764866&w=150&h=150", price = 0, lastupdated = 1663281649, sort = {} },
        { name = "BURBERRY LOLA ATTITUDE - BLOOM", id = 10147919199, icon = "rbxthumb://type=Asset&id=10147919199&w=150&h=150", price = 0, lastupdated = 1663281649, sort = {} },
        { name = "Skadoosh Emote - Kung Fu Panda 4", id = 16371235025, icon = "rbxthumb://type=Asset&id=16371235025&w=150&h=150", price = 0, lastupdated = 1708496660, sort = {} },
        { name = "Chicken Dance", id = 4849493309, icon = "rbxthumb://type=Asset&id=4849493309&w=150&h=150", price = 0, lastupdated = 1663281649, sort = {} },
        { name = "BLACKPINK Don't know what to do", id = 18855609889, icon = "rbxthumb://type=Asset&id=18855609889&w=150&h=150", price = 0, lastupdated = 1723090163, sort = {} },
        { name = "Man City Scorpion Kick", id = 13694139364, icon = "rbxthumb://type=Asset&id=13694139364&w=150&h=150", price = 0, lastupdated = 1688061827, sort = {} },
        { name = "Gashina - SUNMI", id = 9528294735, icon = "rbxthumb://type=Asset&id=9528294735&w=150&h=150", price = 0, lastupdated = 1651539455, sort = {} },
        { name = "Fashion Spin", id = 130046968468383, icon = "rbxthumb://type=Asset&id=130046968468383&w=150&h=150", price = 0, lastupdated = 1732653968, sort = {} },
        { name = "Country Line Dance - Lil Nas X (LNX)", id = 5915780563, icon = "rbxthumb://type=Asset&id=5915780563&w=150&h=150", price = 0, lastupdated = 1605561299, sort = {} },
        { name = "Sandwich Dance", id = 4390121879, icon = "rbxthumb://type=Asset&id=4390121879&w=150&h=150", price = 0, lastupdated = 1663281651, sort = {} },
        { name = "BLACKPINK LISA Money", id = 15679957363, icon = "rbxthumb://type=Asset&id=15679957363&w=150&h=150", price = 0, lastupdated = 1703004397, sort = {} },
        { name = "Nicki Minaj That's That Super Bass Emote", id = 15571536896, icon = "rbxthumb://type=Asset&id=15571536896&w=150&h=150", price = 0, lastupdated = 1702052899, sort = {} },
        { name = "Salute", id = 3360689775, icon = "rbxthumb://type=Asset&id=3360689775&w=150&h=150", price = 0, lastupdated = 1663281651, sort = {} },
        { name = "Olympic Dismount", id = 18666650035, icon = "rbxthumb://type=Asset&id=18666650035&w=150&h=150", price = 0, lastupdated = 1722014387, sort = {} },
        { name = "MANIAC - Stray Kids", id = 11309309359, icon = "rbxthumb://type=Asset&id=11309309359&w=150&h=150", price = 0, lastupdated = 1668458448, sort = {} },
        { name = "BLACKPINK JISOO Flower", id = 15439454888, icon = "rbxthumb://type=Asset&id=15439454888&w=150&h=150", price = 0, lastupdated = 1701124495, sort = {} },
        { name = "Man City Bicycle Kick", id = 13422286833, icon = "rbxthumb://type=Asset&id=13422286833&w=150&h=150", price = 0, lastupdated = 1684429651, sort = {} },
        { name = "Man City Backflip", id = 13694140956, icon = "rbxthumb://type=Asset&id=13694140956&w=150&h=150", price = 0, lastupdated = 1688061856, sort = {} },
        { name = "BLACKPINK Pink Venom - Straight to Ya Dome", id = 14548711723, icon = "rbxthumb://type=Asset&id=14548711723&w=150&h=150", price = 0, lastupdated = 1732579764, sort = {} },
        { name = "BLACKPINK Pink Venom - I Bring the Pain Like…", id = 14548710952, icon = "rbxthumb://type=Asset&id=14548710952&w=150&h=150", price = 0, lastupdated = 1732579780, sort = {} },
        { name = "Stadium", id = 3360686498, icon = "rbxthumb://type=Asset&id=3360686498&w=150&h=150", price = 0, lastupdated = 1663281651, sort = {} },
        { name = "BLACKPINK ROSÉ On The Ground", id = 15679958535, icon = "rbxthumb://type=Asset&id=15679958535&w=150&h=150", price = 0, lastupdated = 1703004441, sort = {} },
        { name = "Bunny Hop", id = 4646296016, icon = "rbxthumb://type=Asset&id=4646296016&w=150&h=150", price = 0, lastupdated = 1663281649, sort = {} },
        { name = "BLACKPINK Shut Down - Part 1", id = 14901369589, icon = "rbxthumb://type=Asset&id=14901369589&w=150&h=150", price = 0, lastupdated = 1732579788, sort = {} },
        { name = "BLACKPINK Kill This Love", id = 16181843366, icon = "rbxthumb://type=Asset&id=16181843366&w=150&h=150", price = 0, lastupdated = 1706724495, sort = {} },
        { name = "SpongeBob Dance", id = 18443271885, icon = "rbxthumb://type=Asset&id=18443271885&w=150&h=150", price = 0, lastupdated = 1720722377, sort = {} },
        { name = "Borock's Rage", id = 3236848555, icon = "rbxthumb://type=Asset&id=3236848555&w=150&h=150", price = 0, lastupdated = 1663281649, sort = {} },
        { name = "The Conductor - George Ezra", id = 10370926562, icon = "rbxthumb://type=Asset&id=10370926562&w=150&h=150", price = 0, lastupdated = 1658879306, sort = {} },
        { name = "Swag Walk", id = 10478377385, icon = "rbxthumb://type=Asset&id=10478377385&w=150&h=150", price = 0, lastupdated = 1659642405, sort = {} },
        { name = "BLACKPINK Shut Down - Part 2", id = 14901371589, icon = "rbxthumb://type=Asset&id=14901371589&w=150&h=150", price = 0, lastupdated = 1732579772, sort = {} },
        { name = "BLACKPINK Ice Cream", id = 16181840356, icon = "rbxthumb://type=Asset&id=16181840356&w=150&h=150", price = 0, lastupdated = 1706724478, sort = {} },
        { name = "Superhero Reveal", id = 3696759798, icon = "rbxthumb://type=Asset&id=3696759798&w=150&h=150", price = 0, lastupdated = 1663281651, sort = {} },
        { name = "BLACKPINK Pink Venom - Get em Get em Get em", id = 14548709888, icon = "rbxthumb://type=Asset&id=14548709888&w=150&h=150", price = 0, lastupdated = 1732579749, sort = {} },
        { name = "NBA Monster Dunk", id = 82163305721376, icon = "rbxthumb://type=Asset&id=82163305721376&w=150&h=150", price = 0, lastupdated = 1739396236, sort = {} },
        { name = "TWICE ABCD by Nayeon", id = 18933761755, icon = "rbxthumb://type=Asset&id=18933761755&w=150&h=150", price = 0, lastupdated = 1723561480, sort = {} },
        { name = "BURBERRY LOLA ATTITUDE - NIMBUS", id = 10147924028, icon = "rbxthumb://type=Asset&id=10147924028&w=150&h=150", price = 0, lastupdated = 1657728069, sort = {} },
        { name = "Ud'zal's Summoning", id = 3307604888, icon = "rbxthumb://type=Asset&id=3307604888&w=150&h=150", price = 0, lastupdated = 1663281651, sort = {} },
        { name = "TWICE Pop by Nayeon", id = 13768975574, icon = "rbxthumb://type=Asset&id=13768975574&w=150&h=150", price = 0, lastupdated = 1687549777, sort = {} },
        { name = "TWICE Set Me Free - Dance 1", id = 12715395038, icon = "rbxthumb://type=Asset&id=12715395038&w=150&h=150", price = 0, lastupdated = 1678474186, sort = {} },
        { name = "TWICE Set Me Free - Dance 2", id = 12715397488, icon = "rbxthumb://type=Asset&id=12715397488&w=150&h=150", price = 0, lastupdated = 1678474350, sort = {} },
        { name = "Hyperfast 5G Dance Move", id = 9408642191, icon = "rbxthumb://type=Asset&id=9408642191&w=150&h=150", price = 0, lastupdated = 1663281650, sort = {} },
        { name = "You can't sit with us - Sunmi", id = 9983549160, icon = "rbxthumb://type=Asset&id=9983549160&w=150&h=150", price = 0, lastupdated = 1657679637, sort = {} },
        { name = "Hype Dance", id = 3696757129, icon = "rbxthumb://type=Asset&id=3696757129&w=150&h=150", price = 0, lastupdated = 1663281650, sort = {} },
        { name = "BLACKPINK - How You Like That", id = 16874596971, icon = "rbxthumb://type=Asset&id=16874596971&w=150&h=150", price = 0, lastupdated = 1711414303, sort = {} },
        { name = "BLACKPINK - Lovesick Girls", id = 16874600526, icon = "rbxthumb://type=Asset&id=16874600526&w=150&h=150", price = 0, lastupdated = 1711414329, sort = {} },
        { name = "TWICE Like Ooh-Ahh", id = 14124050904, icon = "rbxthumb://type=Asset&id=14124050904&w=150&h=150", price = 0, lastupdated = 1689868872, sort = {} },
        { name = "Heisman Pose", id = 3696763549, icon = "rbxthumb://type=Asset&id=3696763549&w=150&h=150", price = 0, lastupdated = 1663281650, sort = {} },
        { name = "BLACKPINK As If It's Your Last", id = 18855603653, icon = "rbxthumb://type=Asset&id=18855603653&w=150&h=150", price = 0, lastupdated = 1723090177, sort = {} },
        { name = "TWICE Moonlight Sunrise ", id = 12715393154, icon = "rbxthumb://type=Asset&id=12715393154&w=150&h=150", price = 0, lastupdated = 1678474249, sort = {} },
        { name = "TWICE Fancy", id = 13520623514, icon = "rbxthumb://type=Asset&id=13520623514&w=150&h=150", price = 0, lastupdated = 1685112803, sort = {} },
        { name = "Point2", id = 3576823880, icon = "rbxthumb://type=Asset&id=3576823880&w=150&h=150", price = 0, lastupdated = 1663281650, sort = {} },
        { name = "BURBERRY LOLA ATTITUDE - GEM", id = 10147916560, icon = "rbxthumb://type=Asset&id=10147916560&w=150&h=150", price = 0, lastupdated = 1663281649, sort = {} },
        { name = "Vroom Vroom", id = 18526410572, icon = "rbxthumb://type=Asset&id=18526410572&w=150&h=150", price = 0, lastupdated = 1721931643, sort = {} },
        { name = "Hwaiting (화이팅)", id = 9528291779, icon = "rbxthumb://type=Asset&id=9528291779&w=150&h=150", price = 0, lastupdated = 1663281650, sort = {} },
        { name = "BLACKPINK JENNIE You and Me", id = 15439457146, icon = "rbxthumb://type=Asset&id=15439457146&w=150&h=150", price = 0, lastupdated = 1701124471, sort = {} },
        { name = "Tilt", id = 3360692915, icon = "rbxthumb://type=Asset&id=3360692915&w=150&h=150", price = 0, lastupdated = 1663281651, sort = {} },
        { name = "Applaud", id = 5915779043, icon = "rbxthumb://type=Asset&id=5915779043&w=150&h=150", price = 0, lastupdated = 1663264200, sort = {} },
        { name = "BLACKPINK DDU-DU DDU-DU", id = 16553262614, icon = "rbxthumb://type=Asset&id=16553262614&w=150&h=150", price = 0, lastupdated = 1709100790, sort = {} },
        { name = "BURBERRY LOLA ATTITUDE - HYDRO", id = 10147926081, icon = "rbxthumb://type=Asset&id=10147926081&w=150&h=150", price = 0, lastupdated = 1657814503, sort = {} },
        { name = "BURBERRY LOLA ATTITUDE - REFLEX", id = 10147921916, icon = "rbxthumb://type=Asset&id=10147921916&w=150&h=150", price = 0, lastupdated = 1663281649, sort = {} },
        { name = "Air Guitar", id = 3696761354, icon = "rbxthumb://type=Asset&id=3696761354&w=150&h=150", price = 0, lastupdated = 1663264200, sort = {} },
        { name = "Annyeong (안녕)", id = 9528286240, icon = "rbxthumb://type=Asset&id=9528286240&w=150&h=150", price = 0, lastupdated = 1651539455, sort = {} },
        { name = "BLACKPINK Boombayah Emote", id = 16553259683, icon = "rbxthumb://type=Asset&id=16553259683&w=150&h=150", price = 0, lastupdated = 1709339907, sort = {} },
        { name = "Victory - 24kGoldn", id = 9178397781, icon = "rbxthumb://type=Asset&id=9178397781&w=150&h=150", price = 0, lastupdated = 1663281651, sort = {} },
        { name = "Hello", id = 3576686446, icon = "rbxthumb://type=Asset&id=3576686446&w=150&h=150", price = 0, lastupdated = 1663281650, sort = {} },
        { name = "Vans Ollie", id = 18305539673, icon = "rbxthumb://type=Asset&id=18305539673&w=150&h=150", price = 0, lastupdated = 1719938530, sort = {} },
        { name = "TWICE Strategy", id = 106862678450011, icon = "rbxthumb://type=Asset&id=106862678450011&w=150&h=150", price = 0, lastupdated = 1734540744, sort = {} },
        { name = "TWICE The Feels", id = 12874468267, icon = "rbxthumb://type=Asset&id=12874468267&w=150&h=150", price = 0, lastupdated = 1679673336, sort = {} },
        { name = "TWICE What Is Love", id = 13344121112, icon = "rbxthumb://type=Asset&id=13344121112&w=150&h=150", price = 0, lastupdated = 1683906913, sort = {} },
        { name = "Shrug", id = 3576968026, icon = "rbxthumb://type=Asset&id=3576968026&w=150&h=150", price = 0, lastupdated = 1663281651, sort = {} },
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
    addEmote("R15 Death (Accurate)", 114899970878842, 39, "Aug 08, 2025")
    addEmote("Wally West", 133948663586698, 39, "Aug 08, 2025")
    addEmote("Take The L", 123159156696507, 39, "Aug 08, 2025")
    addEmote("Xaviersobased", 131763631172236, 39, "Aug 09, 2025")
    addEmote("Belly Dancing", 131939729732240, 39, "Aug 08, 2025")
    addEmote("RAT DANCE", 133461102795137, 78, "Aug 08, 2025")
    addEmote("CaramellDansen", 93105950995997, 39, "Aug 08, 2025")
    addEmote("Biblically Accurate", 133596366979822, 39, "Aug 08, 2025")
    addEmote("Rambunctious", 108128682361404, 39, "Aug 08, 2025")
    addEmote("Die Lit", 121001502815813, 39, "Aug 08, 2025")
    addEmote("Nyan Nyan!", 73796726960568, 39, "Aug 08, 2025")
    addEmote("Teto Territory", 114428584463004, 39, "Aug 08, 2025")
    addEmote("Skibidi", 124828909173982, 39, "Aug 08, 2025")
    addEmote("Chronoshift", 92600655160976, 39, "Aug 08, 2025")
    addEmote("Floating on Clouds", 111426928948833, 39, "Aug 08, 2025")
    addEmote("Jersey Joe", 134149640725489, 39, "Aug 08, 2025")
    addEmote("Virtual Insanity", 83261816934732, 39, "Aug 09, 2025")
    addEmote("Doodle Dance", 107091254142209, 39, "Aug 08, 2025")
    addEmote("Subject 3", 83732367439808, 39, "Aug 08, 2025")
    addEmote("Club Penguin", 98099211500155, 39, "Aug 09, 2025")
    addEmote("Kazotsky", 97629500912487, 39, "Aug 08, 2025")
    addEmote("Miku Dance", 117734400993750, 39, "Aug 08, 2025")
    addEmote("Deltarune - Tenna Swing", 103139492736941, 39, "Aug 08, 2025")
    addEmote("Hakari Dance", 80270168146449, 39, "Aug 08, 2025")
    addEmote("Addendum Dance [R6]", 134442882516163, 39, "Aug 09, 2025")
    addEmote("Gangnam Style", 77205409178702, 39, "Aug 08, 2025")
    addEmote("Push-Up", 117922227854118, 39, "Aug 09, 2025")
    addEmote("Split", 98522218962476, 39, "Aug 08, 2025")
    addEmote("PROXIMA", 81390693780805, 39, "Aug 08, 2025")
    addEmote("HeadBanging", 87447252507832, 39, "Aug 08, 2025")
    addEmote("Assumptions", 127507691649322, 39, "Aug 08, 2025")
    addEmote("Jumpstyle", 99563839802389, 39, "Aug 08, 2025")
    addEmote("Flopping Fish", 133142324349281, 39, "Aug 08, 2025")
    addEmote("Kicking Feet Sit", 78758922757947, 39, "Aug 08, 2025")
    addEmote("Fancy Feets", 124512151372711, 39, "Aug 08, 2025")
    addEmote("Cute Sit", 90244178386698, 39, "Aug 08, 2025")
    addEmote("Absolute Cinema", 97258018304125, 39, "Aug 08, 2025")
    addEmote("Bubbly Sit", 112758073578333, 39, "Aug 08, 2025")
    addEmote("Become A Car", 131544122623505, 39, "Aug 08, 2025")
    addEmote("Hiding Human Box", 124935873390035, 39, "Aug 08, 2025")
    addEmote("Magical Pose", 135489824748823, 39, "Aug 08, 2025")
    addEmote("Griddy", 116065653184749, 39, "Aug 08, 2025")
    addEmote("Spy Laugh tf2", 137720205462499, 39, "Aug 10, 2025") 
    addEmote("Head Juggling", 82224981519682, 39, "Aug 09, 2025")
    addEmote("Omniman Think", 70560694892323, 39, "Aug 09, 2025")
    addEmote("Ishowspeed Shake Dancing", 138386881919239, 39, "Aug 09, 2025")
    addEmote("Wait", 106569806588657, 39, "Aug 09, 2025")
    addEmote("Shinji Pose", 97629500912487, 39, "Aug 09, 2025")
    addEmote("Come At Me [ R6 ]", 107758370940834, 39, "Aug 09, 2025")
    addEmote("Oscillating Fan", 71493999860590, 39, "Aug 09, 2025")
    addEmote("Locked In", 110145155419199, 39, "Aug 10, 2025")
    addEmote("BirdBrain", 105730788757021, 39, "Aug 10, 2025")
    addEmote("Hakari (FULL)", 71056659089869, 39, "Aug 09, 2025")
    addEmote("Strongest Stance", 80146495484274, 39, "Aug 09, 2025")
    addEmote("Cat Things", 131193808160056, 39, "Aug 09, 2025")
    addEmote("Doggy Things", 105206768873249, 39, "Aug 09, 2025")
    addEmote("Wally West Edit", 72247161810866, 39, "Aug 09, 2025")
    addEmote("24 Hour Cinderella", 122972776209997, 39, "Aug 09, 2025")
    addEmote("Rafa Polinesio Baile", 133047022806044, 39, "Aug 09, 2025")
    addEmote("Mesmerizer", 92707348383277, 39, "Aug 09, 2025")
    addEmote("Soda Pop", 132718205548925, 39, "Aug 10, 2025")
    addEmote("Best Mates", 73271793399763, 39, "Aug 10, 2025")
    addEmote("Garou", 86200585395371, 39, "Aug 09, 2025")
    addEmote("Dio Pose", 76736978166708, 39, "Aug 09, 2025")
    addEmote("Twerkstuff", 133246132766663, 39, "Aug 09, 2025")
    addEmote("Golden Freddy", 122463450997235, 39, "Aug 09, 2025")
    addEmote("Noclip, Speed", 137006085779408, 39, "Aug 09, 2025")
    addEmote("Static [Hatsune Miku]", 84534006084837, 39, "Aug 09, 2025")
    addEmote("GOALL", 78830825254717, 39, "Aug 09, 2025")
    addEmote("Lethal Dance", 77108921633993, 39, "Aug 09, 2025")
    addEmote("Plug Walk", 100359724990859, 39, "Aug 09, 2025")
    addEmote("At Ease", 76993139936388, 39, "Aug 09, 2025")
    addEmote("Conga", 97547955535086, 39, "Aug 09, 2025")
    addEmote("Barrel", 84511772437190, 39, "Aug 08, 2025")
    addEmote("Helicopter", 84555218084038, 39, "Aug 08, 2025")
    addEmote("Aura Farm Boat", 88042995626011, 39, "Aug 09, 2025")
    addEmote("Prince Of Egypt", 134063402217274, 39, "Aug 08, 2025")
    addEmote("Jersey Joe2", 115782117564871, 39, "Aug 09, 2025")
    addEmote("Deltarune - Tenna Dance", 73715378215546, 39, "Aug 08, 2025")
    addEmote("California Girl", 132074413582912, 39, "Aug 08, 2025")
    addEmote("Default Dance", 80877772569772, 39, "Aug 08, 2025")
    addEmote("Shocked meme", 129501229484294, 39, "Aug 08, 2025")
    addEmote("Family Guy", 78459263478161, 39, "Aug 08, 2025")
    addEmote("Tank Transformation", 132382355371060, 39, "Aug 08, 2025")
    addEmote("Insanity", 129843344424281, 39, "Aug 08, 2025")
    addEmote("Honored One", 121643381580730, 39, "Aug 08, 2025")
    addEmote("Sukuna", 91839607010745, 39, "Aug 08, 2025")
    addEmote("Dropper", 130358790702800, 39, "Aug 08, 2025")
    addEmote("Be Not Afraid", 70635223083942, 39, "Aug 08, 2025")
    addEmote("Macarena", 91274761264433, 39, "Aug 08, 2025")
    addEmote("Helicopter2", 119431985170060, 39, "Aug 08, 2025")
    addEmote("RONALDO", 97547486465713, 39, "Aug 08, 2025")
    addEmote("Nya Anime Dance", 126647057611522, 39, "Aug 08, 2025")
    addEmote("Do that thang", 113772829398170, 39, "Aug 08, 2025")
    addEmote("Squat?", 95441477641149, 39, "Aug 08, 2025")
    addEmote("Slickback", 103789826265487, 39, "Aug 08, 2025")
    
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
