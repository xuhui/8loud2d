gameW = 24     -- Game width
gameH = 5     -- Game height
gridSize = 40  -- Size of the grid squares
tileSize = gridSize-10  -- Size of the tiles (snake bits and pellets)
-- pelletShape = "circle" -- 'square' or 'circle'
-- pelletMin = 20 -- Min ticks between pellets
-- pelletMax = 40 -- Max ticks between pellets
wrap = false   -- Snake wraps around screen

function love.conf(t)
  screenW = gameW * gridSize + 8
  screenH = gameH * gridSize + 8
  t.title = "SMART GAME"         -- The title of the window the game is in (string)
  t.author = "X. H."     -- The author of the game (string)
  t.window.width = screenW  -- The window width (number)
  t.window.height = screenH -- The window height (number)
end
