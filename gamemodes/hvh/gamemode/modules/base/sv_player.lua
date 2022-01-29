plycfg = {}

plycfg.HP 					= 100
plycfg.Armor 				= 0

plycfg.WalkSpeed 			= 400
plycfg.RunSpeed				= 400

plycfg.Dancing 				= false
plycfg.Suicide 				= true
plycfg.FallDamage 			= false
plycfg.Flashlight 			= false
plycfg.Spray 				= false

local entMeta = FindMetaTable("Entity")
local oldPlyColor

local function disableBabyGod(ply)
	ply.Babygod = nil
	ply:GodDisable()
	ply:SetRenderMode(RENDERMODE_NORMAL)
	ply:SetSolid(2)

	local reinstateOldColor = true
	for _, p in ipairs(player.GetAll()) do
	    reinstateOldColor = reinstateOldColor and p.Babygod == nil
	end

	if (reinstateOldColor) then
	    entMeta.SetColor = oldPlyColor
	    oldPlyColor = nil
	end

	ply:SetColor(ply.babyGodColor or Color(255, 255, 255, 255))
	ply.babyGodColor = nil
end

local function enableBabyGod(ply)
    timer.Remove(ply:EntIndex() .. "babygod")

    ply.Babygod = true
    ply:GodEnable()
    ply.babyGodColor = ply:GetColor()
    ply:SetRenderMode(RENDERMODE_TRANSALPHA)

    if (not oldPlyColor) then
        oldPlyColor = entMeta.SetColor
        entMeta.SetColor = function(p, c, ...)
            if (not p.Babygod) then
            	return oldPlyColor(p, c, ...)
            end

            p.babyGodColor = c
            oldPlyColor(p, Color(c.r, c.g, c.b, 100))
        end
    end

    ply:SetColor(ply.babyGodColor)

    timer.Create(ply:EntIndex() .. "babygod", 2.5, 1, function()
    	if (IsValid(ply)) and (ply.Babygod) then
    		disableBabyGod(ply)
    	end 
	end)
end

hook.Add("EntityFireBullets", "BabyGodRemover", function(ply)
    if (IsValid(ply)) and (ply.Babygod) then
    	disableBabyGod(ply)
    end
end)

hook.Add("PlayerSpawn", "Spawn", function(ply)
	ply:SetNWString("spectatemode", false)
	ply:SetNWString("AdminMode", false)
	ply.invisible = false
	if (not ply.Babygod) then
        enableBabyGod(ply)
    end

	ply:Health(plycfg.HP)
	ply:Armor(plycfg.Armor)

	ply:SetFOV(90)

	ply:SetWalkSpeed(plycfg.WalkSpeed)
	ply:SetRunSpeed(plycfg.RunSpeed)
	-- ply:SetLadderClimbSpeed(90)

	ply:SetModel("models/player/urban.mdl")
	
	local primary = "css_ak47"
	local secondary = "css_glock"

	local c_primary = ply:GetInfo("weapon_primary")
	local c_secondary = ply:GetInfo("weapon_secondary")
	
	if config.AllowedWeapons.primary[c_primary] ~= nil then
		primary = c_primary
	end
	
	if config.AllowedWeapons.secondary[c_secondary] ~= nil then
		secondary = c_secondary
	end

	local weapons = {ply:GetInfo("weapon_primary") or "css_ak47", ply:GetInfo("weapon_secondary") or "css_p228"}
	for k, v in pairs(weapons) do
		ply:Give(v)
	end

	for _, v in pairs(config.AmmoTypes) do
		ply:GiveAmmo(config.AmmoAmmount, v, true)
	end

	ply:SetupHands()
end)

hook.Add("PlayerDeath", "Death", function(victim, attacker)
	victim:CreateRagdoll()
	victim.LastDeath = CurTime()
end)

hook.Add("PlayerDeathThink", "AfterDeath", function(ply)
	if (config.AutoRespawn) and (not ply:Alive()) and (ply.LastDeath ~= nil) and (ply.LastDeath + config.RespawnTime) <= (CurTime()) then
		ply:Spawn()
	end

	return true
end)