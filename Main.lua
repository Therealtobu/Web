-- Cheat Hub Dashboard UI Library
local CheatHub = {}
CheatHub.__index = CheatHub

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Create main dashboard
function CheatHub:CreateWindow(config)
    local self = setmetatable({}, CheatHub)
    
    self.Title = config.Title or "CHEAT HUB"
    self.Categories = {}
    self.CurrentCategory = nil
    
    -- Create ScreenGui
    self.ScreenGui = Instance.new("ScreenGui")
    self.ScreenGui.Name = "CheatHubDashboard"
    self.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    self.ScreenGui.ResetOnSpawn = false
    self.ScreenGui.Parent = game:GetService("CoreGui")
    
    -- Main container
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 700, 0, 500)
    MainFrame.Position = UDim2.new(0.5, -350, 0.5, -250)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = self.ScreenGui
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = MainFrame
    
    -- Add shadow effect
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Size = UDim2.new(1, 40, 1, 40)
    Shadow.Position = UDim2.new(0, -20, 0, -20)
    Shadow.BackgroundTransparency = 1
    Shadow.Image = "rbxassetid://6015897843"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 0.5
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(49, 49, 450, 450)
    Shadow.ZIndex = -1
    Shadow.Parent = MainFrame
    
    -- Top bar
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Size = UDim2.new(1, 0, 0, 50)
    TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame
    
    local TopCorner = Instance.new("UICorner")
    TopCorner.CornerRadius = UDim.new(0, 12)
    TopCorner.Parent = TopBar
    
    -- Title
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "Title"
    TitleLabel.Size = UDim2.new(0, 200, 1, 0)
    TitleLabel.Position = UDim2.new(0, 20, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = self.Title
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 20
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = TopBar
    
    -- Close button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 40, 0, 40)
    CloseButton.Position = UDim2.new(1, -50, 0, 5)
    CloseButton.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    CloseButton.Text = "×"
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextSize = 24
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.Parent = TopBar
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 8)
    CloseCorner.Parent = CloseButton
    
    CloseButton.MouseButton1Click:Connect(function()
        self.ScreenGui:Destroy()
    end)
    
    -- Sidebar container
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Size = UDim2.new(0, 200, 1, -50)
    Sidebar.Position = UDim2.new(0, 0, 0, 50)
    Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 23)
    Sidebar.BorderSizePixel = 0
    Sidebar.Parent = MainFrame
    
    local SidebarList = Instance.new("UIListLayout")
    SidebarList.Padding = UDim.new(0, 5)
    SidebarList.Parent = Sidebar
    
    -- Content container
    local Content = Instance.new("Frame")
    Content.Name = "Content"
    Content.Size = UDim2.new(1, -200, 1, -50)
    Content.Position = UDim2.new(0, 200, 0, 50)
    Content.BackgroundTransparency = 1
    Content.BorderSizePixel = 0
    Content.Parent = MainFrame
    
    -- Logo in center
    local LogoContainer = Instance.new("Frame")
    LogoContainer.Name = "LogoContainer"
    LogoContainer.Size = UDim2.new(0, 300, 0, 150)
    LogoContainer.Position = UDim2.new(0.5, -150, 0.5, -75)
    LogoContainer.BackgroundTransparency = 1
    LogoContainer.Parent = Content
    
    local LogoText = Instance.new("TextLabel")
    LogoText.Name = "LogoText"
    LogoText.Size = UDim2.new(1, 0, 1, 0)
    LogoText.BackgroundTransparency = 1
    LogoText.Text = "CHEAT\nHUB"
    LogoText.Font = Enum.Font.GothamBold
    LogoText.TextSize = 48
    LogoText.TextColor3 = Color3.fromRGB(255, 50, 50)
    LogoText.Parent = LogoContainer
    
    -- Add gradient to logo
    local LogoGradient = Instance.new("UIGradient")
    LogoGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 50, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 0, 0))
    }
    LogoGradient.Rotation = 45
    LogoGradient.Parent = LogoText
    
    -- Add stroke to logo
    local LogoStroke = Instance.new("UIStroke")
    LogoStroke.Color = Color3.fromRGB(0, 0, 0)
    LogoStroke.Thickness = 3
    LogoStroke.Parent = LogoText
    
    -- Pulsing animation for logo
    local pulseIn = TweenService:Create(LogoText, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        TextSize = 52
    })
    pulseIn:Play()
    
    self.MainFrame = MainFrame
    self.Sidebar = Sidebar
    self.Content = Content
    self.LogoContainer = LogoContainer
    
    -- Make draggable
    self:MakeDraggable(MainFrame, TopBar)
    
    return self
end

