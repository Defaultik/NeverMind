function PLAYER:SetPrefix(name)
	self:SetNWString("Prefix", name)
end

function PLAYER:GetPrefix()
	return self:GetNWString("Prefix")
end

function PLAYER:SetPrefixColor(R, G, B)
	self:SetNWString("PrefixColor", Color(R, G, B))
end

function PLAYER:GetPrefixColor()
	return self:GetNWString("PrefixColor")
end

hook.Add("OnPlayerChat", "Prefix", function(ply, text)
	if (IsValid(ply)) then
		if (ply:IsSuperAdmin()) then
			ply:SetPrefix("OWNER")
			ply:SetPrefixColor(255, 0, 0)
		elseif (ply:IsUserGroup("vip")) then
			ply:SetPrefix("VIP")
			ply:SetPrefixColor(255, 255, 0)
		else
			ply:SetPrefix("USER")
			ply:SetPrefixColor(180, 180, 180)
		end

		chat.AddText(ply:GetPrefixColor(), "["..ply:GetPrefix().."] ", color.white, ply:GetName(), ": ", text)
        return true
	end
end)