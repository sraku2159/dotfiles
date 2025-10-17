return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-telescope/telescope-file-browser.nvim",
    },
    keys = {
      {
        "<leader>tfP",
        function()
          require("telescope.builtin").find_files({
            cwd = require("lazy.core.config").options.root,
          })
        end,
        desc = "Find Plugin File",
      },
      {
        "<Plug>(customPrefix)tf",
        function()
          local builtin = require("telescope.builtin")
          builtin.find_files({
            no_ignore = false,
            hidden = true,
          })
        end,
        desc = "Lists files of current working directory with hidden files",
      },
      {
        "<Plug>(customPrefix)tb",
        function()
          local builtin = require("telescope.builtin")
          builtin.buffers()
        end,
        desc = "Lists files of buffers",
      },
      {
        "<Plug>(customPrefix)tr",
        function()
          local builtin = require("telescope.builtin")
          builtin.resume()
        end,
        desc = "Lists the results incl.",
      },
      {
        "<Plug>(customPrefix)tl",
        function()
          local builtin = require("telescope.builtin")
          builtin.lsp_references()
        end,
        desc = "Lists the results incl.",
      },
    },
  },
}
