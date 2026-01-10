-- Highlight, edit, and navigate code
-- https://github.com/nvim-treesitter/nvim-treesitter
return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  config = function()
    -- Use prebuilt parsers to avoid tree-sitter CLI version incompatibility
    require('nvim-treesitter.install').prefer_git = false

    require('nvim-treesitter.configs').setup {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'latex', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'python', 'query', 'vim', 'vimdoc' },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    }
  end,
}
