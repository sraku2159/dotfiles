-- URLに組み込むリビジョンを「タグ → ブランチ → SHA(プラグインデフォルト)」の順で解決する。
-- setup() に rev オプションは存在しないため、キー押下時に解決して link({ rev = ... }) で渡す。
local function resolve_rev()
  local dir = vim.fn.shellescape(vim.fn.expand("%:p:h"))

  -- 1. 現在のコミットに正確に一致するタグ（v1.0.0など）があればそれを使う
  local tag = vim.fn.systemlist("git -C " .. dir .. " describe --tags --exact-match 2>/dev/null")[1]
  if vim.v.shell_error == 0 and tag and tag ~= "" then
    return tag
  end

  -- 2. タグがなければ、現在のアクティブなブランチ名（main, developなど）を使う
  local branch = vim.fn.systemlist("git -C " .. dir .. " branch --show-current 2>/dev/null")[1]
  if vim.v.shell_error == 0 and branch and branch ~= "" then
    return branch
  end

  -- 3. どちらも取れない（detached HEADなど）場合は nil を返し、
  --    プラグインのデフォルト解決（コミットハッシュ）に任せる
  return nil
end

local function link(action)
  require("gitlinker").link({
    router_type = "browse",
    action = action,
    rev = resolve_rev(),
  })
end

return {
  {
    "linrongbin16/gitlinker.nvim",
    cmd = "GitLink",
    keys = {
      -- ノーマル・ビジュアルモード両対応
      {
        "<leader>gyy",
        function()
          link(require("gitlinker.actions").clipboard)
        end,
        mode = { "n", "v" },
        desc = "Gitパーマリンクをコピー"
      },

      {
        "<leader>gyo",
        function()
          local actions = require("gitlinker.actions")
          link(function(url)
            actions.clipboard(url)
            actions.system(url)
          end)
        end,
        mode = { "n", "v" },
        desc = "Gitのリンクコピー&ブラウザで開く"
      },

      {
        "<leader>go",
        function()
          link(require("gitlinker.actions").system)
        end,
        mode = { "n", "v" },
        desc = "ブラウザで開く"
      },
    },
    opts = {},
  },
}
