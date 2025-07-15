return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies =  {
    { "nvim-lua/plenary.nvim", lazy = true },
    { "MunifTanjim/nui.nvim", lazy = true },
    { "nvim-tree/nvim-web-devicons", lazy = true},
  },
  opts = {
   filesystem = {
      filtered_items = {
        hide_dotfiles = false,
      },
    },
  }
}
