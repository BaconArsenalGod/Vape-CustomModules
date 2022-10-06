opkillaura = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
    ["Name"] = "opkillaura",
    ["Function"] = function(callback)
        if callback then
            if killauraaimcirclepart then 
                killauraaimcirclepart.Parent = cam
            end
            if killaurarangecirclepart then 
                killaurarangecirclepart.Parent = cam
            end
            task.spawn(function()
                repeat
                    task.wait()
                    if (killauraanimation["Enabled"] and not killauraswing["Enabled"]) then
                        if killauranear then
                            pcall(function()
                                if origC0 == nil then
                                    origC0 = cam.Viewmodel.RightHand.RightWrist.C0
                                end
                                if killauraplaying == false then
                                    killauraplaying = true
                                    for i,v in pairs(anims[killauraanimmethod["Value"]]) do 
                                        if (not Killaura["Enabled"]) or (not killauranear) then break end
                                        killauracurrentanim = game:GetService("TweenService"):Create(cam.Viewmodel.RightHand.RightWrist, TweenInfo.new(v.Time), {C0 = origC0 * v.CFrame})
                                        killauracurrentanim:Play()
                                        task.wait(v.Time - 0.01)
                                    end
                                    killauraplaying = false
                                end
                            end)	
                        end
                    end
                until Killaura["Enabled"] == false
            end)
            oldplay = bedwars["ViewmodelController"]["playAnimation"]
            oldsound = bedwars["SoundManager"]["playSound"]
            bedwars["SoundManager"]["playSound"] = function(tab, soundid, ...)
                if (soundid == bedwars["SoundList"].SWORD_SWING_1 or soundid == bedwars["SoundList"].SWORD_SWING_2) and Killaura["Enabled"] and killaurasound["Enabled"] and killauranear then
                    return nil
                end
                return oldsound(tab, soundid, ...)
            end
            bedwars["ViewmodelController"]["playAnimation"] = function(Self, id, ...)
                if id == 15 and killauranear and killauraswing["Enabled"] and entity.isAlive then
                    return nil
                end
                if id == 15 and killauranear and killauraanimation["Enabled"] and entity.isAlive then
                    return nil
                end
                return oldplay(Self, id, ...)
            end
            local targetedplayer
            RunLoops:BindToHeartbeat("Killaura", 1, function()
                for i,v in pairs(killauraboxes) do 
                    if v:IsA("BoxHandleAdornment") and v.Adornee then
                        local cf = v.Adornee and v.Adornee.CFrame
                        local onex, oney, onez = cf:ToEulerAnglesXYZ() 
                        v.CFrame = CFrame.new() * CFrame.Angles(-onex, -oney, -onez)
                    end
                end
                if entity.isAlive then
                    if killauraaimcirclepart then 
                        killauraaimcirclepart.Position = targetedplayer and closestpos(targetedplayer.RootPart, entity.character.HumanoidRootPart.Position) or Vector3.zero
                    end
                    local Root = entity.character.HumanoidRootPart
                    if Root then
                        if killaurarangecirclepart then 
                            killaurarangecirclepart.Position = Root.Position - Vector3.new(0, entity.character.Humanoid.HipHeight, 0)
                        end
                        local Neck = entity.character.Head:FindFirstChild("Neck")
                        local LowerTorso = Root.Parent and Root.Parent:FindFirstChild("LowerTorso")
                        local RootC0 = LowerTorso and LowerTorso:FindFirstChild("Root")
                        if Neck and RootC0 then
                            if orig == nil then
                                orig = Neck.C0.p
                            end
                            if orig2 == nil then
                                orig2 = RootC0.C0.p
                            end
                            if orig2 and killauracframe["Enabled"] then
                                if targetedplayer ~= nil then
                                    local targetPos = targetedplayer.RootPart.Position + Vector3.new(0, 2, 0)
                                    local direction = (Vector3.new(targetPos.X, targetPos.Y, targetPos.Z) - entity.character.Head.Position).Unit
                                    local direction2 = (Vector3.new(targetPos.X, Root.Position.Y, targetPos.Z) - Root.Position).Unit
                                    local lookCFrame = (CFrame.new(Vector3.zero, (Root.CFrame):VectorToObjectSpace(direction)))
                                    local lookCFrame2 = (CFrame.new(Vector3.zero, (Root.CFrame):VectorToObjectSpace(direction2)))
                                    Neck.C0 = CFrame.new(orig) * CFrame.Angles(lookCFrame.LookVector.Unit.y, 0, 0)
                                    RootC0.C0 = lookCFrame2 + orig2
                                else
                                    Neck.C0 = CFrame.new(orig)
                                    RootC0.C0 = CFrame.new(orig2)
                                end
                            end
                        end
                    end
                end
            end)
            task.spawn(function()
                repeat
                    task.wait(0.03)
                    if (GuiLibrary["ObjectsThatCanBeSaved"]["Lobby CheckToggle"]["Api"]["Enabled"] == false or matchState ~= 0) and Killaura["Enabled"] then
                        targettable = {}
                        targetsize = 0
                        local plrs = GetAllNearestHumanoidToPosition(killauratargetframe["Players"]["Enabled"], killaurarange["Value"] - 0.0001, 1, false, (oldcloneroot and oldcloneroot.Position or localserverpos), killaurasortmethods[killaurasortmethod["Value"]])
                        local attackedplayers = {}
                        local firstplayercodedone = {done = false}
                        for i,plr in pairs(plrs) do
                            targettable[plr.Player.Name] = {
                                ["UserId"] = plr.Player.UserId,
                                ["Health"] = (plr.Humanoid and plr.Humanoid.Health or 10) + getShield(plr.Character),
                                ["MaxHealth"] = (plr.Humanoid and plr.Humanoid.MaxHealth or 10)
                            }
                            targetsize = targetsize + 1
                            task.spawn(newAttackEntity, plr, firstplayercodedone, attackedplayers)
                            if firstplayercodedone.done then
                                targetedplayer = plr
                            end
                        end
                        for i,v in pairs(killauraboxes) do 
                            local attacked = attackedplayers[i]
                            v.Adornee = attacked and ((not killauratargethighlight["Enabled"]) and attacked.RootPart or (not GuiLibrary["ObjectsThatCanBeSaved"]["ChamsOptionsButton"]["Api"]["Enabled"]) and attacked.Character or nil)
                        end
                        if (#plrs <= 0) then
                            lastplr = nil
                            targetedplayer = nil
                            killauranear = false
                            pcall(function()
                                if origC0 == nil then
                                    origC0 = cam.Viewmodel.RightHand.RightWrist.C0
                                end
                                if cam.Viewmodel.RightHand.RightWrist.C0 ~= origC0 then
                                    pcall(function()
                                        killauracurrentanim:Cancel()
                                    end)
                                    killauracurrentanim = game:GetService("TweenService"):Create(cam.Viewmodel.RightHand.RightWrist, TweenInfo.new(0.1), {C0 = origC0})
                                    killauracurrentanim:Play()
                                end
                            end)
                        end
                        targetinfo.UpdateInfo(targettable, targetsize)
                    end
                until Killaura["Enabled"] == false
            end)
        else
            RunLoops:UnbindFromHeartbeat("Killaura") 
            killauranear = false
            for i,v in pairs(killauraboxes) do 
                v.Adornee = nil
            end
            if killauraaimcirclepart then 
                killauraaimcirclepart.Parent = nil
            end
            if killaurarangecirclepart then 
                killaurarangecirclepart.Parent = nil
            end
            bedwars["ViewmodelController"]["playAnimation"] = oldplay
            bedwars["SoundManager"]["playSound"] = oldsound
            oldplay = nil
            targetinfo.UpdateInfo({}, 0)
            pcall(function()
                if entity.isAlive then
                    local Root = entity.character.HumanoidRootPart
                    if Root then
                        local Neck = Root.Parent.Head.Neck
                        if orig and orig2 then 
                            Neck.C0 = CFrame.new(orig)
                            Root.Parent.LowerTorso.Root.C0 = CFrame.new(orig2)
                        end
                    end
                end
                if origC0 == nil then
                    origC0 = cam.Viewmodel.RightHand.RightWrist.C0
                end
                if cam.Viewmodel.RightHand.RightWrist.C0 ~= origC0 then
                    pcall(function()
                        killauracurrentanim:Cancel()
                    end)
                    killauracurrentanim = game:GetService("TweenService"):Create(cam.Viewmodel.RightHand.RightWrist, TweenInfo.new(0.1), {C0 = origC0})
                    killauracurrentanim:Play()
                end
            end)
        end
    end,
    ["HoverText"] = "Attack players around you\nwithout aiming at them."
})
killauratargetframe = Killaura.CreateTargetWindow({})
local sortmethods = {"Distance"}
for i,v in pairs(killaurasortmethods) do if i ~= "Distance" then table.insert(sortmethods, i) end end
killaurasortmethod = Killaura.CreateDropdown({
    ["Name"] = "Sort",
    ["Function"] = function() end,
    ["List"] = sortmethods
})
killaurarange = Killaura.CreateSlider({
    ["Name"] = "RAKE CLIENT RANGE",
    ["Min"] = 1,
    ["Max"] = 200,
    ["Function"] = function(val) 
        if killaurarangecirclepart then 
            killaurarangecirclepart.Size = Vector3.new(val * 0.7, 0.01, val * 0.7)
        end
    end, 
    ["Default"] = 200
})
killauraangle = Killaura.CreateSlider({
    ["Name"] = "RAKE CLIENT RANGE",
    ["Min"] = 1,
    ["Max"] = 600,
    ["Function"] = function(val) end,
    ["Default"] = 600
})
--[[  killauratargets = Killaura.CreateSlider({
    ["Name"] = "Max targets",
    ["Min"] = 1,
    ["Max"] = 10,
    ["Function"] = function(val) end,
    ["Default"] = 10
})]]
killauraanimmethod = Killaura.CreateDropdown({
    ["Name"] = "Animation", 
    ["List"] = {"Normal", "Slow", "New", "Vertical Spin", "Exhibition", "Exhibition Old"},
    ["Function"] = function(val) end
})
killauramouse = Killaura.CreateToggle({
    ["Name"] = "Require mouse down",
    ["Function"] = function() end,
    ["HoverText"] = "Only attacks when left click is held.",
    ["Default"] = false
})
killauragui = Killaura.CreateToggle({
    ["Name"] = "GUI Check",
    ["Function"] = function() end,
    ["HoverText"] = "Attacks when you are not in a GUI."
})
killauratarget = Killaura.CreateToggle({
    ["Name"] = "Show target",
    ["Function"] = function(callback) 
        if killauratargethighlight["Object"] then 
            killauratargethighlight["Object"].Visible = callback
        end
    end,
    ["HoverText"] = "Shows a red box over the opponent."
})
killauratargethighlight = Killaura.CreateToggle({
    ["Name"] = "Use New Highlight",
    ["Function"] = function(callback) 
        for i,v in pairs(killauraboxes) do 
            v:Remove()
        end
        for i = 1, 10 do 
            local killaurabox
            if callback then 
                killaurabox = Instance.new("Highlight")
                killaurabox.FillTransparency = 0.5
                killaurabox.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                killaurabox.OutlineTransparency = 1
                killaurabox.Parent = GuiLibrary["MainGui"]
            else
                killaurabox = Instance.new("BoxHandleAdornment")
                killaurabox.Transparency = 0.5
                killaurabox.Color3 = Color3.fromHSV(killauracolor["Hue"], killauracolor["Sat"], killauracolor["Value"])
                killaurabox.Adornee = nil
                killaurabox.AlwaysOnTop = true
                killaurabox.Size = Vector3.new(3, 6, 3)
                killaurabox.ZIndex = 11
                killaurabox.Parent = GuiLibrary["MainGui"]
            end
            killauraboxes[i] = killaurabox
        end
    end
})
killauratargethighlight["Object"].BorderSizePixel = 0
killauratargethighlight["Object"].BackgroundTransparency = 0
killauratargethighlight["Object"].BackgroundColor3 = Color3.fromRGB(15, 15, 15)
killauratargethighlight["Object"].Visible = false
killauracolor = Killaura.CreateColorSlider({
    ["Name"] = "Target Color",
    ["Function"] = function(hue, sat, val) 
        for i,v in pairs(killauraboxes) do 
            v[(killauratargethighlight["Enabled"] and "FillColor" or "Color3")] = Color3.fromHSV(hue, sat, val)
        end
        if killauraaimcirclepart then 
            killauraaimcirclepart.Color = Color3.fromHSV(hue, sat, val)
        end
        if killaurarangecirclepart then 
            killaurarangecirclepart.Color = Color3.fromHSV(hue, sat, val)
        end
    end,
    ["Default"] = 1
})
for i = 1, 10 do 
    local killaurabox = Instance.new("BoxHandleAdornment")
    killaurabox.Transparency = 0.5
    killaurabox.Color3 = Color3.fromHSV(killauracolor["Hue"], killauracolor["Sat"], killauracolor["Value"])
    killaurabox.Adornee = nil
    killaurabox.AlwaysOnTop = true
    killaurabox.Size = Vector3.new(3, 6, 3)
    killaurabox.ZIndex = 11
    killaurabox.Parent = GuiLibrary["MainGui"]
    killauraboxes[i] = killaurabox
