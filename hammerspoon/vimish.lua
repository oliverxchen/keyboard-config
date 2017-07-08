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

-- basic movement
remap({'ctrl'}, 'h', pressFn('left'))
remap({'ctrl'}, 'j', pressFn('down'))
remap({'ctrl'}, 'k', pressFn('up'))
remap({'ctrl'}, 'l', pressFn('right'))

-- next/previous word
remap({'cmd'}, 'h', pressFn({'alt'}, 'left'))
remap({'cmd'}, 'l', pressFn({'alt'}, 'right'))

-- page down/up
remap({'cmd'}, 'j', pressFn('pagedown'))
remap({'cmd'}, 'k', pressFn('pageup'))
