---------------------------------------------------------------------------
-- @author Inokentiy Babushkin <inokentiy.babushkin@googlemail.com>
-- @copyright 2015 Inokentiy Babushkin
-- @copyright 2008 Julien Danjou
-- Simple, yet complete configuration for the awesome window manager.
-- Implements the features of the standard config, as well as some
-- todo-agenda via naughty notification, lain widgets, mouse
-- positioning, fixes for fullscreen videos in tiled layouts, removed
-- unnecessary code and features (launcher in taskbar etc.), applied
-- some neat settings (taglist only shows minimized clients).
-- @license beerware
---------------------------------------------------------------------------

local gears = require("gears")
local awful = require("awful")

awful.rules = require("awful.rules")

local autofocus = require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local lain = require("lain")
local string = require("string")

-- {{{ error handling
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors
                  })
end

-- handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true
        awful.util.spawn("logger " .. err)
        in_error = false
    end)
end
-- }}}

-- {{{ variable definitions
-- themes define colours, icons, and wallpapers
beautiful.init("~/.config/awesome/theme.lua")

-- notfication objects for on-demand destroying
local org_notification = nil
local weather_notification = nil

local agenda_command =
    "~/.local/bin/morgue -d -f Pango -s slow ~/org/notes.md ~/org/uni.md"
local forecast_command =
    "~/.local/bin/hweather -a $(cat ~/hweather/openweathermap.id) -f Pango \
    -u Metric -c Aachen -C de"


-- this is used later as the default terminal and editor to run.
terminal = "termite"
editor = "vim"

-- default modkey
modkey = "Mod4"

-- volume widget
volume = lain.widgets.alsabar()

-- CPU widget
cpu = lain.widgets.cpu({
    timeout = 2,
    settings = function()
        widget:set_markup("<b>cpu:</b> " .. cpu_now.usage .. "%")
    end
})

-- memory and swap stats widget
mem = lain.widgets.mem({
    timeout = 2,
    settings = function()
        widget:set_markup("<b>mem:</b> " .. mem_now.used ..
        "MiB / " .. mem_now.swapused .. "MiB")
    end
})

-- battery status
bat = lain.widgets.bat({
    timeout = 30,
    settings = function()
        widget:set_markup("<b>bat:</b> " .. bat_now['perc'] .. "%")
    end
})


-- table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
}
-- }}}

-- {{{ set wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, false)
    end
end
-- }}}

-- {{{ tags and their layouts
tags = {
  names  = { "web", "2", "3", "4", "5", "media", "chat", "logs", "monitoring"},
  layout = { layouts[1], layouts[1], layouts[1], layouts[1], layouts[5],
             layouts[1], layouts[4], layouts[3], layouts[4]
           }
}
 
-- tags on secondary monitor (if any)
tags2 = {
  names =  { "chat", "books", "presentation", "4", "5", "6"},
  layout = { layouts[1], layouts[1], layouts[5], layouts[5],
             layouts[5], layouts[5]}
}

-- for each screen, create the tagset
for s = 1, screen.count() do
    if s ~= 2 then
        tags[s] = awful.tag(tags.names, s, tags.layout)
    else
        tags[s] = awful.tag(tags2.names, s, tags.layout)
    end
end

-- for the chat tag, set the master window factor
awful.tag.setmwfact(0.7, tags[1][7])

-- for each tag used for monitoring, set the master window factor
awful.tag.setmwfact(0.3, tags[1][8])
awful.tag.setmwfact(0.65, tags[1][9])

-- }}}

-- move the mouse out of the way (also bound to a key below)
function hide_mouse() mouse.coords({x=0, y=768}) end

hide_mouse()

-- {{{ menu

-- create a laucher widget and a main menu with submenus
mygamemenu = {
   { "&minecraft", "java -jar ~/Minecraft.jar" },
   { "&sauerbraten", "sauerbraten-client" },
   { "&flightgear", "fgo" },
}

mymainmenu = awful.menu({
    items = { { "&luakit", "luakit" },
              { "&firefox", "firefox" },
              { "&org", terminal .. " -e \"vim org/notes.md\"" },
              { "&bookmarks", terminal .. " -e \"vim bookmarks.md\"" },
              { "&weechat", terminal .. " --class Chat -e weechat" },
              { "&telegram", terminal .. " --class Chat -e \"telegram-cli -A\"" },
              { "&mumble", "mumble" },
              { "&games", mygamemenu },
          }
      })

-- }}}

