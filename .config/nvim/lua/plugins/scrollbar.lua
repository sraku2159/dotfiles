return {
  {
    "petertriho/nvim-scrollbar",
    -- 2026-11-16 に main が v2 へ切り替わり設定が非互換になるため、移行するまで v1 に固定
    -- https://github.com/petertriho/nvim-scrollbar/issues/121
    branch = "v1",
    event = "VeryLazy",
    opts = {
      handlers = {
        gitsigns = true, -- git変更箇所を表示
        diagnostic = true, -- エラーや警告を表示
      },
    },
  },
}
