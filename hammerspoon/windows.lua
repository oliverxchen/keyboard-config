hs.window.animationDuration = 0
window = hs.getObjectMetatable("hs.window")

-- +-----------------+
-- |        |        |
-- |  HERE  |        |
-- |        |        |
-- +-----------------+
function window.left(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end

-- +-----------------+
-- |        |        |
-- |        |  HERE  |
-- |        |        |
-- +-----------------+
function window.right(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end

-- +-----------------+
-- |      HERE       |
-- +-----------------+
-- |                 |
-- +-----------------+
function window.up(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.w = max.w
  f.y = max.y
  f.h = max.h / 2
  win:setFrame(f)
end

-- +-----------------+
-- |                 |
-- +-----------------+
-- |      HERE       |
-- +-----------------+
function window.down(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.w = max.w
  f.y = max.y + (max.h / 2)
  f.h = max.h / 2
  win:setFrame(f)
end

-- +-----------------+
-- |  HERE  |        |
-- +--------+        |
-- |                 |
-- +-----------------+
function window.upLeft(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()

  f.x = max.x
  f.y = max.y
  f.w = max.w/2
  f.h = max.h/2
  win:setFrame(f)
end

-- +-----------------+
-- |                 |
-- +--------+        |
-- |  HERE  |        |
-- +-----------------+
function window.downLeft(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()

  f.x = max.x
  f.y = max.y + (max.h / 2)
  f.w = max.w/2
  f.h = max.h/2
  win:setFrame(f)
end

-- +-----------------+
-- |                 |
-- |        +--------|
-- |        |  HERE  |
-- +-----------------+
function window.downRight(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()

  f.x = max.x + (max.w / 2)
  f.y = max.y + (max.h / 2)
  f.w = max.w/2
  f.h = max.h/2

  win:setFrame(f)
end

-- +-----------------+
-- |        |  HERE  |
-- |        +--------|
-- |                 |
-- +-----------------+
function window.upRight(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w/2
  f.h = max.h/2
  win:setFrame(f)
end

-- +--------------+
-- |  |        |  |
-- |  |  HERE  |  |
-- |  |        |  |
-- +---------------+
function window.centerWithFullHeight(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:fullFrame()

  f.x = max.x + (max.w / 5)
  f.w = max.w * 3/5
  f.y = max.y
  f.h = max.h
  win:setFrame(f)
end

-- +-----------------+
-- |      |          |
-- | HERE |          |
-- |      |          |
-- +-----------------+
function window.left25(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w * 0.25
  f.h = max.h
  win:setFrame(f)
end

-- +-----------------+
-- |      |          |
-- |      |   HERE   |
-- |      |          |
-- +-----------------+
function window.right75(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w * 0.25)
  f.y = max.y
  f.w = max.w * 0.75
  f.h = max.h
  win:setFrame(f)
end

function window.nextScreen(win)
  local currentScreen = win:screen()
  local allScreens = hs.screen.allScreens()
  currentScreenIndex = hs.fnutils.indexOf(allScreens, currentScreen)
  nextScreenIndex = currentScreenIndex + 1

  if allScreens[nextScreenIndex] then
    win:moveToScreen(allScreens[nextScreenIndex])
  else
    win:moveToScreen(allScreens[1])
  end
end

windowLayoutMode = hs.hotkey.modal.new({}, 'F16')

windowLayoutMode.entered = function()
  windowLayoutMode.statusMessage:show()

  -- If "Secure Keyboard Entry"/Secure Input is enabled (commonly by Terminal/iTerm),
  -- macOS will prevent event taps from seeing key presses. That would make
  -- h/j/k/l (and even Escape) appear to do nothing here.
  if hs.eventtap and hs.eventtap.isSecureInputEnabled and hs.eventtap.isSecureInputEnabled() then
    hs.alert.show('Window Layout Mode: Secure Input is ON\nSome app has enabled Secure Keyboard Entry, so only `return` and `space` will work.')
    hs.printf('[WindowLayoutMode] Secure Input is enabled; keyDown eventtap will not receive keystrokes.')
  end

  -- In macOS 26.2, binding letter keys with no modifiers via hs.hotkey can stop
  -- working (the focused app still receives the keystrokes). Use an eventtap
  -- while the mode is active to capture/suppress keys reliably.
  if windowLayoutMode._eventtap then
    windowLayoutMode._eventtap:stop()
    windowLayoutMode._eventtap = nil
  end

  windowLayoutMode._eventtap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(evt)
    local keyCode = evt:getKeyCode()
    local flags = evt:getFlags() or {}

    -- Always allow exiting the mode with Escape
    if hs.keycodes.map and keyCode == hs.keycodes.map.escape then
      windowLayoutMode:exit()
      return true
    end

    for _, mapping in ipairs(windowLayoutMode._keycodeMappings or {}) do
      if keyCode == mapping.keyCode and mapping:modsMatch(flags) then
        windowLayoutMode:exit()

        local fw = hs.window.focusedWindow()
        if fw then
          local fn = fw[mapping.winFunction]
          if type(fn) == 'function' then
            local ok, err = pcall(fn, fw)
            if not ok then
              hs.alert.show('Window fn error: ' .. tostring(mapping.winFunction))
              hs.printf('WindowLayoutMode error (%s): %s', tostring(mapping.winFunction), tostring(err))
            end
          else
            hs.alert.show('Unknown window function: ' .. tostring(mapping.winFunction))
          end
        end

        -- Swallow the keystroke so the app (e.g. Vim) doesn't receive it
        return true
      end
    end

    -- Not a Window Layout key; let it through
    return false
  end)
  windowLayoutMode._eventtap:start()
end
windowLayoutMode.exited = function()
  windowLayoutMode.statusMessage:hide()
  if windowLayoutMode._eventtap then
    windowLayoutMode._eventtap:stop()
    windowLayoutMode._eventtap = nil
  end
end

-- Bind the given key to call the given function and exit WindowLayout mode
function windowLayoutMode.bindWithAutomaticExit(mode, modifiers, key, fn)
  mode:bind(modifiers, key, function()
    mode:exit()
    fn()
  end)
end

local status, windowMappings = pcall(require, 'keyboard.windows-bindings')

if not status then
  windowMappings = require('keyboard.windows-bindings-defaults')
end

local modifiers = windowMappings.modifiers
local showHelp  = windowMappings.showHelp
local trigger   = windowMappings.trigger
local mappings  = windowMappings.mappings

function getModifiersStr(modifiers)
  local modMap = { shift = '⇧', ctrl = '⌃', alt = '⌥', cmd = '⌘' }
  local retVal = ''

  for i, v in ipairs(modifiers) do
    retVal = retVal .. modMap[v]
  end

  return retVal
end

local msgStr = getModifiersStr(modifiers)
msgStr = 'Window Layout Mode (' .. msgStr .. (string.len(msgStr) > 0 and '+' or '') .. trigger .. ')'

local function resolveKeyCode(triggerKey)
  if type(triggerKey) ~= 'string' then return nil end

  -- hs.keycodes.map uses "comma"/"period" but our bindings file uses ","/".".
  local alias = {
    [','] = 'comma',
    ['.'] = 'period',
    ['return'] = 'return',
    ['space'] = 'space',
    ['left'] = 'left',
    ['right'] = 'right',
    ['up'] = 'up',
    ['down'] = 'down',
  }

  local k = alias[triggerKey] or triggerKey
  local code = (hs.keycodes.map and hs.keycodes.map[k]) or nil
  if code then return code end

  -- Hard fallbacks for common keys (in case map names change)
  local hard = {
    ['return'] = 36,
    ['space'] = 49,
    ['comma'] = 43,
    ['period'] = 47,
  }
  return hard[k]
end

local function requiredModsMatch(requiredMods, flags)
  -- Only require listed modifiers; allow extras (so e.g. sticky keys won't break it)
  for _, m in ipairs(requiredMods) do
    if not flags[m] then return false end
  end
  return true
end

-- Precompute keycode mappings for the eventtap handler above.
windowLayoutMode._keycodeMappings = {}

for i, mapping in ipairs(mappings) do
  local modifiers, triggerKey, winFunction = table.unpack(mapping)
  local hotKeyStr = getModifiersStr(modifiers)

  if showHelp == true then
    if string.len(hotKeyStr) > 0 then
      msgStr = msgStr .. (string.format('\n%10s+%s => %s', hotKeyStr, triggerKey, winFunction))
    else
      msgStr = msgStr .. (string.format('\n%11s => %s', triggerKey, winFunction))
    end
  end

  -- Keep the original modal bindings so special keys like space/return keep
  -- working even if the eventtap path fails.
  windowLayoutMode:bindWithAutomaticExit(modifiers, triggerKey, function()
    local fw = hs.window.focusedWindow()
    if not fw then return end
    fw[winFunction](fw)
  end)

  local keyCode = resolveKeyCode(triggerKey)
  if keyCode then
    table.insert(windowLayoutMode._keycodeMappings, {
      keyCode = keyCode,
      winFunction = winFunction,
      modsMatch = function(_, flags) return requiredModsMatch(modifiers, flags) end,
    })
  end
end

local message = require('keyboard.status-message')
windowLayoutMode.statusMessage = message.new(msgStr)

-- Use modifiers+trigger to toggle WindowLayout Mode
hs.hotkey.bind(modifiers, trigger, function()
  windowLayoutMode:enter()
end)
windowLayoutMode:bind(modifiers, trigger, function()
  windowLayoutMode:exit()
end)
