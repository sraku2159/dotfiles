return {
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {
      -- 基本的な設定
      padding = true, -- コメント記号とテキストの間にスペースを追加
      sticky = true, -- カーソル位置を保持
      ignore = nil, -- 空行を無視するパターン

      -- キーマップ
      toggler = {
        line = "gcc", -- 行コメントトグル
        block = "gbc", -- ブロックコメントトグル
      },
      opleader = {
        line = "gc", -- 行コメント（モーション対応）
        block = "gb", -- ブロックコメント（モーション対応）
      },
      extra = {
        above = "gcO", -- 上に行を追加してコメント
        below = "gco", -- 下に行を追加してコメント
        eol = "gcA", -- 行末にコメント
      },
    },
  },
}
