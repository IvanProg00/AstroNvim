local config = {
  updater = {
    remote = "origin",
    channel = "stable",
    version = "latest",
    branch = "main",
    commit = nil,
    pin_plugins = nil,
    skip_prompts = false,
    show_changelog = true,
    auto_reload = false,
    auto_quit = false,
  },
  colorscheme = "default_theme",
  highlights = {},
  header = {
    " █████  ███████ ████████ ██████   ██████",
    "██   ██ ██         ██    ██   ██ ██    ██",
    "███████ ███████    ██    ██████  ██    ██",
    "██   ██      ██    ██    ██   ██ ██    ██",
    "██   ██ ███████    ██    ██   ██  ██████",
    " ",
    "    ███    ██ ██    ██ ██ ███    ███",
    "    ████   ██ ██    ██ ██ ████  ████",
    "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
    "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
    "    ██   ████   ████   ██ ██      ██",
  },
  default_theme = {
    colors = {
      fg = "#abb2bf",
      bg = "#1e222a",
    },
    highlights = function(hl)
      local C = require "default_theme.colors"

      hl.Normal = { fg = C.fg, bg = C.bg }

      hl.DiagnosticError.italic = true
      hl.DiagnosticHint.italic = true
      hl.DiagnosticInfo.italic = true
      hl.DiagnosticWarn.italic = true

      return hl
    end,
    plugins = {
      aerial = true,
      beacon = false,
      bufferline = true,
      cmp = true,
      dashboard = true,
      highlighturl = true,
      hop = false,
      indent_blankline = true,
      lightspeed = false,
      ["neo-tree"] = true,
      notify = true,
      ["nvim-tree"] = false,
      ["nvim-web-devicons"] = true,
      rainbow = true,
      symbols_outline = false,
      telescope = true,
      treesitter = true,
      vimwiki = false,
      ["which-key"] = true,
    },
  },
  diagnostics = {
    virtual_text = true,
    underline = true,
  },
  lsp = {
    servers = {},
    skip_setup = {
      "rust_analyzer",
    },
    formatting = {
      format_on_save = {
        enabled = true, -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
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
    ["server-settings"] = {
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
  },
  mappings = {
    n = {
      ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
      ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
      ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
      ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
    },
    t = {},
  },
  plugins = {
    ["null-ls"] = function(config)
      local null_ls = require "null-ls"
      local b = null_ls.builtins

      require("crates").setup {
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
      }

      config.sources = {
        b.diagnostics.golangci_lint,
        b.diagnostics.markdownlint,

        b.formatting.stylua,
        b.formatting.prettier,
        b.formatting.goimports,
        b.formatting.shfmt,
        b.formatting.gofumpt,
      }

      return config
    end,
    treesitter = {
      ensure_installed = {
        "lua",
        "go",
        "gomod",
        "gowork",
        "rust",
        "json",
        "yaml",
        "toml",
        "javascript",
        "python",
        "html",
        "css",
        "help",
        "vim",
        "markdown",
        "fish",
        "bash",
        "dockerfile",
      },
    },
    ["mason-lspconfig"] = {
      ensure_installed = {
        "sumneko_lua",
        "rust_analyzer",
      },
    },
    ["mason-null-ls"] = {
      ensure_installed = {
        "actionlint",
        "autopep8",
        "eslint-lsp",
        "gitlint",
        "prettier",
        "lua-language-server",
        "css-lsp",
        "html-lsp",
        "typescript-language-server",
        "emmet-ls",
        "json-lsp",
        "stylua",
        "yaml-language-server",
        "pylint",
        "golangci-lint-langserver",
        "terraform-ls",
        "dockerfile-language-server",
        "gopls",
        "gofumpt",
        "goimports",
        "typescript-language-server",
        "shfmt",
        "markdownlint",
      },
    },
    ["mason-nvim-dap"] = {
      ensure_installed = { "delve" },
    },
    ["neo-tree"] = {
      enable_git_status = true,
      enable_diagnostics = true,
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
    },
    gitsigns = {
      current_line_blame = true,
      current_line_blame_opts = {
        ignore_whitespace = true,
        delay = 600,
      },
    },
  },
  luasnip = {
    filetype_extend = {},
    vscode = {
      paths = {},
    },
  },
  cmp = {
    source_priority = {
      nvim_lsp = 1000,
      luasnip = 750,
      buffer = 500,
      path = 250,
    },
  },
  heirline = {
    -- separators = {
    --   tab = { "", "" },
    -- },
    -- -- -- Customize colors for each element each element has a `_fg` and a `_bg`
    -- colors = function(colors)
    --   colors.git_branch_fg = astronvim.get_hlgroup "Conditional"
    --   return colors
    -- end,
    -- attributes = {
    --   -- styling choices for each heirline element, check possible attributes with `:h attr-list`
    --   git_branch = { bold = true }, -- bold the git branch statusline component
    -- },
    -- icon_highlights = {
    --   breadcrumbs = false, -- LSP symbols in the breadcrumbs
    --   file_icon = {
    --     winbar = false, -- Filetype icon in the winbar inactive windows
    --     statusline = true, -- Filetype icon in the statusline
    --   },
    -- },
  },
  ["which-key"] = {
    register = {
      n = {
        ["<leader>"] = {
          ["b"] = { name = "Buffer" },
        },
      },
    },
  },
  polish = function() end,
}

return config
