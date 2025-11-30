-- Modern folding plugin using treesitter and LSP
-- https://github.com/kevinhwang91/nvim-ufo
return {
  'kevinhwang91/nvim-ufo',
  dependencies = {
    'kevinhwang91/promise-async',
  },
  event = 'VeryLazy',
  opts = {
    provider_selector = function(bufnr, filetype, buftype)
      -- Use treesitter as primary provider, fallback to indent
      return { 'treesitter', 'indent' }
    end,
    -- Customize fold text to show number of folded lines
    fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
      local newVirtText = {}
      local suffix = (' 󰁂 %d '):format(endLnum - lnum)
      local sufWidth = vim.fn.strdisplaywidth(suffix)
      local targetWidth = width - sufWidth
      local curWidth = 0
      for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
          table.insert(newVirtText, chunk)
        else
          chunkText = truncate(chunkText, targetWidth - curWidth)
          local hlGroup = chunk[2]
          table.insert(newVirtText, { chunkText, hlGroup })
          chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if curWidth + chunkWidth < targetWidth then
            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
          end
          break
        end
        curWidth = curWidth + chunkWidth
      end
      table.insert(newVirtText, { suffix, 'MoreMsg' })
      return newVirtText
    end,
  },
  config = function(_, opts)
    -- Fold options for better UX
    vim.o.foldcolumn = '1' -- Show fold column
    vim.o.foldlevel = 99 -- Open most folds by default
    vim.o.foldlevelstart = 99 -- Start with folds open
    vim.o.foldenable = true -- Enable folding
    vim.o.fillchars = [[eob: ,fold: ,foldopen:▼,foldclose:▶]]

    require('ufo').setup(opts)

    -- Highlight configuration for ufo
    vim.cmd [[
      hi default link UfoPreviewSbar PmenuSbar
      hi default link UfoPreviewThumb PmenuThumb
      hi default link UfoPreviewWinBar UfoFoldedBg
      hi default link UfoPreviewCursorLine Visual
      hi default link UfoFoldedEllipsis Comment
      hi default link UfoCursorFoldedLine CursorLine
    ]]
  end,
}
