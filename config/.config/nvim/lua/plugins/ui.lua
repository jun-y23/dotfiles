return {
  -- Tokyo Night theme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true }
        }
      })

      -- 背景色を透過
      vim.cmd('colorscheme tokyonight')
      vim.cmd('highlight Normal guibg=NONE ctermbg=NONE')
    end
  },

  -- Toggleterm
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require('toggleterm').setup({
        open_mapping = [[<c-\>]],
        direction = 'float',
      })
      -- Horizontal terminal toggle
      vim.keymap.set('n', '<leader>th', function()
        vim.cmd('ToggleTerm direction=horizontal')
      end, { desc = 'Toggle horizontal terminal' })
      -- Terminal resize keymaps
      vim.keymap.set('n', '<leader>t+', ':resize +5<CR>', { desc = 'Increase terminal height' })
      vim.keymap.set('n', '<leader>t-', ':resize -5<CR>', { desc = 'Decrease terminal height' })
      vim.keymap.set('n', '<leader>t>', ':vertical resize +10<CR>', { desc = 'Increase terminal width' })
      vim.keymap.set('n', '<leader>t<', ':vertical resize -10<CR>', { desc = 'Decrease terminal width' })

      -- Terminal navigation keymaps
      function _G.set_terminal_keymaps()
        local opts = { buffer = 0 }
        -- Window navigation
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
        -- Exit terminal mode with Ctrl-g
        vim.keymap.set('t', '<C-g>', [[<C-\><C-n>]], opts)
        -- Normal mode navigation in terminal
        vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], opts)
      end

      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    end
  },

  -- Neo-tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require('neo-tree').setup({
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,
          },
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "󰜌",
          provider = function(icon, node, state) -- default icon provider utilizes nvim-web-devicons if available
            if node.type == "file" or node.type == "terminal" then
              local success, web_devicons = pcall(require, "nvim-web-devicons")
              local name = node.type == "terminal" and "terminal" or node.name
              if success then
                local devicon, hl = web_devicons.get_icon(name)
                icon.text = devicon or icon.text
                icon.highlight = hl or icon.highlight
              end
            end
          end,
          -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
          -- then these will never be used.
          default = "*",
          highlight = "NeoTreeFileIcon",
        },

        window = {
          mappings = {
            ["<C-h>"] = function() vim.cmd("wincmd h") end,
            ["<C-j>"] = function() vim.cmd("wincmd j") end,
            ["<C-k>"] = function() vim.cmd("wincmd k") end,
            ["<C-l>"] = function() vim.cmd("wincmd l") end,
            ["l"] = "open",
            ["h"] = "close_node",
          }
        }
      })

      -- Neotree toggle keybind
      vim.keymap.set('n', '<C-n>', ':Neotree toggle<CR>', { silent = true })
    end
  }
}
