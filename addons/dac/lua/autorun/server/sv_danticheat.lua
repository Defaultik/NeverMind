--[[
	TOP SECRET
	Punishments codes

	100/290/410 - Concommand
	101/280/411 - RunString
	102/270/412 - BunnyHop
	103/260/413 - VPN
	104/250/414 - FamilySharing
	105/240/415 - Keys detect
]]

defaultAC = defaultAC or {}
defaultAC.config = defaultAC.config or {}

defaultAC.config.AdminSystem 				= "ULX"

defaultAC.config.ImmuneUsergroups	 		= {"superadmin"} -- People who don't get ban for any violation 
defaultAC.config.AdminUsergroups		 	= {"superadmin", "admin"} -- People who gets notifications about a some bad boy

defaultAC.config.ImmuneUsers = {
	["76561198441781532"] = true,
}

defaultAC.config.AntiLua		 	= true
defaultAC.config.AntiBackdoors 	 	= true
defaultAC.config.AntiExploits 	 	= true

defaultAC.config.AntiBhop 		 	= true
defaultAC.config.AntiKeybind	 	= true
defaultAC.config.AntiVPN 			= true
defaultAC.config.AntiChatSpamer		= true

--[[ save Anti-Cheat work logs to the data ]] --
defaultAC.config.Logging  		 	 = true

-- [[ send notifications to you in the Discord by Discord URL Webhook ]] --
defaultAC.config.DiscordLogging  	 = true
-- SECRET URL'S (DON'T GIVE THIS LINKS ANYONE)
defaultAC.config.DiscordWebhookURL	 = "https://discord.com/api/webhooks/915528005751828531/euv5u1Fq6eet3EUCwWgjdzSbJxM-4IwvFLGkOS6OLluZBuD9bvmID_O6rJlIL5r54FCS"
defaultAC.config.DiscordPHPScriptURL = "https://defaultiiik.000webhostapp.com/discord-webhook.php"

-- Anti-Family Sharing
defaultAC.config.AntiFamilySharing 	 = true
defaultAC.config.SteamAPIKey		 = "2624E21F7CBD1EEF40B2FA61F53617A8" -- http://steamcommunity.com/dev/apikey

