local kickMessage = [[Nice try]]

local function clearServerEntries()
    MySQLite.query(string.format([[
        DELETE FROM serverplayer WHERE serverid = %s
    ]], MySQLite.SQLStr(serverId)))
end

local function insertSteamid64(steamid64, userid)
    local query = string.format([[
        INSERT INTO serverplayer VALUES(%s, %s)
    ]], steamid64, MySQLite.SQLStr(serverId))
    MySQLite.query(
        query,
        -- Ignore result of successful insertion
        function() end,
        -- Attempt to kick the user when insertion fails, as it means that
        -- the row already exists in the database.
        function(err)
            if not string.find(err, "Duplicate entry") then return end

            game.KickID(userid, kickMessage)
            return true
        end
    )
end

local function insertPlayer(ply)
    insertSteamid64(ply:SteamID64(), ply:UserID())
end

local function removePlayer(ply)
    MySQLite.query(string.format([[
        DELETE FROM serverplayer WHERE uid = %s AND serverid = %s
    ]], ply:SteamID64(), MySQLite.SQLStr(serverId)))
end

local function addHooks()
    hook.Add("PlayerAuthed", "antimultirun", function(ply, steamId)
        insertSteamid64(util.SteamIDTo64(steamId), ply:UserID())
    end)

    hook.Add("PlayerDisconnected", "antimultirun", removePlayer)
    hook.Add("ShutDown", "antimultirun", clearServerEntries)
end

hook.Add("DBInitialized", "antimultirun", function()
    if (MySQLite.isMySQL()) and (game.IsDedicated()) then
        hook.Add("Think", "antimultirun", function()
            serverId = game.GetIPAddress()
            if string.sub(serverId, 0, 8) == "0.0.0.0:" then return end
            hook.Remove("Think", "antimultirun")

            MySQLite.query([[
                CREATE TABLE IF NOT EXISTS serverplayer(
                    uid BIGINT NOT NULL,
                    serverid VARCHAR(32) NOT NULL,
                    PRIMARY KEY(uid, serverid)
                );
            ]])

            -- Clear this server's entries in case the server wasn't cleanly shut down
            clearServerEntries()    

            addHooks()
        end)
    end
end)
