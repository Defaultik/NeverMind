AddCSLuaFile()

prefix = "[Information]:"

if (SERVER) then
	util.AddNetworkString("AutoChatSpam")
	
	timer.Create("AutoChatSpam", config.ChatSpamCooldown, 0, function()
		net.Start("AutoChatSpam")
		net.Broadcast()
	end)
end

if (CLIENT) then
	net.Receive("AutoChatSpam", function()
		chat.AddText(color.orange, prefix .. " ", color.white, "Our VK group: ", color.orange, "vk.com/nevermind.gmod", color.white, ".")
		chat.AddText(color.orange, prefix .. " ", color.white, "Do not forget add server to the ", color.orange, "Favorites", color.white, ".")
		chat.AddText(color.orange, prefix .. " ", color.white, "IP: ", color.orange, game.GetIPAddress(), color.white, ".")
		chat.AddText(color.orange, prefix .. " ", color.white, "Map: ", color.orange, game.GetMap(), color.white, ".")
	end)
end