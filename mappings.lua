return {
  n = {
    ["<leader>T"] = { name = "Test" },
    ["<leader>Trr"] = { ':lua require("neotest").run.run()<CR>', desc = "Test" },
    ["<leader>Trf"] = { ':lua require("neotest").run.run(vim.fn.expand("%"))<CR>', desc = "Test file" },
    ["<leader>Trs"] = { ':lua require("neotest").run.stop()<CR>' },
    ["<leader>To"] = { ':lua require("neotest").output.open({ short = true, enter = true })<CR>' },
    ["<leader>Ts"] = { ':lua require("neotest").summary.toggle()<CR>' },
    ["<leader>Td"] = { ':lua require("neotest").diagnostic()<CR>' },
  },
  t = {},
}
