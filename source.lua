local CoreGui,TweenService,Lib,Http,InsertedObjects = game:GetService('CoreGui'),game:GetService("TweenService"),{},game:GetService("HttpService"),{}
local ms = game:GetService("Players").LocalPlayer:GetMouse()
local debug = true 
for _,v in pairs(CoreGui:GetChildren()) do
    if v:IsA("ScreenGui") and v.Name == "Library" then v:Destroy() end 
end
local udim2ToTable = function(udim2)
    return {udim2.X.Scale, udim2.X.Offset, udim2.Y.Scale, udim2.Y.Offset}
end

local udim2FromTable = function(udim2)
    return UDim2.new(udim2[1], udim2[2], udim2[3], udim2[4])
end

_G.Settings = {
    Position = nil
}
function Check()
    if writefile or appendfile or readfile or isfile or makefolder or delfolder or isfolder then
        return true
    else
        return false
    end
end

if Check() then
    makefolder("./ReductUI/")
else
    print("Not supported")
end
local fname = "./ReductUI/settings.dat"
function load()
    if (Check() and isfile(fname)) then
        _G.Settings = Http:JSONDecode(readfile(fname))
    end
end
function save()
    local json
    if Check() then
        json = Http:JSONEncode(_G.Settings)
        writefile(fname, json)
    else
        print("Not supported")
    end
end

load()
save()



function DraggingEnabled(frame, parent)
        
    parent = parent or frame
        local dragging = false
    local dragInput, mousePos, framePos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = parent.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            parent.Position  = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
            _G.Settings.Position = udim2ToTable(parent.Position)
            save()
        end
    end)
end


function Lib.ToggleUI()
    if CoreGui["Library"].Enabled then
        CoreGui["Libary"].Enabled = false 
    else
        CoreGui["Library"].Enabled = true 
    end
end
function Identifier()
    return Http:GenerateGUID(false)
end
function Corner(parent,radius)
   local A = Instance.new("UICorner")
    A.Parent = parent 
    A.Name = Identifier()
    A.CornerRadius = radius
    table.insert(InsertedObjects,A.Name .. " | " ..  tostring(A.CornerRadius) .. " | " .. A.Parent.Name)
end
function Constraint(parent,min,max)
   local B = Instance.new("UITextSizeConstraint")
    B.Parent = parent
    B.Name = Identifier()
    B.MinTextSize = min
    B.MaxTextSize = max
    table.insert(InsertedObjects,B.Name .. " | " ..  tostring(B.MinTextSize) .. " | " .. tostring(B.MaxTextSize) .. " | " .. B.Parent.Name)
end
function pause(wait)
    local old = os.clock()
    spawn(function()
        while true do
            if (os.clock() - old) >= wait then
                break
            end
        end
    end)
end
function Lib.Window(settings)
    settings = settings or {}
    local Title = settings.Title or "New Library"
    if not typeof(Title) == "string" then Title = "New Library" end
 local SavePosition = settings.SavePosition 
 if SavePosition == nil then
    SavePosition = true 
end
if _G.Settings.Position == nil then
    local pos = UDim2.new(.5, 0, 0.5, 0)
    _G.Settings.Position = udim2ToTable(pos)
    save()
end

if debug == false then
    wait(1)
    pause(.5)
    wait(.2)
    pause(.5)
    wait(.2)
    pause(.5)
    wait(1)
end

        local Library = Instance.new("ScreenGui")
        local MotherFrame = Instance.new("Frame")
        local Header = Instance.new("Frame")
        local UIListLayout = Instance.new("UIListLayout")
        local UIPadding = Instance.new("UIPadding")
        local Close = Instance.new("ImageButton")
        local Header2 = Instance.new("Frame")
        local UIName = Instance.new("TextLabel")
        local Cover = Instance.new("Frame")
        local Backshadow = Instance.new("ImageLabel")
        local TabContainer = Instance.new("ScrollingFrame")
        local UIListLayout_2 = Instance.new("UIListLayout")
        local UIPadding_2 = Instance.new("UIPadding")
        local Pages = Instance.new("Folder")


Library.Name = "Library"
Library.Parent = CoreGui
Library.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MotherFrame.Name = "MotherFrame"
MotherFrame.Parent = Library
MotherFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MotherFrame.BackgroundColor3 = Color3.fromRGB(21, 21, 21)
MotherFrame.Position = UDim2.new(0.502010703, 0, 0.503292203, 0)
MotherFrame.Size = UDim2.new(0, 450, 0, 550)


if SavePosition then 
    MotherFrame.Position = udim2FromTable(_G.Settings.Position)
else
    MotherFrame.Position = UDim2.new(0.5,0,.5,0)
end


Corner(MotherFrame,UDim.new(0,4))

Header.Name = "Header"
Header.Parent = MotherFrame
Header.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Header.Size = UDim2.new(0, 450, 0, 23)
DraggingEnabled(Header,MotherFrame)

Corner(Header,UDim.new(0,4))

UIListLayout.Parent = Header
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
UIListLayout.Padding = UDim.new(0, 6)

UIPadding.Parent = Header
UIPadding.PaddingRight = UDim.new(0, 8)

Close.Name = "Close"
Close.Parent = Header
Close.BackgroundColor3 = Color3.fromRGB(255, 96, 92)
Close.BackgroundTransparency = 1.000
Close.LayoutOrder = 4
Close.Position = UDim2.new(0.623515427, 0, 0.278600812, 0)
Close.Size = UDim2.new(0, 13, 0, 18)
Close.ZIndex = 2
Close.Image = "rbxassetid://3926305904"
Close.ImageColor3 = Color3.fromRGB(255, 96, 92)
Close.ImageRectOffset = Vector2.new(124, 124)
Close.ImageRectSize = Vector2.new(36, 36)
Close.ScaleType = Enum.ScaleType.Fit

