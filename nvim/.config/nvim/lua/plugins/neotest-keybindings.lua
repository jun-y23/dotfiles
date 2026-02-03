---@type LazySpec
return {
  "AstroNvim/astrocore",
  opts = function(_, opts)
    if not opts.mappings then opts.mappings = {} end
    if not opts.mappings.n then opts.mappings.n = {} end
    local maps = opts.mappings
    local prefix = "<Leader>n"

    maps.n[prefix] = { desc = " Neotest" }
    maps.n[prefix .. "f"] = {
      function() require("neotest").run.run(vim.fn.expand("%")) end,
      desc = "Run file tests",
    }
    maps.n[prefix .. "n"] = {
      function() require("neotest").run.run() end,
      desc = "Run nearest test",
    }
    maps.n[prefix .. "t"] = {
      function() require("neotest").summary.toggle() end,
      desc = "Toggle test summary",
    }
    maps.n[prefix .. "w"] = {
      function()
        require("neotest").run.run({
          jestCommand = require("neotest-jest.jest-util").getJestCommand(vim.fn.expand("%:p:h")) .. " --watch",
        })
      end,
      desc = "Run nearest test (watch)",
    }
    maps.n[prefix .. "W"] = {
      function() require("neotest").watch.toggle(vim.fn.expand("%")) end,
      desc = "Toggle watch file",
    }
    maps.n[prefix .. "o"] = {
      function() require("neotest").output.open({ enter = true, auto_close = true }) end,
      desc = "Show test output",
    }
    maps.n[prefix .. "O"] = {
      function() require("neotest").output_panel.toggle() end,
      desc = "Toggle output panel",
    }
    maps.n[prefix .. "d"] = {
      function() require("neotest").run.run({ strategy = "dap" }) end,
      desc = "Debug nearest test",
    }
    maps.n[prefix .. "s"] = {
      function() require("neotest").run.stop() end,
      desc = "Stop test",
    }
    maps.n[prefix .. "a"] = {
      function() require("neotest").run.run(vim.fn.getcwd()) end,
      desc = "Run all tests",
    }
    maps.n["]n"] = {
      function() require("neotest").jump.next({ status = "failed" }) end,
      desc = "Next failed test",
    }
    maps.n["[n"] = {
      function() require("neotest").jump.prev({ status = "failed" }) end,
      desc = "Previous failed test",
    }
  end,
}
