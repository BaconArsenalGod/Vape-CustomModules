loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main//CustomModules/6872274481.lua",true))()


game:GetService("StarterGui"):SetCore('ChatWindowPosition', UDim2.new(0.0, 0, 0.0, 700))

local GuiLibrary = shared.GuiLibrary
local players = game:GetService("Players")
local textservice = game:GetService("TextService")
local repstorage = game:GetService("ReplicatedStorage")
local lplr = players.LocalPlayer
local lighting = game:GetService("Lighting")
local cam = workspace.CurrentCamera
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
	cam = (workspace.CurrentCamera or workspace:FindFirstChild("Camera") or Instance.new("Camera"))
end)
local targetinfo = shared.VapeTargetInfo
local collectionservice = game:GetService("CollectionService")
local uis = game:GetService("UserInputService")
local mouse = lplr:GetMouse()
local bedwars = {}
local bedwarsblocks = {}
local blockraycast = RaycastParams.new()
blockraycast.FilterType = Enum.RaycastFilterType.Whitelist
local getfunctions
local oldchar
local oldcloneroot
local matchState = 0
local kit = ""
local antivoidypos = 0
local kills = 0
local beds = 0
local lagbacks = 0
local otherlagbacks = 0
local matchstatetick = 0
local lagbackevent = Instance.new("BindableEvent")
local reported = 0
local allowspeed = true
local antivoiding = false
local bettergetfocus = function()
	if KRNL_LOADED then 
		return ((game:GetService("Players").LocalPlayer.PlayerGui.Chat.Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar:IsFocused() or searchbar:IsFocused()) and true or nil) 
	else
		return game:GetService("UserInputService"):GetFocusedTextBox()
	end
end
local betterisfile = function(file)
	local suc, res = pcall(function() return readfile(file) end)
	return suc and res ~= nil
end
local requestfunc = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or request or function(tab)
	if tab.Method == "GET" then
		return {
			Body = game:HttpGet(tab.Url, true),
			Headers = {},
			StatusCode = 200
		}
	else
		return {
			Body = "bad exploit",
			Headers = {},
			StatusCode = 404
		}
	end
end 
local queueteleport = syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport or function() end
local teleportfunc
local getasset = getsynasset or getcustomasset or function(location) return "rbxasset://"..location end
local storedshahashes = {}
local oldshoot
local chatconnection
local blocktable
local inventories = {}
local currentinventory = {
	["inventory"] = {
		["items"] = {},
		["armor"] = {},
		["hand"] = nil
	}
}
local Hitboxes = {["Enabled"] = false}
local Reach = {["Enabled"] = false}
local Killaura = {["Enabled"] = false}
local flyspeed = {["Value"] = 40}
local nobob = {["Enabled"] = false}
local AnticheatBypass = {["Enabled"] = false}
local AnticheatBypassCombatCheck = {["Enabled"] = false}
local combatcheck = false
local combatchecktick = tick()
local disabletpcheck = false
local queueType = "bedwars_test"
local FastConsume = {["Enabled"] = false}
local chatconnection2
local oldchanneltab
local oldchannelfunc
local oldchanneltabs = {}
local connectionstodisconnect = {}
local anticheatfunny = false
local anticheatfunnyyes = false
local tpstring
local networkownertick = tick()
local networkownerfunc = isnetworkowner or function(part)
	if gethiddenproperty(part, "NetworkOwnershipRule") == Enum.NetworkOwnership.Manual then 
		sethiddenproperty(part, "NetworkOwnershipRule", Enum.NetworkOwnership.Automatic)
		networkownertick = tick() + 8
	end
	return networkownertick <= tick()
end
local uninjectflag = false
local vec3 = Vector3.new
local cfnew = CFrame.new
local clients = {
	ChatStrings1 = {
		["KVOP25KYFPPP4"] = "vape",
		["IO12GP56P4LGR"] = "future",
		["RQYBPTYNURYZC"] = "rektsky"
	},
	ChatStrings2 = {
		["vape"] = "KVOP25KYFPPP4",
		["future"] = "IO12GP56P4LGR",
		["rektsky"] = "RQYBPTYNURYZC"
	},
	ClientUsers = {}
}
local function GetURL(scripturl)
	if shared.VapeDeveloper then
		return readfile("vape/"..scripturl)
	else
		return game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/"..scripturl, true)
	end
end
local entity = shared.vapeentity
local WhitelistFunctions = shared.vapewhitelist
local AnticheatBypassNumbers = {
	TPSpeed = 0.1,
	TPCombat = 0.3,
	TPLerp = 0.39,
	TPCheck = 15
}

local RunLoops = {RenderStepTable = {}, StepTable = {}, HeartTable = {}}
do
	function RunLoops:BindToRenderStep(name, num, func)
		if RunLoops.RenderStepTable[name] == nil then
			RunLoops.RenderStepTable[name] = game:GetService("RunService").RenderStepped:Connect(func)
		end
	end

	function RunLoops:UnbindFromRenderStep(name)
		if RunLoops.RenderStepTable[name] then
			RunLoops.RenderStepTable[name]:Disconnect()
			RunLoops.RenderStepTable[name] = nil
		end
	end

	function RunLoops:BindToStepped(name, num, func)
		if RunLoops.StepTable[name] == nil then
			RunLoops.StepTable[name] = game:GetService("RunService").Stepped:Connect(func)
		end
	end

	function RunLoops:UnbindFromStepped(name)
		if RunLoops.StepTable[name] then
			RunLoops.StepTable[name]:Disconnect()
			RunLoops.StepTable[name] = nil
		end
	end

	function RunLoops:BindToHeartbeat(name, num, func)
		if RunLoops.HeartTable[name] == nil then
			RunLoops.HeartTable[name] = game:GetService("RunService").Heartbeat:Connect(func)
		end
	end

	function RunLoops:UnbindFromHeartbeat(name)
		if RunLoops.HeartTable[name] then
			RunLoops.HeartTable[name]:Disconnect()
			RunLoops.HeartTable[name] = nil
		end
	end
end

--skidded off the devforum because I hate projectile math
-- Compute 2D launch angle
-- v: launch velocity
-- g: gravity (positive) e.g. 196.2
-- d: horizontal distance
-- h: vertical distance
-- higherArc: if true, use the higher arc. If false, use the lower arc.
local function LaunchAngle(v: number, g: number, d: number, h: number, higherArc: boolean)
	local v2 = v * v
	local v4 = v2 * v2
	local root = math.sqrt(v4 - g*(g*d*d + 2*h*v2))
	if not higherArc then root = -root end
	return math.atan((v2 + root) / (g * d))
end

-- Compute 3D launch direction from
-- start: start position
-- target: target position
-- v: launch velocity
-- g: gravity (positive) e.g. 196.2
-- higherArc: if true, use the higher arc. If false, use the lower arc.
local function LaunchDirection(start, target, v, g, higherArc: boolean)
	-- get the direction flattened:
	local horizontal = vec3(target.X - start.X, 0, target.Z - start.Z)
	
	local h = target.Y - start.Y
	local d = horizontal.Magnitude
	local a = LaunchAngle(v, g, d, h, higherArc)
	
	-- NaN ~= NaN, computation couldn't be done (e.g. because it's too far to launch)
	if a ~= a then return nil end
	
	-- speed if we were just launching at a flat angle:
	local vec = horizontal.Unit * v
	
	-- rotate around the axis perpendicular to that direction...
	local rotAxis = vec3(-horizontal.Z, 0, horizontal.X)
	
	-- ...by the angle amount
	return CFrame.fromAxisAngle(rotAxis, a) * vec
end

local function FindLeadShot(targetPosition: Vector3, targetVelocity: Vector3, projectileSpeed: Number, shooterPosition: Vector3, shooterVelocity: Vector3, gravity: Number)
	local distance = (targetPosition - shooterPosition).Magnitude

	local p = targetPosition - shooterPosition
	local v = targetVelocity - shooterVelocity
	local a = Vector3.zero

	local timeTaken = (distance / projectileSpeed)
	
	if gravity > 0 then
		local timeTaken = projectileSpeed/gravity+math.sqrt(2*distance/gravity+projectileSpeed^2/gravity^2)
	end

	local goalX = targetPosition.X + v.X*timeTaken + 0.5 * a.X * timeTaken^2
	local goalY = targetPosition.Y + v.Y*timeTaken + 0.5 * a.Y * timeTaken^2
	local goalZ = targetPosition.Z + v.Z*timeTaken + 0.5 * a.Z * timeTaken^2
	
	return vec3(goalX, goalY, goalZ)
end

local function addvectortocframe(cframe, vec)
	local x, y, z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = cframe:GetComponents()
	return cfnew(x + vec.X, y + vec.Y, z + vec.Z, R00, R01, R02, R10, R11, R12, R20, R21, R22)
end

local function addvectortocframe2(cframe, newylevel)
	local x, y, z, R00, R01, R02, R10, R11, R12, R20, R21, R22 = cframe:GetComponents()
	return cfnew(x, newylevel, z, R00, R01, R02, R10, R11, R12, R20, R21, R22)
end

local function runcode(func)
	func()
end

runcode(function()
	local textlabel = Instance.new("TextLabel")
	textlabel.Size = UDim2.new(1, 0, 0, 36)
	textlabel.Text = "Moderators can ban you at any time, Always use alts."
	textlabel.BackgroundTransparency = 1
	textlabel.ZIndex = 10
	textlabel.TextStrokeTransparency = 0
	textlabel.TextScaled = true
	textlabel.Font = Enum.Font.SourceSans
	textlabel.TextColor3 = Color3.new(1, 1, 1)
	textlabel.Position = UDim2.new(0, 0, 0, -36)
	textlabel.Parent = GuiLibrary["MainGui"].ScaledGui.ClickGui
	task.spawn(function()
		repeat task.wait() until matchState ~= 0
		textlabel:Remove()
	end)
end)

local cachedassets = {}
local function getcustomassetfunc(path)
	if not betterisfile(path) then
		task.spawn(function()
			local textlabel = Instance.new("TextLabel")
			textlabel.Size = UDim2.new(1, 0, 0, 36)
			textlabel.Text = "Downloading "..path
			textlabel.BackgroundTransparency = 1
			textlabel.TextStrokeTransparency = 0
			textlabel.TextSize = 30
			textlabel.Font = Enum.Font.SourceSans
			textlabel.TextColor3 = Color3.new(1, 1, 1)
			textlabel.Position = UDim2.new(0, 0, 0, -36)
			textlabel.Parent = GuiLibrary["MainGui"]
			repeat task.wait() until betterisfile(path)
			textlabel:Remove()
		end)
		local req = requestfunc({
			Url = "https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/"..path:gsub("vape/assets", "assets"),
			Method = "GET"
		})
		writefile(path, req.Body)
	end
	if cachedassets[path] == nil then
		cachedassets[path] = getasset(path) 
	end
	return cachedassets[path]
end

