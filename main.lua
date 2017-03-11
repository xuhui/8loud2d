
require "runengine"
require "keyboard"
require "render"

GAME = require "8loud"

offset = 0
screenX = 1
screenY = 1
key = ""           -- Latest pressed key
latestKey = ""
gameIsLost = false -- Whether the game has been lost or not
runStatus = "start"    -- Game screen
menuStage = 0
score = 0

-- min_dt = 1/60

-- love_timer_sleep = love.timer.sleep -- in s (like >=0.8.0)
-- if love._version:find("^0%.[0-7]%.") then -- if version < 0.8.0
--  love_timer_sleep = function(s) love.timer.sleep(s*1000) end
-- end

function love.load()
  -- if love.graphics.setMode(screenW, screenH) == false then love.event.quit() end
  renderInit()
  randomInit()
  loveInit()
--  tiles = {}
--  gridInit()

end

function renderInit()
  screenW2 = screenW / 2
  screenH2 = screenH / 2
  circleSize = math.floor(tileSize / 2)
  squareOffset = math.ceil((gridSize - tileSize) / 2) + 3 - gridSize
  circleOffset = math.ceil(gridSize / 2) + 3 - gridSize
end

function loveInit()
  gfx = love.graphics
  kbd = love.keyboard
  gfx.setLineWidth(1)
  gfx.setLineStyle("rough")
end

function randomInit()
  math.randomseed(os.time())
  math.random()
  math.random()
  math.random()
end