-- {{{ wibox
-- create a textclock widget
mytextclock = awful.widget.textclock()

-- create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytasklist = {}

for s = 1, screen.count() do
    -- create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- create an imagebox widget for layout symbols
    -- we need one layoutbox per screen
    mylayoutbox[s] = awful.widget.layoutbox(s)

    -- create a taglist widget
    mytaglist[s] = awful.widget.taglist(s,
        awful.widget.taglist.filter.all, mytaglist.buttons)

    -- create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s,
        awful.widget.tasklist.filter.minimizedcurrenttags, mytasklist.buttons)

    -- create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })

    -- {{{ widgets that are aligned to the left

    local left_layout = wibox.layout.fixed.horizontal()

    -- make sure the taglist gets a margin to the left
    taglist_layout = wibox.layout.margin()
    taglist_layout:set_left(8)
    taglist_layout:set_widget(mytaglist[s])
    left_layout:add(taglist_layout)
    left_layout:add(mypromptbox[s])

    -- }}}

    -- {{{ widgets that are aligned to the right

    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    sep3 = wibox.widget.textbox()
    sep3:set_text(" : ")
    right_layout:add(sep3)
    right_layout:add(volume.bar)
    
    -- make the cpu widget fixed-sized
    cpu_layout = wibox.layout.constraint()
    cpu_layout:set_strategy("exact")
    cpu_layout:set_width(60)
    cpu_layout:set_widget(cpu)

    -- same for mem
    mem_layout = wibox.layout.constraint()
    mem_layout:set_strategy("exact")
    mem_layout:set_width(150)
    mem_layout:set_widget(mem)

    -- and bat
    bat_layout = wibox.layout.constraint()
    bat_layout:set_strategy("exact")
    bat_layout:set_width(65)
    bat_layout:set_widget(bat)
    
    -- add the rest of the right-aligned widgets
    sep4 = wibox.widget.textbox()
    sep4:set_text(" :: ")
    right_layout:add(sep4)
    right_layout:add(cpu_layout)
    sep0 = wibox.widget.textbox()
    sep0:set_text(" :: ")
    right_layout:add(sep0)
    right_layout:add(mem_layout)
    sep1 = wibox.widget.textbox()
    sep1:set_text(" :: ")
    right_layout:add(sep1)
    right_layout:add(bat_layout)
    sep2 = wibox.widget.textbox()
    sep2:set_text(" ::: ")
    right_layout:add(sep2)
    right_layout:add(mytextclock)
    right_layout:add(mylayoutbox[s])

    -- }}}

    -- now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ key bindings
