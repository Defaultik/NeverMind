hook.Add("Think", "CheckPing", function()
	if (LocalPlayer():Ping() > 185) then
		chat.AddText(Color(255, 100, 0), "> ", color_white, "You have unstable connetction on internet! It can cause problems in your game!")
	end
end)