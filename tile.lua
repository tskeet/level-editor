--[[

class Tile represents a generic Tile that will be draggable and 

]]

Tile = class()

Tile.x = 0
Tile.y = 0
Tile.cellsize = 20
Tile.color = {255, 255, 255, 255}

--[[
constructor of Tile.

x, location on x-axis of the upper left hand corner of the tile
y, location on y-axis of the upper left hand corner of the tile
]]
function Tile:init(x, y, c)
  self.x = x or self.x
  self.y = y or self.y
  self.cellsize = c or self.cellsize

  print("old c is " .. c)
end

--[[

sets postion to given position

]]
function Tile:setPosition(x, y)
  self.x, self.y = x, y
end

--[[

returns current position
returns x, y as one 

]]
function Tile:getPosition()
  return self.x, self.y
end

--[[

returns x position

]]
function Tile:getX()
  return self.x
end

--[[

returns y position

]]
function Tile:getY()
  return self.y
end

--[[

tests whether given point is contained within tile

returns true if given position is within Tile's boundry, otherwise returns false
]]
function Tile:contains(x, y)
  if x >= self.x and x <= (self.x + self.cellsize) then
    if y >= self.y and y <= (self.y + self.cellsize) then
      return true
    else
      return false
    end 
  else
    return false
  end
end

function Tile:onClick()
  self.color = {255, 0, 0, 255}
end

--[[

Tile's draw function

]]
function Tile:draw()
  love.graphics.setColor(self.color)
  love.graphics.rectangle('fill', self.x, self.y, self.cellsize, self.cellsize)
end
