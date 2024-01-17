local dlg = Dialog("Isometric Master")
dlg:entry{ id="user_value", label="User Value:", text="Default User" }
dlg:button{ id="confirm", text="Confirm" }
dlg:button{ id="cancel", text="Cancel" }
dlg:show()
local data = dlg.data
if data.confirm then
  app.alert("The given value is '" .. data.user_value .. "'")
end