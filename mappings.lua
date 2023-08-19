local crates = require "crates"
local neotest = require "neotest"

return {
  n = {
    ["<Leader>T"] = { name = "Test" },
    ["<Leader>Trr"] = { function() neotest.run.run() end, desc = "Test" },
    ["<Leader>Trf"] = { function() neotest.run.run(vim.fn.expand "%") end, desc = "Test file" },
    ["<Leader>Trs"] = { function() neotest.run.stop() end, desc = "Stop test" },
    ["<Leader>To"] = {
      function() neotest.output.open { short = true, enter = true } end,
      desc = "Show test result",
    },
    ["<Leader>Ts"] = { function() neotest.summary.toggle() end, desc = "Summary" },
    ["<Leader>Td"] = { function() neotest.diagnostic() end, desc = "Diagnostic" },

    ["<Leader>fT"] = { ":TodoTelescope keywords=TODO,FIX<CR>", desc = "Todo list" },

    ["<Leader>r"] = { name = "Rust" },
    ["<Leader>rf"] = { function() crates.show_features_popup() end, desc = "Show features" },
    ["<Leader>rr"] = { function() crates.reload() end, desc = "Reload" },
  },
  t = {},
}
