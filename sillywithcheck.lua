repeat wait() until game:IsLoaded()

local Players = game:GetService("Players")
local getPlayers = Players:GetPlayers()
local PlayerInServer = #getPlayers
local alts = {"Rainbowsun210416","SunnyALT2016","SunnyBoiiiiii7","Rainbowsunny210416","IScarePS99Players4","IScarePS99Players5"}

local function jumpToServer() 
local sfUrl = "https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=%s&limit=%s&excludeFullGames=true" 
local req = request({ Url = string.format(sfUrl, 8737899170, "Desc", 100) }) 
local body = game:GetService("HttpService"):JSONDecode(req.Body) 
local deep = math.random(1, 4)
if deep > 1 then 
    for i = 1, deep, 1 do 
        req = request({ Url = string.format(sfUrl .. "&cursor=" .. body.nextPageCursor, 8737899170, "Desc", 100) }) 
        body = game:GetService("HttpService"):JSONDecode(req.Body) 
        task.wait(0.1)
    end 
end 
local servers = {} 
if body and body.data then 
    for i, v in next, body.data do 
            if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= game.JobId then
                table.insert(servers, 1, v.id)
            end
        end
    end
    local randomCount = #servers
    if not randomCount then
        randomCount = 2
    end
    game:GetService("TeleportService"):TeleportToPlaceInstance(8737899170, servers[math.random(1, randomCount)], game:GetService("Players").LocalPlayer) 
end

for i = 1, PlayerInServer do
   for ii = 1,#alts do
        if getPlayers[i].Name == alts[ii] and alts[ii] ~= Players.LocalPlayer.Name then
            while task.wait(10) do
		        jumpToServer()
	        end
        end
    end
end

Players.PlayerAdded:Connect(function(player)
    for i = 1,#alts do
        if player.Name == alts[i] and alts[i] ~= Players.LocalPlayer.Name then
	        task.wait(math.random(0, 60))
                while task.wait(10) do
	                jumpToServer()
	            end
        end
    end
end)
