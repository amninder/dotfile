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
          glyphs = {
            git = {
              unstaged = '',  -- Modified/changed
              staged = '',    -- Staged for commit
              unmerged = '',  -- Merge conflict
              renamed = '➜',   -- Renamed
              untracked = '', -- New/added file
              deleted = '',   -- Deleted
              ignored = '◌',   -- Git ignored
            },
          },
        },
        highlight_git = 'name', -- Highlight git status on file/folder names
      },
      git = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
      },
    }

    -- Custom highlight colors for git signs (Gruvbox palette)
    vim.api.nvim_set_hl(0, 'NvimTreeGitNew', { fg = '#b8bb26' })        -- Green - added/untracked
    vim.api.nvim_set_hl(0, 'NvimTreeGitDirty', { fg = '#fabd2f' })      -- Yellow - modified
    vim.api.nvim_set_hl(0, 'NvimTreeGitStaged', { fg = '#b8bb26' })     -- Green - staged
    vim.api.nvim_set_hl(0, 'NvimTreeGitDeleted', { fg = '#fb4934' })    -- Red - deleted
    vim.api.nvim_set_hl(0, 'NvimTreeGitRenamed', { fg = '#d3869b' })    -- Purple - renamed
    vim.api.nvim_set_hl(0, 'NvimTreeGitMerge', { fg = '#fe8019' })      -- Orange - merge conflict
    vim.api.nvim_set_hl(0, 'NvimTreeGitIgnored', { fg = '#928374' })    -- Gray - ignored
  end,
}
