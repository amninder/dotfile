-- Gruvbox colorscheme with treesitter support
-- https://github.com/ellisonleao/gruvbox.nvim
return {
  'ellisonleao/gruvbox.nvim',
  priority = 1000,
  config = function()
    require('gruvbox').setup {
      contrast = '', -- can be 'hard', 'soft' or empty string
      italic = {
        strings = false,
        comments = false,
        operators = false,
        folds = false,
      },
      overrides = {
        -- Match gutter (line numbers, signs, folds) background to editor background
        SignColumn = { bg = '' }, -- Empty string means use Normal background
        LineNr = { bg = '' }, -- Line number column
        CursorLineNr = { bg = '' }, -- Current line number
        FoldColumn = { bg = '' }, -- Fold column
      },
    }
    vim.cmd.colorscheme 'gruvbox'
  end,
}
