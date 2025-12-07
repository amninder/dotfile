-- A blazing fast and easy to configure Neovim statusline
-- https://github.com/nvim-lualine/lualine.nvim
-- Styled to match tmux-powerline gruvbox-dark theme
return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- Gruvbox Dark palette (matches tmux-powerline theme)
    local gruvbox = {
      aqua = '#8ec07c',
      bg0 = '#282828',
      bg1 = '#3c3836',
      bg2 = '#504945',
      bg3 = '#665c54',
      bg4 = '#7c6f64',
      blue = '#83a598',
      fg0 = '#fbf1c7',
      fg1 = '#ebdbb2',
      fg2 = '#d5c4a1',
      fg3 = '#bdae93',
      fg4 = '#a89984',
      green = '#b8bb26',
      orange = '#fe8019',
      purple = '#d3869b',
      red = '#fb4934',
      white = '#FFFFFF',
      yellow = '#fabd2f',
    }

    -- Custom gruvbox theme matching tmux-powerline
    local custom_gruvbox = {
      normal = {
        a = { bg = gruvbox.yellow, fg = gruvbox.bg0, gui = 'bold' },
        b = { bg = gruvbox.bg2, fg = gruvbox.fg1 },
        c = { bg = gruvbox.bg1, fg = gruvbox.fg4 },
      },
      insert = {
        a = { bg = gruvbox.blue, fg = gruvbox.bg0, gui = 'bold' },
        b = { bg = gruvbox.bg2, fg = gruvbox.fg1 },
        c = { bg = gruvbox.bg1, fg = gruvbox.fg4 },
      },
      visual = {
        a = { bg = gruvbox.orange, fg = gruvbox.bg0, gui = 'bold' },
        b = { bg = gruvbox.bg2, fg = gruvbox.fg1 },
        c = { bg = gruvbox.bg1, fg = gruvbox.fg4 },
      },
      replace = {
        a = { bg = gruvbox.red, fg = gruvbox.bg0, gui = 'bold' },
        b = { bg = gruvbox.bg2, fg = gruvbox.fg1 },
        c = { bg = gruvbox.bg1, fg = gruvbox.fg4 },
      },
      command = {
        a = { bg = gruvbox.aqua, fg = gruvbox.bg0, gui = 'bold' },
        b = { bg = gruvbox.bg2, fg = gruvbox.fg1 },
        c = { bg = gruvbox.bg1, fg = gruvbox.fg4 },
      },
      inactive = {
        a = { bg = gruvbox.bg1, fg = gruvbox.fg4 },
        b = { bg = gruvbox.bg1, fg = gruvbox.fg4 },
        c = { bg = gruvbox.bg1, fg = gruvbox.fg4 },
      },
    }

    require('lualine').setup {
      options = {
        theme = custom_gruvbox,
        icons_enabled = true,
        -- Powerline bold arrow separators (matches tmux-powerline)
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
      },
      sections = {
        lualine_b = {
          {
            'branch',
            color = { bg = gruvbox.orange, fg = gruvbox.white, gui = 'bold' },
            separator = { left = '', right = '' },
          },
          'diff',
          'diagnostics',
        },
      },
    }
  end,
}
