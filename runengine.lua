TICK = 1/5
next_time = 0

function love.update(dt)
  key = latestKey
  if runStatus == "playing" then
    if kbd.isDown(key) == true and key == 'p' then
      runStatus = "paused"
      return
    else
      if next_time > TICK then
        next_time = 0
        tick(dt)
      end
      next_time = next_time + dt
    end
  else
    if #keyBuffer ~= 0 then key = table.remove(keyBuffer, 1) end
  end
  if runStatus == "paused" then
    if keyWait('p') == false then return end
    runStatus = "playing"
  elseif runStatus == "lost" then return end
end

function tick(dt)
  if #keyBuffer ~= 0 then
    key = table.remove(keyBuffer, 1)
  else
    key = nil
  end

  if runStatus == "playing" then
      GAME.run(dt, key)
  end
end

function loseGame()
  runStatus = "lost"
  gameIsLost = true
  return gameIsLost
end
