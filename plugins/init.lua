return {
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
  ["hashivim/vim-terraform"] = {},
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
    after = "mason-lspconfig.nvim",
    config = function()
      require("rust-tools").setup {
        server = astronvim.lsp.server_settings "rust_analyzer",
      }
    end,
  },
  {
    "saecki/crates.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function() require("crates").setup() end,
  },
  -- Git
  { "akinsho/git-conflict.nvim", tag = "*", config = function() require("git-conflict").setup() end },
  -- Test
  {
    "nvim-neotest/neotest",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-go",
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
    config = function() require("nvim-dap-virtual-text").setup() end,
  },
}
