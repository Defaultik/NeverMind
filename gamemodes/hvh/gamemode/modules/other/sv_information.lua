hook.Add("PlayerSay", "PlayerStatistic", function(ply, text)
	if (string.match(text, "/", 1)) and (string.match(text, "info", 2) or string.match(text, "stat", 2)) then
		timer.Simple(0.1, function()
			if (ply:GetXP()) then
				ply:ChatPrint(color.orange, "["..config.ProjectName.."]: ", color.white, "Your experience: "..ply:GetXP().." XP")
				ply:ChatPrint(color.orange, "["..config.ProjectName.."]: ", color.white, "Your total kills: ")
				ply:ChatPrint(color.orange, "["..config.ProjectName.."]: ", color.white, "Your total deaths: ")
				ply:ChatPrint(color.orange, "["..config.ProjectName.."]: ", color.white, "Your playtime: "..timeToStr(ply:GetUTimeTotalTime()))
			else
				ply:ChatPrint(color.orange, "["..config.ProjectName.."]: ", color.white, "Play more time!")
			end
		end)
	end
end)