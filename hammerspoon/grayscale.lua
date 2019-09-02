hs.hotkey.bind({"ctrl"}, "D", function()
  forceToGray = hs.screen.getForceToGray()
  if(forceToGray)
  then
    hs.screen.setForceToGray(false)
    hs.notify.new({title="Hammerspoon", informativeText="Color's back"}):send()
  else
    hs.screen.setForceToGray(true)
    hs.notify.new({title="Hammerspoon", informativeText="Gone gray"}):send()
  end
end)
