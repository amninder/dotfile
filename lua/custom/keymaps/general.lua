-- General keymaps not specific to any plugin

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Exit insert mode with jj
vim.keymap.set('i', 'jj', '<Esc>', { desc = 'Exit insert mode' })

-- Keybinds to make split navigation easier
-- Use CTRL+<hl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })

-- Buffer navigation with Ctrl+j/k (scoped to current tab with scope.nvim)
vim.keymap.set('n', '<C-j>', '<cmd>bprevious<CR>', { desc = 'Previous buffer (scoped)' })
vim.keymap.set('n', '<C-k>', '<cmd>bnext<CR>', { desc = 'Next buffer (scoped)' })

-- Toggle nvim-tree file explorer
-- Note: <C-e> is disabled inside nvim-tree buffer (see nvim-tree.lua on_attach)
vim.keymap.set('n', '<C-e>', ':NvimTreeToggle<CR>', { desc = 'Toggle file tree', silent = true, noremap = true })

-- Toggle tagbar code structure sidebar
vim.keymap.set('n', '<C-t>', '<cmd>TagbarToggle<CR>', { desc = 'Toggle tagbar', silent = true })

-- Buffer navigation (scoped to current tab with scope.nvim)
vim.keymap.set('n', '[b', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', ']b', '<cmd>bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bd', '<cmd>bdelete<CR>', { desc = '[B]uffer [D]elete' })
vim.keymap.set('n', '<leader>bn', '<cmd>enew<CR>', { desc = '[B]uffer [N]ew' })

-- Split window management
vim.keymap.set('n', 'sj', '<C-W>w', { desc = 'Move to next window' })
vim.keymap.set('n', 'sk', '<C-W>W', { desc = 'Move to previous window' })
vim.keymap.set('n', 'su', '<cmd>resize +5<CR>', { desc = 'Increase window height' })
vim.keymap.set('n', 'si', '<cmd>resize -5<CR>', { desc = 'Decrease window height' })
vim.keymap.set('n', 'sh', '<cmd>vertical resize -5<CR>', { desc = 'Decrease window width' })
vim.keymap.set('n', 'sl', '<cmd>vertical resize +5<CR>', { desc = 'Increase window width' })
vim.keymap.set('n', 'sd', '<cmd>hide<CR>', { desc = 'Hide current window' })
vim.keymap.set('n', 'ss', ':split ', { desc = 'Split window horizontally' })
vim.keymap.set('n', 'sv', ':vsplit ', { desc = 'Split window vertically' })

-- Tab navigation
vim.keymap.set('n', '[t', '<cmd>tabprevious<CR>', { desc = 'Previous tab' })
vim.keymap.set('n', ']t', '<cmd>tabnext<CR>', { desc = 'Next tab' })
vim.keymap.set('n', '<leader>tn', '<cmd>tabnew<CR>', { desc = '[T]ab [N]ew' })
vim.keymap.set('n', '<leader>tc', '<cmd>tabclose<CR>', { desc = '[T]ab [C]lose' })

-- Additional tab management
vim.keymap.set('n', 'th', '<cmd>tabfirst<CR>', { desc = 'Go to first tab' })
vim.keymap.set('n', 'tj', '<cmd>tabnext<CR>', { desc = 'Go to next tab' })
vim.keymap.set('n', 'tk', '<cmd>tabprev<CR>', { desc = 'Go to previous tab' })
vim.keymap.set('n', 'tl', '<cmd>tablast<CR>', { desc = 'Go to last tab' })
vim.keymap.set('n', 'tt', ':tabedit ', { desc = 'Open file in new tab' })
vim.keymap.set('n', 'tm', ':tabm ', { desc = 'Move tab to position' })
vim.keymap.set('n', 'td', '<cmd>tabclose<CR>', { desc = 'Close current tab' })
