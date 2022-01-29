function PLAYER:AdminModeOn()
	if (self:IsSuperAdmin()) or (self:IsUserGroup("admin")) then
		if (not LocalPlayer():GetNWString("spectatemode")) then
			self.adminmode = true
			self:SetNWString("AdminMode", true)

			ULib.invisible(self, true)
			self:GodEnable()
			self:SetHealth(100)
			self:StripWeapons()
			self:Spectate(6)
			self:SetSolid(0)

			timer.Simple(0.1, function()
				self:ChatPrint(color.orange, "["..config.ProjectName.."]: ", color.white, "You activate Admin Mode")
				for _, v in pairs(player.GetAll()) do
					if (v ~= self) then
						v:ChatPrint(color.orange, "["..config.ProjectName.."]: ", color.white, self:Nick(), " activate Admin Mode")
					end
				end
			end)
		end
	end
end

function PLAYER:AdminModeOff()
	if (self:IsSuperAdmin()) or (self:IsUserGroup("admin")) then
		if (not LocalPlayer():GetNWString("spectatemode")) then
			self.adminmode = false
			self:SetNWString("AdminMode", false)

			ULib.invisible(self, false)
			self:GodDisable()
			self:Spectate(0)
			self:Kill()

			timer.Simple(0.1, function()
				self:ChatPrint(color.orange, "["..config.ProjectName.."]: ", color.white, "You deactivate Admin Mode")
				for _, v in pairs(player.GetAll()) do
					if (v ~= self) then
						v:ChatPrint(color.orange, "["..config.ProjectName.."]: ", color.white, self:Nick(), " deactivate Admin Mode")
					end
				end
			end)
		end
	end
end

hook.Add("PlayerSay", "AFKMode", function(ply, text)
	if (string.match(text, "/", 1)) and (string.match(text, "admin", 2)) then
		if IsValid(ply) then
			if (ply.adminmode) then
				ply:AdminModeOff()
			else
				ply:AdminModeOn()
			end
		end
	end
end)