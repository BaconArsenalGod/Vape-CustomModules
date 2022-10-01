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






acdis2 = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
    ["Name"] = "AcDis2",
    ["Function"] = function(callback)
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
        end)
    end,
    ["HoverText"] = "Disables 50% of the anti cheat"
})
