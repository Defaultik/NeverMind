if (SERVER) then
	util.AddNetworkString("RestartNotify")
	util.AddNetworkString("RestartCommand")

	hook.Add("Think", "AutoRestart", function()
		if (os.date("%H:%M") == "04:25") then
			net.Start("RestartNotify")
			net.Broadcast()

			timer.Simple(300, function()
				RunConsoleCommand("_restart")
			end)
		end
	end)

	net.Receive("RestartCommand", function(len, ply)
		if (ply:IsSuperAdmin()) then
			net.Start("RestartNotify")
			net.Broadcast()

			timer.Simple(300, function()
				RunConsoleCommand("_restart")
			end)
		end
	end)
end

if (CLIENT) then
	net.Receive("RestartNotify", function()
		hook.Add("HUDPaint", "AutoRestartNotify", function()
			local Scrw, Scrh = ScrW(), ScrH()

			draw.RoundedBox(8, Scrw / 2.5, 50, 505, 100, Color(0, 0, 0, 200))
			draw.SimpleText("The sever will restart in 5 minutes", "Text", Scrw / 2, 60, color.white)
		end)
	end)

	concommand.Add("serverRestart", function(ply)
		if (ply:IsSuperAdmin()) then
			net.Start("RestartCommand")
			net.SendToServer()
		end
	end)
end