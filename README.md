## Fcitx5 migration reminder with fcitx5-lua

This is a simple fcitx5 lua addon that show a reminder to run fcitx5-migrator when you start to type with fcitx5.

If you click "ok", it will launch fcitx5-migrator, and never bother you any more.

If you click "cancel", it will remind you the next day until you do the migration.

It simply checks two files, "~/.config/fcitx4/.migration-complete" and "~/.config/fcitx5/lua/migration-reminder/.timestamp".

If you have done the migration by yourself, you can just disable this addon :-D.

This addon is used for openSUSE distribution for fcitx4 to fcitx5 migration.

It requires "lua-lgi" to run.