local function CreateAutoHotbarGUI(children2, argstable)
	local buttonapi = {}
	buttonapi["Hotbars"] = {}
	buttonapi["CurrentlySelected"] = 1
	local currentanim
	local amount = #children2:GetChildren()
	local sortableitems = {
		{itemType = "swords", itemDisplayType = "diamond_sword"},
		{itemType = "pickaxes", itemDisplayType = "diamond_pickaxe"},
		{itemType = "axes", itemDisplayType = "diamond_axe"},
		{itemType = "shears", itemDisplayType = "shears"},
		{itemType = "wool", itemDisplayType = "wool_white"},
		{itemType = "iron", itemDisplayType = "iron"},
		{itemType = "diamond", itemDisplayType = "diamond"},
		{itemType = "emerald", itemDisplayType = "emerald"},
		{itemType = "bows", itemDisplayType = "wood_bow"},
	}
	local items = bedwars["ItemTable"]
	if items then
		for i2,v2 in pairs(items) do
			if (i2:find("axe") == nil or i2:find("void")) and i2:find("bow") == nil and i2:find("shears") == nil and i2:find("wool") == nil and v2.sword == nil and v2.armor == nil and v2["dontGiveItem"] == nil and bedwars["ItemTable"][i2] and bedwars["ItemTable"][i2].image then
				table.insert(sortableitems, {itemType = i2, itemDisplayType = i2})
			end
		end
	end
	local buttontext = Instance.new("TextButton")
	buttontext.AutoButtonColor = false
	buttontext.BackgroundTransparency = 1
	buttontext.Name = "ButtonText"
	buttontext.Text = ""
	buttontext.Name = argstable["Name"]
	buttontext.LayoutOrder = 1
	buttontext.Size = UDim2.new(1, 0, 0, 40)
	buttontext.Active = false
	buttontext.TextColor3 = Color3.fromRGB(162, 162, 162)
	buttontext.TextSize = 17
	buttontext.Font = Enum.Font.SourceSans
	buttontext.Position = UDim2.new(0, 0, 0, 0)
	buttontext.Parent = children2
	local toggleframe2 = Instance.new("Frame")
	toggleframe2.Size = UDim2.new(0, 200, 0, 31)
	toggleframe2.Position = UDim2.new(0, 10, 0, 4)
	toggleframe2.BackgroundColor3 = Color3.fromRGB(38, 37, 38)
	toggleframe2.Name = "ToggleFrame2"
	toggleframe2.Parent = buttontext
	local toggleframe1 = Instance.new("Frame")
	toggleframe1.Size = UDim2.new(0, 198, 0, 29)
	toggleframe1.BackgroundColor3 = Color3.fromRGB(26, 25, 26)
	toggleframe1.BorderSizePixel = 0
	toggleframe1.Name = "ToggleFrame1"
	toggleframe1.Position = UDim2.new(0, 1, 0, 1)
	toggleframe1.Parent = toggleframe2
	local addbutton = Instance.new("ImageLabel")
	addbutton.BackgroundTransparency = 1
	addbutton.Name = "AddButton"
	addbutton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	addbutton.Position = UDim2.new(0, 93, 0, 9)
	addbutton.Size = UDim2.new(0, 12, 0, 12)
	addbutton.ImageColor3 = Color3.fromRGB(5, 133, 104)
	addbutton.Image = getcustomassetfunc("vape/assets/AddItem.png")
	addbutton.Parent = toggleframe1
	local children3 = Instance.new("Frame")
	children3.Name = argstable["Name"].."Children"
	children3.BackgroundTransparency = 1
	children3.LayoutOrder = amount
	children3.Size = UDim2.new(0, 220, 0, 0)
	children3.Parent = children2
	local uilistlayout = Instance.new("UIListLayout")
	uilistlayout.Parent = children3
	uilistlayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		children3.Size = UDim2.new(1, 0, 0, uilistlayout.AbsoluteContentSize.Y)
	end)
	local uicorner = Instance.new("UICorner")
	uicorner.CornerRadius = UDim.new(0, 5)
	uicorner.Parent = toggleframe1
	local uicorner2 = Instance.new("UICorner")
	uicorner2.CornerRadius = UDim.new(0, 5)
	uicorner2.Parent = toggleframe2
	buttontext.MouseEnter:Connect(function()
		game:GetService("TweenService"):Create(toggleframe2, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(79, 78, 79)}):Play()
	end)
	buttontext.MouseLeave:Connect(function()
		game:GetService("TweenService"):Create(toggleframe2, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(38, 37, 38)}):Play()
	end)
	local ItemListBigFrame = Instance.new("Frame")
	ItemListBigFrame.Size = UDim2.new(1, 0, 1, 0)
	ItemListBigFrame.Name = "ItemList"
	ItemListBigFrame.BackgroundTransparency = 1
	ItemListBigFrame.Visible = false
	ItemListBigFrame.Parent = GuiLibrary["MainGui"]
	local ItemListFrame = Instance.new("Frame")
	ItemListFrame.Size = UDim2.new(0, 660, 0, 445)
	ItemListFrame.Position = UDim2.new(0.5, -330, 0.5, -223)
	ItemListFrame.BackgroundColor3 = Color3.fromRGB(26, 25, 26)
	ItemListFrame.Parent = ItemListBigFrame
	local ItemListExitButton = Instance.new("ImageButton")
	ItemListExitButton.Name = "ItemListExitButton"
	ItemListExitButton.ImageColor3 = Color3.fromRGB(121, 121, 121)
	ItemListExitButton.Size = UDim2.new(0, 24, 0, 24)
	ItemListExitButton.AutoButtonColor = false
	ItemListExitButton.Image = getcustomassetfunc("vape/assets/ExitIcon1.png")
	ItemListExitButton.Visible = true
	ItemListExitButton.Position = UDim2.new(1, -31, 0, 8)
	ItemListExitButton.BackgroundColor3 = Color3.fromRGB(26, 25, 26)
	ItemListExitButton.Parent = ItemListFrame
	local ItemListExitButtonround = Instance.new("UICorner")
	ItemListExitButtonround.CornerRadius = UDim.new(0, 16)
	ItemListExitButtonround.Parent = ItemListExitButton
	ItemListExitButton.MouseEnter:Connect(function()
		game:GetService("TweenService"):Create(ItemListExitButton, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(60, 60, 60), ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
	end)
	ItemListExitButton.MouseLeave:Connect(function()
		game:GetService("TweenService"):Create(ItemListExitButton, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {BackgroundColor3 = Color3.fromRGB(26, 25, 26), ImageColor3 = Color3.fromRGB(121, 121, 121)}):Play()
	end)
	ItemListExitButton.MouseButton1Click:Connect(function()
		ItemListBigFrame.Visible = false
		GuiLibrary["MainGui"].ScaledGui.ClickGui.Visible = true
	end)
	local ItemListFrameShadow = Instance.new("ImageLabel")
	ItemListFrameShadow.AnchorPoint = Vector2.new(0.5, 0.5)
	ItemListFrameShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	ItemListFrameShadow.Image = getcustomassetfunc("vape/assets/WindowBlur.png")
	ItemListFrameShadow.BackgroundTransparency = 1
	ItemListFrameShadow.ZIndex = -1
	ItemListFrameShadow.Size = UDim2.new(1, 6, 1, 6)
	ItemListFrameShadow.ImageColor3 = Color3.new(0, 0, 0)
	ItemListFrameShadow.ScaleType = Enum.ScaleType.Slice
	ItemListFrameShadow.SliceCenter = Rect.new(10, 10, 118, 118)
	ItemListFrameShadow.Parent = ItemListFrame
	local ItemListFrameText = Instance.new("TextLabel")
	ItemListFrameText.Size = UDim2.new(1, 0, 0, 41)
	ItemListFrameText.BackgroundTransparency = 1
	ItemListFrameText.Name = "WindowTitle"
	ItemListFrameText.Position = UDim2.new(0, 0, 0, 0)
	ItemListFrameText.TextXAlignment = Enum.TextXAlignment.Left
	ItemListFrameText.Font = Enum.Font.SourceSans
	ItemListFrameText.TextSize = 17
	ItemListFrameText.Text = "    New AutoHotbar"
	ItemListFrameText.TextColor3 = Color3.fromRGB(201, 201, 201)
	ItemListFrameText.Parent = ItemListFrame
	local ItemListBorder1 = Instance.new("Frame")
	ItemListBorder1.BackgroundColor3 = Color3.fromRGB(40, 39, 40)
	ItemListBorder1.BorderSizePixel = 0
	ItemListBorder1.Size = UDim2.new(1, 0, 0, 1)
	ItemListBorder1.Position = UDim2.new(0, 0, 0, 41)
	ItemListBorder1.Parent = ItemListFrame
	local ItemListFrameCorner = Instance.new("UICorner")
	ItemListFrameCorner.CornerRadius = UDim.new(0, 4)
	ItemListFrameCorner.Parent = ItemListFrame
	local ItemListFrame1 = Instance.new("Frame")
	ItemListFrame1.Size = UDim2.new(0, 112, 0, 113)
	ItemListFrame1.Position = UDim2.new(0, 10, 0, 71)
	ItemListFrame1.BackgroundColor3 = Color3.fromRGB(38, 37, 38)
	ItemListFrame1.Name = "ItemListFrame1"
	ItemListFrame1.Parent = ItemListFrame
	local ItemListFrame2 = Instance.new("Frame")
	ItemListFrame2.Size = UDim2.new(0, 110, 0, 111)
	ItemListFrame2.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	ItemListFrame2.BorderSizePixel = 0
	ItemListFrame2.Name = "ItemListFrame2"
	ItemListFrame2.Position = UDim2.new(0, 1, 0, 1)
	ItemListFrame2.Parent = ItemListFrame1
	local ItemListFramePicker = Instance.new("ScrollingFrame")
	ItemListFramePicker.Size = UDim2.new(0, 495, 0, 220)
	ItemListFramePicker.Position = UDim2.new(0, 144, 0, 122)
	ItemListFramePicker.BorderSizePixel = 0
	ItemListFramePicker.ScrollBarThickness = 3
	ItemListFramePicker.ScrollBarImageTransparency = 0.8
	ItemListFramePicker.VerticalScrollBarInset = Enum.ScrollBarInset.None
	ItemListFramePicker.BackgroundTransparency = 1
	ItemListFramePicker.Parent = ItemListFrame
	local ItemListFramePickerGrid = Instance.new("UIGridLayout")
	ItemListFramePickerGrid.CellPadding = UDim2.new(0, 4, 0, 3)
	ItemListFramePickerGrid.CellSize = UDim2.new(0, 51, 0, 52)
	ItemListFramePickerGrid.Parent = ItemListFramePicker
	ItemListFramePickerGrid:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		ItemListFramePicker.CanvasSize = UDim2.new(0, 0, 0, ItemListFramePickerGrid.AbsoluteContentSize.Y * (1 / GuiLibrary["MainRescale"].Scale))
	end)
	local ItemListcorner = Instance.new("UICorner")
	ItemListcorner.CornerRadius = UDim.new(0, 5)
	ItemListcorner.Parent = ItemListFrame1
	local ItemListcorner2 = Instance.new("UICorner")
	ItemListcorner2.CornerRadius = UDim.new(0, 5)
	ItemListcorner2.Parent = ItemListFrame2
	local selectedslot = 1
	local hoveredslot = 0
	
	local refreshslots
	local refreshList
	refreshslots = function()
		local startnum = 144
		local oldhovered = hoveredslot
		for i2,v2 in pairs(ItemListFrame:GetChildren()) do
			if v2.Name:find("ItemSlot") then
				v2:Remove()
			end
		end
		for i3,v3 in pairs(ItemListFramePicker:GetChildren()) do
			if v3:IsA("TextButton") then
				v3:Remove()
			end
		end
		for i4,v4 in pairs(sortableitems) do
			local ItemFrame = Instance.new("TextButton")
			ItemFrame.Text = ""
			ItemFrame.BackgroundColor3 = Color3.fromRGB(31, 30, 31)
			ItemFrame.Parent = ItemListFramePicker
			ItemFrame.AutoButtonColor = false
			local ItemFrameIcon = Instance.new("ImageLabel")
			ItemFrameIcon.Size = UDim2.new(0, 32, 0, 32)
			ItemFrameIcon.Image = bedwars["getIcon"]({itemType = v4.itemDisplayType}, true) 
			ItemFrameIcon.ResampleMode = (bedwars["getIcon"]({itemType = v4.itemDisplayType}, true):find("rbxasset://") and Enum.ResamplerMode.Pixelated or Enum.ResamplerMode.Default)
			ItemFrameIcon.Position = UDim2.new(0, 10, 0, 10)
			ItemFrameIcon.BackgroundTransparency = 1
			ItemFrameIcon.Parent = ItemFrame
			local ItemFramecorner = Instance.new("UICorner")
			ItemFramecorner.CornerRadius = UDim.new(0, 5)
			ItemFramecorner.Parent = ItemFrame
			ItemFrame.MouseButton1Click:Connect(function()
				for i5,v5 in pairs(buttonapi["Hotbars"][buttonapi["CurrentlySelected"]]["Items"]) do
					if v5.itemType == v4.itemType then
						buttonapi["Hotbars"][buttonapi["CurrentlySelected"]]["Items"][tostring(i5)] = nil
					end
				end
				buttonapi["Hotbars"][buttonapi["CurrentlySelected"]]["Items"][tostring(selectedslot)] = v4
				refreshslots()
				refreshList()
			end)
		end
		for i = 1, 9 do
			local item = buttonapi["Hotbars"][buttonapi["CurrentlySelected"]]["Items"][tostring(i)]
			local ItemListFrame3 = Instance.new("Frame")
			ItemListFrame3.Size = UDim2.new(0, 55, 0, 56)
			ItemListFrame3.Position = UDim2.new(0, startnum - 2, 0, 380)
			ItemListFrame3.BackgroundTransparency = (selectedslot == i and 0 or 1)
			ItemListFrame3.BackgroundColor3 = Color3.fromRGB(35, 34, 35)
			ItemListFrame3.Name = "ItemSlot"
			ItemListFrame3.Parent = ItemListFrame
			local ItemListFrame4 = Instance.new("TextButton")
			ItemListFrame4.Size = UDim2.new(0, 51, 0, 52)
			ItemListFrame4.BackgroundColor3 = (oldhovered == i and Color3.fromRGB(31, 30, 31) or Color3.fromRGB(20, 20, 20))
			ItemListFrame4.BorderSizePixel = 0
			ItemListFrame4.AutoButtonColor = false
			ItemListFrame4.Text = ""
			ItemListFrame4.Name = "ItemListFrame4"
			ItemListFrame4.Position = UDim2.new(0, 2, 0, 2)
			ItemListFrame4.Parent = ItemListFrame3
			local ItemListImage = Instance.new("ImageLabel")
			ItemListImage.Size = UDim2.new(0, 32, 0, 32)
			ItemListImage.BackgroundTransparency = 1
			local img = (item and bedwars["getIcon"]({itemType = item.itemDisplayType}, true) or "")
			ItemListImage.Image = img
			ItemListImage.ResampleMode = (img:find("rbxasset://") and Enum.ResamplerMode.Pixelated or Enum.ResamplerMode.Default)
			ItemListImage.Position = UDim2.new(0, 10, 0, 10)
			ItemListImage.Parent = ItemListFrame4
			local ItemListcorner3 = Instance.new("UICorner")
			ItemListcorner3.CornerRadius = UDim.new(0, 5)
			ItemListcorner3.Parent = ItemListFrame3
			local ItemListcorner4 = Instance.new("UICorner")
			ItemListcorner4.CornerRadius = UDim.new(0, 5)
			ItemListcorner4.Parent = ItemListFrame4
			ItemListFrame4.MouseEnter:Connect(function()
				ItemListFrame4.BackgroundColor3 = Color3.fromRGB(31, 30, 31)
				hoveredslot = i
			end)
			ItemListFrame4.MouseLeave:Connect(function()
				ItemListFrame4.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
				hoveredslot = 0
			end)
			ItemListFrame4.MouseButton1Click:Connect(function()
				selectedslot = i
				refreshslots()
			end)
			ItemListFrame4.MouseButton2Click:Connect(function()
				buttonapi["Hotbars"][buttonapi["CurrentlySelected"]]["Items"][tostring(i)] = nil
				refreshslots()
				refreshList()
			end)
			startnum = startnum + 55
		end
	end	

	local function createHotbarButton(num, items)
		num = tonumber(num) or #buttonapi["Hotbars"] + 1
		local hotbarbutton = Instance.new("TextButton")
		hotbarbutton.Size = UDim2.new(1, 0, 0, 30)
		hotbarbutton.BackgroundTransparency = 1
		hotbarbutton.LayoutOrder = num
		hotbarbutton.AutoButtonColor = false
		hotbarbutton.Text = ""
		hotbarbutton.Parent = children3
		buttonapi["Hotbars"][num] = {["Items"] = items or {}, ["Object"] = hotbarbutton, ["Number"] = num}
		local hotbarframe = Instance.new("Frame")
		hotbarframe.BackgroundColor3 = (num == buttonapi["CurrentlySelected"] and Color3.fromRGB(54, 53, 54) or Color3.fromRGB(31, 30, 31))
		hotbarframe.Size = UDim2.new(0, 200, 0, 27)
		hotbarframe.Position = UDim2.new(0, 10, 0, 1)
		hotbarframe.Parent = hotbarbutton
		local uicorner3 = Instance.new("UICorner")
		uicorner3.CornerRadius = UDim.new(0, 5)
		uicorner3.Parent = hotbarframe
		local startpos = 11
		for i = 1, 9 do
			local item = buttonapi["Hotbars"][num]["Items"][tostring(i)]
			local hotbarbox = Instance.new("ImageLabel")
			hotbarbox.Name = i
			hotbarbox.Size = UDim2.new(0, 17, 0, 18)
			hotbarbox.Position = UDim2.new(0, startpos, 0, 5)
			hotbarbox.BorderSizePixel = 0
			hotbarbox.Image = (item and bedwars["getIcon"]({itemType = item.itemDisplayType}, true) or "")
			hotbarbox.ResampleMode = ((item and bedwars["getIcon"]({itemType = item.itemDisplayType}, true) or ""):find("rbxasset://") and Enum.ResamplerMode.Pixelated or Enum.ResamplerMode.Default)
			hotbarbox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
			hotbarbox.Parent = hotbarframe
			startpos = startpos + 18
		end
		hotbarbutton.MouseButton1Click:Connect(function()
			if buttonapi["CurrentlySelected"] == num then
				ItemListBigFrame.Visible = true
				GuiLibrary["MainGui"].ScaledGui.ClickGui.Visible = false
				refreshslots()
			end
			buttonapi["CurrentlySelected"] = num
			refreshList()
		end)
		hotbarbutton.MouseButton2Click:Connect(function()
			if buttonapi["CurrentlySelected"] == num then
				buttonapi["CurrentlySelected"] = (num == 2 and 0 or 1)
			end
			table.remove(buttonapi["Hotbars"], num)
			refreshList()
		end)
	end

	refreshList = function()
		local newnum = 0
		local newtab = {}
		for i3,v3 in pairs(buttonapi["Hotbars"]) do
			newnum = newnum + 1
			newtab[newnum] = v3
		end
		buttonapi["Hotbars"] = newtab
		for i,v in pairs(children3:GetChildren()) do
			if v:IsA("TextButton") then
				v:Remove()
			end
		end
		for i2,v2 in pairs(buttonapi["Hotbars"]) do
			createHotbarButton(i2, v2["Items"])
		end
		GuiLibrary["Settings"][children2.Name..argstable["Name"].."ItemList"] = {["Type"] = "ItemList", ["Items"] = buttonapi["Hotbars"], ["CurrentlySelected"] = buttonapi["CurrentlySelected"]}
	end
	buttonapi["RefreshList"] = refreshList

	buttontext.MouseButton1Click:Connect(function()
		createHotbarButton()
	end)

	GuiLibrary["Settings"][children2.Name..argstable["Name"].."ItemList"] = {["Type"] = "ItemList", ["Items"] = buttonapi["Hotbars"], ["CurrentlySelected"] = buttonapi["CurrentlySelected"]}
	GuiLibrary["ObjectsThatCanBeSaved"][children2.Name..argstable["Name"].."ItemList"] = {["Type"] = "ItemList", ["Items"] = buttonapi["Hotbars"], ["Api"] = buttonapi, ["Object"] = buttontext}

	return buttonapi
end

GuiLibrary["LoadSettingsEvent"].Event:Connect(function(res)
	for i,v in pairs(res) do
		local obj = GuiLibrary["ObjectsThatCanBeSaved"][i]
		if obj and v["Type"] == "ItemList" and obj.Api then
			obj["Api"]["Hotbars"] = v["Items"]
			obj["Api"]["CurrentlySelected"] = v["CurrentlySelected"]
			obj["Api"]["RefreshList"]()
		end
	end
end)

local function createwarning(title, text, delay)
	local suc, res = pcall(function()
		local frame = GuiLibrary["CreateNotification"](title, text, delay, "assets/WarningNotification.png")
		frame.Frame.Frame.ImageColor3 = Color3.fromRGB(236, 129, 44)
		return frame
	end)
	return (suc and res)
end

local function getItemNear(itemName, inv)
	for i5, v5 in pairs(inv or currentinventory.inventory.items) do
		if v5.itemType:find(itemName) then
			return v5, i5
		end
	end
	return nil
end

local function getItem(itemName, inv)
	for i5, v5 in pairs(inv or currentinventory.inventory.items) do
		if v5.itemType == itemName then
			return v5, i5
		end
	end
	return nil
end

local function getHotbarSlot(itemName)
	for i5, v5 in pairs(currentinventory.hotbar) do
		if v5["item"] and v5["item"].itemType == itemName then
			return i5 - 1
		end
	end
	return nil
end