Header2.Name = "Header2"
Header2.Parent = MotherFrame
Header2.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
Header2.BorderSizePixel = 0
Header2.Position = UDim2.new(0, 0, 0.0418181829, 0)
Header2.Size = UDim2.new(0, 450, 0, 35)

UIName.Name = "UIName"
UIName.Parent = Header2
UIName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
UIName.BackgroundTransparency = 1.000
UIName.Position = UDim2.new(0.0288888887, 0, 0.200000003, 0)
UIName.Size = UDim2.new(0, 429, 0, 20)
UIName.Font = Enum.Font.GothamSemibold
UIName.Text = Title
UIName.TextColor3 = Color3.fromRGB(190, 190, 190)
UIName.TextScaled = true
UIName.TextSize = 14.000
UIName.TextWrapped = true

Constraint(UIName,14,14)

Cover.Name = "Cover"
Cover.Parent = MotherFrame
Cover.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Cover.BorderSizePixel = 0
Cover.Position = UDim2.new(0, 0, 0.0300395489, 0)
Cover.Size = UDim2.new(0, 45, 0, 6)
Cover.ZIndex = 0

TabContainer.Name = "TabContainer"
TabContainer.Parent = MotherFrame
TabContainer.Active = true
TabContainer.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
TabContainer.BorderSizePixel = 0
TabContainer.Position = UDim2.new(0.001, 0, 0.106, 0)
TabContainer.Size = UDim2.new(0, 450,0, 29)
TabContainer.CanvasSize = UDim2.new(0, 0, 0.5, 0)
TabContainer.ScrollingDirection=Enum.ScrollingDirection.X
TabContainer.AutomaticCanvasSize = Enum.AutomaticSize.X
TabContainer.ScrollBarImageTransparency = 1

UIListLayout_2.Parent = TabContainer
UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_2.Padding = UDim.new(0, 8)

UIPadding_2.Parent = TabContainer
UIPadding_2.PaddingLeft = UDim.new(0, 10)
UIPadding_2.PaddingTop = UDim.new(0, 2)



Pages.Name = "Pages"
Pages.Parent = MotherFrame

