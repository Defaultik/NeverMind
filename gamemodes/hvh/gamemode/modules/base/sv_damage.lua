hook.Add("PlayerDeath", "NeverMind.Kill", function(victim, attacker)
	if (victim == attacker) then
		victim.Killstreak = 0
		return
	end

	if (IsValid(attacker)) and (IsValid(victim)) then
		attacker.Killstreak = (attacker.Killstreak or 0) + 1

		attacker:AddFrags(1)
		attacker:AddXP(config.Leveling["KillXP"], "kill " .. victim:Nick())
		attacker:SetHealth(plycfg.HP)

		for _, v in pairs(config.AmmoTypes) do
			attacker:GiveAmmo(config.AmmoAmmount, v, true)
		end

		victim:AddDeaths(1)
		victim:RemoveXP(config.Leveling["DeathXP"], "death")
        victim.Killstreak = 0

        local killstreak = config.Killstreaks[attacker.Killstreak]
        if (killstreak ~= nil) then
        	API.ChatPrintEverybody(color.orange, "[NeverMind]: ", color.white, attacker:Nick(), " ", killstreak.str)
        end
	end
end)

hook.Add("ScalePlayerDamage", "NeverMind.Damage", function(ply, hitbox, damage)
	if (hitbox == HITGROUP_HEAD) then
		damage:ScaleDamage(9999)
	else
		damage:ScaleDamage(0)
	end

	local attacker = damage:GetAttacker()
	--[[if (IsValid(attacker)) and (hitbox == HITGROUP_HEAD) then
		for _, v in pairs(player.GetAll()) do
			API.ChatPrint(v, color.orange, "[NeverMind]: ", color.white, attacker:Nick(), " did a headshot!")
		end
	end]]
end)