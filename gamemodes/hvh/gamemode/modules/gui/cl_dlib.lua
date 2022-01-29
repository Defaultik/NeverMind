surface.CreateFont("RobotoTitle", {font = "Roboto", size = ScrH() * 0.018, weight = 400, antialias = true})
surface.CreateFont("RobotoText", {font = "Roboto", size = ScrH() * 0.020, weight = 400, antialias = true})
surface.CreateFont("RobotoSmallText", {font = "Roboto", size = ScrH() * 0.017, weight = 400, antialias = true})
surface.CreateFont("RobotoButton", {font = "Roboto", size = ScrH() * 0.017, weight = 400, antialias = true})

--[[
    Default UI Library
    https://github.com/Defaultik/DefaultUILibary
]]

DLib = {}
DLib.Color = {}
DLib.Material = {}

DLib.RoundingPower = 8 --[[ 0 - without rounding; 8 - perfect value ]]

DLib.Color.TitleText = Color(255, 255, 255, 255)
DLib.Color.Header = Color(255, 100, 0)
DLib.Color.Top = Color(255, 100, 0)
DLib.Color.GradientColor = Color(255, 100, 0, 120)
DLib.Color.Background = Color(25, 25, 25, 252)

DLib.Color.Text = Color(255, 255, 255, 255)

DLib.Color.SwitcherBackgroundOn = Color(255, 102, 0)
DLib.Color.SwitcherBackgroundOff = Color(255, 102, 0)

DLib.Material.Blur = Material("pp/blurscreen")
DLib.Material.DownGradient = Material("gui/gradient_down")
DLib.Material.UpGradient = Material("gui/gradient_up")
DLib.Material.RightGradient = Material("vgui/gradient-r")
DLib.Material.LeftGradient = Material("vgui/gradient-l")

--[[
    Sound
]]
function DLib.Sound(sound, volume)
    LocalPlayer():EmitSound(sound, 75, 100, volume, CHAN_AUTO)
end

--[[
    Frame
]]
function DLib.Frame(x, y, w, h, title)
    local frame = vgui.Create("DFrame")
    frame:MakePopup()
    frame:SetSize(w, h)
    frame:SetTitle("")
    frame:SetDraggable(false)
    frame:ShowCloseButton(false)
    frame.headerHeight = 30
    if (x == -1 && y == -1) then
        frame:Center()
    else
        frame:SetPos(x, y)
    end

    function frame:Paint(w, h)
        draw.RoundedBox(DLib.RoundingPower, 0, 1, w, h - 1, DLib.Color.Background) -- Background
        draw.RoundedBoxEx(DLib.RoundingPower, 0, 0, w, self.headerHeight, DLib.Color.Header, true, true) -- Header

        surface.SetDrawColor(DLib.Color.GradientColor) -- Gradient Color
        surface.SetMaterial(DLib.Material.DownGradient) -- Gradient Type
        surface.DrawTexturedRect(0, self.headerHeight, w, h - 5) -- Gradient Distance

        draw.SimpleText(title, "RobotoTitle", w * 0.0150, self.headerHeight / 2, DLib.Color.TitleText, 0, 1) -- Title in the Header
    end

    close = DLib.Button(frame, frame:GetWide() - 50, -25, 44, 22, DLib.RoundingPower, "x") -- Close Button
    function close:DoClick()
        DLib.Sound("buttons/button15.wav", 0.4)
        frame:Close()
    end
    return frame
end

--[[
    Panel
]]
function DLib.Panel(frame, x, y, w, h, title)
    local panel = vgui.Create("DFrame", frame)
    panel:SetSize(w, h)
    panel:SetTitle("")
    panel:ShowCloseButton(false)
    panel.headerHeight = 30
    if (x == -1 && y == -1) then
        panel:Center()
    else
        panel:SetPos(x, y)
    end

    function panel:Paint(w, h)
        draw.RoundedBox(DLib.RoundingPower, 0, 1, w, h - 1, DLib.Color.Background)
        draw.RoundedBoxEx(DLib.RoundingPower, 0, 0, w, self.headerHeight, DLib.Color.Header, true, true)

        surface.SetDrawColor(DLib.Color.GradientColor)
        surface.SetMaterial(DLib.Material.DownGradient)
        surface.DrawTexturedRect(0, self.headerHeight, w, h - 3)

        draw.SimpleText(title, "RobotoTitle", w * 0.0225, self.headerHeight / 2, DLib.Color.TitleText, 0, 1)
    end

    local close = DLib.Button(panel, panel:GetWide() - 50, -25, 44, 22, DLib.RoundingPower, "x") -- Close Button
    function close:DoClick()
        DLib.Sound("buttons/button15.wav", 0.4)
        panel:Close()
    end
    return panel
