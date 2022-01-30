local delay = 7
local nextOccurance = 0

function PLAYER:enableAFK()
	if (not self:GetNWString("AdminMode")) then
		local timeLeft = nextOccurance - CurTime()
		if (timeLeft) < 0 then
			self.invisible = true
			self:SetNWString("spectatemode", true)

			ULib.invisible(self, true)
			self:GodEnable()
			self:SetHealth(100)
			self:StripWeapons()
			self:Spectate(6)
			self:SetSolid(0)

			timer.Simple(0.1, function()
				self:ChatPrint(color.orange, "["..config.ProjectName.."]: ", color.white, "You activate AFK mode")
				for _, v in pairs(player.GetAll()) do
					if (v ~= self) then
						v:ChatPrint(color.orange, "["..config.ProjectName.."]: ", color.white, self:Nick(), " activate AFK mode")
					end
				end
			end)
			nextOccurance = CurTime() + delay
		else
			timer.Simple(0.1, function()
				self:ChatPrint(color.orange, "["..config.ProjectName.."]: ", color.white, "Please don't spam this function")
			end)
		end
	end
end

function PLAYER:disableAFK()
	if (not self:GetNWString("AdminMode")) then
		self.invisible = false
		self:SetNWString("spectatemode", false)

		ULib.invisible(self, false)
		self:GodDisable()
		self:Spectate(0)
		self:SetSolid(0)
		self:Kill()

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