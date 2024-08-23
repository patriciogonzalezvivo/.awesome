-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

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

