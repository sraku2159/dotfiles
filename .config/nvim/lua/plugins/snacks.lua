return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = { hidden = true },
          explorer = {
            hidden = true,
            win = {
              input = {
                keys = {
                  ["<C-l>"] = "focus_list", -- list windowにフォーカス
                },
              },
              list = {
                keys = {
                  ["<C-h>"] = "focus_input", -- input windowに戻る
                },
              },
            },
          },
        },
      },
    },
  },
}
