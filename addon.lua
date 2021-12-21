local fcitx = require("fcitx")

fcitx.watchEvent(fcitx.EventType.KeyEvent, "migrate4to5")

function migrate4to5(sym, state, release)
  if state == fcitx.KeyState.Ctrl and sym == 32 and not release then
    io.popen("lua ./reminder.lua")
  end
  return false
end
