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
      end,
      view = {
        width = 30,
      },
      renderer = {
        icons = {
          show = {
            hidden = true,
            file = true,
            folder = true,
            folder_arrow = true,
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
