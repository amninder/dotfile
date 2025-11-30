-- Scope buffers to tabs
-- https://github.com/tiagovla/scope.nvim
-- Restricts buffer navigation to only show buffers within the current tab
return {
  'tiagovla/scope.nvim',
  config = function()
    require('scope').setup {
      hooks = {
        -- Hooks can be used to execute logic at different tab lifecycle events
        -- pre_tab_enter = function() end,
        -- post_tab_enter = function() end,
        -- pre_tab_leave = function() end,
        -- post_tab_leave = function() end,
        -- pre_tab_close = function() end,
        -- post_tab_close = function() end,
      },
    }
  end,
}
