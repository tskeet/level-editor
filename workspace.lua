--[[
Class Workspace is the main workspace where the level is created.

]]
Workspace = class()

Workspace.width = 10
Workspace.height = 10
Workspace.cellsize = 20
Workspace.lines = nil
Workspace.tiles = nil

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
function Workspace:addTile(x, y)
  local tile = Tile(x, y)
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

draws the graph paper backgound and all the tiles.
]]
function Workspace:draw()
  tr, tg, tb, ta = love.graphics.getColor()
  love.graphics.setColor(0,0,128)

  for k, v in pairs(self.lines) do
    love.graphics.line(v)
  end
  love.graphics.setColor(tr, tg, tb, ta)

  for k, v in pairs(self.tiles) do
    v:draw()
  end
end
