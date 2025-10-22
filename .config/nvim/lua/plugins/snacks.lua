return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = { hidden = true },
          explorer = { hidden = true },
        },
      },
      explorer = {
        keys = {
          filter = {
            ["<esc>"] = { "focus", mode = "n" },
          },
        },
      },
    },
  },
}
