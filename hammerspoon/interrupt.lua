hs.hotkey.bind({"cmd", "shift"}, "L", function()
  hs.caffeinate.lockScreen()
end)

hs.hotkey.bind({"cmd", "shift"}, "S", function()
  hs.caffeinate.systemSleep()
end)
