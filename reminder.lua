local lgi = require("lgi")
local Gtk = lgi.Gtk

local buffer = Gtk.TextBuffer {}
local iter = buffer:get_iter_at_offset(0)
buffer:insert(iter, "Migration to Fcitx5\nOur system detects that you have fcitx4 installed before,\nplease run `fcitx5-migrator` to migrate your configuration and data.", -1)

local window = Gtk.Window {
      title = "Fcitx4 to Fcitx5 Migration Reminder",
      border_width = 10,
      default_width = 200,
      default_height = 100,
      window_position = 'CENTER',
      resizable = false,
      Gtk.Box {
        orientation = 'VERTICAL',
        Gtk.Frame {
            Gtk.TextView {
              buffer = buffer
            }
        },
        Gtk.Frame {
          Gtk.ButtonBox {
            orientation = 'HORIZONTAL',
            border_width = 5,
            spacing = 80,
            Gtk.Button { use_stock = true, label = Gtk.STOCK_OK },
            Gtk.Button { use_stock = true, label = Gtk.STOCK_CANCEL }
          }
        },
      },
      on_destroy = Gtk.main_quit
}

window:show_all()
Gtk.main()
