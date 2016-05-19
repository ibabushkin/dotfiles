--------------------------
-- Default luakit theme --
--------------------------

local theme = {}

-- Default settings
theme.font = "sans 8"
theme.fg   = "#b8b8b8"
theme.bg   = "#202020"

-- Genaral colours
theme.success_fg = "#b8b8b8"
theme.loaded_fg  = "#33aadd"
theme.error_fg = "#f8f8f8"
theme.error_bg = "#ff0606"

-- Warning colours
theme.warning_fg = "#f8f8f8"
theme.warning_bg = "#ff0606"

-- Notification colours
theme.notif_fg = "#f8f8f8"
theme.notif_bg = "#ff0606"

-- Menu colours
theme.menu_fg                   = "#f2f2f2"
theme.menu_bg                   = "#202020"
theme.menu_selected_fg          = "#f8f8f8"
theme.menu_selected_bg          = "#535d6c"
theme.menu_title_bg             = "#202020"
theme.menu_primary_title_fg     = "#f8f8f8"
theme.menu_secondary_title_fg   = "#f2f2f2"

-- Proxy manager
theme.proxy_active_menu_fg      = '#f8f8f8'
theme.proxy_active_menu_bg      = '#535d6c'
theme.proxy_inactive_menu_fg    = '#f2f2f2'
theme.proxy_inactive_menu_bg    = '#202020'

-- Statusbar specific
theme.sbar_fg         = "#f2f2f2"
theme.sbar_bg         = "#101010"

-- Downloadbar specific
theme.dbar_fg         = "#f2f2f2"
theme.dbar_bg         = "#101010"
theme.dbar_error_fg   = "#ff0606"

-- Input bar specific
theme.ibar_fg           = "#f2f2f2"
theme.ibar_bg           = "#101010"

-- Tab label
theme.tab_fg            = "#888"
theme.tab_bg            = "#222"
theme.tab_ntheme        = "#ddd"
theme.selected_fg       = "#fff"
theme.selected_bg       = "#000"
theme.selected_ntheme   = "#ddd"
theme.loading_fg        = "#33AADD"
theme.loading_bg        = "#000"

-- Trusted/untrusted ssl colours
theme.trust_fg          = "#0F0"
theme.notrust_fg        = "#F00"

return theme
-- vim: et:sw=4:ts=8:sts=4:tw=80
