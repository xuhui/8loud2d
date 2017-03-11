function love.draw()
  if runStatus == "playing" then renderBoard()
  elseif runStatus == "lost" then renderScore()
  elseif runStatus == "start" then
    setColor("white")
    gfx.printf("Press SPACE to start, [1]-[9] to jump, [ESC] to quit ..", 0, screenH2-28, screenW, "center")
  elseif runStatus == "menu" then renderMenu()
  elseif runStatus == "paused" then renderPaused()
  else renderError() end
end

function renderPaused()
  renderBoard()
  setColor("black")
  gfx.rectangle("fill", screenW2-75, screenH2-23, 150, 46)
  setColor("white")
  gfx.rectangle("line", screenW2-75, screenH2-23, 150, 46)
  gfx.printf("Game is paused", 0, screenH2-14, screenW, "center")
end

function renderError()
  print("runStatus error: "..screen)
  setColor("black")
  gfx.rectangle("fill", screenW2-75, screenH2-23, 150, 46)
  setColor("white")
  gfx.rectangle("line", screenW2-75, screenH2-23, 150, 46)
  gfx.printf("There was an error\nof some kind", 0, screenH2-14, screenW, "center")
end

function renderBoard()
  setColor("white")
  gr = GAME.render()
  gfx.rectangle("line", screenX+2, screenY+2, screenW-5, screenH-5)
  for y = 1, gameH do
    for x = 1, gameW do

      if gr[y][x] ~= 0 then
        -- print("Displaying ".."-"..v.."-"..x.."-"..y)
        setColor("white") -- setColor(tiles[v].color)
        -- if tiles[v].type == "circle" then
        --  gfx.circle("fill", screenX+circleOffset+x*gridSize, screenX+circleOffset+y*gridSize, circleSize, tileSize)
        -- else
        gfx.rectangle("fill", screenX+squareOffset+x*gridSize, screenX+squareOffset+y*gridSize, tileSize, tileSize)
        -- end
      end
    end
  end
end

function renderScore()
  renderBoard()
  setColor("black")
  gfx.rectangle("fill", screenW2-175, screenH2-23, 350, 46)
  setColor("white")
  gfx.rectangle("line", screenW2-175, screenH2-23, 350, 46)
  gfx.printf("You got "..score.." point"..(score == 1 and "" or "s") .. "press SPACE to play again", 0, screenH2-14, screenW, "center")
end

function centerText(text, color)
  if color == nil then setColor("white")
  else setColor(color) end
  gfx.printf(text, 0, screenH2, screenW, "center")
end

function randomColor()
  local color = math.random(1, 6)
  if color == 1 then color = "red"
  elseif color == 2 then color = "yellow"
  elseif color == 3 then color = "cyan"
  elseif color == 4 then color = "blue"
  elseif color == 5 then color = "purple"
  elseif color == 6 then color = "white"
  --elseif color == 4 then color = "green"
  --elseif color == 5 then color = "black"
  end
  return color
end

function setColor(color)
  if type(color) == "string" then
    if color == "red"        then gfx.setColor(255,0  ,0  ,255)
    elseif color == "yellow" then gfx.setColor(255,255,0  ,255)
    elseif color == "green"  then gfx.setColor(0  ,255,0  ,255)
    elseif color == "cyan"   then gfx.setColor(0  ,255,255,255)
    elseif color == "blue"   then gfx.setColor(0  ,0  ,255,255)
    elseif color == "purple" then gfx.setColor(255,0  ,255,255)
    elseif color == "white"  then gfx.setColor(155,155,155,255)
    elseif color == "black"  then gfx.setColor(0  ,0  ,0  ,255)
    end
  elseif type(color) == "table" then
    gfx.setColor(color.r, color.g, color.b, 255)
  end
end
