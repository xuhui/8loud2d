
local G = {}

G.grid = {}
G.jumper = {x = 6, y = 4, e = 0}
G.hole = 0 -- if G.hole > 0 then will place a hole in front of the ground, sized with G.hold

function G.run(dt, key)
  -- print("@" .. (dt or 'nil') .. "-" .. (key or 'nil'))
  if key and key >= '1' and key <= '9' then
    G.jumper.e = key - '0'
  end

  local ground_line = #G.grid  -- #self
  hasGround = G.grid[ground_line][G.jumper.x] ~= 0
  if G.jumper.e == 0 and G.jumper.y == ground_line - 1 and hasGround then return end

  table.remove(G.grid[ground_line], 1)
  if G.hole > 0 then
    table.insert(G.grid[ground_line], #G.grid[ground_line] + 1, 0)
    G.hole = G.hole - 1
  else
    table.insert(G.grid[ground_line], #G.grid[ground_line] + 1, 1)
    -- not to place hole as 'hole == 0', then check if it should be placed
    local ground_completeness = 0
    for x=gameW,1,-1 do
      if G.grid[ground_line][x] == 0 then
        break
      end
      ground_completeness = ground_completeness + G.grid[ground_line][x];
    end
    if ground_completeness > 15 then
      G.hole = math.random(1,10)
    end
  end


  if G.jumper.e > 0 then
    G.jumper.e = G.jumper.e - 1
    if G.jumper.y > 1 then
      G.jumper.y = G.jumper.y - 1
    end
  else
    if G.jumper.y < 4 then
      print("@1")
      G.jumper.y = G.jumper.y + 1
    elseif G.jumper.y > 5 then
      print("@2")
      G.jumper.y = G.jumper.y + 1
      runStatus = 'lost'
    -- elseif G.grid[5][G.jumper.x] < 1 then
    elseif 0 < 1 then
    print("a3a " .. G.grid[5][G.jumper.x] .. ' ' .. G.jumper.x ..'*')
      G.jumper.y = G.jumper.y + 1
    end
    print("aa " .. G.grid[5][G.jumper.x] .. ' ' .. G.jumper.x ..'*'.. G.jumper.y)
  end
end

function G.jump(energy)
  G.jumper.e = energy
end

function G.render()
  local gr = {}
  for y = 1, gameH do
    gr[y] = {}
    for x=1, gameW do
      if x == G.jumper.x and y == G.jumper.y then
        gr[y][x] = 1
      else
        gr[y][x] = G.grid[y][x]
      end
    end
  end
  return gr
end

function G.init()

  G.jumper = {x = 6, y = 4, e = 0}
  G.hole = 0 -- if G.hole > 0 then will place a hole in front of the ground, sized with G.hold
  for y = 1, gameH do
    G.grid[y] = {}
    for x=1, gameW do
      G.grid[y][x] = y == gameH and 1 or 0
    end
  end

end

-- init
for y = 1, gameH do
  G.grid[y] = {}
  for x=1, gameW do
    G.grid[y][x] = y == gameH and 1 or 0
  end
end

-- return an initialized GAME object
return G
