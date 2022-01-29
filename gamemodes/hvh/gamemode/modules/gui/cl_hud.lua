surface.CreateFont("Health", {font = "Roboto", size = 25, weight = 400, antialias = true})
surface.CreateFont("Ammo", {font = "Roboto", size = 35, weight = 1000, antialias = true})

surface.CreateFont("AFKText", {font = "Roboto", size = 40, weight = 1000, antialias = true})
surface.CreateFont("AFKTextSmall", {font = "Roboto", size = 35, weight = 1000, antialias = true})

local Scrw, Scrh = ScrW(), ScrH()

local HealthMain = Color(255, 80, 0, 255)
local HealthBG	 = Color(145, 45, 0, 255)

local Elements = {
	["CHudAmmo"] = true,
	["CHudBattery"] = true,
	["CHudHealth"] = true,
	["CHudSecondaryAmmo"] = true,
	["CHudSuitPower"] = true,
	["CHudWeaponSelection"] = true,
	["CHudCrosshair"] = true,
}

hook.Add("HUDShouldDraw", "hudHideElements", function(name)
	if Elements[name] then
		return false
	end
end)

hook.Add("HUDPaint", "hudDrawHUDPaint", function()
	local tab = {
		[ "$pp_colour_addr" ] = 0,
		[ "$pp_colour_addg" ] = 0,
		[ "$pp_colour_addb" ] = 0,
		[ "$pp_colour_brightness" ] = 0,
		[ "$pp_colour_contrast" ] = 1,
		[ "$pp_colour_colour" ] = 0.2,
		[ "$pp_colour_mulr" ] = 0,
		[ "$pp_colour_mulg" ] = 0,
		[ "$pp_colour_mulb" ] = 0
	}

	if (not LocalPlayer():Alive()) then
		DrawColorModify(tab)
	end
	
	Health = Lerp(0.15 * FrameTime() * 10, Health or 0, LocalPlayer():Health())
	local HealthWidth = math.Min(350 * (Health / 100), 350)
	draw.RoundedBox(1, 35, Scrh - 75, 350, 50, HealthBG)
	draw.RoundedBox(1, 35, Scrh - 75, HealthWidth, 50, HealthMain)
	if (LocalPlayer():Alive()) and (not LocalPlayer():GetNWString("AdminMode")) then
		draw.SimpleText(LocalPlayer():Health() .. "%", "Health", 50, Scrh - 63, Color(255, 255, 255))
	elseif (LocalPlayer():GetNWString("AdminMode")) then
		draw.SimpleText("Immortal", "Health", 50, Scrh - 63, Color(255, 255, 255))
	else
		draw.SimpleText("0%", "Health", 50, Scrh - 63, Color(255, 255, 255))
	end

	if (LocalPlayer():GetActiveWeapon():IsValid()) then
		local PrimaryAmmo = LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType()
		local PrimaryClip = LocalPlayer():GetActiveWeapon():Clip1()

		local PrimaryAmmoText = LocalPlayer():GetAmmoCount(PrimaryAmmo) .. " "
		local PrimaryClipText = " " .. PrimaryClip .. " / "

		surface.SetFont("Ammo")
		local PrimaryAmmoWidth = surface.GetTextSize(PrimaryAmmoText)

		surface.SetFont("Ammo")
		local PrimaryClipWidth = surface.GetTextSize(PrimaryClipText)

		if (PrimaryClip ~= -1) and (PrimaryAmmo ~= -1) then
			if (PrimaryClip == 0) and (PrimaryAmmo == 0) then
				draw.SimpleTextOutlined(PrimaryClipText, "Ammo", Scrw - (PrimaryAmmoWidth + PrimaryClipWidth + 25), Scrh - 50, Color(255, 0, 0, 255), 35, Scrh - 50, 2, Color(0, 0, 0, 30)) return
			end

			draw.SimpleTextOutlined(PrimaryClipText, "Ammo", Scrw - (PrimaryAmmoWidth + PrimaryClipWidth + 25), Scrh - 50, Color(255, 102, 0, 255), 35, Scrh - 50, 2, Color(0, 0, 0, 30))
			draw.SimpleTextOutlined(PrimaryAmmoText, "Ammo", Scrw - (PrimaryAmmoWidth + 25), Scrh - 50, Color(255, 255, 255, 255), 35, Scrh - 50, 2, Color(0, 0, 0, 30))
		end
	end

	if (LocalPlayer():GetNWString("spectatemode")) then
		draw.SimpleTextOutlined("You are in AFK mode!", "AFKText", Scrw / 2, Scrh / 7, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 30))
		draw.SimpleTextOutlined('Type: "/unafk" in chat', "AFKTextSmall", Scrw / 2, Scrh / 5.5, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 30))
	end

	if (LocalPlayer():GetNWString("AdminMode")) then
		draw.SimpleTextOutlined("You are in Admin Mode!", "AFKText", Scrw / 2, Scrh / 7, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 30))
		draw.SimpleTextOutlined('Type: "/admin" in chat', "AFKTextSmall", Scrw / 2, Scrh / 5.5, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, Color(0, 0, 0, 30))
	end
end)