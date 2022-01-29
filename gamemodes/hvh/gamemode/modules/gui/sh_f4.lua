if SERVER then
	function GM:ShowSpare2(ply)
		ply:ConCommand("f4")
	end
end

if CLIENT then
	CreateClientConVar("voice_enable", "true", true, true, "Enable Voice")
	CreateClientConVar("voice_type", "male", true, true, "male / female")

	CreateClientConVar("weapon_primary", "css_ak47", true, true, "Primary Weapon")
	CreateClientConVar("weapon_secondary", "css_glock", true, true, "Secondary Weapon")

	surface.CreateFont("Title", {font = "Roboto", size = 17, weight = 400, antialias = true})
	surface.CreateFont("Main", {font = "Roboto", size = 15, weight = 400, antialias = true})

	function Menu()
		frame = DLib.Frame(-1, -1, 700, 450, "NeverMind Menu")
		function close:DoClick()
	        DLib.Sound("buttons/button15.wav", 0.4)
	        frame:Close()
	    end

		local weaponButton = DLib.Button(frame, 5, 10, 125, 44, 8, "Weapons")
		function weaponButton:DoClick()
			DLib.Sound("buttons/button15.wav", 0.4)
			if IsValid(modelsTab) then modelsTab:Remove() end
			if IsValid(settingsTab) then settingsTab:Remove() end

			weaponTab = vgui.Create("DScrollPanel", frame)
			weaponTab:SetPos(5, frame.headerHeight + 60)
			weaponTab:SetSize(frame:GetWide() - 10, frame:GetTall() - 95)
			function weaponTab:Paint()
				draw.RoundedBox(8, 0, 0, weaponTab:GetWide(), weaponTab:GetTall(), Color(240, 80, 0, 210))
				draw.SimpleText("Primary Weapon", "Title", 5, 5, color_white)
				draw.SimpleText("Secondary Weapon", "Title", 5, 120, color_white)
			end

			DLib.IconLayout(weaponTab, 5, 25, 16, 5)
			for wep, v in SortedPairs(config.AllowedWeapons.primary) do
				local model = iconlayout:Add("SpawnIcon")
				model:SetSize(71, 71)
				model:SetModel(v.mdl)
				model:SetToolTip()
					
				function model:DoClick()
					if (LocalPlayer():GetInfo("weapon_primary") == wep) then
						if (table.HasValue(config.RussianLanguage, system.GetCountry())) then
							chat.AddText(color.orange, "[NeverMind]: ", color_white, "Вы уже используете это оружие!")
						else
							chat.AddText(color.orange, "[NeverMind]: ", color_white, "You already use this weapon!")
						end
						return
					end

					if (table.HasValue(config.RussianLanguage, system.GetCountry())) then
						chat.AddText(color.orange, "[NeverMind]: ", color_white, "Вы успешно сменили основное оружие на ", color.orange, wep, color_white, "!", color.orange, "\nОРУЖИЕ СМЕНИТСЯ ПОСЛЕ СМЕРТИ")
					else
						chat.AddText(color.orange, "[NeverMind]: ", color_white, "You have successfully changed your primary weapon to ", color.orange, wep, color_white, "!", color.orange, "\nWEAPON WILL CHANGE AFTER DEATH")
					end

					GetConVar("weapon_primary"):SetString(wep)
					frame:Close()
				end

				function model:Paint(w, h)
					draw.RoundedBox(8, 0, 0, w, h, color.orange)
					draw.SimpleText(v.name, "Main", w / 2, h - 5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
				end
				
				function model:PaintOver(w, h) end
			end

			DLib.IconLayout(weaponTab, 5, 140, 16, 5)
			for wep, v in SortedPairs(config.AllowedWeapons.secondary) do
				local model = iconlayout:Add("SpawnIcon")
				model:SetSize(71, 71)
				model:SetModel(v.mdl)
				model:SetToolTip()
					
				function model:DoClick()
					if (LocalPlayer():GetInfo("weapon_secondary") == wep) then
						if (table.HasValue(config.RussianLanguage, system.GetCountry())) then
							chat.AddText(color.orange, "[NeverMind]: ", color_white, "Вы уже используете это оружие!")
						else
							chat.AddText(color.orange, "[NeverMind]: ", color_white, "You already use this weapon!")
						end
						return
					end

					if (table.HasValue(config.RussianLanguage, system.GetCountry())) then
						chat.AddText(color.orange, "[NeverMind]: ", color_white, "Вы успешно сменили второстепенное оружие на ", color.orange, wep, color_white, "!", color.orange, "\nОРУЖИЕ СМЕНИТСЯ ПОСЛЕ СМЕРТИ")
					else
						chat.AddText(color.orange, "[NeverMind]: ", color_white, "You have successfully changed your secondary weapon to ", color.orange, wep, color_white, "!", color.orange, "\nWEAPON WILL CHANGE AFTER DEATH")
					end

					GetConVar("weapon_secondary"):SetString(wep)
					frame:Close()
				end

				function model:Paint(w, h)
					draw.RoundedBox(8, 0, 0, w, h, color.orange)
					draw.SimpleText(v.name, "Main", w / 2, h - 5, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
				end

				function model:PaintOver(w, h) end
			end
		end

		local modelsButton = DLib.Button(frame, 140, 10, 125, 44, 8, "Models")
		function modelsButton:DoClick()
			DLib.Sound("buttons/button15.wav", 0.4)
			if IsValid(weaponTab) then weaponTab:Remove() end
			if IsValid(settingsTab) then settingsTab:Remove() end

			modelsTab = vgui.Create("DScrollPanel", frame)
			modelsTab:SetPos(5, frame.headerHeight + 60)
			modelsTab:SetSize(frame:GetWide() - 10, frame:GetTall() - 95)
			function modelsTab:Paint()
				draw.RoundedBox(8, 0, 0, modelsTab:GetWide(), modelsTab:GetTall(), Color(240, 80, 0, 210))
			end
		end

		local settingsButton = DLib.Button(frame, 275, 10, 125, 44, 8, "Settings")
		function settingsButton:DoClick()
			DLib.Sound("buttons/button15.wav", 0.4)
			if IsValid(weaponTab) then weaponTab:Remove() end
			if IsValid(modelsTab) then modelsTab:Remove() end

			settingsTab = vgui.Create("DScrollPanel", frame)
			settingsTab:SetPos(5, frame.headerHeight + 60)
			settingsTab:SetSize(frame:GetWide() - 10, frame:GetTall() - 95)
			function settingsTab:Paint()
				draw.RoundedBox(8, 0, 0, settingsTab:GetWide(), settingsTab:GetTall(), Color(240, 80, 0, 210))
				draw.SimpleText("Voice Sounds (male/female)", "Title", 5, 10, color_white)
			end

			DLib.CheckBox(settingsTab, 10, 2, "voice_enable")
			DLib.Switch(settingsTab, 40, 4, "voice_type")
		end
	end
	concommand.Add("f4", Menu)
end