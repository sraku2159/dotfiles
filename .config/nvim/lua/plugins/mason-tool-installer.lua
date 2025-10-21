return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        "ast-grep",
      },
      auto_update = true,
      run_on_start = true,
    },
  },
}
