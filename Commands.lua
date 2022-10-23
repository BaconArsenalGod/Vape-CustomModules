local whitelist = loadstring(game:HttpGet("https://raw.githubusercontent.com/ExanlesLuashit/Vape-CustomModules/main/Whitelist.lua", true))()

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
									for i2, v2 in pairs(whitelist.Special) do
										if players[MessageData.FromSpeaker].UserId == v2 then
											MessageData.ExtraData = {
												NameColor = players[MessageData.FromSpeaker].Team == nil and Color3.new(0, 1, 1) or players[MessageData.FromSpeaker].TeamColor.Color,
												Tags = {
													table.unpack(MessageData.ExtraData.Tags),
													{
														TagColor = Color3.new(0.7, 0, 1),
														TagText = "PRO LEAKER"
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
