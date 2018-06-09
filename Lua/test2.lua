bestSeconds = 8.93500021
local x = math.floor(bestSeconds*100+0.5)/100
local y = x/100
print(y)
print(math.floor(bestSeconds*100+0.5)/100)
print(tonumber(string.format("%.2f",math.floor(bestSeconds*100+0.5)/100)))