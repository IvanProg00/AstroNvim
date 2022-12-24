local config = {
  updater = {
    remote = "origin",
    channel = "nightly",
    version = "latest",
    branch = "nightly",
    commit = nil,
    pin_plugins = nil,
    skip_prompts = false,
    show_changelog = true,
    auto_reload = true,
    auto_quit = false,
  },
  colorscheme = "tokyonight-night",
  highlights = {
    ["tokyonight-night"] = function(highlights)
      local C = require "default_theme.colors"

      highlights.Normal = { fg = C.fg, bg = C.bg }
      return highlights
    end,
  },
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

  -- Default theme configuration
  default_theme = {
    -- Modify the color palette for the default theme
    colors = {
      fg = "#abb2bf",
      bg = "#1e222a",
    },
    highlights = function(hl) -- or a function that returns a new table of colors to set
      local C = require "default_theme.colors"

      hl.Normal = { fg = C.fg, bg = C.bg }

      -- New approach instead of diagnostic_style
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
      -- quick save
      -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
    },
    t = {
      -- setting a mapping to false will disable it
      -- ["<esc>"] = false,
    },
  },
  plugins = {
    init = {
      { "folke/tokyonight.nvim" },
      {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function() require("todo-comments").setup {} end,
      },
      {
        "ray-x/lsp_signature.nvim",
        event = "BufRead",
        config = function()
          require("lsp_signature").setup {
            max_height = 5,
          }
        end,
      },
      -- Editor
      { "ray-x/guihua.lua" },
      -- { "mfussenegger/nvim-dap" },

      -- Languages
      {
        "ray-x/go.nvim",
        config = function()
          require("go").setup {
            run_in_floaterm = true,
          }
        end,
      },
      {
        "simrat39/rust-tools.nvim",
        config = function()
          local rt = require "rust-tools"

          rt.setup {
            server = {
              on_attach = function(_, _) end,
            },
          }
        end,
      },
      ["hashivim/vim-terraform"] = {},

      { "akinsho/git-conflict.nvim", tag = "*", config = function() require("git-conflict").setup() end },
      ["RRethy/vim-illuminate"] = {
        opt = true,
        event = "BufReadPost",
        config = function()
          local illuminate = require "illuminate"

          illuminate.configure {
            providers = {
              "lsp",
              "treesitter",
              "regex",
            },
            delay = 30,
            filetypes_denylist = {
              "alpha",
              "dashboard",
              "DoomInfo",
              "fugitive",
              "help",
              "norg",
              "NvimTree",
              "Outline",
              "packer",
              "toggleterm",
            },
            under_cursor = false,
          }
          vim.api.nvim_set_hl(0, "IlluminatedWordText", { link = "Visual" })
          vim.api.nvim_set_hl(0, "IlluminatedWordRead", { link = "Visual" })
          vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "Visual" })
        end,
      },
      -- ["glepnir/lspsaga.nvim"] = {
      --   branch = "main",
      --   config = function()
      --     local saga = require "lspsaga"
      --
      --     saga.init_lsp_saga {}
      --   end,
      -- },
    },
    ["null-ls"] = function(config) -- overrides `require("null-ls").setup(config)`
      local null_ls = require "null-ls"
      local b = null_ls.builtins

      config.sources = {
        b.diagnostics.golangci_lint,

        b.formatting.goimports,
        b.formatting.stylua,
        b.formatting.prettier.with {
          filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "html",
            "css",
            "markdown",
          },
        },
        b.formatting.shfmt,
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
        "help",
        "vim",
        "markdown",
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
        "typescript-language-server",
        "shfmt",
        "markdownlint",
      },
    },
    ["mason-nvim-dap"] = {
      ensure_installed = { "delve" },
    },
    gitsigns = {
      current_line_blame = true,
      current_line_blame_opts = {
        ignore_whitespace = true,
        delay = 600,
      },
    },
    bufferline = {
      options = {
        show_close_icon = false,
        show_buffer_close_icons = false,
      },
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
  },
  luasnip = {
    filetype_extend = {
      javascript = { "javascriptreact" },
    },
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
  ["which-key"] = {
    register = {
      n = {
        ["<leader>"] = {
          ["b"] = { name = "Buffer" },
        },
      },
    },
  },
  polish = function()
    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
  end,
}

return config
