--[[
Class Workspace is the main workspace where the level is created.
]]
Workspace = class()

Workspace.width = 10
Workspace.height = 10
Workspace.cellsize = 20
Workspace.lines = nil
Workspace.tiles = nil
Workspace.squareCursor = {x = 0, y = 0}
Workspace.camera = nil
Workspace.selectedTile = nil
Workspace.isDrag = false

--[[
Constructor of Workspace
  w, width in number of cells 
  h. height in number of cells
  c, size of individual cells
]]
function Workspace:init(w, h, c)

  self.width =  w or self.width
  self.height = h or self.height
  self.cellsize = c or self.cellsize
  self.length = 0
  self.lines = self:initializeGrid(self.width, self.height, self.cellsize) --note 300 x 300 is probably a good default
  self.tiles = {} 

  local w, h = love.graphics.getDimensions()
  self.camera = Camera(0, 0, w, h)

end

--[[
creates a graph paper backround for creating the level
w, width in number cells
h, height in number cells
c, size of cells

]]
function Workspace:initializeGrid(w, h, c)
  local lines = {}
  for i = 0, w do
    line = {}
    line[1] = i * c
    line[2] = 0
    line[3] = i * c
    line[4] = h * c

    table.insert(lines, line)
    self.length = self.length + 1
  end

  for j = 0, h do
    line = {}
    line[1] = 0
    line[2] = j * c 
    line[3] = w * c
    line[4] = j * c

    table.insert(lines, line)
    self.length = self.length + 1
  end
  return lines
end



--[[
adds tile to the workspace at the given coordinates
x, location on x-axis
y, location on y-axis
]]
function Workspace:addTile()
  local tile = Tile(self.squareCursor.x, self.squareCursor.y)
  table.insert(self.tiles, tile)
end

--[[
checks to see if a point is contained in one of the tiles.
If the point is contained in one of the tiles, then that tile is returned.
if not, nil is returned.

x, location of point in x-axis
y, location of point in y-axis
]]
function Workspace:checkTiles(x, y)
  local tileClicked = nil
  for k, v in pairs(self.tiles) do
    if v:contains(x, y) then
      tileClicked = v
    end
  end

  return tileClicked
end

--[[
  maps a point from the worldspace onto an intersection of the graph paper
  x, location of point on x-axis
  y, location of point on y-axis
  returns mapped point 
]]
function Workspace:mapToGraph(x, y)
  --print("x to graph: " .. x .. " y to graph: " .. y)
  return math.floor( x / self.cellsize) * self.cellsize, math.floor( y / self.cellsize) * self.cellsize
end

--[[
  Sets the location of the upper left hand corner of the cursor
]]
function Workspace:setCursor(x, y)
  self.squareCursor.x, self.squareCursor.y = x, y
end

--[[
  checks to keyboard and makes appropriate changes to variables
]]

function Workspace:checkKeyboard()
  if love.keyboard.isDown('up') then
    self.camera:move(0, -1)
  end
  if love.keyboard.isDown('down') then
    self.camera:move(0, 1)
  end
  if love.keyboard.isDown('right') then
    self.camera:move(1, 0)
  end
  if love.keyboard.isDown('left') then
    self.camera:move(-1, 0)
  end
end

--[[
  checks the mouse and makes appropriate changes to variables
]]

function Workspace:checkMouse()
  local tx, ty = love.mouse.getPosition()
  tx, ty = self.camera:mapToWorld(tx, ty)
  tx, ty = self:mapToGraph(tx, ty)
  self:setCursor(tx, ty)

  if love.mouse.isDown(1) then --if left mouse button is pressed
    if self.isDrag == false then -- if mouse entered pressed
      if self.selectedTile == nil then -- if selected is nil,
        self.selectedTile = self:checkTiles(tx, ty) -- check to see to if tile is at point
        if self.selectedTile ~= nil then --checking to see if space is occupied by tile
          self.selectedTile:onClick()
        else
          self:addTile()
        end
      end
      self.isDrag = true
    else --mouse is dragging
      if self.selectedTile ~= nil then
        self.selectedTile:setPosition(tx, ty)
      end
    end
  else
    if self.isDrag == true then --exiting drag
      self.isDrag = false
    end
  end
end

--[[
  workspace's method for handling updates
]]
function Workspace:update(dt)
  self:checkKeyboard()
  self:checkMouse()
end
 
--[[
  draws the graph paper backgound and all the tiles.
]]
function Workspace:draw()
  self.camera:set()
  --setting color and drawing graph lines on workspace
  love.graphics.setColor(0,0,128)
  for k, v in pairs(self.lines) do
    love.graphics.line(v)
  end

  for k, v in pairs(self.tiles) do
    v:draw()
  end

  love.graphics.setColor(173, 216, 230, 255)
  love.graphics.rectangle('line', self.squareCursor.x, self.squareCursor.y, self.cellsize, self.cellsize)

  self.camera:unset()
end
