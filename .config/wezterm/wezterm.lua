local wezterm = require('wezterm')
local act = wezterm.action

local config = {
  default_prog = { os.getenv("SHELL") },
  color_scheme = 'Micrac',
  font_size = 10,
  font = wezterm.font_with_fallback {
    'DejaVuSansM Nerd Font Mono',
    'DejaVu Sans Mono',
  },
  use_fancy_tab_bar = false,
  -- show_tabs_in_tab_bar = false,
  -- show_new_tab_button_in_tab_bar = false,
  -- enable_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  window_padding = {
    bottom = 0,
    top = 0,
    left = 0,
    right = 0,
  },
  disable_default_key_bindings = true,
  keys = {
    -- Font size
    { key = '+', mods = 'CTRL|SHIFT', action = act.IncreaseFontSize },
    { key = '-', mods = 'CTRL', action = act.DecreaseFontSize },
    { key = '0', mods = 'CTRL', action = act.ResetFontSize },
    -- Tabs
    -- { key = '1', mods = 'SHIFT|CTRL', action = act.ActivateTab(0) },
    -- { key = '2', mods = 'SHIFT|CTRL', action = act.ActivateTab(1) },
    -- { key = '3', mods = 'SHIFT|CTRL', action = act.ActivateTab(2) },
    -- { key = '4', mods = 'SHIFT|CTRL', action = act.ActivateTab(3) },
    -- { key = '5', mods = 'SHIFT|CTRL', action = act.ActivateTab(4) },
    -- { key = '7', mods = 'SHIFT|CTRL', action = act.ActivateTab(6) },
    -- { key = '8', mods = 'SHIFT|CTRL', action = act.ActivateTab(7) },
    -- { key = '9', mods = 'SHIFT|CTRL', action = act.ActivateTab(-1) },
    -- Clipboard
    { key = 'c', mods = 'SHIFT|CTRL', action = act.CopyTo 'Clipboard' },
    { key = 'v', mods = 'SHIFT|CTRL', action = act.PasteFrom 'Clipboard' },
    { key = 'Insert', mods = 'NONE', action = act.PasteFrom 'Clipboard' },
    { key = 'Copy', mods = 'NONE', action = act.CopyTo 'Clipboard' },
    { key = 'Paste', mods = 'NONE', action = act.PasteFrom 'Clipboard' },
    -- Modes
    { key = 'phys:Space', mods = 'SHIFT|CTRL', action = act.QuickSelect },
    { key = 'x', mods = 'SHIFT|CTRL', action = act.ActivateCopyMode },
    { key = ':', mods = 'SHIFT|CTRL', action = act.ActivateCommandPalette },
    { key = 'f', mods = 'SHIFT|CTRL', action = act.Search 'CurrentSelectionOrEmptyString' },
    { key = 'l', mods = 'SHIFT|CTRL', action = act.ShowDebugOverlay },
    -- New window
    { key = 'Enter', mods = 'ALT', action = act.SpawnWindow },
    { key = 'r', mods = 'SHIFT|CTRL', action = act.ReloadConfiguration },
    -- Unicode input
    { key = 'u', mods = 'SHIFT|CTRL', action = act.CharSelect{ copy_on_select = true, copy_to =  'ClipboardAndPrimarySelection' } },
    { key = 'z', mods = 'SHIFT|CTRL', action = act.TogglePaneZoomState },
    -- Scrolling
    { key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1) },
    { key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1) },
    { key = 'UpArrow', mods = 'SHIFT', action = act.ScrollByLine(-1) },
    { key = 'DownArrow', mods = 'SHIFT', action = act.ScrollByLine(1) },
    { key = 'UpArrow', mods = 'SHIFT|CTRL', action = act.ScrollByLine(-5) },
    { key = 'DownArrow', mods = 'SHIFT|CTRL', action = act.ScrollByLine(5) },
  },
  window_background_opacity = 0.8,

  term = "wezterm",
  -- Debug
  debug_key_events = true,
}

return config