end

--[[
    Scroll Panel
]]

function DLib.ScrollPanel(x, y, w, h, title)
    mainFrame = vgui.Create("DFrame")
    mainFrame:SetSize(w, h)
    mainFrame:SetTitle("")
    mainFrame:ShowCloseButton(false)
    mainFrame.headerHeight = 30
    if (x == -1 && y == -1) then
        mainFrame:Center()
    else
        mainFrame:SetPos(x, y)
    end

    function mainFrame:Paint(w, h)
        draw.RoundedBox(DLib.RoundingPower, 0, 1, w, h - 1, DLib.Color.Background)
        draw.RoundedBoxEx(DLib.RoundingPower, 0, 0, w, self.headerHeight, DLib.Color.Header, true, true)

        surface.SetDrawColor(DLib.Color.GradientColor)
        surface.SetMaterial(DLib.Material.DownGradient)
        surface.DrawTexturedRect(0, 0, w, h - 5)

        draw.SimpleText(title, "RobotoTitle", w * 0.0150, self.headerHeight / 2, DLib.Color.TitleText, 0, 1)
    end

    panel = vgui.Create("DScrollPanel", mainFrame)
    panel:SetSize(w, h)
    panel.headerHeight = 30
    if (x == -1 && y == -1) then
        panel:Center()
    else
        panel:SetPos(x, y)
    end

    --[[local sbar = panel:GetVBar()
    function sbar:Paint() end
    function sbar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, DLib.Color.Top)
    end
    function sbar.btnUp:Paint() end
    function sbar.btnDown:Paint() end]]

    local close = DLib.Button(mainFrame, panel:GetWide() - 50, -25, 44, 22, 8, "x") -- Close Button
    function close:DoClick()
        DLib.Sound("buttons/button15.wav", 0.4)
        mainFrame:Close()
    end
end

--[[
    Button
]]
function DLib.Button(frame, x, y, w, h, rounding, text)
    local button = vgui.Create("DButton", frame)
    button:SetPos(x, 30 + y)
    button:SetSize(w, h)
    button:SetText("")
    button:SetColor(DLib.Color.Top)
    function button:Paint(w, h)
        draw.RoundedBox(rounding, 0, 0, w, h, self:GetColor())
        if self:IsHovered() then
            self.Lerp = Lerp(0.09, self.Lerp or 0, 25)
        else
            self.Lerp = Lerp(0.09, self.Lerp or 0, 0)
        end
        draw.RoundedBox(rounding, 0, 0, w, h, Color(255, 255, 255, self.Lerp))
        draw.SimpleText(text, "RobotoTitle", w / 2, h / 2, DLib.Color.Text, 1, 1)
    end
    return button
end


--[[
    Checkbox
]]
function DLib.CheckBox(frame, x, y, convar)
    local box = vgui.Create("DCheckBox", frame)
    box:SetPos(x, (frame.headerHeight or 30) + y)
    box:SetSize(20, 20)
    box:SetConVar(convar)
    function box:Paint(w, h)
        draw.RoundedBox(DLib.RoundingPower, 0, 0, w, h, DLib.Color.Top)
        if self:GetChecked() then
            self.Lerp = Lerp(0.1, self.Lerp or 0, 255)
        else
            self.Lerp = Lerp(0.1, self.Lerp or 0, 0)
        end
        draw.RoundedBox(DLib.RoundingPower, 5, 5, w - 10, h - 10, Color(225, 72, 0, self.Lerp))
    end

    function box:OnChange(bVal) -- SPECIAL THANKS TO THE ARTEMKING4
        if bVal ~= self.prevVal then
            DLib.Sound("buttons/button15.wav", 0.4)
        end

        self.prevVal = bVal
    end
    return box
