include("shared.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

local fol = GM.FolderName  ..  "/gamemode/modules/"
local files, folders = file.Find(fol  ..  "*", "LUA")
local SortedPairs = SortedPairs

local loadedFolders = {}
for _, v in ipairs(files) do
    if string.GetExtensionFromFilename(v) ~= "lua" then continue end
    include(fol  ..  v)
end

for _, folder in SortedPairs(folders, true) do
    if folder == "." or folder == " .. " then continue end
    table.insert(loadedFolders, folder)

    for _, File in SortedPairs(file.Find(fol  ..  folder  ..  "/sh_*.lua", "LUA"), true) do
        AddCSLuaFile(fol  ..  folder  ..  "/"  ..  File)
        include(fol  ..  folder  ..  "/"  ..  File)
    end

    for _, File in SortedPairs(file.Find(fol  ..  folder  ..  "/sv_*.lua", "LUA"), true) do
        include(fol  ..  folder  ..  "/"  ..  File)
    end

    for _, File in SortedPairs(file.Find(fol  ..  folder  ..  "/cl_*.lua", "LUA"), true) do
        AddCSLuaFile(fol  ..  folder  ..  "/"  ..  File)
    end
end

local reallyloadedFolders = "Loaded folders: " .. table.concat(loadedFolders, ", ")
local charCount = string.len(reallyloadedFolders) + 5
hook.Add("PostGamemodeLoaded", "GMLoaded", function()
    print("[" .. string.rep("=", charCount) .. "]")
    print("|| Server has been started!")
    print("|| Server name: " .. GetHostName())
    print("|| Gamemode name: " .. engine.ActiveGamemode())
    print("|| Map name: " .. game.GetMap())
    print("|| Max players: " .. game.MaxPlayers())
    print("|| " .. reallyloadedFolders)
    print("||")
    print("|| CREATED BY DEFAULT")
    print("[" .. string.rep("=", charCount) .. "]")
end)