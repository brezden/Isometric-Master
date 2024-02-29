local dlg = Dialog("Isometric Master")

local maxSize = {
  x = math.floor(app.activeSprite.width/4),
  y = math.floor(app.activeSprite.width/4),
  z = math.floor(app.activeSprite.height/2)
}

local Shapes = {
  CUBE = "Cube",
  CIRCLE = "Circle",
  RAMP = "Ramp"
}

local selected_shape = Shapes.CUBE
local leftMiddle = true

local function drawStraightLine(x, y, len, color, direction)
  for i=1,len do
    if direction == "vertical" then
      app.activeImage:putPixel(x, y+i, color)
    end
    if direction == "horizontal" then
      app.activeImage:putPixel(x+i, y, color)
    end
  end
end

local function isoLine(x, y, len, color, direction)
  for i=0,len do
    x1 = i*2
    x2 = x1+1
    if direction == "downRight" then
      app.activeImage:putPixel(x+x1, y+i, color)
      app.activeImage:putPixel(x+x2, y+i, color)
    elseif direction == "downLeft" then
      app.activeImage:putPixel(x-x1, y+i, color)
      app.activeImage:putPixel(x-x2, y+i, color)
    elseif direction == "upRight" then
      app.activeImage:putPixel(x+x1, y-i, color)
      -- if ((i ~= len) or (i > len)) then
      app.activeImage:putPixel(x+x2, y-i, color)
      -- end
    elseif direction == "upLeft" then
      app.activeImage:putPixel(x-x1, y-i, color)
      app.activeImage:putPixel(x-x2, y-i, color)
    end
  end
end

local function drawCube(x, y, z, color)
  local centerX = math.floor(app.activeSprite.width/2)
  local centerY = math.floor(app.activeSprite.height/2)
  local offset = leftMiddle and -1 or 0
  drawStraightLine(centerX + offset, centerY, z, color, "vertical") --middle
  drawStraightLine(centerX-y*2-1, centerY-y, z, color, "vertical") --left
  drawStraightLine(centerX+x*2, centerY-x, z, color, "vertical") --right
  isoLine(centerX - 1, centerY, x, color, "upRight") -- top right
  isoLine(centerX, centerY, y, color, "upLeft") -- top left
  isoLine(centerX, centerY + z, y, color, "upLeft") -- bottom left
  isoLine(centerX - 1, centerY + z, x, color, "upRight") -- bottom right
  isoLine(centerX-y*2-1, centerY-y, x, color, "upRight")
  isoLine(centerX+x*2, centerY-x, y, color, "upLeft")



  -- isoLine(x, y, z, color, "upRight")
  -- isoLine(x, y, z, color, "upLeft")
end

local function newLayer(name)
  sprite = app.activeSprite
  layer = sprite:newLayer()
  layer.name = name
  sprite:newCel(layer, 1)
  return layer
end

dlg:separator{ text="Shapes" }
    :button { id="cube", text="Cube", selected=true, onclick=function() selected_shape = Shapes.CUBE dlg:modify{id="cube", selected=true} dlg:modify{id="circle", selected=false} dlg:modify{id="ramp", selected=false} end }
    :button { id="circle", text="Circle", selected=false, onclick=function() selected_shape = Shapes.CIRCLE dlg:modify{id="circle", selected=true} dlg:modify{id="cube", selected=false} dlg:modify{id="ramp", selected=false} end }
    :button { id="ramp", text="Ramp", selected=false, onclick=function() selected_shape = Shapes.RAMP dlg:modify{id="ramp", selected=true} dlg:modify{id="circle", selected=false} dlg:modify{id="cube", selected=false} end }

dlg:separator{ text="Shapes" }
    :slider {id="ySize", label="Left:", min=1, max=maxSize.y, value=5}
    :slider {id="xSize", label="Right:", min=1, max=maxSize.x, value=5}
    :slider {id="zSize", label="Height:", min=3, max=maxSize.z, value=10}

dlg:separator{ text="Colors:" }
    :color {id="color", label="Stroke:", color = app.fgColor}

dlg:separator{ text="Actions" }
    :radio {
        id="left", 
        label="Middle Line: ", 
        text="Left", 
        selected=leftMiddle, 
        onclick=function() leftMiddle = true end
    }
    :radio {
        id="right", 
        text="Right", 
        selected=not leftMiddle, 
        onclick=function() leftMiddle = false end
    }

:button {id="submit", text="Add Shape",onclick=function()
          local data = dlg.data
          app.transaction(function()
            newLayer("Cube("..data.xSize.." "..data.ySize.." "..data.zSize..")")
            drawCube(data.xSize, data.ySize, data.zSize, data.color)
          end)
          app.refresh()
        end
}

dlg:show()