require 'lib/lutil-master/util'
require 'camera'
require 'workspace'
require 'tile'

function love.load()
  workspace = Workspace(20, 20)
end

function love.wheelmoved(x, y, dx, dy, istouch)
  workspace:wheelmoved(x,y)
end

function love.update(dt)
  workspace:update(dt)
end

function love.draw()
  workspace:draw()
end
