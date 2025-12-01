-- A snazzy bufferline for Neovim
-- https://github.com/akinsho/bufferline.nvim
return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    -- Get gruvbox colors
    local gruvbox_bg = vim.api.nvim_get_hl(0, { name = 'Normal' }).bg or '#282828'

    require('bufferline').setup {
      options = {
        mode = 'buffers', -- set to "tabs" to only show tabpages instead
        themable = true, -- allows highlight groups to be overridden
        numbers = 'none', -- can be "none" | "ordinal" | "buffer_id" | "both"
        close_command = 'bdelete! %d', -- can be a string | function
        right_mouse_command = 'bdelete! %d', -- can be a string | function
        left_mouse_command = 'buffer %d', -- can be a string | function
        middle_mouse_command = nil, -- can be a string | function
        indicator = {
          icon = '▎', -- this should be omitted if indicator style is not 'icon'
          style = 'icon', -- can be 'icon' | 'underline' | 'none'
        },
        buffer_close_icon = '󰅖',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',
        max_name_length = 18,
        max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
        truncate_names = true, -- whether or not tab names should be truncated
        tab_size = 18,
        diagnostics = 'nvim_lsp', -- can be "nvim_lsp" | "coc" | false
        diagnostics_update_in_insert = false,
        -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match 'error' and ' ' or ' '
          return ' ' .. icon .. count
        end,
        offsets = {
          {
            filetype = 'NvimTree',
            text = 'File Explorer',
            text_align = 'left', -- can be "left" | "center" | "right"
            separator = true,
          },
        },
        color_icons = true, -- whether or not to add the filetype icon highlights
        show_buffer_icons = true, -- disable filetype icons for buffers
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        separator_style = 'thin', -- can be "slant" | "slope" | "thick" | "thin" | { 'any', 'any' }
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        hover = {
          enabled = true,
          delay = 200,
          reveal = { 'close' },
        },
        sort_by = 'insert_after_current', -- can be 'insert_after_current' | 'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function
      },
      highlights = {
        fill = {
          bg = gruvbox_bg,
        },
        background = {
          bg = gruvbox_bg,
        },
        tab = {
          bg = gruvbox_bg,
        },
        tab_close = {
          bg = gruvbox_bg,
        },
      },
    }
  end,
}
