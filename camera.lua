--[[

This is the module that is resposible for handling the camera.  This camera is only
able to pan and zoom.

]]
Camera = class()

Camera.xPos = 0 --x location of the middle of the camera in the world coordinate system
Camera.yPos = 0 --y location of the middle of the camera in the world coordinate system
Camera.x = 0 -- x location of upper left hand corner of the camera
Camera.y = 0 -- y location of the upper left hand corner of the camera
Camera.width = 0 --width of the window
Camera.height = 0 --height of the window
Camera.scale = 1 --the scale of the world coordinant system

--[[

Constructs a new Camera

]]
function Camera:init(x, y, w, h )

  self:initialize(x, y, w, h)
end

--[[

Initializes all variables.

paramters:
  x, the x location of the upper left hand corner of the camera
  y, the y location of the upper left hand corner of the camera
  w, the width of the window
  h, the height of the window

]]
function Camera:initialize(x, y, w, h)
  self.width, self.height = w, h
  self.x, self.y = x, y
  self.xPos, self.yPos = x + (w * 0.5), y + (h * 0.5)
  self.scale = 1
end 

--[[

takes in a point from the window space and translate the point  to a point in the world space.

]]
function Camera:mapToWorld(x , y)
  local tx, ty = (x - (self.width * 0.5)) * self.scale, (y - (self.height * 0.5)) * self.scale
  return self.xPos + tx, self.yPos + ty
end

--[[

Changes the coordinate system so to draw the elements of the world

]]
function Camera:set()

  love.graphics.push()
  love.graphics.translate(self.width * 0.5, self.height * 0.5) --translate the middle of the screen to the upper left hand corner of the window
  love.graphics.scale(1 / self.scale, 1 / self.scale) --scale the coordinate system
  love.graphics.translate(-1 * ((self.width * 0.5) + self.x), -1 * ((self.height * 0.5) + self.y)) --translate the coordinate system back to the 
end

--[[

Restores coordinate system to previous settings.

]]
function Camera:unset()
  love.graphics.pop()
end

--[[

Changes the position of the camera

]]
function Camera:move(dx, dy)
  self.xPos = self.xPos + (dx or 0)
  self.yPos = self.yPos + (dy or 0)
  self.x, self.y = self.xPos - (self.width * 0.5), self.yPos - (self.height * 0.5)
end

--[[
  Changes the position of the camera to the origin
]]
function Camera:goToOrigin()
  self.xPos, self.yPos = self.width * 0.5, self.height * 0.5
  self.x, self.y = self.xPos - (self.width * 0.5), self.yPos - (self.height * 0.5)
end

--[[

Changes the scale of the coordinate system

]]
function Camera:setScale(s)
  self.scale = self.scale * (s or self.scale)
  --self.xPos, self.yPos = self.xPos * self.scale, self.yPos * self.scale
  --self.x, self.y = self.xPos - (self.width * 0.5), self.yPos - (self.height * 0.5)
end

--[[

Returns the state of the camera

]]
function Camera:getState()
  return self.x, self.y, self.xPos, self.yPos, self.scale
end
