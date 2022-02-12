if (not sql.TableExists("idsystem")) then
	sql.Query("CREATE TABLE idsystem(nickname TEXT, steamid BIGINT, id BIGINT)")
end

function PLAYER:mysqlGetID()
	return sql.QueryValue("SELECT id FROM idsystem WHERE steamid = "..self:SteamID64())
end

function PLAYER:mysqlSetID(id)
	if (not self:mysqlGetID()) then
		return sql.Query("INSERT INTO idsystem(nickname, steamid, id) VALUES("..SQLStr(self:GetName()).. ", "..self:SteamID64()..", "..id..")")
	end

	return sql.Query("UPDATE idsystem SET id = "..id..", nickname = "..SQLStr(self:GetName()).." WHERE steamid = ".. self:SteamID64())
end

function PLAYER:GetID()
	return self:GetNWString("id")
end

function PLAYER:SetID(id)
	self:SetNWString("id", id)
end

hook.Add("PlayerInitialSpawn", "GiveID", function(ply)
	if (not ply:mysqlGetID()) then
		ply:mysqlSetID(math.random(10000, 99999))
	end

	ply:SetID(ply:mysqlGetID())
end)