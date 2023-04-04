local config = {
  updater = {
    remote = "origin",
    channel = "stable",
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
  heirline = {
    -- -- Customize different separators between sections
    -- separators = {
    --   breadcrumbs = " > ",
    --   tab = { "", "" },
    -- },
    -- -- Customize colors for each element each element has a `_fg` and a `_bg`
    -- colors = function(colors)
    --   colors.git_branch_fg = require("astronvim.utils").get_hlgroup "Conditional"
    --   return colors
    -- end,
    -- -- Customize attributes of highlighting in Heirline components
    -- attributes = {
    --   -- styling choices for each heirline element, check possible attributes with `:h attr-list`
    --   git_branch = { bold = true }, -- bold the git branch statusline component
    -- },
    -- -- Customize if icons should be highlighted
    -- icon_highlights = {
    --   breadcrumbs = false, -- LSP symbols in the breadcrumbs
    --   file_icon = {
    --     winbar = false, -- Filetype icon in the winbar inactive windows
    --     statusline = true, -- Filetype icon in the statusline
    --     tabline = true, -- Filetype icon in the tabline
    --   },
    -- },
  },
  polish = function()
  end,
}

return config
