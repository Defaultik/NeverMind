local AFKTIme = 75 -- Time (in seconds) after what people get AFK mode

hook.Add("PlayerInitialSpawn", "FirstSpawn", function(ply)
	ply.afk = false
	ply.lastactivity = CurTime()
	ply.ready = true
end)

hook.Add("PlayerSay", "StartWriting", function(ply)
	ply.lastactivity = CurTime()
	if (ply.afk) then SetPlayerAFK(ply, false) end
end)

hook.Add("KeyPress", "StartMoving", function(ply)
	ply.lastactivity = CurTime()
	if (ply.afk) then SetPlayerAFK(ply, false) end
end)

function SetPlayerAFK(ply, afk)
	ply.afk = afk

	if (afk) then
		if (player.GetCount() == game.MaxPlayers()) then
			ply:Kick()
		else
			ply:enableAFK()
		end
	end
end

function CheckAFKPlayer()
	for _, v in pairs(player.GetAll()) do
		if (v.ready) and (not v.afk) and ((CurTime() - v.lastactivity) > AFKTIme) then
			SetPlayerAFK(v, true)
		end
	end
end

thinktime = 1
nextthink = CurTime() + thinktime
hook.Add("Think", "EveryThink", function()
	if CurTime() <= nextthink then return end
	nextthink = CurTime() + thinktime
	CheckAFKPlayer()
end)