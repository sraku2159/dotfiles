return {
  {
    "petertriho/nvim-scrollbar",
    event = "VeryLazy",
    opts = {
      handlers = {
        gitsigns = true, -- git変更箇所を表示
        diagnostic = true, -- エラーや警告を表示
      },
    },
  },
}