globalkeys = awful.util.table.join(
    -- volume settings
    awful.key({}, "XF86AudioRaiseVolume",
        function ()
            awful.util.spawn("amixer -c 1 set Master 5%+")
            volume.update()
        end
    ),
    awful.key({}, "XF86AudioLowerVolume",
        function ()
            awful.util.spawn("amixer -c 1 set Master 5%-")
            volume.update()
        end
    ),
    awful.key({}, "XF86AudioMute",
        function ()
            awful.util.spawn("amixer -c 1 set Master toggle")
            volume.update()
        end
    ),
    awful.key({}, "XF86MonBrightnessDown",
        function ()
            awful.util.spawn("xbacklight -dec 5")
        end
    ),
    awful.key({}, "XF86MonBrightnessUp",
        function ()
            awful.util.spawn("xbacklight -inc 5")
        end
    ),

    -- focus clients by direction
    awful.key({modkey,            }, "k",
        function ()
            awful.client.focus.global_bydirection("up")
            if client.focus then client.focus:raise() end
        end),
    awful.key({modkey,            }, "j",
        function ()
            awful.client.focus.global_bydirection("down")
            if client.focus then client.focus:raise() end
        end),
    awful.key({modkey,            }, "l",
        function ()
            awful.client.focus.global_bydirection("right")
            if client.focus then client.focus:raise() end
        end),
    awful.key({modkey,            }, "h",
        function ()
            awful.client.focus.global_bydirection("left")
            if client.focus then client.focus:raise() end
        end), 

    -- swap clients by direction
    awful.key({modkey, "Shift"    }, "k",
        function ()
            awful.client.swap.global_bydirection("up")
            if client.focus then client.focus:raise() end
        end),
    awful.key({modkey, "Shift"    }, "j",
        function ()
            awful.client.swap.global_bydirection("down")
            if client.focus then client.focus:raise() end
        end),
    awful.key({modkey, "Shift"    }, "l",
        function ()
            awful.client.swap.global_bydirection("right")
            if client.focus then client.focus:raise() end
        end),
    awful.key({modkey, "Shift"    }, "h",
        function ()
            awful.client.swap.global_bydirection("left")
            if client.focus then client.focus:raise() end
        end),

    -- normal focusing by id
    awful.key({ modkey,           }, "+",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "-",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),

    -- show menu
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end),
    
    -- relative screen focus
    awful.key({ modkey, "Shift" }, "+",
        function () awful.screen.focus_relative( 1)
        end),
    awful.key({ modkey, "Shift" }, "-",
        function () awful.screen.focus_relative(-1)
        end),
    
    -- focus urgent / previous tags
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then client.focus:raise() end
        end),

    -- standard program
    awful.key({ modkey,           }, "i",
        function () awful.util.spawn(terminal) end),
    awful.key({ modkey,           }, "y", hide_mouse),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),
    
    -- layout and tag parameters 
    awful.key({ modkey, "Control" }, "k",
        function () awful.tag.incmwfact( 0.05) end),
    awful.key({ modkey, "Control" }, "j",
        function () awful.tag.incmwfact(-0.05) end),
    awful.key({ modkey, "Control" }, "h",
        function () awful.tag.incnmaster(1) end),
    awful.key({ modkey, "Control" }, "l",
        function () awful.tag.incnmaster(-1) end),
    awful.key({ modkey, "Control" }, "+",
        function () awful.tag.incncol( 1) end),
    awful.key({ modkey, "Control" }, "-",
        function () awful.tag.incncol(-1) end),
    awful.key({ modkey,           }, "space",
        function () awful.layout.inc(layouts, 1) end),
    awful.key({ modkey, "Shift"   }, "space",
        function () awful.layout.inc(layouts, -1) end),
    
    -- restore minimized client
    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- prompt
    awful.key({ modkey }, "r",
        function () mypromptbox[mouse.screen]:run() end),

    -- create a naughty notification with my agenda
    awful.key({ modkey }, "o",
        function()
            if org_notification == nil then
                local agenda = awful.util.pread(agenda_command)
                org_notification = naughty.notify({text = agenda, timeout = 0})
            else
                naughty.destroy(org_notification)
                org_notification = nil
            end
         end),

    -- create a naughty notification with my weather forecast
    awful.key({ modkey }, "p",
        function()
            if weather_notification == nil then
                local weather = awful.util.pread(forecast_command)
                weather_notification =
                    naughty.notify({text = weather, timeout = 0})
            else
                naughty.destroy(weather_notification)
                weather_notification = nil
            end
        end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",
        function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",
        function (c) c:kill() end),
    awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle),
    awful.key({ modkey, "Control" }, "Return",
        function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey, "Shift"   }, "o", awful.client.movetoscreen),
    awful.key({ modkey,           }, "t",
        function (c) c.ontop = not c.ontop end),
    awful.key({ modkey,           }, "n", function (c) c.minimized = true end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- bind all key numbers to tags.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
            function ()
                local screen = mouse.screen
                local tag = awful.tag.gettags(screen)[i]
                if tag then awful.tag.viewonly(tag) end
            end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
            function ()
                local screen = mouse.screen
                local tag = awful.tag.gettags(screen)[i]
                if tag then awful.tag.viewtoggle(tag) end
            end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = awful.tag.gettags(client.focus.screen)[i]
                    if tag then awful.client.movetotag(tag) end
               end
            end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
            function ()
                if client.focus then
                    local tag = awful.tag.gettags(client.focus.screen)[i]
                    if tag then awful.client.toggletag(tag) end
                end
            end)
        )
end

-- set keys
root.keys(globalkeys)
-- }}}

-- {{{ rules
awful.rules.rules = {
    -- all clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys } },
    { rule = { class = "Chat" },
      properties = { tag = tags[1][7],
                     switchtotag = true } },
    { rule = { class = "Firefox" },
      properties = { tag = tags[1][1],
                     switchtotag = true } },
    { rule = { class = "Log" },
      properties = { tag = tags[1][8],
                     urgent = false } },
    { rule = { class = "Monitor" },
      properties = { tag = tags[1][9],
                     urgent = false } },
}
-- }}}

-- {{{ signals
-- signal function to execute when a window is focused, used for flash player
client.connect_signal("focus",
    function(c) 
        if c.name == "plugin-container" then
            flash_client = c
            mt = timer({timeout=0.1})
            mt:connect_signal("timeout",
                function()
                    flash_client.fullscreen = true
                    mt:stop()
                end)
            mt:start()
        end
    end)

-- signal function to execute when a new client appears.
client.connect_signal("manage",
    function (c, startup)
        -- enable sloppy focus
        c:connect_signal("mouse::enter",
            function(c)
                if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
                    and awful.client.focus.filter(c) then
                    client.focus = c
                end
            end)

        if not startup then
            -- open as slave
            awful.client.setslave(c)
            if not c.size_hints.user_position
                and not c.size_hints.program_position then
                awful.placement.no_overlap(c)
                awful.placement.no_offscreen(c)
            end
        end
    end)

client.connect_signal("focus",
    function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus",
    function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- start our applications
require("autostart");
