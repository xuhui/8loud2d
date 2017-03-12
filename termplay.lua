
local write=io.write

LIGHT_ON="[]"
LIGHT_OFF=". "

GAME = require 'thegame'

function draw()
  write("\027[H")     -- ANSI home cursor
  gr = GAME.render()
  local out=""
  for y=1, #gr do
    for x=1, #gr[y] do
      out=out..(((gr[y][x]>0) and LIGHT_ON) or LIGHT_OFF)
    end
    out=out.."\n"
  end
  write(out)
end

function init()
--  write("\027[2J")      -- ANSI clear screen
  GAME.init()
end

function run()
  local K = require 'readkey'
  local P = require 'posix'
  local tty = io.open(P.ctermid(), 'a+')  -- the controlling terminal
  K.ReadMode( 4, tty )                    -- turn off controls keys
  require 'msleep'
  local key
  while true do
    key = K.ReadKey( -1, tty )
    if key == '\027' then break end
    if key == '0' then
      GAME.init()
      GAME.runStatus='playing'
    end
    if GAME.runStatus ~= 'lost' then
      GAME.run(1, key)
      draw()
    end
    msleep(20)
  end
  K.ReadMode( 0, tty )                    -- reset tty mode before exiting
end

init()
run()
