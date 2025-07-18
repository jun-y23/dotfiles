return {
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    },
  },
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>hd", "<cmd>DiffviewOpen HEAD~1<cr>",   desc = "View Diff" },
      { "<leader>hf", "<cmd>DiffviewFileHistory %<cr>", desc = "View File History" },
    }
  }
}
