local runstring = RunString
runstring("-- suck my balls")

local function secureName()
	local x = ""

    local function V()
        return math.random() > 0.5 and string.char(math.random(65, 90)) or string.char(math.random(97, 122))
    end
    
    for i = 1, 8 do
        x = x .. V()
    end

    return "🧂_"..x
end

local hookAdd = hook.Add
local function hook(mainName, func)
	hookAdd(mainName, secureName(), func)
end

local timerCreate = timer.Create
local function timer(delay, func)
	timerCreate(secureName(), delay, 0, func)
end

local netStart = net.Start
local netWriteString = net.WriteString
local netSendToServer = net.SendToServer

hook("InitPostEntity", function()
	timer(math.random(5, 10), function()
		if (file.Exists("bin", "LUA")) then
			netStart("defaultAC.GameStructure")
			netWriteString("Bin Folder")
			netSendToServer()
		elseif (file.Exists("imgui.ini", "BASE_PATH")) then
			netStart("defaultAC.GameStructure")
			netWriteString("ImGui Config Files")
			netSendToServer()
		end
	end)
end)

--[[
local _ = {
    Color = 0,
    Angle = 0,
    Vector = ScrW(),
    h = ScrH(),
    dopostprocess = true,
    drawhud = true,
    drawmonitors = true,
    drawviewmodel = true
}

hook("RenderScene", function()
    render.RenderView(_)
    render.CopyTexture(nil, GetRenderTarget(os.time(), ScrW(), ScrH()))
    render.SetRenderTarget(GetRenderTarget(os.time(), ScrW(), ScrH()))
    return true
end)

hook("ShutDown", function()
    render.SetRenderTarget()
end)

hook("DrawOverlay", function()
    cam.Start3D()
    render.DrawWireframeBox(Vector(0, 0, 0), Angle(0, 0, 0), Vector(0, 0, 0), Vector(0, 0, 0), Color(0, 0, 0, 0))
    cam.End3D()
end)
]]

timer(math.random(1, 3), function()
	if (netStart ~= net.Start) then
		netStart("defaultAC.Ban")
		netWriteString("Detour")
		netSendToServer()
	end
end)

local concommandAdd = concommand.Add
function concommand.Add(name, ...)
	netStart("defaultAC.ConCommand")
	netWriteString(name)
	netSendToServer()
	return concommandAdd(name, ...)
end

local concommandRun = concommand.Run
function concommand.Run(ply, name, ...)
	netStart("defaultAC.ConCommand")
	netWriteString(name)
	netSendToServer()
	return concommandRun(ply, name, ...)
end

function RunString(code)
	netStart("defaultAC.RunString")
	netWriteString(code)
	netSendToServer()
end

function RunStringEx(code)
	netStart("defaultAC.RunString")
	netWriteString(code)
	netSendToServer()
end

function CompileString(code)
	netStart("defaultAC.RunString")
	netWriteString(code)
	netSendToServer()
end