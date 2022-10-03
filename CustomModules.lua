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

InfiniteJump = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
    ["Name"] = "Infinite Jump",
    ["Function"] = function(callback)
        local InfiniteJumpEnabled = true
        game:GetService("UserInputService").JumpRequest:connect(function()
            if InfiniteJumpEnabled then
                game:GetService "Players".LocalPlayer.Character:FindFirstChildOfClass 'Humanoid':ChangeState("Jumping")
            end
        end)
    end,
    ["HoverText"] = "Makes you infinite jump"
})



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

local function createwarning(title, text, delay)
    local suc, res = pcall(function()
        local frame = GuiLibrary["CreateNotification"](title, text, delay, "assets/WarningNotification.png")
        frame.Frame.Frame.ImageColor3 = Color3.fromRGB(236, 129, 44)
        return frame
    end)
    return (suc and res)
end

	ac = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
		["Name"] = "50%AntiCheatDisabler",
		["Function"] = function(callback)
			if callback then
game:GetService("Players").LocalPlayer.PlayerScripts.Modules.anticheat:Destroy()
wait(0.1)
game:GetService("StarterPlayer").StarterPlayerScripts.Modules.anticheat:Destroy()
wait(0.1)
game:GetService("ReplicatedStorage").Modules.anticheat:Destroy()
wait(3)
createwarning("50%AntiCheatDisabler", "Disabled 50% of the anti cheat.", 3)				

			end
		end,
		["HoverText"] = "Disables 50% of the Anti Cheat."
	})
