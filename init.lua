return {
  updater = {
    remote = "origin",
    channel = "nightly",
    version = "latest",
    branch = nil,
    commit = nil,
    pin_plugins = nil,
    skip_prompts = false,
    show_changelog = true,
    auto_quit = false,
  },
  colorscheme = "astrodark",
  diagnostics = {
    underline = true,
  },
  lsp = {
    servers = {},
    skip_setup = {},
    formatting = {
      format_on_save = {
        enabled = true,
        allow_filetypes = {
          "go",
          "rust",
          "lua",
        },
        ignore_filetypes = {},
      },
      disabled = {},
      timeout_ms = 1000,
    },
    mappings = {
      n = {
        -- ["<leader>lf"] = false -- disable formatting keymap
      },
    },
    config = {
      rust_analyzer = {
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              loadOutDirsFromCheck = true,
              features = "all",
            },
            checkOnSave = {
              command = "clippy",
            },
            procMacro = {
              enable = true,
            },
            experimental = {
              procAttrMacros = true,
            },
          },
        },
      },
      yamlls = {
        settings = {
          yaml = {
            schemas = {
              ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
              ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
              ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
            },
          },
        },
      },
      emmet_ls = {
        filetypes = {
          "html",
          "css",
          "javascript",
          "jsx",
          "typescript",
          "tsx",
          "eelixir",
          "heex",
        },
      },
    },
    setup_handlers = {
      rust_analyzer = function(_, opts) require("rust-tools").setup { server = opts } end,
    },
  },
  lazy = {
    defaults = { lazy = true },
    git = {
      timeout = 40,
    },
    performance = {
      rtp = {
        disabled_plugins = {
          "tohtml",
          "gzip",
          "matchit",
          "zipPlugin",
          "netrwPlugin",
          "tarPlugin",
          "matchparen",
        },
      },
    },
  },
}
