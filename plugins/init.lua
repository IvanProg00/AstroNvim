return {
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      opts.section.header.val = {
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
      }
      return opts
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, config)
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
        b.formatting.csharpier,
        b.formatting.taplo,
      }

      return config
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
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
        "c_sharp",
        "html",
        "css",
        "help",
        "vim",
        "markdown",
        "fish",
        "bash",
        "dockerfile",
        "sql",
        "http",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
      },
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = {
      automatic_installation = true,
      automatic_setup = true,
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
        "csharpier",
        "terraform-ls",
        "dockerfile-language-server",
        "gopls",
        "gofumpt",
        "goimports",
        "typescript-language-server",
        "shfmt",
        "markdownlint",
        "taplo",
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      ensure_installed = { "delve" },
    },
  },
  --- Editor
  { "ray-x/guihua.lua" },
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
  "hashivim/vim-terraform",
  -- Languages
  {
    "ray-x/go.nvim",
    requires = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup {
        run_in_floaterm = true,
        lsp_inlay_hints = {
          enable = false,
          only_current_line = false,
          only_current_line_autocmd = "CursorMoved",
        },
      }
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
  },
  "simrat39/rust-tools.nvim",
  {
    "saecki/crates.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function() require("crates").setup() end,
  },
  -- Git
  { "akinsho/git-conflict.nvim", config = function() require("git-conflict").setup {} end },
  -- Test
  {
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-go",
      "rouge8/neotest-rust",
    },
    config = function()
      local neotest_ns = vim.api.nvim_create_namespace "neotest"
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, neotest_ns)
      require("neotest").setup {
        adapters = {
          require "neotest-go" {
            experimental = {
              test_table = true,
            },
            args = { "-v", "-count=1", "-timeout=60s" },
          },
          require "neotest-rust",
        },
      }
    end,
  },
  -- Debug
  {
    "theHamsta/nvim-dap-virtual-text",
    config = function() require("nvim-dap-virtual-text").setup {} end,
  },
  {
    "leoluz/nvim-dap-go",
    config = function() require("dap-go").setup() end,
  },
}