end
killauracframe = Killaura.CreateToggle({
    ["Name"] = "Face target",
    ["Function"] = function() end,
    ["HoverText"] = "Makes your character face the opponent."
})
killaurarangecircle = Killaura.CreateToggle({
    ["Name"] = "Range Visualizer",
    ["Function"] = function(callback)
        if callback then 
            killaurarangecirclepart = Instance.new("MeshPart")
            killaurarangecirclepart.MeshId = "rbxassetid://3726303797"
            killaurarangecirclepart.Color = Color3.fromHSV(killauracolor["Hue"], killauracolor["Sat"], killauracolor["Value"])
            killaurarangecirclepart.CanCollide = false
            killaurarangecirclepart.Anchored = true
            killaurarangecirclepart.Material = Enum.Material.Neon
            killaurarangecirclepart.Size = Vector3.new(killaurarange["Value"] * 0.7, 0.01, killaurarange["Value"] * 0.7)
            killaurarangecirclepart.Parent = cam
            bedwars["QueryUtil"]:setQueryIgnored(killaurarangecirclepart, true)
        else
            if killaurarangecirclepart then 
                killaurarangecirclepart:Destroy()
                killaurarangecirclepart = nil
            end
        end
    end
})
killauraaimcircle = Killaura.CreateToggle({
    ["Name"] = "Aim Visualizer",
    ["Function"] = function(callback)
        if callback then 
            killauraaimcirclepart = Instance.new("Part")
            killauraaimcirclepart.Shape = Enum.PartType.Ball
            killauraaimcirclepart.Color = Color3.fromHSV(killauracolor["Hue"], killauracolor["Sat"], killauracolor["Value"])
            killauraaimcirclepart.CanCollide = false
            killauraaimcirclepart.Anchored = true
            killauraaimcirclepart.Material = Enum.Material.Neon
            killauraaimcirclepart.Size = Vector3.new(0.5, 0.5, 0.5)
            killauraaimcirclepart.Parent = cam
        else
            if killauraaimcirclepart then 
                killauraaimcirclepart:Destroy()
                killauraaimcirclepart = nil
            end
        end
    end
})
killaurasound = Killaura.CreateToggle({
    ["Name"] = "No Swing Sound",
    ["Function"] = function() end,
    ["HoverText"] = "Removes the swinging sound."
})
killauraswing = Killaura.CreateToggle({
    ["Name"] = "No Swing",
    ["Function"] = function() end,
    ["HoverText"] = "Removes the swinging animation."
})
killaurahandcheck = Killaura.CreateToggle({
    ["Name"] = "Limit to items",
    ["Function"] = function() end,
    ["HoverText"] = "Only attacks when your sword is held."
})
killaurabaguette = Killaura.CreateToggle({
    ["Name"] = "Baguette Aura",
    ["Function"] = function() end,
    ["HoverText"] = "Uses the baguette instead of the sword."
})
killauraanimation = Killaura.CreateToggle({
    ["Name"] = "Custom Animation",
    ["Function"] = function() end,
    ["HoverText"] = "Uses a custom animation for swinging"
})
if WhitelistFunctions:CheckPlayerType(lplr) ~= "DEFAULT" then
    killauranovape = Killaura.CreateToggle({
        ["Name"] = "No Vape",
        ["Function"] = function() end,
        ["HoverText"] = "no hit vape user"
    })
end
end)
