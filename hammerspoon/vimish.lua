-- from https://github.com/kkamdooong/hammerspoon-control-hjkl-to-arrow

local function pressFn(mods, key)
  if key == nil then
    key = mods
    mods = {}
  end
  return function() hs.eventtap.keyStroke(mods, key, 1000) end
end

local function remap(mods, key, pressFn)
  hs.hotkey.bind(mods, key, pressFn, nil, pressFn)
end

local isInBrowser = function()
  app = hs.application.frontmostApplication():name()
  return app == 'Google Chrome' or app == 'FireFox'
end

-- backward/forward in browser, left/right elsewhere
hs.hotkey.bind({'ctrl'}, 'h', function()
  if isInBrowser() then
    keyUpDown({'cmd'}, 'left')
  else
    keyUpDown({}, 'left')
  end
end)
hs.hotkey.bind({'ctrl'}, 'l', function()
  if isInBrowser() then
    keyUpDown({'cmd'}, 'right')
  else
    keyUpDown({}, 'right')
  end
end)

-- up/down
remap({'ctrl'}, 'j', pressFn('down'))
remap({'ctrl'}, 'k', pressFn('up'))

-- next/previous word
remap({'cmd'}, 'h', pressFn({'alt'}, 'left'))
remap({'cmd'}, 'l', pressFn({'alt'}, 'right'))

-- page down/up
remap({'cmd'}, 'j', pressFn('pagedown'))
remap({'cmd'}, 'k', pressFn('pageup'))
