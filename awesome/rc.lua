-- Required libraries

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- require("autostart")

local gears         = require("gears")
local awful         = require("awful")
                      require("awful.autofocus")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local naughty       = require("naughty")
local lain          = require("lain")
local menubar       = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
                      require("awful.hotkeys_popup.keys")
local apps          = require("apps")
local keys          = require("keys")
local mytable       = awful.util.table or gears.table -- 4.{0,1} compatibility

-- Error handling
require("errors")

-- Autostart windowless processes 
require("autostart")

-- Desktop
require("desktop")

-- Menu
require("menu")

-- Bindings
require("bindings")

-- Rules
require("rules")


-- Signals
require("signals")

