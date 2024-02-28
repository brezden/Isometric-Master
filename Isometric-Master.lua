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

local function drawCube(x, y, color)
  local len = 5
  for i=0,len do
    x1 = i*2
    x2 = x1+1
    app.activeImage:putPixel(x+x1, y+i, color)
    app.activeImage:putPixel(x+x2, y+i, color)
  end
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

:button {id="submit", text="Add Shape",onclick=function()
          local data = dlg.data
          app.transaction(function()
            newLayer("Cube("..data.xSize.." "..data.ySize.." "..data.zSize..")")
            drawCube(data.xSize, data.ySize, data.color)
          end)
          app.refresh()
        end
      }
dlg:show()

print("Selected shape is: " .. selected_shape)