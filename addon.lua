local fcitx = require("fcitx")

fcitx.watchEvent(fcitx.EventType.KeyEvent, "migrate4to5")

function migrate4to5(sym, state, release)
  local home = os.getenv("HOME")
  local path = debug.getinfo(1).source:match("@?(.*/)")
  local reminder = "lua " .. path .. "reminder.lua"
  local f = io.open(home .. "/.config/fcitx", "r")
  if f == nil then
    f.close()
    return false
  end
  f = io.open(home .. "/.config/fcitx/.migration-complete", "r")
  if f ~= nil then
    f.close()
    return false
  end

  f = io.open(home .. "/.config/fcitx5/.timestamp", "r")
  if f ~= nil then
    io.close(f)
    local cmd = "stat -c %Y " .. home .. "/.config/fcitx5/.timestamp"
    local timestamp = io.popen(cmd)
    local last_modified = timestamp:read()
    local day = math.floor(os.difftime(os.time(), last_modified) / (24*60*60))
    if day > 0 then
      if state == fcitx.KeyState.Ctrl and sym == 32 and not release then
        io.popen(reminder)
      end
    end
  else
    if state == fcitx.KeyState.Ctrl and sym == 32 and not release then
      io.popen(reminder)
    end
  end
  return false
end