end


--[[
    Switcher
]]
function DLib.Switch(frame, x, y, convar)
    local button = vgui.Create("DCheckBox", frame)
    button:SetPos(x, (frame.headerHeight or 30) + y)
    button:SetSize(35, 17)
    button:SetConVar(convar)
    function button:Paint(w, h)
        if self:GetChecked() then
            button.Lerp = Lerp(0.09, button.Lerp or 0, w - (w * 0.500))
            button.LerpR = Lerp(0.09, button.LerpR or 0, DLib.Color.SwitcherBackgroundOn.r)
            button.LerpG = Lerp(0.09, button.LerpG or 0, DLib.Color.SwitcherBackgroundOn.g)
            button.LerpB = Lerp(0.09, button.LerpB or 0, DLib.Color.SwitcherBackgroundOn.b)
        else
            button.Lerp = Lerp(0.09, button.Lerp or 0, w - (w * 1))
            button.LerpR = Lerp(0.09, button.LerpR or 0, DLib.Color.SwitcherBackgroundOff.r)
            button.LerpG = Lerp(0.09, button.LerpG or 0, DLib.Color.SwitcherBackgroundOff.g)
            button.LerpB = Lerp(0.09, button.LerpB or 0, DLib.Color.SwitcherBackgroundOff.b)
        end
        draw.RoundedBox(DLib.RoundingPower, 0, 0, w, h, Color(button.LerpR, button.LerpG, button.LerpB))
        draw.RoundedBox(DLib.RoundingPower, self.Lerp, 0, w / 2, h, Color(230, 230, 230))
    end

    function button:OnChange(bVal) -- SPECIAL THANKS TO THE ARTEMKING4
        if bVal ~= self.prevVal then
            DLib.Sound("buttons/button15.wav", 0.4)
        end

        self.prevVal = bVal
    end
    return button
end


--[[
    Binder
]]
function DLib.Binder(frame, x, y, convar)
    local binder = vgui.Create("DBinder", frame)
    binder:SetSize(90, 20)
    binder:SetPos(x, (frame.headerHeight or 30) + y)
    binder:SetConVar(convar)
    binder:SetFont("RobotoSmallText")
    binder:SetTextColor(DLib.Color.Text)

    function binder:Paint(w, h)
        draw.RoundedBox(DLib.RoundingPower, 0, 0, self:GetWide(), self:GetTall(), Color(100, 100, 255))

        if self.Hovered then 
            draw.RoundedBox(DLib.RoundingPower, 0, 0, self:GetWide(), self:GetTall(), Color(255, 255, 255, 10))
        end
    end

    function binder:OnChange(bVal) -- SPECIAL THANKS TO THE ARTEMKING4
        if bVal ~= self.prevVal then
            DLib.Sound("buttons/button14.wav", 0.4)
        end
        self.prevVal = bVal
    end

    function binder:DoClick()
        self:SetText("...") -- Change fu#king gmod "PRESS ANY KEY"
        input.StartKeyTrapping()
        self.Trapping = true
    end
    return binder
end


--[[
    Slider
]]
function DLib.Slider(frame, x, y, w, h, minValue, maxValue, convar)
    local slider = vgui.Create("DNumSlider", frame)
    slider:SetPos(x, (frame.headerHeight or 30) + y)
    slider:SetSize(w, h)
    slider:SetDecimals(0)
    slider:SetMinMax(minValue, maxValue)
    slider:SetConVar(convar)
    slider.TextArea:SetFont("RobotoSmallText")
    slider.TextArea.SetTextColor(DLib.Color.Text)

    function slider.Slider.Knob:Paint() end
    function slider.Slider:Paint(w, h)
        draw.RoundedBox(DLib.RoundingPower, 0, h / 4, w, h /2, Color(80, 80, 250, 100))
        draw.RoundedBox(DLib.RoundingPower, 0, h / 4, w * ((self:GetParent():GetValue() - self:GetParent():GetMin()) / self:GetParent():GetRange()), h / 2, DLib.Color.Top) -- Thanks to the Exec
    end

    -- Fix gmod shit
    slider.Label:SetWide(0)
    function slider:PerformLayout() end
    return slider
