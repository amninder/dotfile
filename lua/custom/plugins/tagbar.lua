-- Tagbar: Display code structure in a sidebar
-- https://github.com/preservim/tagbar
-- Requires: Universal Ctags (install with: brew install universal-ctags)
return {
  'preservim/tagbar',
  cmd = 'TagbarToggle', -- Lazy load on command
  init = function()
    -- Configuration options (set before plugin loads)
    -- Uncomment and set if ctags is not in your PATH
    -- vim.g.tagbar_ctags_bin = '/path/to/ctags'

    -- Auto-close tagbar when selecting a tag
    vim.g.tagbar_autoclose = 0

    -- Auto-focus tagbar when opened
    vim.g.tagbar_autofocus = 1

    -- Width of tagbar window
    vim.g.tagbar_width = 30

    -- Sort tags by name instead of order in file
    vim.g.tagbar_sort = 0

    -- Show line numbers in tagbar
    vim.g.tagbar_show_linenumbers = 0

    -- Compact display (no extra blank lines)
    vim.g.tagbar_compact = 1
  end,
}
