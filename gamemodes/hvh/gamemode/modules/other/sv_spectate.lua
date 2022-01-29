function PLAYER:enableAFK()
	if (not LocalPlayer():GetNWString("AdminMode")) then
		self.invisible = true
		self:SetNWString("spectatemode", true)
		self:Spectate(6) self:SetSolid(0) self:GodEnable() self:SetHealth(100) self:StripWeapons() self:DrawShadow(false) self:SetMaterial("models/effects/vol_light001") self:SetRenderMode(RENDERMODE_TRANSALPHA) self:Fire("alpha", visibility, 0)
		self:GetTable().invis = {vis=visibility}

		timer.Simple(0.1, function()
			self:ChatPrint(color.orange, "["..config.ProjectName.."]: ", color.white, "You activate AFK mode")
			for _, v in pairs(player.GetAll()) do
				if (v ~= self) then
					v:ChatPrint(color.orange, "["..config.ProjectName.."]: ", color.white, self:Nick(), " activate AFK mode")
				end
			end
		end)
	end
end

function PLAYER:disableAFK()
	if (not LocalPlayer():GetNWString("AdminMode")) then
		self.invisible = false
		self:SetNWString("spectatemode", false)
		self:Spectate(0) self:GodDisable() self:DrawShadow(true) self:SetMaterial("") self:SetRenderMode(RENDERMODE_NORMAL) self:Fire("alpha", 255, 0) self:Kill()
		self:GetTable().invis = nil

		timer.Simple(0.1, function()
			self:ChatPrint(color.orange, "["..config.ProjectName.."]: ", color.white, "You deactivate AFK mode")
			for _, v in pairs(player.GetAll()) do
				if (v ~= self) then
					v:ChatPrint(color.orange, "["..config.ProjectName.."]: ", color.white, self:Nick(), " deactivate AFK mode")
				end
			end
		end)
	end
end

hook.Add("PlayerSay", "AFKMode", function(ply, text)
	if (string.match(text, "/", 1)) and (string.match(text, "spec", 2) or string.match(text, "afk", 2)) then
		if (IsValid(ply)) then
			if (not ply.invisible) and (ply:Alive()) then
				ply:enableAFK()
			elseif (ply.invisible) then
				ply:disableAFK()
			elseif (not ply.invisible) and (not ply:Alive()) then
				timer.Simple(0.1, function()
					ply:ChatPrint(color.orange, "["..config.ProjectName.."]: ", color.white, "You need be alive to do this!")
				end)
			end 
		end
	end
end)

concommand.Add("spectate", function(ply)
	if (IsValid(ply)) then
		if (not ply.invisible) and (ply:Alive()) then
			ply:enableAFK()
		elseif (ply.invisible) then
			ply:disableAFK()
		elseif (not ply:Alive()) then
			timer.Simple(0.1, function()
				ply:ChatPrint(color.orange, "["..config.ProjectName.."]: ", color.white, "You need be alive to do this!")
			end)
		end 
	end
end)