return {
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
        b.diagnostics.credo,

        b.formatting.mix.with {
          filetypes = {
            "elixir",
            "ex",
            "exs",
            "heex",
          },
        },
        b.formatting.stylua,
        b.formatting.prettierd,
        b.formatting.goimports,
        b.formatting.shfmt,
        b.formatting.gofumpt,
        b.formatting.csharpier,
        b.formatting.taplo,
        b.formatting.djlint,
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
        "vim",
        "markdown",
        "fish",
        "bash",
        "dockerfile",
        "sql",
        "http",
        "elixir",
        "heex",
        "eex",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "pyright",
        "ruff_lsp",
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
        "black",
        "isort",
        "eslint-lsp",
        "gitlint",
        "prettierd",
        "lua-language-server",
        "css-lsp",
        "html-lsp",
        "typescript-language-server",
        "emmet-ls",
        "json-lsp",
        "stylua",
        "yaml-language-server",
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
        "elixir-ls",
        "djlint",
      },
    },
  },
  -- Editor
  { "ray-x/guihua.lua" },
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function() require("todo-comments").setup {} end,
    event = "VeryLazy",
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
  -- Languages
  {
    "ray-x/go.nvim",
    dependencies = {
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
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "linux-cultist/venv-selector.nvim",
    opts = {},
    keys = { { "<leader>lv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" } },
  },
  -- Git
  { "akinsho/git-conflict.nvim", config = function() require("git-conflict").setup {} end },
  -- Test
  {
    "nvim-neotest/neotest",
    dependencies = {
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
    ft = { "go", "rust" },
  },
  -- Debug
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      ensure_installed = { "delve", "python" },
    },
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    config = function() require("nvim-dap-virtual-text").setup {} end,
  },
  {
    "leoluz/nvim-dap-go",
    config = function() require("dap-go").setup() end,
    ft = "go",
  },
}