local function getSword()
	local bestsword, bestswordslot, bestswordnum = nil, nil, 0
	for i5, v5 in pairs(currentinventory.inventory.items) do
		if bedwars["ItemTable"][v5.itemType]["sword"] then
			local swordrank = bedwars["ItemTable"][v5.itemType]["sword"]["damage"] or 0
			if swordrank > bestswordnum then
				bestswordnum = swordrank
				bestswordslot = i5
				bestsword = v5
			end
		end
	end
	return bestsword, bestswordslot
end

local function getBlock()
	for i5, v5 in pairs(currentinventory.inventory.items) do
		if bedwars["ItemTable"][v5.itemType]["block"] then
			return v5.itemType, v5.amount
		end
	end
	return
end

local function getSlotFromItem(item)
	for i,v in pairs(currentinventory.inventory.items) do
		if v.itemType == item.itemType then
			return i
		end
	end
	return nil
end

local function getShield(char)
	local shield = 0
	for i,v in pairs(char:GetAttributes()) do 
		if i:find("Shield") and type(v) == "number" then 
			shield = shield + v
		end
	end
	return shield
end

local function getAxe()
	local bestsword, bestswordslot, bestswordnum = nil, nil, 0
	for i5, v5 in pairs(currentinventory.inventory.items) do
		if v5.itemType:find("axe") and v5.itemType:find("pickaxe") == nil and v5.itemType:find("void") == nil then
			bestswordnum = swordrank
			bestswordslot = i5
			bestsword = v5
		end
	end
	return bestsword, bestswordslot
end

local function getPickaxe()
	return getItemNear("pick")
end

local function getBaguette()
	return getItemNear("baguette")
end

local function getwool()
	local wool = getItemNear("wool")
	return wool and wool.itemType, wool and wool.amount
end

local function isAliveOld(plr, alivecheck)
	if plr then
		return plr and plr.Character and plr.Character.Parent ~= nil and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Head") and plr.Character:FindFirstChild("Humanoid")
	end
	return entity.isAlive
end

local function isAlive(plr, alivecheck)
	if plr then
		local ind, tab = entity.getEntityFromPlayer(plr)
		return ((not alivecheck) or tab and tab.Humanoid:GetState() ~= Enum.HumanoidStateType.Dead) and tab
	end
	return entity.isAlive
end

local function hashvec(vec)
	return {
		["value"] = vec
	}
end

local function getremote(tab)
	for i,v in pairs(tab) do
		if v == "Client" then
			return tab[i + 1]
		end
	end
	return ""
end

local function betterfind(tab, obj)
	for i,v in pairs(tab) do
		if v == obj or type(v) == "table" and v.hash == obj then
			return v
		end
	end
	return nil
end

local GetNearestHumanoidToMouse = function() end

local function randomString()
	local randomlength = math.random(10,100)
	local array = {}

	for i = 1, randomlength do
		array[i] = string.char(math.random(32, 126))
	end

	return table.concat(array)
end

local function getWhitelistedBed(bed)
	for i,v in pairs(players:GetChildren()) do
		if v:GetAttribute("Team") and bed and bed:GetAttribute("Team"..v:GetAttribute("Team").."NoBreak") and WhitelistFunctions:CheckWhitelisted(v) then
			return true
		end
	end
	return false
end

