return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  opts = {
    terminal = {
      split_side = "right",
      split_width_percentage = 0.50,
      provider = "auto"
    },
    diff_opts = {
      auto_close_on_accept = true,
      vertical_split = true
    }
  },
  keys = {
    { "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude Code" },
    { "<leader>cf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude Code" },
    { "<leader>cs", "<cmd>ClaudeCodeStatus<cr>", desc = "Claude Code Status" },
  }
}