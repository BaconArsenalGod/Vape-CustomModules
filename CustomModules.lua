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
		["Name"] = "60%AcDisabler",
		["Function"] = function(callback)
			if callback then
ac["ToggleButton"](false)
createwarning("60%AcDisabler", "Disabling 60% of the anti cheat..", 2)
ac["ToggleButton"](false)
game:GetService("ReplicatedStorage").Modules.anticheat:Destroy()
wait(0.1)
game:GetService("Players").LocalPlayer.PlayerScripts.Modules:Destroy()
wait(0.1)
game:GetService("StarterPlayer").StarterPlayerScripts.Modules:Destroy()
wait(1)
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
createwarning("60%AcDisabler", "Disabled 60% of the anti cheat.", 3)
ac["ToggleButton"](false)
				
			end
		end,
		["HoverText"] = "Disables 60% of the Anti Cheat."
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
							
	btm = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
		["Name"] = "BetterMultiAura",
		["Function"] = function(callback)
			if callback then
    bedwars["PaintRemote"] = getremote(debug.getconstants(KnitClient.Controllers.PaintShotgunController.fire))
     repeat
   task.wait(0.03)
  local plrs = GetAllNearestHumanoidToPosition(18.8)
 for i,plr in pairs(plrs) do
 local selfpos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
 local newpos = plr.Character.HumanoidRootPart.Position
 bedwars["ClientHandler"]:Get(bedwars["PaintRemote"]):SendToServer(selfpos, CFrame.lookAt(selfpos, newpos).lookVector)
  end
until BetterMultiaura["Enabled"] == false
								
			end
		end,
		["HoverText"] = "a Better MultiAura."
	})
