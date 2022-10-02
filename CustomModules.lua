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




	ac = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
		["Name"] = "50%AntiCheatDisabler",
		["Function"] = function(callback)
			if callback then
local vec3 = Vector3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X + 39, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Y + 12, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z)
local bp = Instance.new('BodyPosition')
bp.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
bp.Position = vec3
wait(1)
bp:remove()
local bv = Instance.new("BodyVelocity")
bv.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
bv.Velocity = Vector3.new(0, -25, 0)
wait(.2)
local bpfwd = Instance.new("BodyPosition")
bpfwd.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
bpfwd.Position = Vector3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X + 74, game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y + 25, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z)
bpfwd.P = 10000
bpfwd.D = 0
wait(.1)
bv:remove()
wait(.4)
bpfwd:remove()

			end
		end,
		["HoverText"] = "Disables 50% of the Anti Cheat."
	})
