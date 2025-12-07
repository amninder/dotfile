-- File explorer with tree view
-- https://github.com/nvim-tree/nvim-tree.lua
return {
  'nvim-tree/nvim-tree.lua',
  config = function()
    require('nvim-tree').setup {
      on_attach = function(bufnr)
        local api = require 'nvim-tree.api'

        -- Default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- Remove C-e mapping inside tree to prevent navigating up directory
        -- Global C-e toggle is defined in custom/keymaps/general.lua
        vim.keymap.del('n', '<C-e>', { buffer = bufnr })

        -- Resize nvim-tree width (shadows global sh/sl when inside tree)
        vim.keymap.set('n', 'sh', '<cmd>vertical resize -5<CR>', { buffer = bufnr, desc = 'Decrease nvim-tree width' })
        vim.keymap.set('n', 'sl', '<cmd>vertical resize +5<CR>', { buffer = bufnr, desc = 'Increase nvim-tree width' })
      end,
      view = {
        width = 30,
      },
      filters = {
        dotfiles = false, -- Show hidden files (dotfiles)
        git_ignored = false, -- Show git-ignored files
      },
      actions = {
        open_file = {
          window_picker = {
            enable = false, -- Open in most recently used window instead of prompting
          },
        },
      },
      renderer = {
        icons = {
          show = {
            hidden = true,
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
          web_devicons = {
            file = {
              enable = true,
              color = true,
            },
            folder = {
              enable = false,
              color = true,
            },
          },
        },
      },
    }
  end,
}
