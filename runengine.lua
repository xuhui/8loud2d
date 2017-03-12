TICK = 1/5
next_time = 0

function love.update(dt)
  key = latestKey
  if GAME.runStatus == "playing" then
    if kbd.isDown(key) == true and key == 'p' then
      GAME.runStatus = "paused"
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
  if GAME.runStatus == "paused" then
    if keyWait('p') == false then return end
    GAME.runStatus = "playing"
  elseif GAME.runStatus == "lost" then return end
end

function tick(dt)
  if #keyBuffer ~= 0 then
    key = table.remove(keyBuffer, 1)
  else
    key = nil
  end

  if GAME.runStatus == "playing" then
      GAME.run(dt, key)
  end
end
