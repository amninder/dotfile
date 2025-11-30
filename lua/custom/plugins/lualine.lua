-- A blazing fast and easy to configure Neovim statusline
-- https://github.com/nvim-lualine/lualine.nvim
return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup {
      options = {
        theme = 'gruvbox',
        icons_enabled = vim.g.have_nerd_font,
        component_separators = '|',
        section_separators = '',
      },
    }
  end,
}
