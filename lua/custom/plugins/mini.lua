-- Collection of various small independent plugins/modules
-- https://github.com/echasnovski/mini.nvim
return {
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- NOTE: surround functionality moved to nvim-surround plugin
    -- See lua/custom/plugins/nvim-surround.lua (uses ys/ds/cs keymaps)

    -- NOTE: mini.statusline removed - now using lualine
    -- See lua/custom/plugins/lualine.lua
  end,
}
