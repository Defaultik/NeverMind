API = {}

local reloadTime = 0
hook.Add("OnReloaded", "OnGamemodeReload", function()
	if (CLIENT) and (reloadTime < CurTime()) then
		API.SendNotification("Update of server has been released! It can cause some problems", NOTIFY_HINT, 6)
		reloadTime = CurTime() + 5
	end
end)

function timeToStr(time)
	local tmp = time
	local s = tmp % 60
	tmp = math.floor(tmp / 60)
	local m = tmp % 60
	tmp = math.floor(tmp / 60)
	local h = tmp % 24
	tmp = math.floor(tmp / 24)
	local d = tmp % 7
	local w = math.floor(tmp / 7)

	return string.format("%02ih %02im", w, d, h, m, s)
end

if (CLIENT) then
	function API.SendNotification(text, type, time)
		notification.AddLegacy(text, type, time)
	end

	net.Receive("chatprint", function()
		chat.AddText(unpack(net.ReadTable()))
	end)

	net.Receive("playsound", function()
		local sound = net.ReadString()
		surface.PlaySound(sound)
	end)
end

if (SERVER) then
	local NETs = {"chatprint", "playsound"}
	for _, v in pairs(NETs) do
		util.AddNetworkString(v)
	end

	function PLAYER:ChatPrint(...)
		net.Start("chatprint")
		net.WriteTable({...})
		net.Send(self)
	end

	function API.ChatPrintEverybody(...)
		net.Start("chatprint")
		net.WriteTable({...})
		net.Broadcast()
	end

	function PLAYER:PlaySound(sound)
		net.Start("playsound")
		net.WriteString(sound)
		net.Send(self)
	end
end