hook.Add("PlayerShouldTaunt", "Dance", function(ply, act)
	return plycfg.Dancing
end)

hook.Add("CanPlayerSuicide", "Suicide", function(ply)
	if (ply.invisible) then
		return false
	end
	
	return plycfg.Suicide
end)

hook.Add("GetFallDamage", "FallDamage", function()
    return plycfg.FallDamage
end)

hook.Add("PlayerSwitchFlashlight", "FlashLight", function(ply, status)
	return plycfg.Flashlight
end)

hook.Add("PlayerSpray", "Spray", function(spray)
	return plycfg.Spray
end)

hook.Add("ChatText", "HideShit", function(index, name, text, type)
    if (type == "joinleave") or (type == "namechange") then
        return false
    end
end)

hook.Remove("PlayerSay", "ULXMeCheck")
concommand.Remove("gm_save")