local itermHotkeyMappings = {
  -- Use control + h/j/k/l to move left/down/up/right by one pane
  {
    from = {{'alt'}, 'h'},
    to   = {{'cmd', 'alt'}, 'left'}
  },
  {
    from = {{'alt'}, 'j'},
    to   = {{'cmd', 'alt'}, 'down'}
  },
  {
    from = {{'alt'}, 'k'},
    to   = {{'cmd', 'alt'}, 'up'}
  },
  {
    from = {{'alt'}, 'l'},
    to   = {{'cmd', 'alt'}, 'right'}
  },
}

local terminalWindowFilter = hs.window.filter.new('iTerm2')
local itermHotkeys = hs.fnutils.each(itermHotkeyMappings, function(mapping)
  local fromMods = mapping['from'][1]
  local fromKey = mapping['from'][2]
  local toMods = mapping['to'][1]
  local toKey = mapping['to'][2]
  local hotkey = hs.hotkey.new(fromMods, fromKey, function()
    keyUpDown(toMods, toKey)
  end)
  enableHotkeyForWindowsMatchingFilter(terminalWindowFilter, hotkey)
end)
