surface.CreateFont("Title", {font = "Roboto", size = 17, weight = 400, antialias = true})
surface.CreateFont("Main", {font = "Roboto", size = 15, weight = 400, antialias = true})

hook.Add("OnContextMenuOpen", "Context", function()
	frame = DLib.Frame(35, ScrH() / 2, 280, 350, "Context Menu")

	local weaponButton = DLib.Button(frame, 5, 10, frame:GetWide() - 10, 28, DLib.RoundingPower, "Weapons")
	function weaponButton:DoClick()
		weaponPanel = DLib.Panel(nil, -1, -1, 600, 350, "Weapons")
		DLib.Sound("buttons/button9.wav", 0.4)

		weaponTab = vgui.Create("DScrollPanel", weaponPanel)
		weaponTab:SetPos(5, weaponPanel.headerHeight + 10)
		weaponTab:SetSize(weaponPanel:GetWide() - 10, weaponPanel:GetTall() - 50)
		function weaponTab:Paint()
			draw.RoundedBox(8, 0, 0, weaponTab:GetWide(), weaponTab:GetTall(), Color(240, 80, 0, 210))
			draw.SimpleText("Primary Weapon", "Title", 5, 5, color.white)
			draw.SimpleText("Secondary Weapon", "Title", 5, 180, color.white)
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
						chat.AddText(color.orange, "[NeverMind]: ", color.white, "Вы уже используете это оружие!")
					else
						chat.AddText(color.orange, "[NeverMind]: ", color.white, "You already use this weapon!")
					end
					return
				end

				if (table.HasValue(config.RussianLanguage, system.GetCountry())) then
					chat.AddText(color.orange, "[NeverMind]: ", color.white, "Вы успешно сменили основное оружие на ", color.orange, wep, color.white, "!", color.orange, "\nОРУЖИЕ СМЕНИТСЯ ПОСЛЕ СМЕРТИ")
				else
					chat.AddText(color.orange, "[NeverMind]: ", color.white, "You have successfully changed your primary weapon to ", color.orange, wep, color.white, "!", color.orange, "\nWEAPON WILL CHANGE AFTER DEATH")
				end

				GetConVar("weapon_primary"):SetString(wep)
				weaponPanel:Close()
			end

			function model:Paint(w, h)
				draw.RoundedBox(8, 0, 0, w, h, color.orange)
				draw.SimpleText(v.name, "Main", w / 2, h - 5, color.white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
			end
				
			function model:PaintOver(w, h) end
		end

		DLib.IconLayout(weaponTab, 5, 200, 16, 5)
		for wep, v in SortedPairs(config.AllowedWeapons.secondary) do
			local model = iconlayout:Add("SpawnIcon")
			model:SetSize(71, 71)
			model:SetModel(v.mdl)
			model:SetToolTip()
					
			function model:DoClick()
				if (LocalPlayer():GetInfo("weapon_secondary") == wep) then
					if (table.HasValue(config.RussianLanguage, system.GetCountry())) then
						chat.AddText(color.orange, "[NeverMind]: ", color.white, "Вы уже используете это оружие!")
					else
						chat.AddText(color.orange, "[NeverMind]: ", color.white, "You already use this weapon!")
					end
					return
				end

				if (table.HasValue(config.RussianLanguage, system.GetCountry())) then
					chat.AddText(color.orange, "[NeverMind]: ", color.white, "Вы успешно сменили второстепенное оружие на ", color.orange, wep, color.white, "!", color.orange, "\nОРУЖИЕ СМЕНИТСЯ ПОСЛЕ СМЕРТИ")
				else
					chat.AddText(color.orange, "[NeverMind]: ", color.white, "You have successfully changed your secondary weapon to ", color.orange, wep, color.white, "!", color.orange, "\nWEAPON WILL CHANGE AFTER DEATH")
				end

				GetConVar("weapon_secondary"):SetString(wep)
				weaponPanel:Close()
			end

			function model:Paint(w, h)
				draw.RoundedBox(8, 0, 0, w, h, color.orange)
				draw.SimpleText(v.name, "Main", w / 2, h - 5, color.white, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
			end

			function model:PaintOver(w, h) end
		end
	end

	local settingsButton = DLib.Button(frame, 5, weaponButton:GetY() + 5, frame:GetWide() - 10, 28, DLib.RoundingPower, "Settings")
	function settingsButton:DoClick()
		settingsPanel = DLib.Panel(nil, -1, -1, 600, 350, "Settings")
		DLib.Sound("buttons/button9.wav", 0.4)

		DLib.CheckBox(settingsPanel, 10, 10, "Thirdperson")
	end

	local spectatorButton = DLib.Button(frame, 5, settingsButton:GetY() + 5, frame:GetWide() - 10, 28, DLib.RoundingPower, "Spectator Mode")
	function spectatorButton:DoClick()
		LocalPlayer():ConCommand("spectate")
	end
end)

hook.Add("OnContextMenuClose", "Context", function()
	if (frame) then
		frame:Remove()
	end

	if (weaponPanel) then
		weaponPanel:Remove()
	end

	if (settingsPanel) then
		settingsPanel:Remove()
	end
end)