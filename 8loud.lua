
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
  if key == '1' then
    table.remove(G.grid[1])
  end
end

return G
