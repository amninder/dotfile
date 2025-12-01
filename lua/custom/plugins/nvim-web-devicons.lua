-- File type icons for nvim-tree and other plugins
-- https://github.com/nvim-tree/nvim-web-devicons
return {
  'nvim-tree/nvim-web-devicons',
  priority = 1000, -- Load before other UI plugins
  config = function()
    require('nvim-web-devicons').setup {
      -- Use all default icons from nvim-web-devicons
      default = true,
    }
  end,
}