end


--[[
    Color Picker
]]
-- Special thanks to Crester for memorizing by means of convars
local r = CreateClientConVar("dlib_color_r", 110, true, false, "", 0, 255)
local g = CreateClientConVar("dlib_color_g", 110, true, false, "", 0, 255)
local b = CreateClientConVar("dlib_color_b", 255, true, false, "", 0, 255)

function DLib.GetColor()
    return Color(r:GetInt(), g:GetInt(), b:GetInt())
end

function DLib.ColorPicker(frame, x, y)
    local button = DLib.Button(frame, x, y, 20, 20, DLib.RoundingPower, DLib.GetColor(), "")
    function button:DoClick()
        DLib.Sound("buttons/button15.wav", 0.4)

        local panel = vgui.Create("DPanel", frame)
        panel:SetPos(self:GetX() + 25, y - 50)
        panel:SetSize(160, 155)
        panel:Show()

        local close = DLib.Button(panel, 0, -30, panel:GetWide(), 22, 0, Color(90, 90, 240), 0, "x") -- Close Button
        function close:DoClick()
            DLib.Sound("buttons/button15.wav", 0.4)
            panel:Hide()
        end

        local mixer = vgui.Create("DColorMixer", panel)
        mixer:SetSize(150, 125)
        mixer:SetPos(5, 26)
        mixer:SetPalette(false)
        mixer:SetAlphaBar(false)
        mixer:SetWangs(false)
        mixer:SetColor(DLib.GetColor())

        function mixer:ValueChanged(col)
            button:SetColor(DLib.GetColor())
            r:SetInt(col.r)
            g:SetInt(col.g)
            b:SetInt(col.b)
        end
        return mixer
    end
end

--[[
    DTextEntry
]]
function DLib.TextEntry(title, onlyNum, btnTxt, strDefaultText, enterTxt)
    // ДОБАВИТЬ БЛЮР НА ФОН ИГРОКА

    local frame = DLib.Frame(-1, -1, 300, 140, title)
 
    local textentry = vgui.Create("DTextEntry", frame)
    textentry:SetPos(frame:GetWide() / 4, 50)
    textentry:SetSize(frame:GetWide() / 2, 22)
    textentry:SetMultiline(false)
    textentry:SetNumeric(onlyNum)
    textentry:SetText(strDefaultText or "")
    textentry:SetEnterAllowed(true)
    function textentry:Paint()
        draw.RoundedBox(DLib.RoundingPower, 0, 1, textentry:GetWide(), textentry:GetTall(), DLib.Color.Top)
        textentry:DrawTextEntryText(Color(255, 255, 255), Color(80, 80, 255), Color(255,255,255))
    end

    local button = DLib.Button(frame, frame:GetWide() / 4, 50, frame:GetWide() / 2, 22, 8, btnTxt)
    function button:DoClick()
        DLib.Sound("buttons/button15.wav", 0.4)
        enterTxt(textentry:GetValue())
        frame:Remove()
    end
end

function DLib.List(frame, columnNames)
    list = vgui.Create("DListView", frame)
    list:Dock(FILL)
    list:SetMultiSelect(false)
    list:DrawTextEntryText(Color(255, 255, 255), Color(80, 80, 255), Color(255,255,255))
    for k,v in pairs(columnNames) do
        list:AddColumn(v)
    end
    function list:Paint()
        draw.RoundedBox(DLib.RoundingPower, 0, 1, list:GetWide(), list:GetTall(), DLib.Color.Top)
    end
    return list
end

function DLib.IconLayout(frame, xpos, ypos, x, y)
    iconlayout = vgui.Create("DIconLayout", frame)
    iconlayout:DockMargin(xpos, ypos, 0, 10)
    iconlayout:DockPadding(40, 30, 20, 10)
	iconlayout:Dock(FILL)
	iconlayout:SetSpaceX(x)
	iconlayout:SetSpaceY(y)
    function iconlayout:Paint(w, h) end
end