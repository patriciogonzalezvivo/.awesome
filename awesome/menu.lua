local awful         = require("awful")
local beautiful     = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")
                      require("awful.hotkeys_popup.keys")
local apps          = require("apps")
local menubar       = require("menubar")
local freedesktop   = require("freedesktop")

local myawesomemenu = {
    { "Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "Manual", string.format("%s -e man awesome", apps.default.terminal) },
    { "Edit config", string.format("%s -e %s %s", apps.default.terminal, apps.default.editor, awesome.conffile) },
    { "Restart", awesome.restart },
    { "Quit", function() awesome.quit() end },
 }
 
 awful.util.mymainmenu = freedesktop.menu.build {
     icon_size = beautiful.menu_height or 16,
     before = {
         { "Awesome", myawesomemenu, beautiful.awesome_icon },
         -- other triads can be put here
     },
     after = {
         { "Open terminal", apps.default.terminal },
         -- other triads can be put here
     }
 }
 
 -- -- Hide the menu when the mouse leaves it
 -- awful.util.mymainmenu.wibox:connect_signal("mouse::leave", function()
 --     if not awful.util.mymainmenu.active_child or
 --        (awful.util.mymainmenu.wibox ~= mouse.current_wibox and
 --        awful.util.mymainmenu.active_child.wibox ~= mouse.current_wibox) then
 --         awful.util.mymainmenu:hide()
 --     else
 --         awful.util.mymainmenu.active_child.wibox:connect_signal("mouse::leave",
 --         function()
 --             if awful.util.mymainmenu.wibox ~= mouse.current_wibox then
 --                 awful.util.mymainmenu:hide()
 --             end
 --         end)
 --     end
 -- end)
 
 -- Set the Menubar terminal for applications that require it
 menubar.utils.terminal = apps.default.terminal