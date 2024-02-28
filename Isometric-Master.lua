local dlg = Dialog("Isometric Master")

dlg:separator{ text="Shapes" }
    :button { id="cube", text="Cube", selected=true, onclick=function() dlg:modify{id="cube", selected=true} dlg:modify{id="circle", selected=false} dlg:modify{id="ramp", selected=false} end }
    :button { id="circle", text="Circle", selected=false, onclick=function() dlg:modify{id="circle", selected=true} dlg:modify{id="cube", selected=false} dlg:modify{id="ramp", selected=false} end }
    :button { id="ramp", text="Ramp", selected=false, onclick=function() dlg:modify{id="ramp", selected=true} dlg:modify{id="circle", selected=false} dlg:modify{id="cube", selected=false} end }

dlg:show()
