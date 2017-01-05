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

function Workspace:addTile(x, y)
  local tile = Tile(x, y)
  table.insert(self.tiles, tile)
end

function Workspace:checkTiles(x, y)
  local tileClicked = nil
  for k, v in pairs(self.tiles) do
    if v:contains(x, y) then
      tileClicked = v
    end
  end

  return tileClicked
end

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
