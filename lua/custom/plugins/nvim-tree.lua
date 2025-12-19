-- File explorer with tree view
-- https://github.com/nvim-tree/nvim-tree.lua
--
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
              unstaged = '󰃅', -- Modified/changed (nerd font f055)
              staged = '󰃅', -- Staged for commit
              unmerged = '~', -- Merge conflict
              renamed = '➜', -- Renamed
              untracked = '󰃅', -- New/added file (nerd font f00c5)
              deleted = '', -- Deleted (nerd font f444)
              ignored = '◌', -- Git ignored
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

    -- Custom highlight colors for git signs (Gruvbox palette) with bold
    vim.api.nvim_set_hl(0, 'NvimTreeGitNew', { fg = '#00ff00', bold = true }) -- Bright green - added/untracked
    vim.api.nvim_set_hl(0, 'NvimTreeGitDirty', { fg = '#fabd2f', bold = true }) -- Yellow - unstaged/modified
    vim.api.nvim_set_hl(0, 'NvimTreeGitStaged', { fg = '#fe8019', bold = true }) -- Orange - staged
    vim.api.nvim_set_hl(0, 'NvimTreeGitDeleted', { fg = '#fb4934', bold = true }) -- Red - deleted
    vim.api.nvim_set_hl(0, 'NvimTreeGitRenamed', { fg = '#d3869b', bold = true }) -- Purple - renamed
    vim.api.nvim_set_hl(0, 'NvimTreeGitMerge', { fg = '#fe8019', bold = true }) -- Orange - merge conflict
    vim.api.nvim_set_hl(0, 'NvimTreeGitIgnored', { fg = '#928374' }) -- Gray - ignored (not bold)
    -- Bold highlights for file/folder names with git status
    vim.api.nvim_set_hl(0, 'NvimTreeGitFileDirtyHL', { fg = '#fabd2f', bold = true })
    vim.api.nvim_set_hl(0, 'NvimTreeGitFileNewHL', { fg = '#b8bb26', bold = true })
    vim.api.nvim_set_hl(0, 'NvimTreeGitFileStagedHL', { fg = '#fe8019', bold = true })
    vim.api.nvim_set_hl(0, 'NvimTreeGitFileDeletedHL', { fg = '#fb4934', bold = true })
    vim.api.nvim_set_hl(0, 'NvimTreeGitFolderDirtyHL', { fg = '#fabd2f', bold = true })
    vim.api.nvim_set_hl(0, 'NvimTreeGitFolderNewHL', { fg = '#b8bb26', bold = true })
    vim.api.nvim_set_hl(0, 'NvimTreeGitFolderStagedHL', { fg = '#fe8019', bold = true })
    vim.api.nvim_set_hl(0, 'NvimTreeGitFolderDeletedHL', { fg = '#fb4934', bold = true })
  end,
}
