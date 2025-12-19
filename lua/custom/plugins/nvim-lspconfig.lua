-- Main LSP Configuration
-- https://github.com/neovim/nvim-lspconfig

-- Add filetype detection for DBML files
vim.filetype.add {
  extension = {
    dbml = 'dbml',
  },
}

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'mason-org/mason.nvim', opts = {} },
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
    'saghen/blink.cmp',
  },
  config = function()
    --  This function gets run when an LSP attaches to a particular buffer.
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        -- NOTE: Keymaps are defined in custom/keymaps/lsp.lua
        -- This autocmd is used for LSP-specific features like document highlighting

        -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
        ---@param client vim.lsp.Client
        ---@param method vim.lsp.protocol.Method
        ---@param bufnr? integer some lsp support methods only in specific files
        ---@return boolean
        local function client_supports_method(client, method, bufnr)
          if vim.fn.has 'nvim-0.11' == 1 then
            return client:supports_method(method, bufnr)
          else
            return client.supports_method(method, { bufnr = bufnr })
          end
        end

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
            end,
          })
        end
      end,
    })

    -- Diagnostic Config
    vim.diagnostic.config {
      severity_sort = true,
      float = { border = 'rounded', source = 'if_many' },
      underline = { severity = vim.diagnostic.severity.ERROR },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = '✗', -- Unicode cross
          [vim.diagnostic.severity.WARN] = '⚠', -- Unicode warning triangle
          [vim.diagnostic.severity.INFO] = 'ℹ', -- Unicode info symbol
          [vim.diagnostic.severity.HINT] = '💡', -- Unicode lightbulb
        },
      },
      virtual_text = {
        source = 'if_many',
        spacing = 2,
        format = function(diagnostic)
          local diagnostic_message = {
            [vim.diagnostic.severity.ERROR] = diagnostic.message,
            [vim.diagnostic.severity.WARN] = diagnostic.message,
            [vim.diagnostic.severity.INFO] = diagnostic.message,
            [vim.diagnostic.severity.HINT] = diagnostic.message,
          }
          return diagnostic_message[diagnostic.severity]
        end,
      },
    }

    -- Customize diagnostic sign colors (Gruvbox colors)
    vim.api.nvim_set_hl(0, 'DiagnosticSignError', { fg = '#fb4934', bg = '' }) -- Red
    vim.api.nvim_set_hl(0, 'DiagnosticSignWarn', { fg = '#fabd2f', bg = '' }) -- Yellow
    vim.api.nvim_set_hl(0, 'DiagnosticSignInfo', { fg = '#83a598', bg = '' }) -- Blue
    vim.api.nvim_set_hl(0, 'DiagnosticSignHint', { fg = '#8ec07c', bg = '' }) -- Aqua/Cyan

    -- LSP servers and clients are able to communicate to each other what features they support.
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    -- Add folding capabilities for nvim-ufo
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    -- Enable the following language servers
    local servers = {
      -- Lua
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            diagnostics = {
              globals = { 'vim' }, -- Recognize 'vim' global
            },
          },
        },
      },

      -- Python (using python-lsp-server with ruff)
      -- Requires: pip install python-lsp-server python-lsp-ruff ruff
      pylsp = {
        settings = {
          pylsp = {
            plugins = {
              -- Ruff handles linting and formatting (replaces pycodestyle, pyflakes, autopep8, yapf)
              ruff = {
                enabled = true,
                lineLength = 100,
                -- select = {}, -- Rules to enable (default: ruff defaults)
                -- ignore = {}, -- Rules to ignore
                -- extendSelect = { 'I' }, -- Add import sorting
                -- format = { 'I' }, -- Rules to apply during formatting
              },
              -- Disable linters that ruff replaces
              pycodestyle = { enabled = false },
              pyflakes = { enabled = false },
              mccabe = { enabled = false },
              autopep8 = { enabled = false },
              yapf = { enabled = false },
              -- Keep other useful plugins
              pylint = {
                enabled = false, -- Can be enabled if pylint is installed
              },
              black = {
                enabled = false, -- Disabled - ruff handles formatting
              },
              rope_autoimport = {
                enabled = true,
              },
            },
          },
        },
      },

      -- TypeScript/JavaScript
      ts_ls = {
        root_dir = require('lspconfig').util.root_pattern('package.json', 'tsconfig.json', 'jsconfig.json', '.git'),
        init_options = {
          preferences = {
            includePackageJsonAutoImports = 'on',
          },
        },
      },

      -- Go
      gopls = {
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
          },
        },
      },

      -- Rust
      rust_analyzer = {
        settings = {
          ['rust-analyzer'] = {
            checkOnSave = {
              command = 'clippy',
            },
          },
        },
      },

      -- Bash
      bashls = {},

      -- JSON
      jsonls = {},

      -- YAML
      yamlls = {},

      -- Terraform
      terraformls = {},
    }

    -- Ensure the servers and tools above are installed
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua', -- Used to format Lua code
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      ensure_installed = {},
      automatic_installation = false,
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }

    -- Manual LSP configurations for servers not in Mason
    -- DBML Language Server (install: cargo install dbml-language-server)
    local lspconfig = require 'lspconfig'
    local configs = require 'lspconfig.configs'

    if not configs.dbml_lsp then
      configs.dbml_lsp = {
        default_config = {
          cmd = { vim.fn.expand '~/.cargo/bin/dbml-language-server' },
          filetypes = { 'dbml' },
          root_dir = lspconfig.util.root_pattern('.git'),
          single_file_support = true,
        },
      }
    end

    lspconfig.dbml_lsp.setup {
      capabilities = capabilities,
    }
  end,
}
