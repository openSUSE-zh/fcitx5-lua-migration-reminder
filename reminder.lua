local lgi = require("lgi")
local Gtk = lgi.Gtk
local GdkPixbuf = lgi.GdkPixbuf

local locales = {}
locales.en_US = {
  window_title = "Fcitx4 configuration data migration reminder",
  title = "Migration to Fcitx5",
  text = "\nOur system detects that you have fcitx4 installed before,\nplease click 'ok' to migrate your configuration and data."
}
locales.zh_CN = {
  window_title = "Fcitx4 配置数据迁移提醒",
  title = "迁移到 Fcitx5",
  text = "\n系统检测到您之前安装过 Fcitx4，请点击 ok 运行迁移向导完成配置的迁移。"
}

local lang = os.getenv("LANG"):match("([%a_]+)")
if locales[lang] == nil then
  lang = "en_US"
end
local window_title = locales[lang]["window_title"]
local title = locales[lang]["title"]
local text = locales[lang]["text"]

local buffer = Gtk.TextBuffer {}
local pixbuf = GdkPixbuf.Pixbuf.new_from_file("/usr/share/icons/hicolor/scalable/apps/fcitx.svg")
local iter = buffer:get_iter_at_offset(0)
buffer:insert(iter, title, -1)
local offset = iter:get_offset()
iter = buffer:get_iter_at_offset(offset)
buffer:insert_pixbuf(iter, pixbuf:scale_simple(32, 32, "BILINEAR"))
offset = iter:get_offset() 
iter = buffer:get_iter_at_offset(offset)
buffer:insert(iter, text, -1)

local window = Gtk.Window {
      title = window_title,
      border_width = 10,
      default_width = 200,
      default_height = 100,
      window_position = 'CENTER',
      resizable = false,
      icon = pixbuf:scale_simple(32, 32, "BILINEAR"),
      Gtk.Box {
        orientation = 'VERTICAL',
        Gtk.Frame {
            Gtk.TextView {
              buffer = buffer,
              editable = false,
            }
        },
        Gtk.Frame {
          Gtk.ButtonBox {
            orientation = 'HORIZONTAL',
            border_width = 5,
            spacing = 80,
            Gtk.Button {
              id = "ok_button",
              use_stock = true,
              label = Gtk.STOCK_OK
            },
            Gtk.Button {
              id = "cancel_button",
              use_stock = true,
              label = Gtk.STOCK_CANCEL
            }
          }
        },
      },
      on_destroy = Gtk.main_quit
}

local home = os.getenv("HOME")

function window.child.ok_button:on_clicked()
  io.popen("fcitx5-migrator")
  local f = io.open(home .. "/.config/fcitx/.migration-complete", "w")
  io.close(f)
  window:destroy()
end

function window.child.cancel_button:on_clicked()
  local f = io.open(home .. "/.config/fcitx5/.timestamp", "w")
  io.close(f)
  window:destroy()
end
window:show_all()
Gtk.main()
