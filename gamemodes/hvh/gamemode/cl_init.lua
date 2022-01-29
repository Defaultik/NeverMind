include("shared.lua")

local root = GM.FolderName .. "/gamemode/modules/"
local _, folders = file.Find(root .. "*", "LUA")

for _, folder in SortedPairs(folders, true) do
    for _, File in SortedPairs(file.Find(root .. folder .. "/sh_*.lua", "LUA"), true) do
    	include(root .. folder .. "/" .. File)
    end

    for _, File in SortedPairs(file.Find(root .. "/sh_*.lua", "LUA"), true) do
    	include(root .. File)
    end

    for _, File in SortedPairs(file.Find(root .. folder .. "/cl_*.lua", "LUA"), true) do
    	include(root .. folder .. "/" .. File)
    end
end

local msg = {
[[=========================================================]],
[[ _   _                          ___  ___ _             _ ]],
[[| \ | |                         |  \/  |(_)           | |]],
[[|  \| |  ___ __   __  ___  _ __ |      | _  _ __    __| |]],
[[| . ` | / _ \\ \ / / / _ \| '__|| |\/| || ||  _ \  / _` |]],
[[| |\  ||  __/ \ V / |  __/| |   | |  | || || | | || (_| |]],
[[\_| \_/ \___|  \_/   \___||_|   \_|  |_/|_||_| |_| \____|]],
[[                                                         ]],
[[The best HvH server in Garry`s Mod                       ]],
[[=========================================================]],
}

for _, v in ipairs(msg) do
	MsgC("\n", Color(255, 80, 0), v)
end