-- Add category
function CheatHub:AddCategory(config)
    local CategoryButton = Instance.new("TextButton")
    CategoryButton.Name = config.Title
    CategoryButton.Size = UDim2.new(1, -10, 0, 60)
    CategoryButton.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    CategoryButton.BorderSizePixel = 0
    CategoryButton.Text = ""
    CategoryButton.AutoButtonColor = false
    CategoryButton.Parent = self.Sidebar
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = CategoryButton
    
    -- Icon
    local Icon = Instance.new("ImageLabel")
    Icon.Name = "Icon"
    Icon.Size = UDim2.new(0, 30, 0, 30)
    Icon.Position = UDim2.new(0, 15, 0, 15)
    Icon.BackgroundTransparency = 1
    Icon.Image = config.Icon or "rbxassetid://7733964640"
    Icon.ImageColor3 = Color3.fromRGB(180, 180, 180)
    Icon.Parent = CategoryButton
    
    -- Title
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(1, -55, 0, 20)
    Title.Position = UDim2.new(0, 55, 0, 10)
    Title.BackgroundTransparency = 1
    Title.Text = config.Title
    Title.Font = Enum.Font.GothamMedium
    Title.TextSize = 16
    Title.TextColor3 = Color3.fromRGB(180, 180, 180)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = CategoryButton
    
    -- Description
    local Description = Instance.new("TextLabel")
    Description.Name = "Description"
    Description.Size = UDim2.new(1, -55, 0, 15)
    Description.Position = UDim2.new(0, 55, 0, 32)
    Description.BackgroundTransparency = 1
    Description.Text = config.Description or "Modules that affect your game"
    Description.Font = Enum.Font.Gotham
    Description.TextSize = 11
    Description.TextColor3 = Color3.fromRGB(120, 120, 120)
    Description.TextXAlignment = Enum.TextXAlignment.Left
    Description.Parent = CategoryButton
    
    -- Arrow
    local Arrow = Instance.new("ImageLabel")
    Arrow.Name = "Arrow"
    Arrow.Size = UDim2.new(0, 20, 0, 20)
    Arrow.Position = UDim2.new(1, -30, 0.5, -10)
    Arrow.BackgroundTransparency = 1
    Arrow.Image = "rbxassetid://7733717447"
    Arrow.ImageColor3 = Color3.fromRGB(120, 120, 120)
    Arrow.Parent = CategoryButton
    
    -- Create category page
    local CategoryPage = Instance.new("ScrollingFrame")
    CategoryPage.Name = config.Title .. "Page"
    CategoryPage.Size = UDim2.new(1, -20, 1, -20)
    CategoryPage.Position = UDim2.new(0, 10, 0, 10)
    CategoryPage.BackgroundTransparency = 1
    CategoryPage.BorderSizePixel = 0
    CategoryPage.ScrollBarThickness = 4
    CategoryPage.ScrollBarImageColor3 = Color3.fromRGB(255, 50, 50)
    CategoryPage.Visible = false
    CategoryPage.Parent = self.Content
    
    local PageList = Instance.new("UIListLayout")
    PageList.Padding = UDim.new(0, 10)
    PageList.Parent = CategoryPage
    
    PageList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        CategoryPage.CanvasSize = UDim2.new(0, 0, 0, PageList.AbsoluteContentSize.Y + 10)
    end)
    
    -- Click handler
    CategoryButton.MouseButton1Click:Connect(function()
        self:SelectCategory(config.Title)
    end)
    
    -- Hover effects
    CategoryButton.MouseEnter:Connect(function()
        TweenService:Create(CategoryButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(35, 35, 40)
        }):Play()
        TweenService:Create(Icon, TweenInfo.new(0.2), {
            ImageColor3 = Color3.fromRGB(255, 50, 50)
        }):Play()
        TweenService:Create(Title, TweenInfo.new(0.2), {
            TextColor3 = Color3.fromRGB(255, 255, 255)
        }):Play()
    end)
    
    CategoryButton.MouseLeave:Connect(function()
        if self.CurrentCategory ~= config.Title then
            TweenService:Create(CategoryButton, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(25, 25, 30)
            }):Play()
            TweenService:Create(Icon, TweenInfo.new(0.2), {
                ImageColor3 = Color3.fromRGB(180, 180, 180)
            }):Play()
            TweenService:Create(Title, TweenInfo.new(0.2), {
                TextColor3 = Color3.fromRGB(180, 180, 180)
            }):Play()
        end
    end)
    
    self.Categories[config.Title] = {
        Button = CategoryButton,
        Page = CategoryPage,
        Icon = Icon,
        Title = Title,
        Arrow = Arrow
    }
    
    return {
        Page = CategoryPage,
        AddToggle = function(_, toggleConfig)
            return self:AddToggle(CategoryPage, toggleConfig)
        end,
        AddButton = function(_, buttonConfig)
            return self:AddButton(CategoryPage, buttonConfig)
        end,
        AddSlider = function(_, sliderConfig)
            return self:AddSlider(CategoryPage, sliderConfig)
        end,
        AddSection = function(_, sectionConfig)
            return self:AddSection(CategoryPage, sectionConfig)
        end
    }
end

