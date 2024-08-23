local awful         = require("awful")
local apps          = require("apps")
local keys          = require("keys")
local mytable       = awful.util.table or gears.table -- 4.{0,1} compatibility
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local lain          = require("lain")
local menubar       = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
                      require("awful.hotkeys_popup.keys")

local cycle_prev    = true  -- cycle with only the previously focused client or all https://github.com/lcpz/awesome-copycats/issues/274

-- Mouse bindings
root.buttons(mytable.join(
    awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

-- Key bindings
globalkeys = mytable.join(
    -- -- Destroy all notifications
    -- awful.key({ "Control",           }, "space", function() naughty.destroy_all_notifications() end,
    --           {description = "destroy all notifications", group = "hotkeys"}),

    -- Take a screenshot
    -- https://github.com/lcpz/dots/blob/master/bin/screenshot
    awful.key({ keys.alt }, "p", function() os.execute("screenshot") end,
              {description = "take a screenshot", group = "hotkeys"}),

    -- -- X screen locker
    -- awful.key({ keys.alt, "Control" }, "l", function () os.execute(scrlocker) end,
    --           {description = "lock screen", group = "hotkeys"}),

    -- Show help
    awful.key({ keys.mod,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),

    -- Tag browsing
    awful.key({ "Control",           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ "Control",           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    -- awful.key({ "Control",          }, "Escape", awful.tag.history.restore,
    --           {description = "go back", group = "tag"}),

    -- -- Non-empty tag browsing
    -- awful.key({ keys.alt }, "Left", function () lain.util.tag_view_nonempty(-1) end,
    --           {description = "view  previous nonempty", group = "tag"}),
    -- awful.key({ keys.alt }, "Right", function () lain.util.tag_view_nonempty(1) end,
    --           {description = "view  previous nonempty", group = "tag"}),

    -- -- Default client focus
    -- awful.key({ keys.alt,           }, "j",
    --     function ()
    --         awful.client.focus.byidx( 1)
    --     end,
    --     {description = "focus next by index", group = "client"}
    -- ),
    -- awful.key({ keys.alt,           }, "k",
    --     function ()
    --         awful.client.focus.byidx(-1)
    --     end,
    --     {description = "focus previous by index", group = "client"}
    -- ),

    -- By-direction client focus
    awful.key({ keys.mod }, "j",
        function()
            awful.client.focus.global_bydirection("down")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus down", group = "client"}),
    awful.key({ keys.mod }, "k",
        function()
            awful.client.focus.global_bydirection("up")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus up", group = "client"}),
    awful.key({ keys.mod }, "h",
        function()
            awful.client.focus.global_bydirection("left")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus left", group = "client"}),
    awful.key({ keys.mod }, "l",
        function()
            awful.client.focus.global_bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus right", group = "client"}),

    -- Menu
    awful.key({ keys.mod,           }, "w", function () awful.util.mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ keys.mod, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ keys.mod, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),

    -- awful.key({ keys.mod, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
    --           {description = "focus the next screen", group = "screen"}),
    -- awful.key({ keys.mod, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
    --           {description = "focus the previous screen", group = "screen"}),

    awful.key({ keys.mod,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ keys.mod,           }, "Tab",
        function ()
            if cycle_prev then
                awful.client.focus.history.previous()
            else
                awful.client.focus.byidx(-1)
            end
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "cycle with previous/go back", group = "client"}),

    -- Show/hide wibox
    awful.key({ keys.mod }, "b", function ()
            for s in screen do
                s.mywibox.visible = not s.mywibox.visible
                if s.mybottomwibox then
                    s.mybottomwibox.visible = not s.mybottomwibox.visible
                end
            end
        end,
        {description = "toggle wibox", group = "awesome"}),

    -- -- On-the-fly useless gaps change
    -- awful.key({ keys.alt, "Control" }, "+", function () lain.util.useless_gaps_resize(1) end,
    --           {description = "increment useless gaps", group = "tag"}),
    -- awful.key({ keys.alt, "Control" }, "-", function () lain.util.useless_gaps_resize(-1) end,
    --           {description = "decrement useless gaps", group = "tag"}),

    -- -- Dynamic tagging
    -- awful.key({ keys.mod, "Shift" }, "n", function () lain.util.add_tag() end,
    --           {description = "add new tag", group = "tag"}),
    -- awful.key({ keys.mod, "Shift" }, "r", function () lain.util.rename_tag() end,
    --           {description = "rename tag", group = "tag"}),
    -- awful.key({ keys.mod, "Shift" }, "Left", function () lain.util.move_tag(-1) end,
    --           {description = "move tag to the left", group = "tag"}),
    -- awful.key({ keys.mod, "Shift" }, "Right", function () lain.util.move_tag(1) end,
    --           {description = "move tag to the right", group = "tag"}),
    -- awful.key({ keys.mod, "Shift" }, "d", function () lain.util.delete_tag() end,
    --           {description = "delete tag", group = "tag"}),

    -- Standard program
    awful.key({ keys.mod,           }, "Return", function () awful.spawn(apps.default.terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ keys.mod, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    -- awful.key({ keys.mod, "Shift"   }, "q", awesome.quit,
    --           {description = "quit awesome", group = "awesome"}),

    -- awful.key({ keys.mod, keys.alt    }, "l",     function () awful.tag.incmwfact( 0.05)          end,
    --           {description = "increase master width factor", group = "layout"}),
    -- awful.key({ keys.mod, keys.alt    }, "h",     function () awful.tag.incmwfact(-0.05)          end,
    --           {description = "decrease master width factor", group = "layout"}),
    -- awful.key({ keys.mod, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
    --           {description = "increase the number of master clients", group = "layout"}),
    -- awful.key({ keys.mod, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
    --           {description = "decrease the number of master clients", group = "layout"}),
    -- awful.key({ keys.mod, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
    --           {description = "increase the number of columns", group = "layout"}),
    -- awful.key({ keys.mod, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
    --           {description = "decrease the number of columns", group = "layout"}),

    awful.key({ keys.mod, keys.alt     }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    -- awful.key({ keys.mod, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
    --           {description = "select previous", group = "layout"}),

    -- awful.key({ keys.mod, "Control" }, "n", function ()
    --     local c = awful.client.restore()
    --     -- Focus restored client
    --     if c then
    --         c:emit_signal("request::activate", "key.unminimize", {raise = true})
    --     end
    -- end, {description = "restore minimized", group = "client"}),

    -- -- Dropdown application
    -- awful.key({ keys.mod, }, "z", function () awful.screen.focused().quake:toggle() end,
    --           {description = "dropdown application", group = "launcher"}),

    -- Widgets popups
    -- awful.key({ keys.alt, }, "c", function () if beautiful.cal then beautiful.cal.show(7) end end,
    --           {description = "show calendar", group = "widgets"}),
    -- awful.key({ keys.alt, }, "h", function () if beautiful.fs then beautiful.fs.show(7) end end,
    --           {description = "show filesystem", group = "widgets"}),
    -- awful.key({ keys.alt, }, "w", function () if beautiful.weather then beautiful.weather.show(7) end end,
    --           {description = "show weather", group = "widgets"}),

    -- Screen brightness
 --   awful.key({ }, "XF86MonBrightnessUp", function () os.execute("xbacklight -inc 10") end,
 --             {description = "+10%", group = "hotkeys"}),
 --   awful.key({ }, "XF86MonBrightnessDown", function () os.execute("xbacklight -dec 10") end,
 --             {description = "-10%", group = "hotkeys"}),
    awful.key({ }, "XF86MonBrightnessUp", function () os.execute("rpi-backlight up") end, 
              {description = "+10%", group = "hotkeys"}), 
    awful.key({ }, "XF86MonBrightnessDown", function () os.execute("rpi-backlight down") end, 
              {description = "-10%", group = "hotkeys"}),
    
    -- ALSA volume control
   awful.key({}, "XF86AudioRaiseVolume", 
	function ()
            os.execute(string.format("amixer -q set %s 1%%+", beautiful.volume.channel))
            beautiful.volume.update()
        end,
        {description = "volume up", group = "hotkeys"}),   
   awful.key({}, "XF86AudioLowerVolume", 
	function ()
            os.execute(string.format("amixer -q set %s 1%%-", beautiful.volume.channel))
            beautiful.volume.update()
        end,
        {description = "volume down", group = "hotkeys"}), 
   awful.key({ keys.alt }, "m",
        function ()
            os.execute(string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel))
            beautiful.volume.update()
        end,
        {description = "toggle mute", group = "hotkeys"}),
    awful.key({ keys.alt, "Control" }, "m",
        function ()
            os.execute(string.format("amixer -q set %s 100%%", beautiful.volume.channel))
            beautiful.volume.update()
        end,
        {description = "volume 100%", group = "hotkeys"}),
    awful.key({ keys.alt, "Control" }, "0",
        function ()
            os.execute(string.format("amixer -q set %s 0%%", beautiful.volume.channel))
            beautiful.volume.update()
        end,
        {description = "volume 0%", group = "hotkeys"}),

    -- MPD control
    -- awful.key({ keys.alt, "Control" }, "Up",
    --     function ()
    --         os.execute("mpc toggle")
    --         beautiful.mpd.update()
    --     end,
    --     {description = "mpc toggle", group = "widgets"}),
    -- awful.key({ keys.alt, "Control" }, "Down",
    --     function ()
    --         os.execute("mpc stop")
    --         beautiful.mpd.update()
    --     end,
    --     {description = "mpc stop", group = "widgets"}),
    -- awful.key({ keys.alt, "Control" }, "Left",
    --     function ()
    --         os.execute("mpc prev")
    --         beautiful.mpd.update()
    --     end,
    --     {description = "mpc prev", group = "widgets"}),
    -- awful.key({ keys.alt, "Control" }, "Right",
    --     function ()
    --         os.execute("mpc next")
    --         beautiful.mpd.update()
    --     end,
    --     {description = "mpc next", group = "widgets"}),
    -- awful.key({ keys.alt }, "0",
    --     function ()
    --         local common = { text = "MPD widget ", position = "top_middle", timeout = 2 }
    --         if beautiful.mpd.timer.started then
    --             beautiful.mpd.timer:stop()
    --             common.text = common.text .. lain.util.markup.bold("OFF")
    --         else
    --             beautiful.mpd.timer:start()
    --             common.text = common.text .. lain.util.markup.bold("ON")
    --         end
    --         naughty.notify(common)
    --     end,
    --     {description = "mpc on/off", group = "widgets"}),

    -- Copy primary to clipboard (terminals to gtk)
    awful.key({ keys.mod }, "c", function () awful.spawn.with_shell("xsel | xsel -i -b") end,
              {description = "copy terminal to gtk", group = "hotkeys"}),
    -- Copy clipboard to primary (gtk to terminals)
    awful.key({ keys.mod }, "v", function () awful.spawn.with_shell("xsel -b | xsel") end,
              {description = "copy gtk to terminal", group = "hotkeys"}),

    --Menubar
    -- awful.key({ "Control"}, "space", function() menubar.show() end, {description = "show the menubar", group = "launcher"}),

    -- --dmenu
    -- awful.key({ keys.mod }, "r", function ()
    --                                 os.execute(string.format("dmenu_run -i -fn 'Monospace' -nb '%s' -nf '%s' -sb '%s' -sf '%s'",
    --                                 beautiful.bg_normal, beautiful.fg_normal, beautiful.bg_focus, beautiful.fg_focus))
    --                             end,
    --           {description = "show dmenu", group = "launcher"}),
    --
    -- alternatively use rofi, a dmenu-like application with more features
    -- check https://github.com/DaveDavenport/rofi for more details
    --rofi
    awful.key({ keys.mod }, "space", function () os.execute(apps.default.app_launcher) end, {description = "show app", group = "launcher"}),
    awful.key({ "Control" }, "space", function () os.execute(apps.default.app_launcher) end, {description = "show app", group = "launcher"})
)

clientkeys = mytable.join(
    awful.key({ keys.alt, "Shift"   }, "m",      lain.util.magnify_client,
              {description = "magnify client", group = "client"}),
    awful.key({ keys.mod,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ keys.mod,           }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ keys.mod, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ "Control", "Shift" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ "Control", "Shift" }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ keys.mod,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ keys.mod,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ keys.mod,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ keys.mod, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ keys.mod, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"}),
    -- Move Client to left
    awful.key({ "Control", "Shift"}, "Left",
        function (c)
            -- if c.focus then
                local index = c.screen.selected_tag.index
                local tag = c.screen.tags[index-1]
                if tag then
                    c:move_to_tag(tag)
                end
            --   then move the focus to that tag
                awful.tag.viewprev()
            -- end
        end,
        {description = "move client to left tag", group = "tag"}),
    -- Move Client to right
    awful.key({ "Control", "Shift"}, "Right",
        function (c)
            -- if c then
                local index = c.screen.selected_tag.index
                local tag = c.screen.tags[index+1]
                if tag then
                    c:move_to_tag(tag)
                end
            --   then move the focus to that tag
                awful.tag.viewnext()
            -- end
        end,
        {description = "move client to right tag", group = "tag"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
-- for i = 1, 9 do
--     globalkeys = mytable.join(globalkeys,
--         -- -- View tag only.
--         -- awful.key({ keys.mod }, "#" .. i + 9,
--         --           function ()
--         --                 local screen = awful.screen.focused()
--         --                 local tag = screen.tags[i]
--         --                 if tag then
--         --                    tag:view_only()
--         --                 end
--         --           end,
--         --           {description = "view tag #"..i, group = "tag"}),
--         -- -- Toggle tag display.
--         -- awful.key({ keys.mod, "Control" }, "#" .. i + 9,
--         --           function ()
--         --               local screen = awful.screen.focused()
--         --               local tag = screen.tags[i]
--         --               if tag then
--         --                  awful.tag.viewtoggle(tag)
--         --               end
--         --           end,
--         --           {description = "toggle tag #" .. i, group = "tag"}),
--         -- -- Move client to tag.
--         -- awful.key({ "Control", "Shift" }, "#" .. i + 9,
--         --           function ()
--         --               if client.focus then
--         --                   local tag = client.focus.screen.tags[i]
--         --                   if tag then
--         --                       client.focus:move_to_tag(tag)
--         --                   end
--         --              end
--         --           end,
--         --           {description = "move focused client to tag #"..i, group = "tag"}),
       

--         -- -- Toggle tag on focused client.
--         -- awful.key({ keys.mod, "Control", "Shift" }, "#" .. i + 9,
--         --           function ()
--         --               if client.focus then
--         --                   local tag = client.focus.screen.tags[i]
--         --                   if tag then
--         --                       client.focus:toggle_tag(tag)
--         --                   end
--         --               end
--         --           end,
--         --           {description = "toggle focused client on tag #" .. i, group = "tag"})
--     )
-- end

clientbuttons = mytable.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ keys.mod }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ keys.mod }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
