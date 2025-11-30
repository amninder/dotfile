-- Folding keymaps for nvim-ufo

-- za is already a default Vim keymap for toggling folds
-- It works automatically with nvim-ufo, but we document it here for clarity
vim.keymap.set('n', 'za', 'za', { desc = 'Toggle fold at cursor' })

-- Use ufo functions for better performance with zR and zM
local ufo = require 'ufo'

vim.keymap.set('n', 'zR', ufo.openAllFolds, { desc = 'Open all folds' })
vim.keymap.set('n', 'zM', ufo.closeAllFolds, { desc = 'Close all folds' })

-- Peek at folded content without opening the fold
vim.keymap.set('n', 'zK', function()
  local winid = ufo.peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end, { desc = 'Peek fold or show hover' })
