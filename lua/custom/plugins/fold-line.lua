-- Visual fold indicator lines
-- https://github.com/gh-liu/fold_line.nvim
return {
  'gh-liu/fold_line.nvim',
  event = 'VeryLazy',
  init = function()
    -- Configure fold line characters for visual appearance
    vim.g.fold_line_char_top_close = '>' -- Top of closed fold (matches foldclose)
    vim.g.fold_line_char_close = '├' -- Vertical connector for closed folds
    vim.g.fold_line_char_open_sep = '│' -- Fold separator line
    vim.g.fold_line_char_open_start = '╭' -- Start of open fold
    vim.g.fold_line_char_open_end = '╰' -- End of open fold
    vim.g.fold_line_char_open_start_close = '╒' -- Combined start-close
    vim.g.fold_line_char_open_end_close = '╘' -- Combined end-close
  end,
}
