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
  -- Debug
  {
    "theHamsta/nvim-dap-virtual-text",
    config = function() require("nvim-dap-virtual-text").setup() end,
  },
}
