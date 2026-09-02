local wezterm = require("wezterm")
local config = wezterm.config_builder()
local act = wezterm.action

config.leader = { key = "s", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
  {
    key = "|",
    mods = "LEADER|SHIFT",
    action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "-",
    mods = "LEADER",
    action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "s",
    mods = "LEADER",
    action = act.PaneSelect,
  },
  { key = "l", mods = "ALT",    action = act.ShowLauncher },

  -- workspace: fuzzy切り替え（既存workspaceの選択専用。
  -- ランチャー経由の新規作成はランダム名になるため使わず、作成は LEADER+W で）
  { key = "w", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
  -- workspace: 必ず名前を指定して作成/切り替え
  {
    key = "W",
    mods = "LEADER|SHIFT",
    action = act.PromptInputLine({
      description = "workspace name",
      action = wezterm.action_callback(function(window, pane, line)
        if line and line ~= "" then
          window:perform_action(act.SwitchToWorkspace({ name = line }), pane)
        end
      end),
    }),
  },
  -- workspace: 前後に巡回
  { key = "n", mods = "LEADER", action = act.SwitchWorkspaceRelative(1) },
  { key = "p", mods = "LEADER", action = act.SwitchWorkspaceRelative(-1) },
  -- 固定用途のworkspaceへ直行（監視）
  {
    key = "m",
    mods = "LEADER",
    action = act.SwitchToWorkspace({ name = "monitoring", spawn = { args = { "btop" } } }),
  },

  -- tab: 新規作成は必ず名前入力（デフォルトの CMD+t を置き換え。空入力ならタブを作らない）
  {
    key = "t",
    mods = "SUPER",
    action = act.PromptInputLine({
      description = "tab name",
      action = wezterm.action_callback(function(window, _, line)
        if line and line ~= "" then
          local tab = window:mux_window():spawn_tab({})
          tab:set_title(line)
        end
      end),
    }),
  },
  -- キーバインド一覧を新しいタブで表示（tmuxの prefix+? 相当）
  {
    key = "?",
    mods = "LEADER|SHIFT",
    action = act.SpawnCommandInNewTab({
      -- GUI起動のシェルはPATHが最小限でweztermを見つけられないため絶対パスで指定
      args = { "/bin/sh", "-c", wezterm.executable_dir .. "/wezterm show-keys | less" },
    }),
  },

  -- tab: 既存タブのリネーム
  {
    key = ",",
    mods = "LEADER",
    action = act.PromptInputLine({
      description = "rename tab",
      action = wezterm.action_callback(function(window, _, line)
        if line and line ~= "" then
          window:active_tab():set_title(line)
        end
      end),
    }),
  },
}

return config
