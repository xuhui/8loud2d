
local G = {}

G.grid = {}

for y = 1, gameH, 1 do
	G.grid[y] = {}
	for x=1, gameW, 1 do
		G.grid[y][x] = "o"
	end
end

function G.run(dt, key)
  print("@" .. (dt or 'nil') .. "-" .. (key or 'nil'))
  if key and key >= '1' and key <= '9' then
    G.grid[1][key - '0'] = ""
  end
end

return G
