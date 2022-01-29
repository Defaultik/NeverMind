if (not sql.TableExists("experience")) then
	sql.Query("CREATE TABLE experience(nickname TEXT, steamid BIGINT, xp BIGINT)")
end

function PLAYER:GetXP()
	return sql.QueryValue("SELECT xp FROM experience WHERE steamid = "..self:SteamID64())
end

function PLAYER:UpdateXP(xp)
	if (not self:GetXP()) then 
		return sql.Query("INSERT INTO experience(xp, steamid, nickname) VALUES("..xp.. ", "..self:SteamID64()..", "..SQLStr(self:GetName())..")")
	end
	
	return sql.Query("UPDATE experience SET xp = "..xp..", nickname = "..SQLStr(self:GetName()).." WHERE steamid = ".. self:SteamID64())
end
	
function PLAYER:AddXP(xp, reason)
	if (not self:GetXP()) then 
		self:UpdateXP(config.Leveling["StarterXP"])
	end
		
	local totalXP = self:GetXP() + xp
	self:ChatPrint(color.orange, "["..config.ProjectName.."]: ", color.white, "You received "..xp.." points for ", color.orange, reason)
		
	return self:UpdateXP(totalXP)
end
	
function PLAYER:RemoveXP(xp, reason)
	if (not self:GetXP()) then 
		self:UpdateXp(config.Leveling["StarterXP"])
	end
		
	local totalXP = self:GetXP() - xp
	self:ChatPrint(color.orange, "["..config.ProjectName.."]: ", color.white, "You lost "..xp.." points for ", color.orange, reason)
		
	return self:UpdateXP(totalXP)
end

-- [[ LEADERBOARD ]]
hook.Add("PlayerSay", "Leaderboard", function(ply, text)
    if (string.match(text, "/", 1)) and (string.match(text, "leaderboard", 2) or string.match(text, "lb", 2)) then
        for _, v in pairs(sql.Query("SELECT * FROM experience ORDER BY xp DESC LIMIT 3")) do
            place = (place or 0) + 1
            ply:ChatPrint(color.orange, "[Leaderboard]: ", color.white, place..". ", v["nickname"], " (", util.SteamIDFrom64(v["steamid"]),") - ", v["xp"], " points")
        end
    end
end)