local OldClientGet 
local oldbreakremote
local oldbob
runcode(function()
    getfunctions = function()
		local Flamework = require(repstorage["rbxts_include"]["node_modules"]["@flamework"].core.out).Flamework
		repeat task.wait() until Flamework.isInitialized
        local KnitClient = debug.getupvalue(require(lplr.PlayerScripts.TS.knit).setup, 6)
        local Client = require(repstorage.TS.remotes).default.Client
        local InventoryUtil = require(repstorage.TS.inventory["inventory-util"]).InventoryUtil
        OldClientGet = getmetatable(Client).Get
        getmetatable(Client).Get = function(Self, remotename)
			local res = OldClientGet(Self, remotename)
			if uninjectflag then return res end
			if remotename == "DamageBlock" then
				return {
					["CallServerAsync"] = function(Self, tab)
						local block = bedwars["BlockController"]:getStore():getBlockAt(tab.blockRef.blockPosition)
						if block and block.Name == "bed" then
							if getWhitelistedBed(block) then
								return {andThen = function(self, func) 
									func("failed")
								end}
							end
						end
						return res:CallServerAsync(tab)
					end,
					["CallServer"] = function(Self, tab)
						local block = bedwars["BlockController"]:getStore():getBlockAt(tab.blockRef.blockPosition)
						if block and block.Name == "bed" then
							if getWhitelistedBed(block) then
								return {andThen = function(self, func) 
									func("failed")
								end}
							end
						end
						return res:CallServer(tab)
					end
				}
			elseif remotename == bedwars["AttackRemote"] then
				return {
					["instance"] = res["instance"],
					["SendToServer"] = function(Self, tab)
						local suc, plr = pcall(function() return players:GetPlayerFromCharacter(tab.entityInstance) end)
						if suc and plr then
							local playertype, playerattackable = WhitelistFunctions:CheckPlayerType(plr)
							if not playerattackable then 
								return nil
							end
						end
						if Reach["Enabled"] then
							local mag = (tab.validate.selfPosition.value - tab.validate.targetPosition.value).magnitude
							local newres = hashvec(tab.validate.selfPosition.value + (mag > 14.4 and (CFrame.lookAt(tab.validate.selfPosition.value, tab.validate.targetPosition.value).lookVector * 4) or Vector3.zero))
							tab.validate.selfPosition = newres
						end
						return res:SendToServer(tab)
					end
				}
			end
            return res
        end
		bedwars = {
			["AnimationUtil"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out["shared"].util["animation-util"]).AnimationUtil,
			["AngelUtil"] = require(repstorage.TS.games.bedwars.kit.kits.angel["angel-kit"]),
			["AppController"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out.client.controllers["app-controller"]).AppController,
			["AttackRemote"] = getremote(debug.getconstants(getmetatable(KnitClient.Controllers.SwordController)["attackEntity"])),
			["BatteryRemote"] = getremote(debug.getconstants(debug.getproto(debug.getproto(KnitClient.Controllers.BatteryController.KnitStart, 1), 1))),
			["BatteryEffectController"] = KnitClient.Controllers.BatteryEffectsController,
            ["BalloonController"] = KnitClient.Controllers.BalloonController,
            ["BlockController"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["block-engine"].out).BlockEngine,
            ["BlockController2"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["block-engine"].out.client.placement["block-placer"]).BlockPlacer,
            ["BlockEngine"] = require(lplr.PlayerScripts.TS.lib["block-engine"]["client-block-engine"]).ClientBlockEngine,
            ["BlockEngineClientEvents"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["block-engine"].out.client["block-engine-client-events"]).BlockEngineClientEvents,
			["BlockPlacementController"] = KnitClient.Controllers.BlockPlacementController,
            ["BedwarsKits"] = require(repstorage.TS.games.bedwars.kit["bedwars-kit-shop"]).BedwarsKitShop,
            ["BlockBreaker"] = KnitClient.Controllers.BlockBreakController.blockBreaker,
            ["BowTable"] = KnitClient.Controllers.ProjectileController,
			["BowConstantsTable"] = debug.getupvalue(KnitClient.Controllers.ProjectileController.enableBeam, 5),
			["ChestController"] = KnitClient.Controllers.ChestController,
			["ClickHold"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out.client.ui.lib.util["click-hold"]).ClickHold,
            ["ClientHandler"] = Client,
			["SharedConstants"] = require(repstorage.TS["shared-constants"]),
            ["ClientStoreHandler"] = require(lplr.PlayerScripts.TS.ui.store).ClientStore,
			["ClientHandlerSyncEvents"] = require(lplr.PlayerScripts.TS["client-sync-events"]).ClientSyncEvents,
            ["CombatConstant"] = require(repstorage.TS.combat["combat-constant"]).CombatConstant,
			["CombatController"] = KnitClient.Controllers.CombatController,
			["ConsumeSoulRemote"] = getremote(debug.getconstants(KnitClient.Controllers.GrimReaperController.consumeSoul)),
			["ConstantManager"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out["shared"].constant["constant-manager"]).ConstantManager,
			["CooldownController"] = KnitClient.Controllers.CooldownController,
            ["damageTable"] = KnitClient.Controllers.DamageController,
			["DinoRemote"] = getremote(debug.getconstants(debug.getproto(KnitClient.Controllers.DinoTamerController.KnitStart, 3))),
			["DaoRemote"] = getremote(debug.getconstants(debug.getprotos(KnitClient.Controllers.DaoController.onEnable)[4])),
			["DamageController"] = KnitClient.Controllers.DamageController,
			["DamageIndicator"] = KnitClient.Controllers.DamageIndicatorController.spawnDamageIndicator,
			["DamageIndicatorController"] = KnitClient.Controllers.DamageIndicatorController,
			["DetonateRavenRemote"] = getremote(debug.getconstants(getmetatable(KnitClient.Controllers.RavenController).detonateRaven)),
            ["DropItem"] = getmetatable(KnitClient.Controllers.ItemDropController).dropItemInHand,
            ["DropItemRemote"] = getremote(debug.getconstants(getmetatable(KnitClient.Controllers.ItemDropController).dropItemInHand)),
            ["EatRemote"] = getremote(debug.getconstants(debug.getproto(getmetatable(KnitClient.Controllers.ConsumeController).onEnable, 1))),
            ["EquipItemRemote"] = getremote(debug.getconstants(debug.getprotos(shared.oldequipitem or require(repstorage.TS.entity.entities["inventory-entity"]).InventoryEntity.equipItem)[3])),
			["FishermanTable"] = KnitClient.Controllers.FishermanController,
			["FovController"] = KnitClient.Controllers.FovController,
			["GameAnimationUtil"] = require(repstorage.TS.animation["animation-util"]).GameAnimationUtil,
			["GamePlayerUtil"] = require(repstorage.TS.player["player-util"]).GamePlayerUtil,
            ["getEntityTable"] = require(repstorage.TS.entity["entity-util"]).EntityUtil,
            ["getIcon"] = function(item, showinv)
                local itemmeta = bedwars["ItemTable"][item.itemType]
                if itemmeta and showinv then
                    return itemmeta.image
                end
                return ""
            end,
			["getInventory2"] = function(plr)
                local suc, result = pcall(function() 
					return InventoryUtil.getInventory(plr) 
				end)
                return (suc and result or {
                    ["items"] = {},
                    ["armor"] = {},
                    ["hand"] = nil
                })
            end,
            ["getItemMetadata"] = require(repstorage.TS.item["item-meta"]).getItemMeta,
			["GrimReaperController"] = KnitClient.Controllers.GrimReaperController,
			["GuitarHealRemote"] = getremote(debug.getconstants(KnitClient.Controllers.GuitarController.performHeal)),
			["HangGliderController"] = KnitClient.Controllers.HangGliderController,
			["HighlightController"] = KnitClient.Controllers.EntityHighlightController,
            ["ItemTable"] = debug.getupvalue(require(repstorage.TS.item["item-meta"]).getItemMeta, 1),
			["JuggernautRemote"] = getremote(debug.getconstants(debug.getprotos(debug.getprotos(KnitClient.Controllers.JuggernautController.KnitStart)[1])[4])),
			["KatanaController"] = KnitClient.Controllers.DaoController,
			["KatanaRemote"] = getremote(debug.getconstants(debug.getproto(KnitClient.Controllers.DaoController.onEnable, 4))),
            ["KnockbackTable"] = debug.getupvalue(require(repstorage.TS.damage["knockback-util"]).KnockbackUtil.calculateKnockbackVelocity, 1),
			["LobbyClientEvents"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"].lobby.out.client.events).LobbyClientEvents,
			["MapMeta"] = require(repstorage.TS.game.map["map-meta"]),
			["MissileController"] = KnitClient.Controllers.GuidedProjectileController,
			["MinerRemote"] = getremote(debug.getconstants(debug.getprotos(debug.getproto(getmetatable(KnitClient.Controllers.MinerController).onKitEnabled, 1))[2])),
			["MinerController"] = KnitClient.Controllers.MinerController,
			["ProdAnimations"] = require(repstorage.TS.animation.definitions["prod-animations"]).ProdAnimations,
            ["PickupRemote"] = getremote(debug.getconstants(getmetatable(KnitClient.Controllers.ItemDropController).checkForPickup)),
            ["PlayerUtil"] = require(repstorage.TS.player["player-util"]).GamePlayerUtil,
			["ProjectileMeta"] = require(repstorage.TS.projectile["projectile-meta"]).ProjectileMeta,
			["QueueMeta"] = require(repstorage.TS.game["queue-meta"]).QueueMeta,
			["QueueCard"] = require(lplr.PlayerScripts.TS.controllers.global.queue.ui["queue-card"]).QueueCard,
			["QueryUtil"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out).GameQueryUtil,
			["PaintRemote"] = getremote(debug.getconstants(KnitClient.Controllers.PaintShotgunController.fire)),
            ["prepareHashing"] = require(repstorage.TS["remote-hash"]["remote-hash-util"]).RemoteHashUtil.prepareHashVector3,
			["ProjectileRemote"] = getremote(debug.getconstants(debug.getupvalues(getmetatable(KnitClient.Controllers.ProjectileController)["launchProjectileWithValues"])[2])),
			["ProjectileHitRemote"] = getremote(debug.getconstants(debug.getproto(KnitClient.Controllers.ProjectileController.createLocalProjectile, 1))),
            ["RavenTable"] = KnitClient.Controllers.RavenController,
			["RespawnController"] = KnitClient.Controllers.BedwarsRespawnController,
			["RespawnTimer"] = require(lplr.PlayerScripts.TS.controllers.games.bedwars.respawn.ui["respawn-timer"]).RespawnTimerWrapper,
			["ResetRemote"] = getremote(debug.getconstants(debug.getproto(KnitClient.Controllers.ResetController.createBindable, 1))),
			["RuntimeLib"] = require(repstorage["rbxts_include"].RuntimeLib),
            ["Shop"] = require(repstorage.TS.games.bedwars.shop["bedwars-shop"]).BedwarsShop,
			["ShopItems"] = debug.getupvalue(require(repstorage.TS.games.bedwars.shop["bedwars-shop"]).BedwarsShop.getShopItem, 2),
            ["ShopRight"] = require(lplr.PlayerScripts.TS.controllers.games.bedwars.shop.ui["item-shop"]["shop-left"]["shop-left"]).BedwarsItemShopLeft,
			["SpawnRavenRemote"] = getremote(debug.getconstants(getmetatable(KnitClient.Controllers.RavenController).spawnRaven)),
            ["SoundManager"] = require(repstorage["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out).SoundManager,
			["SoundList"] = require(repstorage.TS.sound["game-sound"]).GameSound,
            ["sprintTable"] = KnitClient.Controllers.SprintController,
			["StopwatchController"] = KnitClient.Controllers.StopwatchController,
            ["SwingSword"] = getmetatable(KnitClient.Controllers.SwordController).swingSwordAtMouse,
            ["SwingSwordRegion"] = getmetatable(KnitClient.Controllers.SwordController).swingSwordInRegion,
            ["SwordController"] = KnitClient.Controllers.SwordController,
            ["TreeRemote"] = getremote(debug.getconstants(debug.getprotos(debug.getprotos(KnitClient.Controllers.BigmanController.KnitStart)[2])[1])),
			["TrinityRemote"] = getremote(debug.getconstants(debug.getproto(getmetatable(KnitClient.Controllers.AngelController).onKitEnabled, 1))),
            ["VictoryScreen"] = require(lplr.PlayerScripts.TS.controllers["game"].match.ui["victory-section"]).VictorySection,
            ["ViewmodelController"] = KnitClient.Controllers.ViewmodelController,
			["VehicleController"] = KnitClient.Controllers.VehicleController,
			["WeldTable"] = require(repstorage.TS.util["weld-util"]).WeldUtil,
        }
		oldbob = bedwars["ViewmodelController"]["playAnimation"]
        bedwars["ViewmodelController"]["playAnimation"] = function(Self, id, ...)
            if id == 19 and nobob["Enabled"] and entity.isAlive then
                id = 11
            end
            return oldbob(Self, id, ...)
        end
		blocktable = bedwars["BlockController2"].new(bedwars["BlockEngine"], getwool())
		bedwars["placeBlock"] = function(newpos, customblock)
			if getItem(customblock) then
				blocktable.blockType = customblock
				return blocktable:placeBlock(vec3(newpos.X / 3, newpos.Y / 3, newpos.Z / 3))
			end
		end
        task.spawn(function()
            repeat task.wait() until matchState ~= 0
			if (not uninjectflag) then
				bedwarsblocks = collectionservice:GetTagged("block")
				connectionstodisconnect[#connectionstodisconnect + 1] = collectionservice:GetInstanceAddedSignal("block"):Connect(function(v) table.insert(bedwarsblocks, v) blockraycast.FilterDescendantsInstances = bedwarsblocks end)
				connectionstodisconnect[#connectionstodisconnect + 1] = collectionservice:GetInstanceRemovedSignal("block"):Connect(function(v) local found = table.find(bedwarsblocks, v) if found then table.remove(bedwarsblocks, found) end blockraycast.FilterDescendantsInstances = bedwarsblocks end)
				blockraycast.FilterDescendantsInstances = bedwarsblocks
				local lowestypos = 99999
				for i,v in pairs(bedwarsblocks) do 
					local newray = workspace:Raycast(v.Position + vec3(0, 800, 0), vec3(0, -1000, 0), blockraycast)
					if i % 200 == 0 then 
						task.wait(0.06)
					end
					if newray and newray.Position.Y <= lowestypos then
						lowestypos = newray.Position.Y
					end
				end
				antivoidypos = lowestypos - 8
			end
        end)
		connectionstodisconnect[#connectionstodisconnect + 1] = bedwars["ClientStoreHandler"].changed:connect(function(p3, p4)
			if p3.Game ~= p4.Game then 
				matchState = p3.Game.matchState
				queueType = p3.Game.queueType or "bedwars_test"
			end
			if p3.Kit ~= p4.Kit then 	
				bedwars["BountyHunterTarget"] = p3.Kit.bountyHunterTarget
			end
			if p3.Bedwars ~= p4.Bedwars then 
				kit = p3.Bedwars.kit
			end
			if p3.Inventory ~= p4.Inventory then 
				currentinventory = p3.Inventory.observedInventory
			end
        end)
		local clientstorestate = bedwars["ClientStoreHandler"]:getState()
        matchState = clientstorestate.Game.matchState or 0
        kit = clientstorestate.Bedwars.kit or ""
		queueType = clientstorestate.Game.queueType or "bedwars_test"
		currentinventory = clientstorestate.Inventory.observedInventory
		if not shared.vapebypassed then
			local fakeremote = Instance.new("RemoteEvent")
			fakeremote.Name = "GameAnalyticsError"
			local realremote = repstorage:WaitForChild("GameAnalyticsError")
			realremote.Parent = nil
			fakeremote.Parent = repstorage
			game:GetService("ScriptContext").Error:Connect(function(p1, p2, p3)
				if not p3 then
					return;
				end;
				local u2 = nil;
				local v4, v5 = pcall(function()
					u2 = p3:GetFullName();
				end);
				if not v4 then
					return;
				end;
				if p3.Parent == nil then
					return;
				end
				realremote:FireServer(p1, p2, u2);
			end)
			shared.vapebypassed = true
		end

		task.spawn(function()
			local chatsuc, chatres = pcall(function() return game:GetService("HttpService"):JSONDecode(readfile("vape/Profiles/bedwarssettings.json")) end)
			if chatsuc then
				if chatres.crashed and (not chatres.said) then
					pcall(function()
						local notification1 = createwarning("Vape", "either ur poor or its a exploit moment", 10)
						notification1:GetChildren()[5].TextSize = 15
						local notification2 = createwarning("Vape", "getconnections crashed, chat hook not loaded.", 10)
						notification2:GetChildren()[5].TextSize = 13
					end)
					local jsondata = game:GetService("HttpService"):JSONEncode({
						crashed = true,
						said = true,
					})
					writefile("vape/Profiles/bedwarssettings.json", jsondata)
				end
				if chatres.crashed then
					return nil
				else
					local jsondata = game:GetService("HttpService"):JSONEncode({
						crashed = true,
						said = false,
					})
					writefile("vape/Profiles/bedwarssettings.json", jsondata)
				end
			else
				local jsondata = game:GetService("HttpService"):JSONEncode({
					crashed = true,
					said = false,
				})
				writefile("vape/Profiles/bedwarssettings.json", jsondata)
			end
			repeat task.wait() until WhitelistFunctions.Loaded
			for i3,v3 in pairs(WhitelistFunctions.WhitelistTable.chattags) do
				if v3.NameColor then
					v3.NameColor = Color3.fromRGB(v3.NameColor.r, v3.NameColor.g, v3.NameColor.b)
				end
				if v3.ChatColor then
					v3.ChatColor = Color3.fromRGB(v3.ChatColor.r, v3.ChatColor.g, v3.ChatColor.b)
				end
				if v3.Tags then
					for i4,v4 in pairs(v3.Tags) do
						if v4.TagColor then
							v4.TagColor = Color3.fromRGB(v4.TagColor.r, v4.TagColor.g, v4.TagColor.b)
						end
					end
				end
			end
			if getconnections then 
				for i,v in pairs(getconnections(repstorage.DefaultChatSystemChatEvents.OnNewMessage.OnClientEvent)) do
					if v.Function and #debug.getupvalues(v.Function) > 0 and type(debug.getupvalues(v.Function)[1]) == "table" and getmetatable(debug.getupvalues(v.Function)[1]) and getmetatable(debug.getupvalues(v.Function)[1]).GetChannel then
						oldchanneltab = getmetatable(debug.getupvalues(v.Function)[1])
						oldchannelfunc = getmetatable(debug.getupvalues(v.Function)[1]).GetChannel
						getmetatable(debug.getupvalues(v.Function)[1]).GetChannel = function(Self, Name)
							local tab = oldchannelfunc(Self, Name)
							if tab and tab.AddMessageToChannel then
								local addmessage = tab.AddMessageToChannel
								if oldchanneltabs[tab] == nil then
									oldchanneltabs[tab] = tab.AddMessageToChannel
								end
								tab.AddMessageToChannel = function(Self2, MessageData)
									if MessageData.FromSpeaker and players[MessageData.FromSpeaker] then
										local plrtype = WhitelistFunctions:CheckPlayerType(players[MessageData.FromSpeaker])
										local hash = WhitelistFunctions:Hash(players[MessageData.FromSpeaker].Name..players[MessageData.FromSpeaker].UserId)
										if plrtype == "VAPE PRIVATE" then
											MessageData.ExtraData = {
												NameColor = players[MessageData.FromSpeaker].Team == nil and Color3.new(0, 1, 1) or players[MessageData.FromSpeaker].TeamColor.Color,
												Tags = {
													table.unpack(MessageData.ExtraData.Tags),
													{
														TagColor = Color3.new(0.7, 0, 1),
														TagText = "VAPE PRIVATE"
													}
												}
											}
										end
										if plrtype == "VAPE OWNER" then
											MessageData.ExtraData = {
												NameColor = players[MessageData.FromSpeaker].Team == nil and Color3.new(1, 0, 0) or players[MessageData.FromSpeaker].TeamColor.Color,
												Tags = {
													table.unpack(MessageData.ExtraData.Tags),
													{
														TagColor = Color3.new(1, 0.3, 0.3),
														TagText = "VAPE OWNER"
													}
												}
											}
										end
										if clients.ClientUsers[tostring(players[MessageData.FromSpeaker])] then
											MessageData.ExtraData = {
												NameColor = players[MessageData.FromSpeaker].Team == nil and Color3.new(1, 0, 0) or players[MessageData.FromSpeaker].TeamColor.Color,
												Tags = {
													table.unpack(MessageData.ExtraData.Tags),
													{
														TagColor = Color3.new(1, 1, 0),
														TagText = clients.ClientUsers[tostring(players[MessageData.FromSpeaker])]
													}
												}
											}
										end
										if WhitelistFunctions.WhitelistTable.chattags[hash] then
											local newdata = {
												NameColor = players[MessageData.FromSpeaker].Team == nil and WhitelistFunctions.WhitelistTable.chattags[hash].NameColor or players[MessageData.FromSpeaker].TeamColor.Color,
												Tags = WhitelistFunctions.WhitelistTable.chattags[hash].Tags
											}
											MessageData.ExtraData = newdata
										end
									end
									return addmessage(Self2, MessageData)
								end
							end
							return tab
						end
					end
				end
			end
			local jsondata = game:GetService("HttpService"):JSONEncode({
				crashed = false,
				said = false,
			})
			writefile("vape/Profiles/bedwarssettings.json", jsondata)
		end)
    end
end)

local fakeuiconnection
GuiLibrary["SelfDestructEvent"].Event:Connect(function()
	if OldClientGet then
		getmetatable(bedwars["ClientHandler"]).Get = OldClientGet
	end
	uninjectflag = true
	if blocktable then blocktable:disable() end
	if teleportfunc then teleportfunc:Disconnect() end
	if chatconnection then chatconnection:Disconnect() end
	if chatconnection2 then chatconnection2:Disconnect() end
	if fakeuiconnection then fakeuiconnection:Disconnect() end
	if oldchannelfunc and oldchanneltab then oldchanneltab.GetChannel = oldchannelfunc end
	for i2,v2 in pairs(oldchanneltabs) do i2.AddMessageToChannel = v2 end
	for i3,v3 in pairs(connectionstodisconnect) do
		if v3.Disconnect then pcall(function() v3:Disconnect() end) end
	end
end)

chatconnection2 = lplr.PlayerGui:WaitForChild("Chat").Frame.ChatChannelParentFrame["Frame_MessageLogDisplay"].Scroller.ChildAdded:Connect(function(text)
	local textlabel2 = text:WaitForChild("TextLabel")
	if WhitelistFunctions:IsSpecialIngame() then
		local args = textlabel2.Text:split(" ")
		local client = clients.ChatStrings1[#args > 0 and args[#args] or tab.Message]
		if textlabel2.Text:find("You are now chatting") or textlabel2.Text:find("You are now privately chatting") then
			text.Size = UDim2.new(0, 0, 0, 0)
			text:GetPropertyChangedSignal("Size"):Connect(function()
				text.Size = UDim2.new(0, 0, 0, 0)
			end)
		end
		if client then
			if textlabel2.Text:find(clients.ChatStrings2[client]) then
				text.Size = UDim2.new(0, 0, 0, 0)
				text:GetPropertyChangedSignal("Size"):Connect(function()
					text.Size = UDim2.new(0, 0, 0, 0)
				end)
			end
		end
		textlabel2:GetPropertyChangedSignal("Text"):Connect(function()
			local args = textlabel2.Text:split(" ")
			local client = clients.ChatStrings1[#args > 0 and args[#args] or tab.Message]
			if textlabel2.Text:find("You are now chatting") or textlabel2.Text:find("You are now privately chatting") then
				text.Size = UDim2.new(0, 0, 0, 0)
				text:GetPropertyChangedSignal("Size"):Connect(function()
					text.Size = UDim2.new(0, 0, 0, 0)
				end)
			end
			if client then
				if textlabel2.Text:find(clients.ChatStrings2[client]) then
					text.Size = UDim2.new(0, 0, 0, 0)
					text:GetPropertyChangedSignal("Size"):Connect(function()
						text.Size = UDim2.new(0, 0, 0, 0)
					end)
				end
			end
		end)
	end
end)

teleportfunc = lplr.OnTeleport:Connect(function(State)
    if State == Enum.TeleportState.Started then
		local clientstorestate = bedwars["ClientStoreHandler"]:getState()
		local queuedstring = ''
		if clientstorestate.Party and clientstorestate.Party.members and #clientstorestate.Party.members > 0 then
        	queuedstring = queuedstring..'shared.vapeteammembers = '..#clientstorestate.Party.members..'\n'
		end
		if tpstring then
			queuedstring = queuedstring..'shared.vapeoverlay = "'..tpstring..'"\n'
		end
		queueteleport(queuedstring)
    end
end)

local function getblock(pos)
	local blockpos = bedwars["BlockController"]:getBlockPosition(pos)
	return bedwars["BlockController"]:getStore():getBlockAt(blockpos), blockpos
end

getfunctions()

local function getNametagString(plr)
	local nametag = ""
	local hash = WhitelistFunctions:Hash(plr.Name..plr.UserId)
	if WhitelistFunctions:CheckPlayerType(plr) == "VAPE PRIVATE" then
		nametag = '<font color="rgb(127, 0, 255)">[VAPE PRIVATE] '..(plr.Name)..'</font>'
	end
	if WhitelistFunctions:CheckPlayerType(plr) == "VAPE OWNER" then
		nametag = '<font color="rgb(255, 80, 80)">[VAPE OWNER] '..(plr.DisplayName or plr.Name)..'</font>'
	end
	if clients.ClientUsers[tostring(plr)] then
		nametag = '<font color="rgb(255, 255, 0)">['..clients.ClientUsers[tostring(plr)]..'] '..(plr.DisplayName or plr.Name)..'</font>'
	end
	if WhitelistFunctions.WhitelistTable.chattags[hash] then
		local data = WhitelistFunctions.WhitelistTable.chattags[hash]
		local newnametag = ""
		if data.Tags then
			for i2,v2 in pairs(data.Tags) do
				newnametag = newnametag..'<font color="rgb('..math.floor(v2.TagColor.r * 255)..', '..math.floor(v2.TagColor.g * 255)..', '..math.floor(v2.TagColor.b * 255)..')">['..v2.TagText..']</font> '
			end
		end
		nametag = newnametag..(newnametag.NameColor and '<font color="rgb('..math.floor(newnametag.NameColor.r * 255)..', '..math.floor(newnametag.NameColor.g * 255)..', '..math.floor(newnametag.NameColor.b * 255)..')">' or '')..(plr.DisplayName or plr.Name)..(newnametag.NameColor and '</font>' or '')
	end
	return nametag
end

local function Cape(char, texture)
	for i,v in pairs(char:GetDescendants()) do
		if v.Name == "Cape" then
			v:Remove()
		end
	end
	local hum = char:WaitForChild("Humanoid")
	local torso = nil
	if hum.RigType == Enum.HumanoidRigType.R15 then
	torso = char:WaitForChild("UpperTorso")
	else
	torso = char:WaitForChild("Torso")
	end
	local p = Instance.new("Part", torso.Parent)
	p.Name = "Cape"
	p.Anchored = false
	p.CanCollide = false
	p.TopSurface = 0
	p.BottomSurface = 0
	p.FormFactor = "Custom"
	p.Size = vec3(0.2,0.2,0.2)
	p.Transparency = 1
	local decal = Instance.new("Decal", p)
	decal.Texture = texture
	decal.Face = "Back"
	local msh = Instance.new("BlockMesh", p)
	msh.Scale = vec3(9,17.5,0.5)
	local motor = Instance.new("Motor", p)
	motor.Part0 = p
	motor.Part1 = torso
	motor.MaxVelocity = 0.01
	motor.C0 = cfnew(0,2,0) * CFrame.Angles(0,math.rad(90),0)
	motor.C1 = cfnew(0,1,0.45) * CFrame.Angles(0,math.rad(90),0)
	local wave = false
	repeat wait(1/44)
		decal.Transparency = torso.Transparency
		local ang = 0.1
		local oldmag = torso.Velocity.magnitude
		local mv = 0.002
		if wave then
			ang = ang + ((torso.Velocity.magnitude/10) * 0.05) + 0.05
			wave = false
		else
			wave = true
		end
		ang = ang + math.min(torso.Velocity.magnitude/11, 0.5)
		motor.MaxVelocity = math.min((torso.Velocity.magnitude/111), 0.04) --+ mv
		motor.DesiredAngle = -ang
		if motor.CurrentAngle < -0.2 and motor.DesiredAngle > -0.2 then
			motor.MaxVelocity = 0.04
		end
		repeat wait() until motor.CurrentAngle == motor.DesiredAngle or math.abs(torso.Velocity.magnitude - oldmag) >= (torso.Velocity.magnitude/10) + 1
		if torso.Velocity.magnitude < 0.1 then
			wait(0.1)
		end
	until not p or p.Parent ~= torso.Parent
end

local function getSpeedMultiplier(reduce)
	local speed = 1
	if lplr.Character then 
		local speedboost = lplr.Character:GetAttribute("SpeedBoost")
		if speedboost and speedboost > 1 then 
			speed = speed + (speedboost - 1)
		end
		if lplr.Character:GetAttribute("GrimReaperChannel") then 
			speed = speed + 0.6
		end
		if lplr.Character:GetAttribute("SpeedPieBuff") then 
			speed = speed + (queueType == "SURVIVAL" and 0.15 or 0.3)
		end
		local armor = currentinventory.inventory.armor[3]
		if type(armor) ~= "table" then armor = {itemType = ""} end
		if armor.itemType == "speed_boots" then 
			speed = speed + 1
		end
	end
	return reduce and speed ~= 1 and speed * (0.85 - (0.15 * math.floor(speed))) or speed
end

runcode(function()
	local function disguisechar(char, id)
		task.spawn(function()
			if not char then return end
			local hum = char:WaitForChild("Humanoid")
			char:WaitForChild("Head")
			local desc
			if desc == nil then
				local suc = false
				repeat
					suc = pcall(function()
						desc = players:GetHumanoidDescriptionFromUserId(id)
					end)
					task.wait(1)
				until suc
			end
			desc.HeightScale = hum:WaitForChild("HumanoidDescription").HeightScale
			char.Archivable = true
			local disguiseclone = char:Clone()
			disguiseclone.Name = "disguisechar"
			disguiseclone.Parent = workspace
			for i,v in pairs(disguiseclone:GetChildren()) do 
				if v:IsA("Accessory") or v:IsA("ShirtGraphic") or v:IsA("Shirt") or v:IsA("Pants") then  
					v:Destroy()
				end
			end
			disguiseclone.Humanoid:ApplyDescriptionClientServer(desc)
			for i,v in pairs(char:GetChildren()) do 
				if (v:IsA("Accessory") and v:GetAttribute("InvItem") == nil and v:GetAttribute("ArmorSlot") == nil) or v:IsA("ShirtGraphic") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("BodyColors") then 
					v.Parent = game
				end
			end
			char.ChildAdded:Connect(function(v)
				if ((v:IsA("Accessory") and v:GetAttribute("InvItem") == nil and v:GetAttribute("ArmorSlot") == nil) or v:IsA("ShirtGraphic") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("BodyColors")) and v:GetAttribute("Disguise") == nil then 
					repeat task.wait() v.Parent = game until v.Parent == game
				end
			end)
			for i,v in pairs(disguiseclone:WaitForChild("Animate"):GetChildren()) do 
				v:SetAttribute("Disguise", true)
				local real = char.Animate:FindFirstChild(v.Name)
				if v:IsA("StringValue") and real then 
					real.Parent = game
					v.Parent = char.Animate
				end
			end
			for i,v in pairs(disguiseclone:GetChildren()) do 
				v:SetAttribute("Disguise", true)
				if v:IsA("Accessory") then  
					for i2,v2 in pairs(v:GetDescendants()) do 
						if v2:IsA("Weld") and v2.Part1 then 
							v2.Part1 = char[v2.Part1.Name]
						end
					end
					v.Parent = char
				elseif v:IsA("ShirtGraphic") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("BodyColors") then  
					v.Parent = char
				elseif v.Name == "Head" then 
					char.Head.MeshId = v.MeshId
				end
			end
			local localface = char:FindFirstChild("face", true)
			local cloneface = disguiseclone:FindFirstChild("face", true)
			if localface and cloneface then localface.Parent = game cloneface.Parent = char.Head end
			char.Humanoid.HumanoidDescription:SetEmotes(desc:GetEmotes())
			char.Humanoid.HumanoidDescription:SetEquippedEmotes(desc:GetEquippedEmotes())
			disguiseclone:Destroy()
		end)
	end

	local function renderNametag(plr)
		if (WhitelistFunctions:CheckPlayerType(plr) ~= "DEFAULT" or WhitelistFunctions.WhitelistTable.chattags[WhitelistFunctions:Hash(plr.Name..plr.UserId)]) then
			local playerlist = game:GetService("CoreGui"):FindFirstChild("PlayerList")
			if playerlist then
				pcall(function()
					local playerlistplayers = playerlist.PlayerListMaster.OffsetFrame.PlayerScrollList.SizeOffsetFrame.ScrollingFrameContainer.ScrollingFrameClippingFrame.ScollingFrame.OffsetUndoFrame
					local targetedplr = playerlistplayers:FindFirstChild("p_"..plr.UserId)
					if targetedplr then 
						targetedplr.ChildrenFrame.NameFrame.BGFrame.OverlayFrame.PlayerIcon.Image = getcustomassetfunc("vape/assets/VapeIcon.png")
					end
				end)
			end
			if lplr ~= plr and WhitelistFunctions:CheckPlayerType(lplr) == "DEFAULT" then
				task.spawn(function()
					repeat task.wait() until plr:GetAttribute("PlayerConnected")
					task.wait(4)
					repstorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("/w "..plr.Name.." "..clients.ChatStrings2.vape, "All")
					task.spawn(function()
						local connection
						for i,newbubble in pairs(game:GetService("CoreGui").BubbleChat:GetDescendants()) do
							if newbubble:IsA("TextLabel") and newbubble.Text:find(clients.ChatStrings2.vape) then
								newbubble.Parent.Parent.Visible = false
								repeat task.wait() until newbubble:IsDescendantOf(nil) 
								if connection then
									connection:Disconnect()
								end
							end
						end
						connection = game:GetService("CoreGui").BubbleChat.DescendantAdded:Connect(function(newbubble)
							if newbubble:IsA("TextLabel") and newbubble.Text:find(clients.ChatStrings2.vape) then
								newbubble.Parent.Parent.Visible = false
								repeat task.wait() until newbubble:IsDescendantOf(nil)
								if connection then
									connection:Disconnect()
								end
							end
						end)
					end)
					repstorage.DefaultChatSystemChatEvents.OnMessageDoneFiltering.OnClientEvent:Wait()
					task.wait(0.2)
					if getconnections then
						for i,v in pairs(getconnections(repstorage.DefaultChatSystemChatEvents.OnNewMessage.OnClientEvent)) do
							if v.Function and #debug.getupvalues(v.Function) > 0 and type(debug.getupvalues(v.Function)[1]) == "table" and getmetatable(debug.getupvalues(v.Function)[1]) and getmetatable(debug.getupvalues(v.Function)[1]).GetChannel then
								debug.getupvalues(v.Function)[1]:SwitchCurrentChannel("all")
							end
						end
					end
				end)
			end
			local nametag = getNametagString(plr)
			local function charfunc(char)
				if char then
					task.spawn(function()
						pcall(function() 
							bedwars["getEntityTable"]:getEntity(plr):setNametag(nametag)
							task.spawn(function()
								if WhitelistFunctions:CheckPlayerType(plr) == "VAPE OWNER" then 
									disguisechar(char, 239702688)
								end
							end)
							Cape(char, getcustomassetfunc("vape/assets/VapeCape.png"))
						end)
					end)
				end
			end

			--[[plr:GetPropertyChangedSignal("Team"):Connect(function()
				task.delay(3, function()
					pcall(function()
						bedwars["getEntityTable"]:getEntity(plr):setNametag(nametag)
					end)
				end)
			end)]]

			charfunc(plr.Character)
			connectionstodisconnect[#connectionstodisconnect + 1] = plr.CharacterAdded:Connect(charfunc)
		end
	end

	task.spawn(function()
		repeat task.wait() until WhitelistFunctions.Loaded
		for i,v in pairs(players:GetChildren()) do renderNametag(v) end
		connectionstodisconnect[#connectionstodisconnect + 1] = players.PlayerAdded:Connect(renderNametag)
	end)
end)

local function friendCheck(plr, recolor)
	if GuiLibrary["ObjectsThatCanBeSaved"]["Use FriendsToggle"]["Api"]["Enabled"] then
		local friend = (table.find(GuiLibrary["ObjectsThatCanBeSaved"]["FriendsListTextCircleList"]["Api"]["ObjectList"], plr.Name) and GuiLibrary["ObjectsThatCanBeSaved"]["FriendsListTextCircleList"]["Api"]["ObjectListEnabled"][table.find(GuiLibrary["ObjectsThatCanBeSaved"]["FriendsListTextCircleList"]["Api"]["ObjectList"], plr.Name)] and true or nil)
		if recolor then
			return (friend and GuiLibrary["ObjectsThatCanBeSaved"]["Recolor visualsToggle"]["Api"]["Enabled"] and true or nil)
		else
			return friend
		end
	end
	return nil
end

local function getPlayerColor(plr)
	return (friendCheck(plr, true) and Color3.fromHSV(GuiLibrary["ObjectsThatCanBeSaved"]["Friends ColorSliderColor"]["Api"]["Hue"], GuiLibrary["ObjectsThatCanBeSaved"]["Friends ColorSliderColor"]["Api"]["Sat"], GuiLibrary["ObjectsThatCanBeSaved"]["Friends ColorSliderColor"]["Api"]["Value"]) or tostring(plr.TeamColor) ~= "White" and plr.TeamColor.Color)
end

local function targetCheck(plr)
	return plr and plr.Humanoid and plr.Humanoid.Health > 0 and plr.Character:FindFirstChild("ForceField") == nil
end

do
	entity.selfDestruct()
	entity.isPlayerTargetable = function(plr)
		return lplr:GetAttribute("Team") ~= plr:GetAttribute("Team") and friendCheck(plr) == nil
	end
	entity.characterAdded = function(plr, char, localcheck)
        if char then
            task.spawn(function()
				local id = game:GetService("HttpService"):GenerateGUID(true)
                entity.entityIds[plr.Name] = id
                local humrootpart = char:WaitForChild("HumanoidRootPart", 10)
                local head = char:WaitForChild("Head", 10)
                local hum = char:WaitForChild("Humanoid", 10)
				if entity.entityIds[plr.Name] ~= id then return end
                if humrootpart and hum and head then
					local childremoved
                    local newent
                    if localcheck then
                        entity.isAlive = true
                        entity.character.Head = head
                        entity.character.Humanoid = hum
                        entity.character.HumanoidRootPart = humrootpart
                    else
						newent = {
                            Player = plr,
                            Character = char,
                            HumanoidRootPart = humrootpart,
                            RootPart = humrootpart,
                            Head = head,
                            Humanoid = hum,
                            Targetable = entity.isPlayerTargetable(plr),
                            Team = plr.Team,
                            Connections = {}
                        }
						local inv = char:WaitForChild("InventoryFolder", 5)
						if inv then 
							local armorobj1 = char:WaitForChild("ArmorInvItem_0", 5)
							local armorobj2 = char:WaitForChild("ArmorInvItem_1", 5)
							local armorobj3 = char:WaitForChild("ArmorInvItem_2", 5)
							local handobj = char:WaitForChild("HandInvItem", 5)
							if entity.entityIds[plr.Name] ~= id then return end
							if armorobj1 then
								table.insert(newent.Connections, armorobj1.Changed:Connect(function() 
									task.delay(0.3, function() 
										inventories[plr] = bedwars["getInventory2"](plr) 
										entity.entityUpdatedEvent:Fire(newent)
									end)
								end))
							end
							if armorobj2 then
								table.insert(newent.Connections, armorobj2.Changed:Connect(function() 
									task.delay(0.3, function() 
										inventories[plr] = bedwars["getInventory2"](plr) 
										entity.entityUpdatedEvent:Fire(newent)
									end)
								end))
							end
							if armorobj3 then
								table.insert(newent.Connections, armorobj3.Changed:Connect(function() 
									task.delay(0.3, function() 
										inventories[plr] = bedwars["getInventory2"](plr) 
										entity.entityUpdatedEvent:Fire(newent)
									end)
								end))
							end
							if handobj then
								table.insert(newent.Connections, handobj.Changed:Connect(function() 
									task.delay(0.3, function() 
										inventories[plr] = bedwars["getInventory2"](plr)
										entity.entityUpdatedEvent:Fire(newent)
									end)
								end))
							end
						end
						task.delay(0.3, function() 
							inventories[plr] = bedwars["getInventory2"](plr) 
							entity.entityUpdatedEvent:Fire(newent)
						end)
						table.insert(newent.Connections, hum:GetPropertyChangedSignal("Health"):Connect(function() entity.entityUpdatedEvent:Fire(newent) end))
						table.insert(newent.Connections, hum:GetPropertyChangedSignal("MaxHealth"):Connect(function() entity.entityUpdatedEvent:Fire(newent) end))
						table.insert(newent.Connections, char.AttributeChanged:Connect(function(attr) if attr:find("Shield") then entity.entityUpdatedEvent:Fire(newent) end end))
                        table.insert(entity.entityList, newent)
						entity.entityAddedEvent:Fire(newent)
                    end
					childremoved = char.ChildRemoved:Connect(function(part)
                        if part.Name == "HumanoidRootPart" or part.Name == "Head" or part.Name == "Humanoid" then
                            childremoved:Disconnect()
                            if localcheck then
                                if char == lplr.Character then
									if part.Name == "HumanoidRootPart" then
										entity.isAlive = false
										local root = char:FindFirstChild("HumanoidRootPart")
										if not root then 
											for i = 1, 30 do 
												task.wait(0.1)
												root = char:FindFirstChild("HumanoidRootPart")
												if root then break end
											end
										end
										if root then 
											entity.character.HumanoidRootPart = root
											entity.isAlive = true
										end
									else
										entity.isAlive = false
									end
								end
                            else
                                entity.removeEntity(plr)
                            end
                        end
                    end)
                    if newent then 
                        table.insert(newent.Connections, childremoved)
                    end
                    table.insert(entity.entityConnections, childremoved)
                end
            end)
        end
    end
	entity.entityAdded = function(plr, localcheck, custom)
       	table.insert(entity.entityConnections, plr.CharacterAdded:Connect(function(char)
            entity.refreshEntity(plr, localcheck)
        end))
        table.insert(entity.entityConnections, plr.CharacterRemoving:Connect(function(char)
            if localcheck then
                entity.isAlive = false
            else
                entity.removeEntity(plr)
            end
        end))
        table.insert(entity.entityConnections, plr:GetAttributeChangedSignal("Team"):Connect(function()
            if localcheck then
                entity.fullEntityRefresh()
            else
				entity.refreshEntity(plr, localcheck)
				local entnum, newent = entity.getEntityFromPlayer(plr)
				if newent then entity.entityUpdatedEvent:Fire(newent) end
				if plr:GetAttribute("Team") == lplr:GetAttribute("Team") then 
					task.delay(3, function()
						entity.refreshEntity(plr, localcheck)
						entnum, newent = entity.getEntityFromPlayer(plr)
						if newent then entity.entityUpdatedEvent:Fire(newent) end
					end)
				end
            end
        end))
		task.spawn(function()
            if not plr.Character then
                for i = 1, 10 do 
                    task.wait(0.1)
                    if plr.Character then break end
                end
            end
            if plr.Character then
                entity.refreshEntity(plr, localcheck)
            end
        end)
    end
	entity.fullEntityRefresh()
end

local function switchItem(tool, legit)
	if legit then
		local hotbarslot = getHotbarSlot(tool.Name)
		if hotbarslot then 
			bedwars["ClientStoreHandler"]:dispatch({
				type = "InventorySelectHotbarSlot", 
				slot = hotbarslot
			})
		end
	end
	pcall(function()
		lplr.Character.HandInvItem.Value = tool
	end)
	bedwars["ClientHandler"]:Get(bedwars["EquipItemRemote"]):CallServerAsync({
		hand = tool
	})
end

local updateitem = Instance.new("BindableEvent")
runcode(function()
	local inputobj = nil
	local tempconnection
	tempconnection = uis.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			inputobj = input
			tempconnection:Disconnect()
		end
	end)
	connectionstodisconnect[#connectionstodisconnect + 1] = updateitem.Event:Connect(function(inputObj)
		if uis:IsMouseButtonPressed(0) then
			game:GetService("ContextActionService"):CallFunction("block-break", Enum.UserInputState.Begin, inputobj)
		end
	end)
end)

local function getBestTool(block)
    local tool = nil
	local blockmeta = bedwars["ItemTable"][block]
	local blockType = blockmeta["block"] and blockmeta["block"]["breakType"]
	if blockType then
		for i,v in pairs(currentinventory.inventory.items) do
			local meta = bedwars["ItemTable"][v.itemType]
			if meta["breakBlock"] and meta["breakBlock"][blockType] then
				tool = v
				break
			end
		end
	end
    return tool
end

local function switchToAndUseTool(block, legit)
	local tool = getBestTool(block.Name)
	if tool and (entity.isAlive and lplr.Character:FindFirstChild("HandInvItem") and lplr.Character.HandInvItem.Value ~= tool["tool"]) then
		if legit then
			if getHotbarSlot(tool.itemType) then
				bedwars["ClientStoreHandler"]:dispatch({
					type = "InventorySelectHotbarSlot", 
					slot = getHotbarSlot(tool.itemType)
				})
				task.wait(0.1)
				updateitem:Fire(inputobj)
				return true
			else
				return false
			end
		end
		switchItem(tool["tool"])
		task.wait(0.1)
	end
end

local normalsides = {}
for i,v in pairs(Enum.NormalId:GetEnumItems()) do if v.Name ~= "Bottom" then table.insert(normalsides, v) end end

local function isBlockCovered(pos)
	local coveredsides = 0
	for i, v in pairs(normalsides) do
		local blockpos = (pos + (Vector3.FromNormalId(v) * 3))
		local block = getblock(blockpos)
		if block then
			coveredsides = coveredsides + 1
		end
	end
	return coveredsides == #normalsides
end

local blacklistedblocks = {
	bed = true,
	ceramic = true
}
local function getallblocks(pos, normal)
	local blocks = {}
	local lastfound = nil
	for i = 1, 20 do
		local blockpos = (pos + (Vector3.FromNormalId(normal) * (i * 3)))
		local extrablock = getblock(blockpos)
		local covered = isBlockCovered(blockpos)
		if extrablock then
			if bedwars["BlockController"]:isBlockBreakable({blockPosition = blockpos}, lplr) and (not blacklistedblocks[extrablock.Name]) then
				table.insert(blocks, extrablock.Name)
			end
			lastfound = extrablock
			if not covered then
				break
			end
		else
			break
		end
	end
	return blocks
end

local function getlastblock(pos, normal)
	local lastfound, lastpos = nil, nil
	for i = 1, 20 do
		local blockpos = (pos + (Vector3.FromNormalId(normal) * (i * 3)))
		local extrablock, extrablockpos = getblock(blockpos)
		local covered = isBlockCovered(blockpos)
		if extrablock then
			lastfound, lastpos = extrablock, extrablockpos
			if not covered then
				break
			end
		else
			break
		end
	end
	return lastfound, lastpos
end

local healthbarblocktable = {
	["blockHealth"] = -1,
	["breakingBlockPosition"] = Vector3.zero
}
bedwars["breakBlock"] = function(pos, effects, normal, bypass)
    if lplr:GetAttribute("DenyBlockBreak") == true then
		return nil
	end
	local block, blockpos = nil, nil
	if not bypass then block, blockpos = getlastblock(pos, normal) end
	if not block then block, blockpos = getblock(pos) end
    if blockpos and block then
        if bedwars["BlockEngineClientEvents"].DamageBlock:fire(block.Name, blockpos, block):isCancelled() then
            return nil
        end
        local blockhealthbarpos = {blockPosition = Vector3.zero}
        local blockdmg = 0
        if block and block.Parent ~= nil then
            switchToAndUseTool(block)
            blockhealthbarpos = {
                blockPosition = blockpos
            }
            if healthbarblocktable.blockHealth == -1 or blockhealthbarpos.blockPosition ~= healthbarblocktable.breakingBlockPosition then
				local blockdata = bedwars["BlockController"]:getStore():getBlockData(blockhealthbarpos.blockPosition)
				local blockhealth = blockdata and blockdata:GetAttribute(lplr.Name .. "_Health") or block:GetAttribute("Health")
				healthbarblocktable.blockHealth = blockhealth
				healthbarblocktable.breakingBlockPosition = blockhealthbarpos.blockPosition
			end
            blockdmg = bedwars["BlockController"]:calculateBlockDamage(lplr, blockhealthbarpos)
            bedwars["ClientHandlerDamageBlock"]:Get("DamageBlock"):CallServerAsync({
                blockRef = blockhealthbarpos, 
                hitPosition = blockpos * 3, 
                hitNormal = Vector3.FromNormalId(normal)
            }):andThen(function(result)
				if result ~= "failed" then
					healthbarblocktable.blockHealth = math.max(healthbarblocktable.blockHealth - blockdmg, 0)
					if effects then
						bedwars["BlockBreaker"]:updateHealthbar(blockhealthbarpos, healthbarblocktable.blockHealth, block:GetAttribute("MaxHealth"), blockdmg)
						if healthbarblocktable.blockHealth <= 0 then
							bedwars["BlockBreaker"].breakEffect:playBreak(block.Name, blockhealthbarpos.blockPosition, lplr)
							bedwars["BlockBreaker"].healthbarMaid:DoCleaning()
							healthbarblocktable.breakingBlockPosition = Vector3.zero
						else
							bedwars["BlockBreaker"].breakEffect:playHit(block.Name, blockhealthbarpos.blockPosition, lplr)
						end
					end
				end
			end)
        end
    end
end	

local function getEquipped()
	local typetext = ""
	local obj = currentinventory.inventory.hand
	if obj then
		local metatab = bedwars["ItemTable"][obj.itemType]
		typetext = metatab.sword and "sword" or metatab.block and "block" or obj.itemType:find("bow") and "bow"
	end
    return {["Object"] = obj and obj.tool, ["Type"] = typetext}
end

local function GetAllNearestHumanoidToPosition(player, distance, amount, targetcheck, overridepos, sortfunc)
	local returnedplayer = {}
	local currentamount = 0
    if entity.isAlive then -- alive check
        for i, v in pairs(entity.entityList) do -- loop through players
            if (v.Targetable or targetcheck) and targetCheck(v) then -- checks
                local mag = (entity.character.HumanoidRootPart.Position - v.RootPart.Position).magnitude
				if overridepos and mag > distance then 
					mag = (overridepos - v.RootPart.Position).magnitude
				end
                if mag <= distance then -- mag check
                    table.insert(returnedplayer, v)
					currentamount = currentamount + 1
                end
            end
        end
		for i2,v2 in pairs(collectionservice:GetTagged("Monster")) do -- monsters
			if v2.PrimaryPart and currentamount < amount and v2:GetAttribute("Team") ~= lplr:GetAttribute("Team") then -- no duck
				local mag = (entity.character.HumanoidRootPart.Position - v2.PrimaryPart.Position).magnitude
				if overridepos and mag > distance then 
					mag = (overridepos - v2.PrimaryPart.Position).magnitude
				end
                if mag <= distance then -- magcheck
                    table.insert(returnedplayer, {Player = {Name = (v2 and v2.Name or "Monster"), UserId = (v2 and v2.Name == "Duck" and 2020831224 or 1443379645)}, Character = v2, RootPart = v2.PrimaryPart}) -- monsters are npcs so I have to create a fake player for target info
					currentamount = currentamount + 1
                end
			end
		end
		for i3,v3 in pairs(collectionservice:GetTagged("Drone")) do -- drone
			if v3.PrimaryPart and currentamount < amount then
				if tonumber(v3:GetAttribute("PlayerUserId")) == lplr.UserId then continue end
				local droneplr = players:GetPlayerByUserId(v3:GetAttribute("PlayerUserId"))
				if droneplr and droneplr.Team == lplr.Team then continue end
				local mag = (entity.character.HumanoidRootPart.Position - v3.PrimaryPart.Position).magnitude
				if overridepos and mag > distance then 
					mag = (overridepos - v3.PrimaryPart.Position).magnitude
				end
                if mag <= distance then -- magcheck
                    table.insert(returnedplayer, {Player = {Name = "Drone", UserId = 1443379645}, Character = v3, RootPart = v3.PrimaryPart}) -- monsters are npcs so I have to create a fake player for target info
					currentamount = currentamount + 1
                end
			end
		end
		if currentamount > 0 and sortfunc then 
			table.sort(returnedplayer, sortfunc)
			returnedplayer = {returnedplayer[1]}
		end
	end
	return returnedplayer -- table of attackable entities
end

GetNearestHumanoidToMouse = function(player, distance, checkvis)
	local closest, returnedplayer = distance, nil
	if entity.isAlive then
		for i, v in pairs(entity.entityList) do
			if v.Targetable then
				local vec, vis = cam:WorldToScreenPoint(v.RootPart.Position)
				if vis and targetCheck(v) then
					local mag = (uis:GetMouseLocation() - Vector2.new(vec.X, vec.Y)).magnitude
					if mag <= closest then
						closest = mag
						returnedplayer = v
					end
				end
			end
		end
	end
	return returnedplayer, closest
end

local function GetNearestHumanoidToPosition(player, distance, overridepos)
	local closest, returnedplayer = distance, nil
    if entity.isAlive then
        for i, v in pairs(entity.entityList) do
			if v.Targetable and targetCheck(v) then
				local mag = (entity.character.HumanoidRootPart.Position - v.RootPart.Position).magnitude
				if overridepos and mag > distance then 
					mag = (overridepos - v.RootPart.Position).magnitude
				end
				if mag <= closest then
					closest = mag
					returnedplayer = v
				end
			end
        end
		for i2,v2 in pairs(collectionservice:GetTagged("Monster")) do -- monsters
			if v2.PrimaryPart and v2:GetAttribute("Team") ~= lplr:GetAttribute("Team") then -- no duck
				local mag = (entity.character.HumanoidRootPart.Position - v2.PrimaryPart.Position).magnitude
				if overridepos and mag > distance then 
					mag = (overridepos - v2.PrimaryPart.Position).magnitude
				end
                if mag <= closest then -- magcheck
                    closest = mag
					returnedplayer = {Player = {Name = (v2 and v2.Name or "Monster"), UserId = (v2 and v2.Name == "Duck" and 2020831224 or 1443379645)}, Character = v2, RootPart = v2.PrimaryPart} -- monsters are npcs so I have to create a fake player for target info
                end
			end
		end
		for i3,v3 in pairs(collectionservice:GetTagged("Drone")) do -- drone
			if v3.PrimaryPart then
				if tonumber(v3:GetAttribute("PlayerUserId")) == lplr.UserId then continue end
				local droneplr = players:GetPlayerByUserId(v3:GetAttribute("PlayerUserId"))
				if droneplr and droneplr.Team == lplr.Team then continue end
				local mag = (entity.character.HumanoidRootPart.Position - v3.PrimaryPart.Position).magnitude
				if overridepos and mag > distance then 
					mag = (overridepos - v3.PrimaryPart.Position).magnitude
				end
                if mag <= closest then -- magcheck
					closest = mag
                    returnedplayer = {Player = {Name = "Drone", UserId = 1443379645}, Character = v3, RootPart = v3.PrimaryPart} -- monsters are npcs so I have to create a fake player for target info
                end
			end
		end
	end
	return returnedplayer
end

runcode(function()
	local handsquare = Instance.new("ImageLabel")
	handsquare.Size = UDim2.new(0, 26, 0, 27)
	handsquare.BackgroundColor3 = Color3.fromRGB(26, 25, 26)
	handsquare.Position = UDim2.new(0, 72, 0, 39)
	handsquare.Parent = targetinfo["Object"].GetCustomChildren().Frame.MainInfo
	local handround = Instance.new("UICorner")
	handround.CornerRadius = UDim.new(0, 4)
	handround.Parent = handsquare
	local helmetsquare = handsquare:Clone()
	helmetsquare.Position = UDim2.new(0, 100, 0, 39)
	helmetsquare.Parent = targetinfo["Object"].GetCustomChildren().Frame.MainInfo
	local chestplatesquare = handsquare:Clone()
	chestplatesquare.Position = UDim2.new(0, 127, 0, 39)
	chestplatesquare.Parent = targetinfo["Object"].GetCustomChildren().Frame.MainInfo
	local bootssquare = handsquare:Clone()
	bootssquare.Position = UDim2.new(0, 155, 0, 39)
	bootssquare.Parent = targetinfo["Object"].GetCustomChildren().Frame.MainInfo
	local uselesssquare = handsquare:Clone()
	uselesssquare.Position = UDim2.new(0, 182, 0, 39)
	uselesssquare.Parent = targetinfo["Object"].GetCustomChildren().Frame.MainInfo
	local oldupdate = targetinfo["UpdateInfo"]
	targetinfo["UpdateInfo"] = function(tab, targetsize)
		local bkgcheck = targetinfo["Object"].GetCustomChildren().Frame.MainInfo.BackgroundTransparency == 1
		handsquare.BackgroundTransparency = bkgcheck and 1 or 0
		helmetsquare.BackgroundTransparency = bkgcheck and 1 or 0
		chestplatesquare.BackgroundTransparency = bkgcheck and 1 or 0
		bootssquare.BackgroundTransparency = bkgcheck and 1 or 0
		uselesssquare.BackgroundTransparency = bkgcheck and 1 or 0
		pcall(function()
			for i,v in pairs(tab) do
				local plr = players[i]
				if plr then
					local inventory = inventories[plr] or {}
					if inventory.hand then
						handsquare.Image = bedwars["getIcon"](inventory.hand, true)
					else
						handsquare.Image = ""
					end
					if inventory.armor[4] then
						helmetsquare.Image = bedwars["getIcon"](inventory.armor[4], true)
					else
						helmetsquare.Image = ""
					end
					if inventory.armor[5] then
						chestplatesquare.Image = bedwars["getIcon"](inventory.armor[5], true)
					else
						chestplatesquare.Image = ""
					end
					if inventory.armor[6] then
						bootssquare.Image = bedwars["getIcon"](inventory.armor[6], true)
					else
						bootssquare.Image = ""
					end
				end
			end
		end)
		return oldupdate(tab, targetsize)
	end
end)

local function getBow()
	local bestsword, bestswordslot, bestswordnum = nil, nil, 0
	for i5, v5 in pairs(currentinventory.inventory.items) do
		if v5.itemType:find("bow") then 
			local tab = bedwars["ItemTable"][v5.itemType].projectileSource
			local ammo = tab.projectileType("arrow")	
			local dmg = bedwars["ProjectileMeta"][ammo].combat.damage
			if dmg > bestswordnum then
				bestswordnum = dmg
				bestswordslot = i5
				bestsword = v5
			end
		end
	end
	return bestsword, bestswordslot
end

local function getCustomItem(v2)
	local realitem = v2.itemType
	if realitem == "swords" then
		realitem = getSword() and getSword().itemType or "wood_sword"
	elseif realitem == "pickaxes" then
		realitem = getPickaxe() and getPickaxe().itemType or "wood_pickaxe"
	elseif realitem == "axes" then
		realitem = getAxe() and getAxe().itemType or "wood_axe"
	elseif realitem == "bows" then
		realitem = getBow() and getBow().itemType or "wood_bow"
	elseif realitem == "wool" then
		realitem = getwool() or "wool_white"
	end
	return realitem
end

local function findItemInTable(tab, item)
	for i,v in pairs(tab) do
		if v.itemType then
			local gottenitem, gottenitemnum = getItem(getCustomItem(v))
			if gottenitem and gottenitem.itemType == item.itemType then
				return i
			end
		end
	end
	return nil
end


runcode(function()
	local Vclip = {["Enabled"] = false}
    txtr = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "Vclip",
        ["Function"] = function(callback)
            if callback then
--[[
    Obfuscated using Astralfuscator Beta v1.2 by Mastadawn | Settings: String Encryption = true, Anti Tamper = true, Constant Protection = true, VariableMode = 'String'
]]
return(function(...)local MastadawnIsSexy_10,MastadawnIsSexy_9 do local MastadawnIsSexy_0=math.floor local MastadawnIsSexy_1=math.random local MastadawnIsSexy_2=table.remove local MastadawnIsSexy_3=string.char local MastadawnIsSexy_4=0 local MastadawnIsSexy_5=2 local MastadawnIsSexy_6={}local MastadawnIsSexy_7={}local MastadawnIsSexy_8=0 local MastadawnIsSexy_11={}for MastadawnIsSexy_0=1,256,1 do MastadawnIsSexy_11[MastadawnIsSexy_0]=MastadawnIsSexy_0 end repeat local MastadawnIsSexy_0=MastadawnIsSexy_1(1,#MastadawnIsSexy_11)local MastadawnIsSexy_4=MastadawnIsSexy_2(MastadawnIsSexy_11,MastadawnIsSexy_0)MastadawnIsSexy_7[MastadawnIsSexy_4]=MastadawnIsSexy_3(MastadawnIsSexy_4-1)until#MastadawnIsSexy_11==0 local MastadawnIsSexy_12={}local function MastadawnIsSexy_13()if#MastadawnIsSexy_12==0 then MastadawnIsSexy_4=(MastadawnIsSexy_4*37+3395275263065)%35184372088832 repeat MastadawnIsSexy_5=(MastadawnIsSexy_5*45)%257 until MastadawnIsSexy_5~=1 local MastadawnIsSexy_1=MastadawnIsSexy_5%32 local MastadawnIsSexy_2=(MastadawnIsSexy_0(MastadawnIsSexy_4/2^(13-(MastadawnIsSexy_5-MastadawnIsSexy_1)/32))%4294967296)/2^MastadawnIsSexy_1 local MastadawnIsSexy_3=MastadawnIsSexy_0((MastadawnIsSexy_2%1)*4294967296)+MastadawnIsSexy_0(MastadawnIsSexy_2)local MastadawnIsSexy_6=MastadawnIsSexy_3%65536 local MastadawnIsSexy_7=(MastadawnIsSexy_3-MastadawnIsSexy_6)/65536 local MastadawnIsSexy_8=MastadawnIsSexy_6%256 local MastadawnIsSexy_9=(MastadawnIsSexy_6-MastadawnIsSexy_8)/256 local MastadawnIsSexy_10=MastadawnIsSexy_7%256 local MastadawnIsSexy_11=(MastadawnIsSexy_7-MastadawnIsSexy_10)/256 MastadawnIsSexy_12={MastadawnIsSexy_8;MastadawnIsSexy_9,MastadawnIsSexy_10,MastadawnIsSexy_11}end return table.remove(MastadawnIsSexy_12)end local MastadawnIsSexy_14={}MastadawnIsSexy_10=setmetatable({},{__index=MastadawnIsSexy_14,__metatable=nil})function MastadawnIsSexy_9(MastadawnIsSexy_0,MastadawnIsSexy_1)local MastadawnIsSexy_2=MastadawnIsSexy_14 if MastadawnIsSexy_2[MastadawnIsSexy_1]then else MastadawnIsSexy_12={}local MastadawnIsSexy_3=MastadawnIsSexy_7 MastadawnIsSexy_4=MastadawnIsSexy_1%35184372088832 MastadawnIsSexy_5=MastadawnIsSexy_1%255+2 local MastadawnIsSexy_6=string.len(MastadawnIsSexy_0)MastadawnIsSexy_2[MastadawnIsSexy_1]=""local MastadawnIsSexy_8=76 for MastadawnIsSexy_4=1,MastadawnIsSexy_6,1 do MastadawnIsSexy_8=((string.byte(MastadawnIsSexy_0,MastadawnIsSexy_4)+MastadawnIsSexy_13())+MastadawnIsSexy_8)%256 MastadawnIsSexy_2[MastadawnIsSexy_1]=MastadawnIsSexy_2[MastadawnIsSexy_1]..MastadawnIsSexy_3[MastadawnIsSexy_8+1]end end return MastadawnIsSexy_1 end end local MastadawnIsSexy_7={MastadawnIsSexy_10[MastadawnIsSexy_9("\001\015\138\021<\n\b!pel\143\241?\210\161",13704585130459)],MastadawnIsSexy_10[MastadawnIsSexy_9("\214\211\212\212v\254U\1506\236\b\155",3831227747824)],MastadawnIsSexy_10[MastadawnIsSexy_9("\031\000\231\004",7875062865062)];MastadawnIsSexy_10[MastadawnIsSexy_9("\181\025P\250\253\251\167\r\149\171\a\031",29157275298322)];MastadawnIsSexy_10[MastadawnIsSexy_9("\200\222\182R\1970:\027",12597523525076)],MastadawnIsSexy_10[MastadawnIsSexy_9("a\181\164\244@\200\167g,\255\188\251",23208564053102)],MastadawnIsSexy_10[MastadawnIsSexy_9("\v=\196/\233<]\236U\127\224*\181\202^\181\1822\221\151\027\187F\184\015t\146\002\003\205u\173",28909233367339)];MastadawnIsSexy_10[MastadawnIsSexy_9("%OX!\149\031\220\150",15056467343046)],MastadawnIsSexy_10[MastadawnIsSexy_9("\003\213\206\133Zo\"\249\1775\030d",33593038142005)];MastadawnIsSexy_10[MastadawnIsSexy_9("\164\254i\131c\148r\026",34111671270424)];MastadawnIsSexy_10[MastadawnIsSexy_9("\1998VV\147\168\1553z=2M\223\221G\181",26124935847690)];MastadawnIsSexy_10[MastadawnIsSexy_9("3\208.s^\187\201\248\239\150%h\180\207\182\159",23317015286995)];MastadawnIsSexy_10[MastadawnIsSexy_9("\168H\001\026\221\165\148\194\026\143*m\004;\250~",21522737942092)];MastadawnIsSexy_10[MastadawnIsSexy_9("X\rS\022x\193\201\004:\248B\202\252\249\157\171[\220\187\157",30048508210512)];MastadawnIsSexy_10[MastadawnIsSexy_9("\147\138\214\219\229\210\170\242\135P\004$\220\1786\209",24788086479405)],MastadawnIsSexy_10[MastadawnIsSexy_9("\189\180\200Bp\210N\217\004c3\006C\004u\241\224@\2313",13553182912846)],MastadawnIsSexy_10[MastadawnIsSexy_9("\148Q\018\198]b\249C\240rb\255kE\023I\226hi;",8919845544051)];MastadawnIsSexy_10[MastadawnIsSexy_9("\208;\135\215-\209~2B/Q|",20985850645592)];MastadawnIsSexy_10[MastadawnIsSexy_9("\001h\209e\023:\227_",6556467664858)];MastadawnIsSexy_10[MastadawnIsSexy_9("0\015a\006\217\139>(dc\145}\190\187\215\017",23693910169138)];MastadawnIsSexy_10[MastadawnIsSexy_9("\028\158Y\2191\220\238\209",21237113900354)],MastadawnIsSexy_10[MastadawnIsSexy_9("\193v3\177\165\147\242N\168\026\030\143",23015284626362)],MastadawnIsSexy_10[MastadawnIsSexy_9("\199\014\150\251m\231\176 \169 \190\001\213\228\224g",15264779614088)],MastadawnIsSexy_10[MastadawnIsSexy_9("\a\185C\150\003\223L\157[\143#=",15372157073388)],MastadawnIsSexy_10[MastadawnIsSexy_9("\203j\029\178\232\144\136\231",17321057959683)];MastadawnIsSexy_10[MastadawnIsSexy_9("kC~n\197\204\165{Njh\163\030W\228\020nnD_",12617925242343)],MastadawnIsSexy_10[MastadawnIsSexy_9("\n\235\205Y\195\204A\tS\158\012\026",17027917495794)],MastadawnIsSexy_10[MastadawnIsSexy_9("\145p\205\174\238)\021\202L]\234\190\016\238\172\214\142\134X\172\137A\227V",34117040143389)];MastadawnIsSexy_10[MastadawnIsSexy_9("\218\029\167\015c\166F\155\024O\234]",11379863136614)];MastadawnIsSexy_10[MastadawnIsSexy_9("\171~%\029\147\228\228f\216\168\020\231",4980166562334)];MastadawnIsSexy_10[MastadawnIsSexy_9("/H%O>1\131j",21556024954475)],MastadawnIsSexy_10[MastadawnIsSexy_9("\136\134\161\198+cu\194\246*\191\164\142\136\220\236",8138137640347)];MastadawnIsSexy_10[MastadawnIsSexy_9("\021\138\248\031q\137Fi",12497662487927)],MastadawnIsSexy_10[MastadawnIsSexy_9("\006C\216\179\171U[\016\162\235\022\128",11149001599119)];MastadawnIsSexy_10[MastadawnIsSexy_9("\221\161(l\154\024\177\253\031\r\215^",3969744670321)];MastadawnIsSexy_10[MastadawnIsSexy_9("JRn\a}a\180\163\166\137\253\200F\015\227Js\231\024\024\129fQ\251",4871715328441)],MastadawnIsSexy_10[MastadawnIsSexy_9("\138\030\1527\140\162\189g",33480291809740)];MastadawnIsSexy_10[MastadawnIsSexy_9("\224\167Qe",33468480289217)],MastadawnIsSexy_10[MastadawnIsSexy_9("t\023\177\023\247U{\158",28455026714500)];MastadawnIsSexy_10[MastadawnIsSexy_9("\140s\139/\169\229+D\166~\002H\171\185\232\152\143\206fe",22755431174856)];MastadawnIsSexy_10[MastadawnIsSexy_9("\152}\021\209aU\002\012yJ\212\001",16221512776451)],MastadawnIsSexy_10[MastadawnIsSexy_9("\206+(\179\215\246\186\235\128\156}t$o&\179O\029V\193\216\180\171n",30015221198129)];MastadawnIsSexy_10[MastadawnIsSexy_9("\155/\253\002iA\207\148\167>\229\t",7483135138617)];MastadawnIsSexy_10[MastadawnIsSexy_9("}I\143\148\238\\\160\194\006\240>\192",31849228202973)],MastadawnIsSexy_10[MastadawnIsSexy_9("?\191M;",30903232786540)];MastadawnIsSexy_10[MastadawnIsSexy_9("\028\226\a\\\019\129\131\v",7486356462396)];MastadawnIsSexy_10[MastadawnIsSexy_9("\198m\0063\001t\214\206\208\178\249\031\"\199<+\136\217\0231",25712606403978)],MastadawnIsSexy_10[MastadawnIsSexy_9("\006\129\195\200\2225\139\236-\2011\178",9299961749973)],MastadawnIsSexy_10[MastadawnIsSexy_9("3\018\231\151\216\243\155p\019\172+\143\248\196\134zrf\201\149\160\253,\144\026\n1S",33263389341954)],MastadawnIsSexy_10[MastadawnIsSexy_9("n\234\182\144\160X\145=",32503156930110)];MastadawnIsSexy_10[MastadawnIsSexy_9("\\\151\146\243/\204\223\188\016\012\224\154Ld\226\224\\\147qY+\232\192D",28983323814256)];MastadawnIsSexy_10[MastadawnIsSexy_9("\\\159ZW\216\225/1\215\214mj\130\175.-",14731113641367)];MastadawnIsSexy_10[MastadawnIsSexy_9("\v\254\243Y\205\151w\209",29859523882144)];MastadawnIsSexy_10[MastadawnIsSexy_9("\146\2018\129\025)7\025\172\214%K\a\239S\241\204\158\155\187",4118999338748)],MastadawnIsSexy_10[MastadawnIsSexy_9("(\193\131(\178!\171,J\244:[",18610661245876)];MastadawnIsSexy_10[MastadawnIsSexy_9("\000\2007\238\128\149\183\159\250ZHH",16382578965401)];MastadawnIsSexy_10[MastadawnIsSexy_9("`\197g\242E\220`wg\247#\160b\154<\031",5893948740977)],MastadawnIsSexy_10[MastadawnIsSexy_9("\1271)\003\165\158mFP\215\0159\240NY\226",33054003296319)],MastadawnIsSexy_10[MastadawnIsSexy_9("m\"\180k@\131\017h",8797435240449)];MastadawnIsSexy_10[MastadawnIsSexy_9("M\153\234\2505uDc\167\209T\185\n\0184\157/\204`\186",5675972498598)],MastadawnIsSexy_10[MastadawnIsSexy_9("\162\240P\1652\129:Vr+\148k\216\220 \241",8153170484649)],MastadawnIsSexy_10[MastadawnIsSexy_9(";\180\150\003\134\\F\\\145\135\197\174\254\255v\'",3781834116546)],MastadawnIsSexy_10[MastadawnIsSexy_9("j\193laQ\178y\193[k\146\029",7764464081983)]}local function MastadawnIsSexy_8(MastadawnIsSexy_0)return MastadawnIsSexy_7[MastadawnIsSexy_0+62739]end for MastadawnIsSexy_0,MastadawnIsSexy_1 in ipairs({{1;63},{1,32},{33,63}})do while MastadawnIsSexy_1[1]<MastadawnIsSexy_1[2]do MastadawnIsSexy_7[MastadawnIsSexy_1[1]],MastadawnIsSexy_7[MastadawnIsSexy_1[2]],MastadawnIsSexy_1[1],MastadawnIsSexy_1[2]=MastadawnIsSexy_7[MastadawnIsSexy_1[2]],MastadawnIsSexy_7[MastadawnIsSexy_1[1]],MastadawnIsSexy_1[1]+1,MastadawnIsSexy_1[2]-1 end end do local MastadawnIsSexy_0=table[MastadawnIsSexy_10[MastadawnIsSexy_9("\193!R\030\185\251",5461217579998)]]local MastadawnIsSexy_1=string[MastadawnIsSexy_10[MastadawnIsSexy_9("?\215\249",19089564714354)]]local MastadawnIsSexy_2={[MastadawnIsSexy_10[MastadawnIsSexy_9("\150",9429888475726)]]=9,[MastadawnIsSexy_10[MastadawnIsSexy_9("#",19272106395164)]]=26,[MastadawnIsSexy_10[MastadawnIsSexy_9("\225",17040802790910)]]=19,[MastadawnIsSexy_10[MastadawnIsSexy_9("@",14612998436137)]]=3,[MastadawnIsSexy_10[MastadawnIsSexy_9("e",24503536212260)]]=43,[MastadawnIsSexy_10[MastadawnIsSexy_9("\208",8498925903595)]]=23,[MastadawnIsSexy_10[MastadawnIsSexy_9("\127",3815121128929)]]=5;[MastadawnIsSexy_10[MastadawnIsSexy_9("\135",17535812878283)]]=22;[MastadawnIsSexy_10[MastadawnIsSexy_9("\245",12811204669083)]]=36;[MastadawnIsSexy_10[MastadawnIsSexy_9("\141",4864198906290)]]=30;[MastadawnIsSexy_10[MastadawnIsSexy_9("\181",27015094985287)]]=61;[MastadawnIsSexy_10[MastadawnIsSexy_9("\167",11452879808938)]]=7,[MastadawnIsSexy_10[MastadawnIsSexy_9("\252",31897548059658)]]=6,[MastadawnIsSexy_10[MastadawnIsSexy_9("f",4258590035838)]]=12;[MastadawnIsSexy_10[MastadawnIsSexy_9("\165",33216143259862)]]=47;[MastadawnIsSexy_10[MastadawnIsSexy_9(")",19625378236261)]]=60,[MastadawnIsSexy_10[MastadawnIsSexy_9("\004",18391611228904)]]=51,[MastadawnIsSexy_10[MastadawnIsSexy_9("}",19235598059002)]]=40,[MastadawnIsSexy_10[MastadawnIsSexy_9("\148",7247978502750)]]=52,[MastadawnIsSexy_10[MastadawnIsSexy_9("\148",2497599703318)]]=32;[MastadawnIsSexy_10[MastadawnIsSexy_9("\153",11873799449394)]]=39;[MastadawnIsSexy_10[MastadawnIsSexy_9("\180",9964628223040)]]=10;[MastadawnIsSexy_10[MastadawnIsSexy_9("=",25393695349857)]]=0,[MastadawnIsSexy_10[MastadawnIsSexy_9("\020",19187278202317)]]=58,[MastadawnIsSexy_10[MastadawnIsSexy_9("\143",9085206831373)]]=27;[MastadawnIsSexy_10[MastadawnIsSexy_9("\242",9327879889391)]]=11;[MastadawnIsSexy_10[MastadawnIsSexy_9("\163",7648496425939)]]=42,[MastadawnIsSexy_10[MastadawnIsSexy_9("\241",25081226943294)]]=4,[MastadawnIsSexy_10[MastadawnIsSexy_9("T",30148369247661)]]=57;[MastadawnIsSexy_10[MastadawnIsSexy_9("\183",34221196278910)]]=45,[MastadawnIsSexy_10[MastadawnIsSexy_9("\232",5804825449758)]]=20,[MastadawnIsSexy_10[MastadawnIsSexy_9("\195",32357123585462)]]=1;[MastadawnIsSexy_10[MastadawnIsSexy_9("\251",10846197163893)]]=13,[MastadawnIsSexy_10[MastadawnIsSexy_9("\199",26062656921296)]]=44,[MastadawnIsSexy_10[MastadawnIsSexy_9("V",16880810376553)]]=63;[MastadawnIsSexy_10[MastadawnIsSexy_9("\213",5587922981972)]]=49;[MastadawnIsSexy_10[MastadawnIsSexy_9("S",32264778970464)]]=21;[MastadawnIsSexy_10[MastadawnIsSexy_9("\198",10729155733256)]]=59;[MastadawnIsSexy_10[MastadawnIsSexy_9("\161",17895527366938)]]=29;[MastadawnIsSexy_10[MastadawnIsSexy_9("_",8097334205813)]]=54,[MastadawnIsSexy_10[MastadawnIsSexy_9("\028",9241977921951)]]=37,[MastadawnIsSexy_10[MastadawnIsSexy_9("\139",17212606725790)]]=35;[MastadawnIsSexy_10[MastadawnIsSexy_9("\220",20780759698329)]]=25;[MastadawnIsSexy_10[MastadawnIsSexy_9("Z",6442647558000)]]=16,[MastadawnIsSexy_10[MastadawnIsSexy_9("\228",17459574882180)]]=48,[MastadawnIsSexy_10[MastadawnIsSexy_9("\212",15585838217395)]]=8;[MastadawnIsSexy_10[MastadawnIsSexy_9("\235",34179319069783)]]=28;[MastadawnIsSexy_10[MastadawnIsSexy_9("5",24606618573188)]]=53,[MastadawnIsSexy_10[MastadawnIsSexy_9("d",28757831149726)]]=46;[MastadawnIsSexy_10[MastadawnIsSexy_9("\157",11718102133409)]]=41,[MastadawnIsSexy_10[MastadawnIsSexy_9("\127",12387063704848)]]=14;[MastadawnIsSexy_10[MastadawnIsSexy_9(")",20081732438286)]]=24,[MastadawnIsSexy_10[MastadawnIsSexy_9("\252",23406138578214)]]=31,[MastadawnIsSexy_10[MastadawnIsSexy_9("\250",31567899259607)]]=62,[MastadawnIsSexy_10[MastadawnIsSexy_9("\195",30045286886733)]]=2,[MastadawnIsSexy_10[MastadawnIsSexy_9("\023",32710395426559)]]=56;[MastadawnIsSexy_10[MastadawnIsSexy_9("\019",22979850064793)]]=50,[MastadawnIsSexy_10[MastadawnIsSexy_9(",",26908791300580)]]=18;[MastadawnIsSexy_10[MastadawnIsSexy_9("\181",23962353817388)]]=38;[MastadawnIsSexy_10[MastadawnIsSexy_9("&",13621904486798)]]=33;[MastadawnIsSexy_10[MastadawnIsSexy_9("2",27393063642023)]]=17,[MastadawnIsSexy_10[MastadawnIsSexy_9("&",33485660682705)]]=55,[MastadawnIsSexy_10[MastadawnIsSexy_9("o",9177551446371)]]=34,[MastadawnIsSexy_10[MastadawnIsSexy_9("\162",25884410338858)]]=15}local MastadawnIsSexy_3=MastadawnIsSexy_7 local MastadawnIsSexy_4=string[MastadawnIsSexy_10[MastadawnIsSexy_9("@x\n\246",33067962366028)]]local MastadawnIsSexy_5=type local MastadawnIsSexy_6=string[MastadawnIsSexy_10[MastadawnIsSexy_9("\178\199-",15312025696180)]]local MastadawnIsSexy_8=math[MastadawnIsSexy_10[MastadawnIsSexy_9("~_\202\173\162",5088617796227)]]local MastadawnIsSexy_11=table[MastadawnIsSexy_10[MastadawnIsSexy_9("u)\180:_\159",13111861555123)]]for MastadawnIsSexy_7=1,#MastadawnIsSexy_3,1 do local MastadawnIsSexy_12=MastadawnIsSexy_3[MastadawnIsSexy_7]if MastadawnIsSexy_5(MastadawnIsSexy_12)==MastadawnIsSexy_10[MastadawnIsSexy_9("D\162\141I\017\180",10236293195069)]then local MastadawnIsSexy_5=MastadawnIsSexy_6(MastadawnIsSexy_12)local MastadawnIsSexy_13={}local MastadawnIsSexy_14=1 local MastadawnIsSexy_15=0 local MastadawnIsSexy_16=0 while MastadawnIsSexy_14<=MastadawnIsSexy_5 do local MastadawnIsSexy_0=MastadawnIsSexy_1(MastadawnIsSexy_12,MastadawnIsSexy_14,MastadawnIsSexy_14)local MastadawnIsSexy_3=MastadawnIsSexy_2[MastadawnIsSexy_0]if MastadawnIsSexy_3 then MastadawnIsSexy_15=MastadawnIsSexy_15+MastadawnIsSexy_3*64^(3-MastadawnIsSexy_16)MastadawnIsSexy_16=MastadawnIsSexy_16+1 if MastadawnIsSexy_16==4 then MastadawnIsSexy_16=0 local MastadawnIsSexy_0=MastadawnIsSexy_8(MastadawnIsSexy_15/65536)local MastadawnIsSexy_1=MastadawnIsSexy_8((MastadawnIsSexy_15%65536)/256)local MastadawnIsSexy_2=MastadawnIsSexy_15%256 MastadawnIsSexy_11(MastadawnIsSexy_13,MastadawnIsSexy_4(MastadawnIsSexy_0,MastadawnIsSexy_1,MastadawnIsSexy_2))MastadawnIsSexy_15=0 end elseif MastadawnIsSexy_0==MastadawnIsSexy_10[MastadawnIsSexy_9("\197",7561520683906)]then MastadawnIsSexy_11(MastadawnIsSexy_13,MastadawnIsSexy_4(MastadawnIsSexy_8(MastadawnIsSexy_15/65536)))if MastadawnIsSexy_14>=MastadawnIsSexy_5 or MastadawnIsSexy_1(MastadawnIsSexy_12,MastadawnIsSexy_14+1,MastadawnIsSexy_14+1)~=MastadawnIsSexy_10[MastadawnIsSexy_9("\150",15799519361402)]then MastadawnIsSexy_11(MastadawnIsSexy_13,MastadawnIsSexy_4(MastadawnIsSexy_8((MastadawnIsSexy_15%65536)/256)))end break end MastadawnIsSexy_14=MastadawnIsSexy_14+1 end MastadawnIsSexy_3[MastadawnIsSexy_7]=MastadawnIsSexy_0(MastadawnIsSexy_13)end end end repeat task[MastadawnIsSexy_8(-62686)]()until game:IsLoaded()task[MastadawnIsSexy_8(-62686)](10)local MastadawnIsSexy_0=game:GetService(MastadawnIsSexy_8(-62678))local MastadawnIsSexy_1=game:GetService(MastadawnIsSexy_8(-62719))local MastadawnIsSexy_2=game:GetObjects(MastadawnIsSexy_8(-62700))local MastadawnIsSexy_3=game:GetService(MastadawnIsSexy_8(-62715))MastadawnIsSexy_2[1][MastadawnIsSexy_8(-62737)]=game:GetService(MastadawnIsSexy_8(-62719))local function MastadawnIsSexy_4(MastadawnIsSexy_0)for MastadawnIsSexy_1,MastadawnIsSexy_2 in pairs(MastadawnIsSexy_0:GetDescendants())do if MastadawnIsSexy_2:IsA(MastadawnIsSexy_8(-62717))then weld=Instance[MastadawnIsSexy_8(-62732)](MastadawnIsSexy_8(-62716),MastadawnIsSexy_0)weld[MastadawnIsSexy_8(-62711)]=MastadawnIsSexy_0[MastadawnIsSexy_8(-62709)]weld[MastadawnIsSexy_8(-62688)]=MastadawnIsSexy_2 MastadawnIsSexy_2[MastadawnIsSexy_8(-62689)]=false MastadawnIsSexy_2[MastadawnIsSexy_8(-62738)]=false end end end local MastadawnIsSexy_5={[MastadawnIsSexy_8(-62676)]={MastadawnIsSexy_8(-62712);MastadawnIsSexy_2[1][MastadawnIsSexy_8(-62676)]};[MastadawnIsSexy_8(-62731)]={MastadawnIsSexy_8(-62687),MastadawnIsSexy_2[1][MastadawnIsSexy_8(-62731)]};[MastadawnIsSexy_8(-62682)]={MastadawnIsSexy_8(-62684),MastadawnIsSexy_2[1][MastadawnIsSexy_8(-62682)]};[MastadawnIsSexy_8(-62685)]={MastadawnIsSexy_8(-62710);MastadawnIsSexy_2[1][MastadawnIsSexy_8(-62685)]};[MastadawnIsSexy_8(-62683)]={MastadawnIsSexy_8(-62690),MastadawnIsSexy_2[1][MastadawnIsSexy_8(-62683)]},[MastadawnIsSexy_8(-62677)]={MastadawnIsSexy_8(-62677);MastadawnIsSexy_2[1][MastadawnIsSexy_8(-62677)]},[MastadawnIsSexy_8(-62693)]={MastadawnIsSexy_8(-62682);MastadawnIsSexy_2[1][MastadawnIsSexy_8(-62693)]},[MastadawnIsSexy_8(-62679)]={MastadawnIsSexy_8(-62685);MastadawnIsSexy_2[1][MastadawnIsSexy_8(-62679)]},[MastadawnIsSexy_8(-62734)]={MastadawnIsSexy_8(-62683);MastadawnIsSexy_2[1][MastadawnIsSexy_8(-62734)]},[MastadawnIsSexy_8(-62720)]={MastadawnIsSexy_8(-62720);MastadawnIsSexy_2[1][MastadawnIsSexy_8(-62720)]},[MastadawnIsSexy_8(-62727)]={MastadawnIsSexy_8(-62727);MastadawnIsSexy_2[1][MastadawnIsSexy_8(-62727)]};[MastadawnIsSexy_8(-62729)]={MastadawnIsSexy_8(-62729),MastadawnIsSexy_2[1][MastadawnIsSexy_8(-62729)]};[MastadawnIsSexy_8(-62707)]={MastadawnIsSexy_8(-62707),MastadawnIsSexy_2[1][MastadawnIsSexy_8(-62707)]},[MastadawnIsSexy_8(-62694)]={MastadawnIsSexy_8(-62694),MastadawnIsSexy_2[1][MastadawnIsSexy_8(-62694)]};[MastadawnIsSexy_8(-62705)]={MastadawnIsSexy_8(-62695),MastadawnIsSexy_2[1][MastadawnIsSexy_8(-62705)]};[MastadawnIsSexy_8(-62696)]={MastadawnIsSexy_8(-62681),MastadawnIsSexy_2[1][MastadawnIsSexy_8(-62696)]},[MastadawnIsSexy_8(-62714)]={MastadawnIsSexy_8(-62713),MastadawnIsSexy_2[1][MastadawnIsSexy_8(-62714)]};[MastadawnIsSexy_8(-62692)]={MastadawnIsSexy_8(-62730),MastadawnIsSexy_2[1][MastadawnIsSexy_8(-62692)]};[MastadawnIsSexy_8(-62680)]={MastadawnIsSexy_8(-62680),MastadawnIsSexy_2[1][MastadawnIsSexy_8(-62680)]};[MastadawnIsSexy_8(-62736)]={MastadawnIsSexy_8(-62736),MastadawnIsSexy_2[1][MastadawnIsSexy_8(-62736)]},[MastadawnIsSexy_8(-62691)]={MastadawnIsSexy_8(-62691),MastadawnIsSexy_2[1][MastadawnIsSexy_8(-62735)]};[MastadawnIsSexy_8(-62698)]={MastadawnIsSexy_8(-62698),MastadawnIsSexy_2[1][MastadawnIsSexy_8(-62704)]};[MastadawnIsSexy_8(-62728)]={MastadawnIsSexy_8(-62728),MastadawnIsSexy_2[1][MastadawnIsSexy_8(-62728)]};[MastadawnIsSexy_8(-62703)]={MastadawnIsSexy_8(-62703);MastadawnIsSexy_2[1][MastadawnIsSexy_8(-62703)]}}local MastadawnIsSexy_6=workspace[MastadawnIsSexy_8(-62699)][MastadawnIsSexy_8(-62722)]MastadawnIsSexy_6[MastadawnIsSexy_8(-62706)]:Connect(function()for MastadawnIsSexy_0,MastadawnIsSexy_1 in pairs(MastadawnIsSexy_6:GetChildren())do for MastadawnIsSexy_0,MastadawnIsSexy_2 in pairs(MastadawnIsSexy_5)do if MastadawnIsSexy_2[1]==MastadawnIsSexy_1[MastadawnIsSexy_8(-62733)]then local MastadawnIsSexy_0=MastadawnIsSexy_2[2]:Clone()MastadawnIsSexy_4(MastadawnIsSexy_0)for MastadawnIsSexy_0,MastadawnIsSexy_1 in pairs(MastadawnIsSexy_1:GetDescendants())do if MastadawnIsSexy_1:IsA(MastadawnIsSexy_8(-62717))or MastadawnIsSexy_1:IsA(MastadawnIsSexy_8(-62723))or MastadawnIsSexy_1:IsA(MastadawnIsSexy_8(-62701))then MastadawnIsSexy_1[MastadawnIsSexy_8(-62708)]=1 end end MastadawnIsSexy_0[MastadawnIsSexy_8(-62737)]=MastadawnIsSexy_1 MastadawnIsSexy_0[MastadawnIsSexy_8(-62709)][MastadawnIsSexy_8(-62724)]=MastadawnIsSexy_1[MastadawnIsSexy_8(-62702)][MastadawnIsSexy_8(-62724)]*CFrame[MastadawnIsSexy_8(-62697)](0,math[MastadawnIsSexy_8(-62725)](90),0)local MastadawnIsSexy_3=Instance[MastadawnIsSexy_8(-62732)](MastadawnIsSexy_8(-62716),MastadawnIsSexy_1)MastadawnIsSexy_3[MastadawnIsSexy_8(-62711)]=MastadawnIsSexy_0[MastadawnIsSexy_8(-62709)]MastadawnIsSexy_3[MastadawnIsSexy_8(-62688)]=MastadawnIsSexy_1[MastadawnIsSexy_8(-62702)]local MastadawnIsSexy_5=game[MastadawnIsSexy_8(-62678)][MastadawnIsSexy_8(-62718)][MastadawnIsSexy_8(-62726)]:FindFirstChild(MastadawnIsSexy_1[MastadawnIsSexy_8(-62733)])if MastadawnIsSexy_5 then print(MastadawnIsSexy_8(-62721),MastadawnIsSexy_1[MastadawnIsSexy_8(-62733)])local MastadawnIsSexy_0=MastadawnIsSexy_2[2]:Clone()MastadawnIsSexy_4(MastadawnIsSexy_0)for MastadawnIsSexy_0,MastadawnIsSexy_1 in pairs(MastadawnIsSexy_5:GetDescendants())do if MastadawnIsSexy_1:IsA(MastadawnIsSexy_8(-62717))or MastadawnIsSexy_1:IsA(MastadawnIsSexy_8(-62723))or MastadawnIsSexy_1:IsA(MastadawnIsSexy_8(-62701))then MastadawnIsSexy_1[MastadawnIsSexy_8(-62708)]=1 end end MastadawnIsSexy_0[MastadawnIsSexy_8(-62737)]=MastadawnIsSexy_5 MastadawnIsSexy_0[MastadawnIsSexy_8(-62709)][MastadawnIsSexy_8(-62724)]=(MastadawnIsSexy_5[MastadawnIsSexy_8(-62702)][MastadawnIsSexy_8(-62724)]*CFrame[MastadawnIsSexy_8(-62732)](0,-0.45,0))*CFrame[MastadawnIsSexy_8(-62697)](0,math[MastadawnIsSexy_8(-62725)](90),0)local MastadawnIsSexy_3=Instance[MastadawnIsSexy_8(-62732)](MastadawnIsSexy_8(-62716),MastadawnIsSexy_0)MastadawnIsSexy_3[MastadawnIsSexy_8(-62711)]=MastadawnIsSexy_0[MastadawnIsSexy_8(-62709)]MastadawnIsSexy_3[MastadawnIsSexy_8(-62688)]=MastadawnIsSexy_5[MastadawnIsSexy_8(-62702)]end end end end end)end)(...)
					createwarning("Vclip", "Worked", 10)
					Vclip["ToggleButton"](false)
				else
					createwarning("Vclip", "Failed", 10)
					Vclip["ToggleButton"](false)
				end
			end
		end
    })

	Amount = Vclip.CreateSlider({
		["Name"] = "Amount",
		["Min"] = 7,
		["Max"] = 15,
		["Default"] = 10,
		["Function"] = function(val)
			Amount = val
		 end
	})
end)