Close.MouseButton1Click:Connect(function()
        local info = TweenInfo.new(.25)
        TweenService:Create(MotherFrame,info,{ BackgroundTransparency = 1 }):Play()
        TweenService:Create(Cover,info,{ BackgroundTransparency = 1 }):Play()
        TweenService:Create(Header,info,{ BackgroundTransparency = 1 }):Play()
        TweenService:Create(Header2,info,{ BackgroundTransparency = 1 }):Play()
        TweenService:Create(TabContainer,info,{ BackgroundTransparency = 1 }):Play()
        TweenService:Create(UIName,info,{ TextTransparency = 1 }):Play()
            for _,v in pairs(TabContainer:GetChildren()) do
                if v:IsA("TextButton") then
                    TweenService:Create(v,info,{ TextTransparency = 1 }):Play()
                end
            end
            TweenService:Create(Backshadow,info,{ ImageTransparency = 1 }):Play()
        local a=    TweenService:Create(Close,info,{ ImageTransparency = 1 })
        a:Play()
    Pages:Destroy()
    a.Completed:Connect(function()
        task.wait(.2)
        Library:Destroy()
    end)
            

    end)
    local Inside = {}

    function Inside.Category(settings)
        settings = settings or {} 
        local Title = string.upper(settings.Title) or "NEW CATEGORY"
         
        local Tab = Instance.new("TextButton")
        local Page = Instance.new("ScrollingFrame")
        local UIListLayout_3 = Instance.new("UIListLayout")

            Tab.Name = "Tab"
            Tab.Parent = TabContainer
            Tab.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            Tab.BackgroundTransparency = 1.000
            Tab.Size = UDim2.new(0, 23, 0, 19)
            Tab.AutoButtonColor = false
            Tab.Font = Enum.Font.GothamBold
            Tab.Text = Title
            Tab.TextColor3 = Color3.fromRGB(220, 220, 220)
            Tab.TextScaled = true
            Tab.TextSize = 12.000
            Tab.TextWrapped = true
            Tab.TextXAlignment = Enum.TextXAlignment.Left
            Tab.AutomaticSize =Enum.AutomaticSize.X
            Constraint(Tab,12,12)

            Page.Name = "Page"
            Page.Parent = Pages
            Page.Active = true
            Page.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Page.BackgroundTransparency = 1.000
            Page.Position = UDim2.new(0, 0, 0.170909092, 0)
            Page.Size = UDim2.new(0, 450, 0, 456)
            Page.CanvasSize = UDim2.new(0, 0, 0.5, 0)
            
            UIListLayout_3.Parent = Page
            UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout_3.Padding = UDim.new(0, 6)
            UIListLayout_3.HorizontalAlignment=Enum.HorizontalAlignment.Center

            local oldITab = 0
            local oldIPage = 0

            for i,v in pairs(TabContainer:GetChildren()) do
                if v:IsA("TextButton") then
                    oldITab = oldITab + 1 
                    v.Name = tostring(oldITab) .. "Cat"
                end
            end
            for i,v in pairs(Pages:GetChildren()) do
                if v:IsA("ScrollingFrame") then
                    oldIPage = oldIPage + 1
                    v.Name = tostring(oldIPage) .. "Page"
                end
            end
            for i,v in pairs(TabContainer:GetChildren()) do
                if v:IsA("TextButton") and v.Name ~= "1Cat" then
                    v.TextColor3 = Color3.fromRGB(150, 150, 150) 
                end
            end
            for i,v in pairs(Pages:GetChildren()) do
                if v:IsA("ScrollingFrame") and v.Name ~= "1Page" then
                        v.Visible = false 
                end
            end

            Tab.MouseButton1Click:Connect(function()
                
                for i,v in next, Pages:GetChildren() do
                    v.Visible = false 
                end
                Page.Visible = true 

                for i,v in pairs(TabContainer:GetChildren()) do
                    if v:IsA("TextButton") then
                        TweenService:Create(v,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(150,150,150)}):Play()
                    end
                end
                TweenService:Create(Tab,TweenInfo.new(.25),{TextColor3 = Color3.fromRGB(220,220,220)}):Play()
            end)
            local CatElements = {}
            function CatElements.Label(settings)
                settings = settings or {}
                local LabelFunctions = {}
                local Title = string.upper(settings.Title) or "NEW LABEL"
                if not typeof(Title) == "string" then
                    Title = "NEW LABEL"
                end
                local Label = Instance.new("TextLabel")
  
                Label.Name = "Label"
                Label.Parent = Page
                Label.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
                Label.BackgroundTransparency = 1.000
                Label.Position = UDim2.new(0.0488888882, 0, 0, 0)
                Label.Size = UDim2.new(0, 420, 0, 16)
                Label.Font = Enum.Font.GothamSemibold
                Label.TextColor3 = Color3.fromRGB(125, 125, 125)
                Label.TextScaled = true
                Label.TextSize = 14.000
                Label.TextWrapped = true
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.Text = Title 
    
                Constraint(Label,13,13)

                function LabelFunctions.Update(settings)
                    settings = settings or {}
                    local Title = settings.Title or "UPDATED LABEL"
                    if not type(Title) == "string" then
                        Title = "UPDATED LABEL"    
                end
                Label.Text = string.upper(Title)
                end
                return LabelFunctions
            end
            function CatElements.Button(settings)
                settings = settings or {}
                local ButtonFunctions = {}
                local Title = settings.Title or "New Button"
                local Callback = settings.Callback or function() end
                if not typeof(Title) == "string" then
                    Title = "New Button"
                end

    
            local Button = Instance.new("TextButton")
     
            local UIPadding = Instance.new("UIPadding")
            local touch_app = Instance.new("ImageButton")
            local Sample = Instance.new("ImageLabel")


            Button.Name = "Button"
            Button.Parent = Page
            Button.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
            Button.Position = UDim2.new(0.0244444441, 0, 0.0482456125, 0)
            Button.Size = UDim2.new(0, 428, 0, 39)
            Button.AutoButtonColor = false
            Button.Font = Enum.Font.GothamSemibold
            Button.Text = Title
            Button.TextColor3 = Color3.fromRGB(200, 200, 200)
            Button.TextScaled = true
            Button.TextSize = 13.000
            Button.TextWrapped = true
            Button.TextXAlignment = Enum.TextXAlignment.Left
            Button.ClipsDescendants = true

            Sample.Name = "Sample"
                Sample.Parent = Button
                Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Sample.BackgroundTransparency = 1.000
                Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
                Sample.ImageColor3 = Color3.fromRGB(125,125,125)
                Sample.ImageTransparency = 0.600

            Corner(Button,UDim.new(0,4))
            Constraint(Button,13,13)

            UIPadding.Parent = Button
            UIPadding.PaddingLeft = UDim.new(0, 6)

            touch_app.Name = "touch_app"
            touch_app.Parent = Button
            touch_app.BackgroundTransparency = 1.000
            touch_app.Position = UDim2.new(0.931544185, 0, 0.181895718, 0)
            touch_app.Size = UDim2.new(0, 18, 0, 24)
            touch_app.ZIndex = 2
            touch_app.Image = "rbxassetid://3926305904"
            touch_app.ImageColor3 = Color3.fromRGB(200, 200, 200)
            touch_app.ImageRectOffset = Vector2.new(84, 204)
            touch_app.ImageRectSize = Vector2.new(36, 36)
            touch_app.ScaleType = Enum.ScaleType.Fit

                local ms = game:GetService("Players").LocalPlayer:GetMouse()
            Button.MouseButton1Click:Connect(function()
                pcall(Callback)

                local c = Sample:Clone()
                c.Parent = Button
                local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
                c.Position = UDim2.new(0, x, 0, y)
                local len, size = 0.35, nil
                if Button.AbsoluteSize.X >= Button.AbsoluteSize.Y then
                    size = (Button.AbsoluteSize.X * 1.5)
                else
                    size = (Button.AbsoluteSize.Y * 1.5)
                end
                c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                for i = 1, 10 do
                    c.ImageTransparency = c.ImageTransparency + 0.05
                    wait(len / 12)
                end
                c:Destroy()

            end)
           Button.MouseEnter:Connect(function(x, y)
                TweenService:Create(Button,TweenInfo.new(.25),{BackgroundColor3 = Color3.fromRGB(45,45,45)}):Play()               
           end)
           Button.MouseLeave:Connect(function(x, y)
            TweenService:Create(Button,TweenInfo.new(.25),{BackgroundColor3 = Color3.fromRGB(31,31,31)}):Play()               
                end)

                function ButtonFunctions.Update(settings)
                    settings = settings or {}
                    local Title = settings.Title or "Updated Button"
                    Button.Text = tostring(Title) 
                end
                return ButtonFunctions
            end

            function CatElements.Toggle(settings)
                settings = settings or {}
                local Title = settings.Title or "New Toggle"
                local Default = settings.Default or false 
                local Callback = settings.Callback or function () end
                if not typeof(Title) == "string" then Title = "New Toggle" end 
                local togglefunctions = {}
            local Toggle = Instance.new("Frame")
            local UICorner = Instance.new("UICorner")
            local ToggleText = Instance.new("TextLabel")
            local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
            local ToggleButton = Instance.new("TextButton")
            local ToggleBack = Instance.new("TextButton")
            local UICorner_2 = Instance.new("UICorner")
            local check = Instance.new("ImageButton")
            local Sample = Instance.new("ImageLabel")

            Toggle.Name = "Toggle"
            Toggle.Parent = Page
            Toggle.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
            Toggle.Size = UDim2.new(0, 428, 0, 39) 
            Toggle.ClipsDescendants = true 

            Corner(Toggle,UDim.new(0,4))

            ToggleText.Name = "ToggleText"
            ToggleText.Parent = Toggle
            ToggleText.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
            ToggleText.BackgroundTransparency = 1.000
            ToggleText.Position = UDim2.new(0.018515043, 0, 0.282051295, 0)
            ToggleText.Size = UDim2.new(0, 385, 0, 16)
            ToggleText.Font = Enum.Font.GothamSemibold
            ToggleText.Text = Title
            ToggleText.TextColor3 = Color3.fromRGB(200, 200, 200)
            ToggleText.TextScaled = true
            ToggleText.TextSize = 14.000
            ToggleText.TextWrapped = true
            ToggleText.TextXAlignment = Enum.TextXAlignment.Left
            ToggleText.ClipsDescendants = true 

            Constraint(ToggleText,13,13)

            ToggleButton.Name = "ToggleButton"
            ToggleButton.Parent = Toggle
            ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleButton.BackgroundTransparency = 1.000
            ToggleButton.Position = UDim2.new(0.00467289705, 0, 0, 0)
            ToggleButton.Size = UDim2.new(0, 426, 0, 39)
            ToggleButton.Font = Enum.Font.SourceSans
            ToggleButton.Text = ""
            ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
            ToggleButton.TextSize = 14.000
            ToggleButton.ClipsDescendants = true 

            Sample.Name = "Sample"
            Sample.Parent = Toggle
            Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Sample.BackgroundTransparency = 1.000
            Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
            Sample.ImageColor3 = Color3.fromRGB(125,125,125)
            Sample.ImageTransparency = 0.600

            ToggleBack.Name = "ToggleBack"
            ToggleBack.Parent = Toggle
            ToggleBack.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
            ToggleBack.Position = UDim2.new(0.925233543, 0, 0.205128223, 0)
            ToggleBack.Size = UDim2.new(0, 26, 0, 24)
            ToggleBack.Text = ""
            ToggleBack.AutoButtonColor = false 

            Corner(ToggleBack,UDim.new(0,4))

            check.Name = "check"
            check.Parent = ToggleBack
            check.AnchorPoint = Vector2.new(0.5, 0.5)
            check.BackgroundTransparency = 1.000
            check.LayoutOrder = 1
            check.Position = UDim2.new(0.5, 0, 0.5, 0)
            check.Size = UDim2.new(0, 24, 0, 22)
            check.ZIndex = 2
            check.Image = "rbxassetid://3926305904"
            check.ImageColor3 = Color3.fromRGB(0, 0, 0)
            check.ImageRectOffset = Vector2.new(312, 4)
            check.ImageRectSize = Vector2.new(24, 24)
            check.ImageTransparency = 1.000
            check.ScaleType = Enum.ScaleType.Fit


            local Toggled = Default 


            local function Togglea()
                TweenService:Create(check,TweenInfo.new(.2),{ImageTransparency=0}):Play()
                TweenService:Create(ToggleBack,TweenInfo.new(.2),{BackgroundColor3 = Color3.fromRGB(243, 224, 10)}):Play()
            end

            local function UnToggle()
                TweenService:Create(check,TweenInfo.new(.2),{ImageTransparency=1}):Play()
                TweenService:Create(ToggleBack,TweenInfo.new(.2),{BackgroundColor3 = Color3.fromRGB(42, 42, 42)}):Play()        
                end
                if Toggled == true then
                    Togglea()
                elseif Toggled == false then
                    UnToggle()
                end

                local function Click()
                  local Debouce = false 

                  local ms = game:GetService("Players").LocalPlayer:GetMouse()
                if Debouce == false then
                    Debouce = true
                    local c = Sample:Clone()
                    c.Parent = Toggle
                    local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
                    c.Position = UDim2.new(0, x, 0, y)
                    local len, size = 0.35, nil
                    if Toggle.AbsoluteSize.X >= Toggle.AbsoluteSize.Y then
                        size = (Toggle.AbsoluteSize.X * 1.5)
                    else
                        size = (Toggle.AbsoluteSize.Y * 1.5)
                    end
                    c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                    for i = 1, 10 do
                        c.ImageTransparency = c.ImageTransparency + 0.05
                        wait(len / 12)
                    end
                    c:Destroy()
    
                    Toggled = not Toggled
                    if Toggled == true then
                        pcall(Callback,Toggled)
                        Togglea(Toggled)
                    elseif Toggled == false then
                        pcall(Callback,Toggled)
                        UnToggle(Toggled)
                    end
                    wait(.8)
                    Debouce = false 
                    end
                end
                ToggleButton.MouseButton1Click:Connect(Click)
                check.MouseButton1Click:Connect(Click)
                Toggle.MouseEnter:Connect(function(x, y)
                    TweenService:Create(Toggle,TweenInfo.new(.25),{BackgroundColor3 = Color3.fromRGB(45,45,45)}):Play()               
               end)
               Toggle.MouseLeave:Connect(function(x, y)
                TweenService:Create(Toggle,TweenInfo.new(.25),{BackgroundColor3 = Color3.fromRGB(31,31,31)}):Play()               
                    end)
                    function togglefunctions.Update(settings)
                        settings = settings or {}
                        local Title = tostring(settings.Title) or "Updated Togggle"
                        ToggleText.Text = Title 
                    end
                    return togglefunctions
            end
            function CatElements.Dropdown(settings)
                settings = settings or {}
                local Title = settings.Title or "New Dropdown"
                local items = settings.Items or {}
                local callback = settings.Callback or function() end
                local dropfunctions = {}
                if not typeof(Title) == "string" then Title = "New dropdown" end
                local opened = false 

        
        local dropFrame = Instance.new("Frame")
        local dropOpen = Instance.new("TextButton")
        local UICorner = Instance.new("UICorner")
        local ListImg = Instance.new("ImageLabel")
        local DropText = Instance.new("TextLabel")
        local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
        local UIListLayout = Instance.new("UIListLayout") 
        local Sample = Instance.new("ImageLabel")    

        dropFrame.Name = "dropFrame"
        dropFrame.Parent = Page
        dropFrame.BackgroundColor3 = Color3.fromRGB(21, 21, 21)
        dropFrame.BorderSizePixel = 0
        dropFrame.ClipsDescendants = true
        dropFrame.Position = UDim2.new(0.0244444441, 0, 0.245614037, 0)
        dropFrame.Size = UDim2.new(0, 428, 0, 39)

        dropOpen.Name = "dropOpen"
        dropOpen.Parent = dropFrame
        dropOpen.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
        dropOpen.ClipsDescendants = true
        dropOpen.Size = UDim2.new(0, 428, 0, 39)
        dropOpen.AutoButtonColor = false
        dropOpen.Font = Enum.Font.SourceSans
        dropOpen.Text = ""
        dropOpen.TextColor3 = Color3.fromRGB(0, 0, 0)
        dropOpen.TextSize = 14.000

        Sample.Name = "Sample"
        Sample.Parent = dropOpen
        Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Sample.BackgroundTransparency = 1.000
        Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
        Sample.ImageColor3 = Color3.fromRGB(125,125,125)
        Sample.ImageTransparency = 0.600

        UICorner.CornerRadius = UDim.new(0, 4)
        UICorner.Parent = dropOpen

        ListImg.Name = "ListImg"
        ListImg.Parent = dropOpen
        ListImg.BackgroundTransparency = 1.000
        ListImg.Position = UDim2.new(0.93224299, 0, 0.179487199, 0)
        ListImg.Size = UDim2.new(0, 18, 0, 24)
        ListImg.Image = "rbxassetid://3926305904"
        ListImg.ImageRectOffset = Vector2.new(644, 364)
        ListImg.ImageRectSize = Vector2.new(36, 36)
        ListImg.ScaleType = Enum.ScaleType.Fit

        DropText.Name = "DropText"
        DropText.Parent = dropOpen
        DropText.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
        DropText.BackgroundTransparency = 1.000
        DropText.Position = UDim2.new(0.018515043, 0, 0.282051295, 0)
        DropText.Size = UDim2.new(0, 385, 0, 16)
        DropText.Font = Enum.Font.GothamSemibold
        DropText.Text = Title
        DropText.TextColor3 = Color3.fromRGB(200, 200, 200)
        DropText.TextScaled = true
        DropText.TextSize = 14.000
        DropText.TextWrapped = true
        DropText.TextXAlignment = Enum.TextXAlignment.Left

        UITextSizeConstraint.Parent = DropText
        UITextSizeConstraint.MaxTextSize = 13

        UIListLayout.Parent = dropFrame
        UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayout.Padding = UDim.new(0, 5)

        local function newItem(da)
            local dropItem = Instance.new("TextButton")
            local UICorner_2 = Instance.new("UICorner")
            local UIPadding = Instance.new("UIPadding")
            local Sample = Instance.new("ImageLabel")

        dropItem.Name = "dropItem"
        dropItem.Parent = dropFrame
        dropItem.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
        dropItem.Position = UDim2.new(0, 0, 0.435643554, 0)
        dropItem.Size = UDim2.new(0, 428, 0, 33)
        dropItem.AutoButtonColor = false
        dropItem.Font = Enum.Font.GothamSemibold
        dropItem.TextColor3 = Color3.fromRGB(200, 200, 200)
        dropItem.TextSize = 14.000
        dropItem.TextXAlignment = Enum.TextXAlignment.Left
        dropItem.TextScaled = true 
        dropItem.TextWrapped = true 
        dropItem.Text = da
        dropItem.ClipsDescendants = true
         
        Sample.Name = "Sample"
            Sample.Parent = dropItem
            Sample.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Sample.BackgroundTransparency = 1.000
            Sample.Image = "http://www.roblox.com/asset/?id=4560909609"
            Sample.ImageColor3 = Color3.fromRGB(125,125,125)
            Sample.ImageTransparency = 0.600

        Constraint(dropItem,14,14)

        UICorner_2.CornerRadius = UDim.new(0, 4)
        UICorner_2.Parent = dropItem

        UIPadding.Parent = dropItem
        UIPadding.PaddingLeft = UDim.new(0, 6)

        dropItem.MouseButton1Click:Connect(function()
            opened = false
            TweenService:Create(dropFrame,TweenInfo.new(.1),{Size = UDim2.new(0, 428, 0, 39)}):Play()
            DropText.Text =  Title .. " - " .. dropItem.Text
            local c = Sample:Clone()
            c.Parent = dropItem
            local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
            c.Position = UDim2.new(0, x, 0, y)
            local len, size = 0.35, nil
            if dropItem.AbsoluteSize.X >= dropItem.AbsoluteSize.Y then
                size = (dropItem.AbsoluteSize.X * 1.5)
            else
                size = (dropItem.AbsoluteSize.Y * 1.5)
            end
            c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
            for i = 1, 10 do
                c.ImageTransparency = c.ImageTransparency + 0.05
                wait(len / 12)
            end
            c:Destroy()      
            pcall(callback,dropItem.Text)
         
        end)

        dropItem.MouseEnter:Connect(function(x, y)
            TweenService:Create(dropItem,TweenInfo.new(.25),{BackgroundColor3 = Color3.fromRGB(45,45,45)}):Play()               
       end)
       dropItem.MouseLeave:Connect(function(x, y)
        TweenService:Create(dropItem,TweenInfo.new(.25),{BackgroundColor3 = Color3.fromRGB(31,31,31)}):Play()               
            end)
        end

        -- dropOpen
        dropOpen.MouseEnter:Connect(function(x, y)
            TweenService:Create(dropOpen,TweenInfo.new(.25),{BackgroundColor3 = Color3.fromRGB(45,45,45)}):Play()               
       end)
       dropOpen.MouseLeave:Connect(function(x, y)
        TweenService:Create(dropOpen,TweenInfo.new(.25),{BackgroundColor3 = Color3.fromRGB(31,31,31)}):Play()               
            end)
        for _,v in pairs(items) do
            newItem(v)
        end
    
        dropOpen.MouseButton1Click:Connect(function()
            opened = not opened 
                if opened == true then
                 TweenService:Create(dropFrame,TweenInfo.new(.1),{Size =  UDim2.new(0, 428, 0, 39 + UIListLayout.AbsoluteContentSize.Y - 39)}):Play()
                 local c = Sample:Clone()
                 c.Parent = dropOpen
                 local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
                 c.Position = UDim2.new(0, x, 0, y)
                 local len, size = 0.35, nil
                 if dropOpen.AbsoluteSize.X >= dropOpen.AbsoluteSize.Y then
                     size = (dropOpen.AbsoluteSize.X * 1.5)
                 else
                     size = (dropOpen.AbsoluteSize.Y * 1.5)
                 end
                 c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                 for i = 1, 10 do
                     c.ImageTransparency = c.ImageTransparency + 0.05
                     wait(len / 12)
                 end
                 c:Destroy()
                 elseif opened == false then
                TweenService:Create(dropFrame,TweenInfo.new(.1),{Size =  UDim2.new(0, 428, 0, 39)}):Play()
                local c = Sample:Clone()
                c.Parent = dropOpen
                local x, y = (ms.X - c.AbsolutePosition.X), (ms.Y - c.AbsolutePosition.Y)
                c.Position = UDim2.new(0, x, 0, y)
                local len, size = 0.35, nil
                if dropOpen.AbsoluteSize.X >= dropOpen.AbsoluteSize.Y then
                    size = (dropOpen.AbsoluteSize.X * 1.5)
                else
                    size = (dropOpen.AbsoluteSize.Y * 1.5)
                end
                c:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, (-size / 2), 0.5, (-size / 2)), 'Out', 'Quad', len, true, nil)
                for i = 1, 10 do
                    c.ImageTransparency = c.ImageTransparency + 0.05
                    wait(len / 12)
                end
                c:Destroy()
             end
        end)
        function dropfunctions.Refresh(settings)
            settings = settings or {}
            local items = settings.Items or {}
            for _,v in pairs(dropFrame:GetChildren()) do
                if v.Name == "dropItem" then
                    v:Destroy()
                end
            end
            for i,v in pairs(items) do
                newItem(v)
            end
        end
        return dropfunctions
    end
    function CatElements.Slider(settings)
 
        settings = settings or {}
        local Title = settings.Title or "New Slider"
        local min = settings.Min or 16
        local max = settings.Max or 500
        local callback = settings.Callback or function() end
        local sliderfunctions = {}
        if not typeof(Title) == "string" then Title = "New Slider" end
        


        local Slider = Instance.new("Frame")
        local UICorner = Instance.new("UICorner")
        local SliderText = Instance.new("TextLabel")
        local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
        local SliderInt = Instance.new("TextLabel")
        local UITextSizeConstraint_2 = Instance.new("UITextSizeConstraint")
        local SliderButton = Instance.new("TextButton")
        local UICorner_2 = Instance.new("UICorner")
        local SliderInner = Instance.new("Frame")
        local UICorner_3 = Instance.new("UICorner")

    
        Slider.Name = "Slider"
        Slider.Parent = Page
        Slider.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
        Slider.Position = UDim2.new(0.0244444441, 0, 0.344298244, 0)
        Slider.Size = UDim2.new(0, 428, 0, 59)

        UICorner.CornerRadius = UDim.new(0, 4)
        UICorner.Parent = Slider

        SliderText.Name = "SliderText"
        SliderText.Parent = Slider
        SliderText.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
        SliderText.BackgroundTransparency = 1.000
        SliderText.Position = UDim2.new(0.025524389, 0, 0.19730553, 0)
        SliderText.Size = UDim2.new(0, 385, 0, 16)
        SliderText.Font = Enum.Font.GothamSemibold
        SliderText.Text = Title
        SliderText.TextColor3 = Color3.fromRGB(200, 200, 200)
        SliderText.TextScaled = true
        SliderText.TextSize = 14.000
        SliderText.TextWrapped = true
        SliderText.TextXAlignment = Enum.TextXAlignment.Left

        UITextSizeConstraint.Parent = SliderText
        UITextSizeConstraint.MaxTextSize = 13

        SliderInt.Name = "SliderInt"
        SliderInt.Parent = Slider
        SliderInt.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
        SliderInt.BackgroundTransparency = 1.000
        SliderInt.Position = UDim2.new(0.883000016, 0, 0.196999997, 0)
        SliderInt.Size = UDim2.new(0, 39, 0, 16)
        SliderInt.Font = Enum.Font.GothamSemibold
        SliderInt.Text = tostring(min)
        SliderInt.TextColor3 = Color3.fromRGB(200, 200, 200)
        SliderInt.TextScaled = true
        SliderInt.TextSize = 14.000
        SliderInt.TextWrapped = true
        SliderInt.TextXAlignment = Enum.TextXAlignment.Right

        UITextSizeConstraint_2.Parent = SliderInt
        UITextSizeConstraint_2.MaxTextSize = 13
        UITextSizeConstraint_2.MinTextSize = 13

        SliderButton.Name = "SliderButton"
        SliderButton.Parent = Slider
        SliderButton.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
        SliderButton.Position = UDim2.new(0.0161785949, 0, 0.542372882, 0)
        SliderButton.Size = UDim2.new(0, 414, 0, 13)
        SliderButton.AutoButtonColor = false
        SliderButton.Font = Enum.Font.SourceSans
        SliderButton.Text = ""
        SliderButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        SliderButton.TextSize = 14.000

        UICorner_2.CornerRadius = UDim.new(0, 3)
        UICorner_2.Parent = SliderButton

        SliderInner.Name = "SliderInner"
        SliderInner.Parent = SliderButton
        SliderInner.BackgroundColor3 = Color3.fromRGB(243, 224, 10)
        SliderInner.BorderColor3 = Color3.fromRGB(31, 31, 31)
        SliderInner.Size = UDim2.new(0, 0, 0, 13)

        UICorner_3.CornerRadius = UDim.new(0, 3)
        UICorner_3.Parent = SliderInner




        local Value;
        local input = game:GetService("UserInputService")
        SliderButton.MouseButton1Down:Connect(function()
        Value = math.floor((((tonumber(max) - tonumber(min)) / 158479) * SliderInner.AbsoluteSize.X) + tonumber(min)) or 0
        SliderInt.Text = Value
        pcall(function()
            callback(Value)
        end)


        SliderInner.Size = UDim2.new(0, math.clamp(ms.X - SliderInner.AbsolutePosition.X, 0, 414), 0, 13)
        moveconnection = ms.Move:Connect(function()
           SliderInt.Text = Value

                TweenService:Create(SliderInt,TweenInfo.new(.7), { TextTransparency = 0 }):Play()
        
                SliderInt.TextTransparency = 0
        
           Value = math.floor((((tonumber(max) - tonumber(min)) / 414) * SliderInner.AbsoluteSize.X) + tonumber(min))
            pcall(function()
                callback(Value)
            end)
            SliderInner.Size = UDim2.new(0, math.clamp(ms.X - SliderInner.AbsolutePosition.X, 0, 414), 0, 13)
        end)
        releaseconnection = input.InputEnded:Connect(function(Mouse)
            if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
                Value = math.floor((((tonumber(max) - tonumber(min)) / 414) * SliderInner.AbsoluteSize.X) + tonumber(min))
                SliderInt.Text = Value
                    TweenService:Create(SliderInt,TweenInfo.new(.7), { TextTransparency = 1 }):Play()
                pcall(function()
                    callback(Value)
                end)
                SliderInner.Size = UDim2.new(0, math.clamp(ms.X - SliderInner.AbsolutePosition.X, 0, 414), 0, 13)
                moveconnection:Disconnect()
                releaseconnection:Disconnect()
            end
        end)
    end)

