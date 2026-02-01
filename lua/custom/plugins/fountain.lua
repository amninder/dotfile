-- Screenplay/Final Draft fountain file support
-- https://github.com/0mykull/nvim-fountain
return {
  '0mykull/nvim-fountain',
  ft = 'fountain',
  opts = {
    keymaps = {
      next_scene = ']]',
      prev_scene = '[[',
      uppercase_line = '<leader>U',
    },
  },
}