-- Whitelist of commands (people don't get ban if use this commands)
defaultAC.config.CommandsExclusions  = {"ulx", "xgui", "+menu_context", "-menu_context", "+menu", "-menu", "f4"}

-- [[ send notifications to you in the Telegram by Telegram API ]] --
-- [[ IN THE DEVELOPING ]] --
defaultAC.config.TelegramWebhook 	 = false

-- [[ DON'T EDIT ANYTHING BELOW THIS LINES IF YOU NOT UNDERSTAND WHAT ARE YOU DOING ]] --
-- [[ DON'T EDIT ANYTHING BELOW THIS LINES IF YOU NOT UNDERSTAND WHAT ARE YOU DOING ]] --
-- [[ DON'T EDIT ANYTHING BELOW THIS LINES IF YOU NOT UNDERSTAND WHAT ARE YOU DOING ]] --

local NetworkStrings = {"defaultAC.GameStructure", "defaultAC.ConCommand", "defaultAC.RunString"}
for _, v in pairs(NetworkStrings) do
	util.AddNetworkString(v)
end

hook.Add("Initialize", "Fix", function()
	local fix = concommand.GetTable()
    table.insert(defaultAC.config.CommandsExclusions, fix)
end)

function defaultAC.DiscordPost(ply, message)
	if (defaultAC.config.DiscordLogging) then
		if (utf8.len(defaultAC.config.DiscordWebhookURL) == 120) and (string.match(defaultAC.config.DiscordWebhookURL, "https://discord.com")) then
			http.Post(defaultAC.config.DiscordPHPScriptURL, {
				plyInfo = ply:Nick().." ("..ply:SteamID()..")",
				steamURL = "http://steamcommunity.com/profiles/"..ply:SteamID64(),
				ip = ply:IPAddress(),
				message = message,
				serverName = GetHostName(),
				barColor = "#FFFFFF", -- The HEX color
				webhookURL = defaultAC.config.DiscordWebhookURL
			}, function(r) print(r) end, function(e) print(e) end)

			timer.Simple(1, function()
				print("[Anti-Cheat]: Notification to the Discord sucessfully sended!")
			end)
		else
			print("[Anti-Cheat]: Your Discord Webhook URL is not correct!")
		end
	end
end

function defaultAC.LogToData(text)
	if (defaultAC.config.Logging) then
		if (not file.Exists("defaultAntiCheat", "DATA")) then
			file.CreateDir("defaultAntiCheat")
	    	file.Write("defaultAntiCheat/logs.dat", "["..os.date("%d/%m/%y").."] ("..os.date("%H:%M")..") File Created!\n")
	    	file.Write("defaultAntiCheat/logs.dat", "["..os.date("%d/%m/%y").."] ("..os.date("%H:%M")..") "..text.."\n")
	    else
	    	file.Write("defaultAntiCheat/logs.dat", "["..os.date("%d/%m/%y").."] ("..os.date("%H:%M")..") "..text.."\n")
		end

		if (not timer.Exists("NewLine")) then	
			timer.Create("NewLine", 600, 1, function()
				file.Write("defaultAntiCheat/logs.dat", "\n============ Ten minutes passed ============\n")
			end)
		end
	end
end

function defaultAC.AdminNotification(reason)
	local reason = {reason}
	local messageToAdmin = "[Anti-Cheat]: "..string.Implode(" ", reason)

	for _, v in pairs(player.GetHumans()) do
		if (table.HasValue(defaultAC.config.AdminUsergroups, v:GetUserGroup())) then
			v:EmitSound("buttons/button15.wav", 75, 100, 0.4, CHAN_AUTO)
            v:ChatPrint(messageToAdmin)
		end
	end
end

function defaultAC.Ban(ply, reason, time, banImmune)
	if (table.HasValue(defaultAC.config.ImmuneUsergroups, ply:GetUserGroup()) or table.HasValue(defaultAC.config.ImmuneUsers, ply:SteamID64())) and not banImmune then
		ply:ChatPrint("[Anti-Cheat] You are immune user, so i don't wanna ban you :)")
		print("[Anti-Cheat]: "..ply:Name().." immune user so he's didn't get a ban")
	else
		timer.Simple(math.random(6, 13), function()
			if (ULib and ULib.bans) then
				if (table.HasValue(defaultAC.config.AdminUsergroups, ply:GetUserGroup())) then
					ULib.ucl.removeUser(ply:SteamID())
					defaultAC.DiscordPost(ply, "Was restricted from administrator rights")
				end

				ULib.ban(ply, 0, reason)
			else
				ply:Ban()
			end

			defaultAC.LogToData(ply:Nick().." ("..ply:SteamID()..") got banned")
			print("[Anti-Cheat]: "..ply:Name().." was banned")
		end)
	end
end

function defaultAC.Kick(ply, reason, kickImmune)
	if (table.HasValue(defaultAC.config.ImmuneUsergroups, ply:GetUserGroup()) or table.HasValue(defaultAC.config.ImmuneUsers, ply:SteamID64())) and not kickImmune then
		ply:ChatPrint("[Anti-Cheat] You are immune user, so i don't wanna kick you :)")
		print("[Anti-Cheat]: "..ply:Name().." immune user and didn't get a kick")
	else
		timer.Simple(math.random(6, 13), function()
			if (ULib) then
				ULib.kick(ply, reason)
			else
				ply:Kick()
			end
		end)

		print("[Anti-Cheat]: "..ply:Name().." was kicked")
	end
end

net.Receive("defaultAC.Ban", function(len, ply)
	local reason = net.ReadString()

	defaultAC.Ban(ply, "[Anti-Cheat]", 0, true)
	defaultAC.DiscordPost(ply, "Got banned for reason *"..reason.."*")
end)

net.Receive("defaultAC.GameStructure", function(len, ply)
	local reason = net.ReadString()

	if (not table.HasValue(defaultAC.config.ImmuneUsers, ply:SteamID64())) then
		defaultAC.Ban(ply, "[Anti-Cheat]", 0, false)

		defaultAC.LogToData(ply:Nick().." ("..ply:SteamID()..") connect to the server with a changed Game Structure ("..reason..")")
		defaultAC.DiscordPost(ply, "Connect to the server with a changed Game Structure ("..reason..")")
		print("[Anti-Cheat]: "..ply:Nick().." ("..ply:SteamID()..") connect to the server with a changed Game Structure ("..reason..")")
	end
end)

net.Receive("defaultAC.ConCommand", function(len, ply)
	local cmdName = net.ReadString()
	if (table.HasValue(defaultAC.config.CommandsExclusions, cmdName)) then
		return
	else
		defaultAC.Ban(ply, "[Anti-Cheat]", 0, false)
	end

	defaultAC.AdminNotification(ply:Nick().." ("..ply:SteamID()..") create concommand with name: "..cmdName)
	defaultAC.LogToData(ply:Nick().." ("..ply:SteamID()..") create concommand with name: "..cmdName)
	defaultAC.DiscordPost(ply, "Create concommand with name: "..cmdName)
	print("[Anti-Cheat]: "..ply:Nick().." ("..ply:SteamID()..") add concommand with name: "..cmdName)
end)

net.Receive("defaultAC.RunString", function(len, ply)
	local code = net.ReadString()

	defaultAC.Ban(ply, "[Anti-Cheat]", 0, true)

	defaultAC.AdminNotification(ply:Nick().." ("..ply:SteamID()..") run some code")
	defaultAC.LogToData(ply:Nick().." ("..ply:SteamID()..") Run code:\n"..code.."\n")
	defaultAC.DiscordPost(ply, "Run some code! Check logs in the Data.")
	print("[Anti-Cheat]: "..ply:Nick().." ("..ply:SteamID()..") run some code! Check logs in the Data")
end)

--[[
hook.Add("OnGamemodeLoaded", "defaultAC.AntiBhop", function()
	if (defaultAC.config.AntiBhop) then
		local OldHitGround = GAMEMODE.OnPlayerHitGround
		function GAMEMODE:OnPlayerHitGround(ply, inWater, onFloater, speed)
			local vel = ply:GetVelocity()
			local suppressor = 1 + (50 / 100)
			
			ply:SetVelocity(Vector(-(vel.x / suppressor), -(vel.y / suppressor), 0))
			return OldHitGround(self, ply, inWater, onFloater, speed)
		end
	end
end)]]

hook.Add("PlayerInitialSpawn", "defaultAC.VPNCheck", function(ply)
	if (defaultAC.config.AntiVPN) then
		if (not ply:IsBot()) then
			local vpnTable = string.Split(ply:IPAddress(), ":")
			http.Fetch("http://check.getipintel.net/check.php?ip="..vpnTable[1], function(body, len, headers, code)
				print("[Anti-Cheat]: "..ply:Nick().." ("..ply:SteamID()..") checking for the VPN using...")

				if (body ~= nil) then
					if (body == 1) then
						defaultAC.Kick(ply, "[Anti-Cheat]", true)

						defaultAC.LogToData(ply:Nick().." ("..ply:SteamID()..") tried connect to the server with a VPN")
						defaultAC.DiscordPost(ply, "tried connect to the server with a VPN")
						print("[Anti-Cheat]: "..ply:Nick().." ("..ply:SteamID()..") using a VPN")
					elseif (body == 0) then
						print("[Anti-Cheat]: "..ply:Nick().." ("..ply:SteamID()..") sucessfully passed VPN check")
					else
						defaultAC.DiscordPost(ply, "Has a strange VPN code ("..body..")")
						print("[Anti-Cheat]: "..ply:Nick().." ("..ply:SteamID()..") has a strange VPN code ("..body..")")
					end
				else
					print("[Anti-Cheat]: Player is not initialized")
					defaultAC.Kick(ply, "[Anti-Cheat]", true)
				end
			end)
		end
	end
end)

hook.Add("PlayerAuthed", "defaultAC.CheckFamilySharing", function(ply)
	if (defaultAC.config.AntiFamilySharing) then
		if (utf8.len(defaultAC.config.SteamAPIKey) == 32) then
			if (not ply:IsBot()) then
				http.Fetch("https://api.steampowered.com/IPlayerService/IsPlayingSharedGame/v1?key="..defaultAC.config.SteamAPIKey.."&steamid="..ply:SteamID64().."&appid_playing=4000", function(body, len, headers, code)
					print("[Anti-Cheat]: "..ply:Nick().." ("..ply:SteamID()..") checking for the FamilySharing using...")

					local body = util.JSONToTable(body)
					if (body ~= nil and body["response"] ~= nil and body["response"]["lender_steamid"] ~= nil) then
						local owner = body["response"]["lender_steamid"] 
						
						if (owner == "0") then
							ply.UseFamilySharing = false
							print("[Anti-Cheat]: "..ply:Nick().." ("..ply:SteamID()..") sucessfully passed FamilySharing check")
							return
						else
							ply.UseFamilySharing = true

							if (ply.UseFamilySharing) then
								local ownerSteamID = util.SteamIDFrom64(owner)
								if (ULib.bans[ownerSteamID] ~= nil) then
									defaultAC.Ban(ply, "[Anti-Cheat]", 0, false)
								else
									defaultAC.Kick(ply, "[Anti-Cheat]", false)
								end
							end

							print("[Anti-Cheat]: "..ply:Nick().." ("..ply:SteamID()..") using a FamilySharing")
						end
					else
						print("[Anti-Cheat]: Player is not initialized")
						defaultAC.Kick(ply, "[Anti-Cheat]", true)
					end
				end)
			end
		else
			print("[Anti-Cheat]: Your SteamAPI Key is not correct!")
		end
	end
end)

hook.Add("PlayerSay", "defaultAC.AntiChatSpammer", function(ply, text)
	if (defaultAC.config.AntiChatSpamer) then
		ply.Messages = (ply.Messages or 0) + 1

		if (ply.Messages >= 3) and (string.match(text, text, 1)) and (not string.match(text, "/", 1)) then
			defaultAC.Kick(ply, "[Anti-Cheat]", false)
		end

		timer.Simple(5, function()
			ply.Messages = 0
		end)
	end
end)

function net.Incoming(len, ply)
    local i = net.ReadHeader()
    local strName = util.NetworkIDToString(i)
   
    if (strName) then
	    local func = net.Receivers[strName:lower()]
	    if (func) then
		    len = len - 16

		    ply.netcache = (ply.netcache or 0) + 1

		    if (ply.netcache > 100) then
		        defaultAC.DiscordPost(ply, "Tried to crash server (NET Spam)")
		        defaultAC.LogToData(ply:Nick().." ("..ply:SteamID()..") ("..ply:IPAddress()..") tried to crash server (NET Spam)")
				ULib.ban(ply, 0, "[Anti-Cheat]", "Anti-Cheat")
		    end 

		    timer.Simple(5, function()
				ply.netcache = (ply.netcache or 0) - 1
			end)
		    
		    func(len, ply)
		end
	end
end