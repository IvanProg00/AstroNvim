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
        "terraform",
        "sql",
        "http",
        "solidity",
      },
    },
  },
  -- Editor
  { "ray-x/guihua.lua" },
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {},
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
    ft = "python",
  },
  -- Git
  { "akinsho/git-conflict.nvim", config = true },
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
    "theHamsta/nvim-dap-virtual-text",
    config = function() require("nvim-dap-virtual-text").setup {} end,
  },
  {
    "leoluz/nvim-dap-go",
    config = function() require("dap-go").setup() end,
    ft = "go",
  },
}
