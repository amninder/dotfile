-- Colorize hex codes, rgb, etc. in the buffer
-- https://github.com/norcalli/nvim-colorizer.lua
return {
  'norcalli/nvim-colorizer.lua',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('colorizer').setup({
      '*', -- Enable for all filetypes
    }, {
      RGB = true, -- #RGB hex codes
      RRGGBB = true, -- #RRGGBB hex codes
      names = false, -- "Name" codes like Blue
      RRGGBBAA = true, -- #RRGGBBAA hex codes
      rgb_fn = true, -- CSS rgb() and rgba()
      hsl_fn = true, -- CSS hsl() and hsla()
      css = false, -- Enable all CSS features
      css_fn = false, -- Enable all CSS *functions*
      mode = 'background', -- 'foreground' or 'background'
    })
  end,
}
