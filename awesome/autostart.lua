local awful         = require("awful")

--[[    This function will run once every time Awesome is started) ]]
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        findme = cmd
        firstspace = cmd:find(" ")
        if firstspace then
            findme = cmd:sub(0, firstspace-1)
        end
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end

-- Autostart programs
run_once({ "xrandr --output DSI-1 --rotate right"}) -- Rotate screen for uConsole
run_once({ "picom --config ~/.awesome/picom.conf" }) -- Enable transparency
run_once({ "unclutter -root" }) -- Hide mouse when not in use

-- This function implements the XDG autostart specification
awful.spawn.with_shell(
    'if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then exit; fi;' ..
    'xrdb -merge <<< "awesome.started:true";' ..
    -- list each of your autostart commands, followed by ; inside single quotes, followed by ..
    'dex --environment Awesome --autostart --search-paths "$XDG_CONFIG_DIRS/autostart:$XDG_CONFIG_HOME/autostart"' -- https://github.com/jceb/dex
)