local DiscordWebhookURL = "https://discordapp.com/api/webhooks/936642059954159676/ixwqX0sI3hgMJWTgdUAfIzKK5_r9lcU2Ds56JoZEZhAEBtQ17XAOxAGPD0XGALhew4AW"
local DiscordPHPScriptURL = "https://defaultiiik.000webhostapp.com/discord-webhook.php"

function discordPost(ply, message)
	http.Post(DiscordPHPScriptURL, {
		plyInfo = ply:Nick().." ("..ply:SteamID()..")",
		steamURL = "http://steamcommunity.com/profiles/"..ply:SteamID64(),
		ip = ply:IPAddress(),
		message = message,
		serverName = GetHostName(),
		barColor = "#FF6600", -- The HEX color
		webhookURL = DiscordWebhookURL
	})
end

hook.Add("PlayerInitialSpawn", "PlayerConnect", function(ply)
	if (ply:IsAdmin()) then
		serverAdmins = (serverAdmins or 0) + 1

		discordPost(ply, "Connected to the server ("..serverAdmins.." admins online)")
	end
end)

hook.Add("PlayerDisconnected", "PlayerDisconnect", function(ply)
	if (ply:IsAdmin()) then
		serverAdmins = serverAdmins - 1

		discordPost(ply, "Disconnected from the server ("..serverAdmins.." admins online)")
	end
end)