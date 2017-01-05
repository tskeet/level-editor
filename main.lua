require 'lib/lutil-master/util'
require 'camera'
require 'workspace'
require 'tile'

function love.load()
  w, h = love.graphics.getDimensions()
  camera = Camera(0, 0, w, h)

  workspace = Workspace()
  
  cameraX = 0
  cameraY = 0
  cameraScale = 1

  mouseX = 0
  mouseY = 0
end

function love.keypressed(key)
  if key == 'up' then
    cameraY = 5
  end
  if key == 'down' then
    cameraY = -5
  end
  if key == 'right' then
    cameraX = 5
  end
  if key == 'left' then
    cameraX = -5
  end
end

function love.wheelmoved(x, y)
  if y == 1 then
    camera:setScale(0.99)
  end
  if y == -1 then
    camera:setScale(1.01)
  end
end

function love.keyreleased(key)
  if key == 'up' or key == 'down' then
    cameraY = 0
  end
  if key == 'left' or key == 'right' then
    cameraX = 0
  end
end

function love.mousepressed(x, y, button, istouch)
  mouseX, mouseY = camera:mapToWorld(x, y)
  print("x = " .. x .. " y = " .. y .. "\n mouseX = " .. mouseX .. " mouseY = " .. mouseY)
  local testTile = workspace:checkTiles(mouseX, mouseY)
  if testTile == nil then
    workspace:addTile(mouseX, mouseY)
  else
    testTile:onClick()
  end	
end

function love.update(dt)
  camera:move(cameraX, cameraY)
  camera:setScale(cameraScale)
end

function love.draw()
  camera:set()
  workspace:draw()
  local tx, ty, txp, typ = camera:getState()
  love.graphics.circle('line', mouseX, mouseY, 10)
  camera:unset()
end