function sliderfunctions.Update(settings)
    settings = settings or {}
    local Title = settings.Title or "Updated Slider"
    SliderText.Text  = tostring(Title)
end
return sliderfunctions
                end
                function CatElements.Keybind(settings)
                    settings = settings or {}
                    local Title = settings.Title or "New Keybind"
                    if not typeof(Title) == "string" then Title = "New Keybind" end 
                    local Callback = settings.Callback or function() end
                    local oldKey = settings.KeyCode.Name or Enum.KeyCode.F.Name
                    local keyfunctions = {}


            local Keybind = Instance.new("Frame")
            local UICorner = Instance.new("UICorner")
            local KeybindText = Instance.new("TextLabel")
            local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
            local Keybutton = Instance.new("TextButton")
            local UITextSizeConstraint_2 = Instance.new("UITextSizeConstraint")
            local UICorner_2 = Instance.new("UICorner")

            Keybind.Name = "Keybind"
            Keybind.Parent = Page
            Keybind.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
            Keybind.Position = UDim2.new(-0.0088888891, 0, 0.00657894742, 0)
            Keybind.Size = UDim2.new(0, 428, 0, 39)

            UICorner.CornerRadius = UDim.new(0, 4)
            UICorner.Parent = Keybind

            KeybindText.Name = "KeybindText"
            KeybindText.Parent = Keybind
            KeybindText.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
            KeybindText.BackgroundTransparency = 1.000
            KeybindText.Position = UDim2.new(0.018515043, 0, 0.282051295, 0)
            KeybindText.Size = UDim2.new(0, 385, 0, 16)
            KeybindText.Font = Enum.Font.GothamSemibold
            KeybindText.Text = Title
            KeybindText.TextColor3 = Color3.fromRGB(200, 200, 200)
            KeybindText.TextScaled = true
            KeybindText.TextSize = 14.000
            KeybindText.TextWrapped = true
            KeybindText.TextXAlignment = Enum.TextXAlignment.Left

            UITextSizeConstraint.Parent = KeybindText
            UITextSizeConstraint.MaxTextSize = 13

            Keybutton.Name = "Keybutton"
            Keybutton.Parent = Keybind
            Keybutton.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
            Keybutton.Position = UDim2.new(0.799, 0,0.179, 0)
            Keybutton.Size = UDim2.new(0, 78,0, 25)
            Keybutton.Font = Enum.Font.GothamSemibold
            Keybutton.Text = tostring(oldKey)
            Keybutton.TextColor3 = Color3.fromRGB(255, 255, 255)
            Keybutton.TextScaled = true
            Keybutton.TextSize = 12.000
            Keybutton.TextWrapped = true
            Keybutton.AutoButtonColor = false 
            Keybutton.AutomaticSize=Enum.AutomaticSize.X
            UITextSizeConstraint_2.Parent = Keybutton

            UITextSizeConstraint_2.MaxTextSize = 11
            UITextSizeConstraint_2.MinTextSize = 11

            UICorner_2.CornerRadius = UDim.new(0, 4)
            UICorner_2.Parent = Keybutton
                    

            Keybutton.MouseButton1Click:Connect(function()
                Keybutton.Text = "..."
                local a, b = game:GetService("UserInputService").InputBegan:Wait()
                if a.KeyCode.Name ~= "Unknown" then
                    Keybutton.Text = a.KeyCode.Name
                    oldKey = a.KeyCode.Name
                end
            end)
            game:GetService("UserInputService").InputBegan:connect(function(current, ok) 
                if not ok then 
                    if current.KeyCode.Name == oldKey then 
                       pcall(Callback)
                    end
                end
            end)
            function keyfunctions.Update(settings)
                settings = settings or {}
                local Title = tostring(settings.Title) or "Updated Keybind"

                KeybindText.Text = Title 
                
            end
            return keyfunctions
                end
                function CatElements.Textbox(settings)
                    settings = settings or {}
                    local Title = settings.Title or "New Textbox"
                    local Callback = settings.Callback or function() end
                    local PlaceholderText = settings.PlaceholderText or ""
                    local textboxfunctions = {}
                    if not typeof(Title) == "string" then Title = "New Textbox" end 

            local Textbox = Instance.new("Frame")
            local UICorner = Instance.new("UICorner")
            local KeybindText = Instance.new("TextLabel")
            local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
            local input = Instance.new("TextBox")
            local UICorner_2 = Instance.new("UICorner")
            local UITextSizeConstraint_2 = Instance.new("UITextSizeConstraint")
            local UIPadding = Instance.new("UIPadding")


            Textbox.Name = "Textbox"
            Textbox.Parent = Page
            Textbox.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
            Textbox.Position = UDim2.new(-0.0088888891, 0, 0.00657894742, 0)
            Textbox.Size = UDim2.new(0, 428, 0, 39)

            UICorner.CornerRadius = UDim.new(0, 4)
            UICorner.Parent = Textbox

            KeybindText.Name = "KeybindText"
            KeybindText.Parent = Textbox
            KeybindText.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
            KeybindText.BackgroundTransparency = 1.000
            KeybindText.Position = UDim2.new(0.018515043, 0, 0.282051295, 0)
            KeybindText.Size = UDim2.new(0, 385, 0, 16)
            KeybindText.Font = Enum.Font.GothamSemibold
            KeybindText.Text = Title
            KeybindText.TextColor3 = Color3.fromRGB(200, 200, 200)
            KeybindText.TextScaled = true
            KeybindText.TextSize = 14.000
            KeybindText.TextWrapped = true
            KeybindText.TextXAlignment = Enum.TextXAlignment.Left

            UITextSizeConstraint.Parent = KeybindText
            UITextSizeConstraint.MaxTextSize = 13

            input.Name = "input"
            input.Parent = Textbox
            input.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
            input.Position = UDim2.new(0.651869178, 0, 0.15384616, 0)
            input.Size = UDim2.new(0, 141, 0, 27)
            input.Font = Enum.Font.GothamSemibold
            input.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
            input.Text = ""
            input.TextColor3 = Color3.fromRGB(200, 200, 200)
            input.TextScaled = true
            input.TextSize = 13.000
            input.TextWrapped = true
            input.TextXAlignment = Enum.TextXAlignment.Left
            input.PlaceholderText = PlaceholderText

            UICorner_2.CornerRadius = UDim.new(0, 4)
            UICorner_2.Parent = input

            UITextSizeConstraint_2.Parent = input
            UITextSizeConstraint_2.MaxTextSize = 14
            UITextSizeConstraint_2.MinTextSize = 14

            UIPadding.Parent = input
            UIPadding.PaddingLeft = UDim.new(0, 7)

            input.FocusLost:Connect(function(enterPressed)
                    if enterPressed then
                        pcall(Callback,input.Text)
                        input.Text = ""
                    end
                    end)
                    function textboxfunctions.Update(settings)
                        settings = settings or {}
                        local Title = tostring(settings.Title) or "Updated Textbox"
                        KeybindText.Text = Title
                    end
                    return textboxfunctions
                end
            return CatElements
    end
    return Inside
end
return Lib
