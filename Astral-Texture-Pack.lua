repeat
    task.wait()
until game:IsLoaded()
repeat
    task.wait()
until shared.GuiLibrary
local GuiLibrary = shared.GuiLibrary
local ScriptSettings = {}
local UIS = game:GetService("UserInputService")
local COB = function(tab, argstable)

end

txtr = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
    ["Name"] = "txtr",
    ["Function"] = function(callback)
loadstring(game:HttpGet("https://raw.githubusercontent.com/NEMOEXEYT/Vape-CustomModules/main/Astral-Minecraft-TexturePack", true))()
    ["HoverText"] = "Loads da texturepack"
})