-- Select category
function CheatHub:SelectCategory(categoryName)
    -- Hide logo
    self.LogoContainer.Visible = false
    
    -- Reset all categories
    for name, category in pairs(self.Categories) do
        category.Page.Visible = false
        TweenService:Create(category.Button, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(25, 25, 30)
        }):Play()
        TweenService:Create(category.Icon, TweenInfo.new(0.2), {
            ImageColor3 = Color3.fromRGB(180, 180, 180)
        }):Play()
        TweenService:Create(category.Title, TweenInfo.new(0.2), {
            TextColor3 = Color3.fromRGB(180, 180, 180)
        }):Play()
    end
    
    -- Show selected category
    if self.Categories[categoryName] then
        self.CurrentCategory = categoryName
        local category = self.Categories[categoryName]
        category.Page.Visible = true
        
        TweenService:Create(category.Button, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(45, 15, 15)
        }):Play()
        TweenService:Create(category.Icon, TweenInfo.new(0.2), {
            ImageColor3 = Color3.fromRGB(255, 50, 50)
        }):Play()
        TweenService:Create(category.Title, TweenInfo.new(0.2), {
            TextColor3 = Color3.fromRGB(255, 255, 255)
        }):Play()
    end
end

-- Add section
function CheatHub:AddSection(parent, config)
    local SectionLabel = Instance.new("TextLabel")
    SectionLabel.Size = UDim2.new(1, 0, 0, 30)
    SectionLabel.BackgroundTransparency = 1
    SectionLabel.Text = config.Title or "Section"
    SectionLabel.Font = Enum.Font.GothamBold
    SectionLabel.TextSize = 18
    SectionLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    SectionLabel.TextXAlignment = Enum.TextXAlignment.Left
    SectionLabel.Parent = parent
end

-- Add toggle
function CheatHub:AddToggle(parent, config)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 40)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = ToggleFrame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -60, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = config.Title or "Toggle"
    Title.Font = Enum.Font.GothamMedium
    Title.TextSize = 14
    Title.TextColor3 = Color3.fromRGB(200, 200, 200)
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = ToggleFrame
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0, 40, 0, 20)
    ToggleButton.Position = UDim2.new(1, -50, 0.5, -10)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Text = ""
    ToggleButton.AutoButtonColor = false
    ToggleButton.Parent = ToggleFrame
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(1, 0)
    ToggleCorner.Parent = ToggleButton
    
    local ToggleCircle = Instance.new("Frame")
    ToggleCircle.Size = UDim2.new(0, 16, 0, 16)
    ToggleCircle.Position = UDim2.new(0, 2, 0.5, -8)
    ToggleCircle.BackgroundColor3 = Color3.fromRGB(120, 120, 125)
    ToggleCircle.BorderSizePixel = 0
    ToggleCircle.Parent = ToggleButton
    
    local CircleCorner = Instance.new("UICorner")
    CircleCorner.CornerRadius = UDim.new(1, 0)
    CircleCorner.Parent = ToggleCircle
    
    local toggled = config.Default or false
    
    if toggled then
        ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        ToggleCircle.Position = UDim2.new(1, -18, 0.5, -8)
        ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    end
    
    ToggleButton.MouseButton1Click:Connect(function()
        toggled = not toggled
        
        if toggled then
            TweenService:Create(ToggleButton, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            }):Play()
            TweenService:Create(ToggleCircle, TweenInfo.new(0.2), {
                Position = UDim2.new(1, -18, 0.5, -8),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            }):Play()
        else
            TweenService:Create(ToggleButton, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(40, 40, 45)
            }):Play()
            TweenService:Create(ToggleCircle, TweenInfo.new(0.2), {
                Position = UDim2.new(0, 2, 0.5, -8),
                BackgroundColor3 = Color3.fromRGB(120, 120, 125)
            }):Play()
        end
        
        if config.Callback then
            config.Callback(toggled)
        end
    end)
    
    return {
        SetValue = function(value)
            toggled = value
            if toggled then
                ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
                ToggleCircle.Position = UDim2.new(1, -18, 0.5, -8)
                ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            else
                ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
                ToggleCircle.Position = UDim2.new(0, 2, 0.5, -8)
                ToggleCircle.BackgroundColor3 = Color3.fromRGB(120, 120, 125)
            end
        end
    }
end

-- Add button
function CheatHub:AddButton(parent, config)
    local ButtonFrame = Instance.new("TextButton")
    ButtonFrame.Size = UDim2.new(1, 0, 0, 40)
    ButtonFrame.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    ButtonFrame.BorderSizePixel = 0
    ButtonFrame.Text = ""
    ButtonFrame.AutoButtonColor = false
    ButtonFrame.Parent = parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = ButtonFrame
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 1, 0)
    Title.BackgroundTransparency = 1
    Title.Text = config.Title or "Button"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 14
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Parent = ButtonFrame
    
    ButtonFrame.MouseButton1Click:Connect(function()
        if config.Callback then
            config.Callback()
        end
    end)
    
    ButtonFrame.MouseEnter:Connect(function()
        TweenService:Create(ButtonFrame, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(200, 40, 40)
        }):Play()
    end)
    
    ButtonFrame.MouseLeave:Connect(function()
        TweenService:Create(ButtonFrame, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        }):Play()
    end)
end

-- Make draggable
function CheatHub:MakeDraggable(frame, handle)
    local dragging, dragInput, dragStart, startPos
    
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

return CheatHub
