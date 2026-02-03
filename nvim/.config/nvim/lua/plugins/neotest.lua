---@type LazySpec
return {
  {
    "fredrikaverpil/neotest-golang",
    dependencies = { "nvim-neotest/neotest" },
  },
  {
    "marilari88/neotest-vitest",
    dependencies = { "nvim-neotest/neotest" },
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    opts = function(_, opts)
      if not opts.adapters then opts.adapters = {} end

      -- Jest adapter
      local avail, jest = pcall(require, "neotest-jest")
      if avail then
        table.insert(
          opts.adapters,
          jest {
            jestCommand = "npm test --",
            jestConfigFile = function(file)
              if string.find(file, "/packages/") then
                return string.match(file, "(.-/[^/]+/)src") .. "jest.config.ts"
              end
              return vim.fn.getcwd() .. "/jest.config.ts"
            end,
            env = { CI = true },
            cwd = function(file)
              if string.find(file, "/packages/") then return string.match(file, "(.-/[^/]+/)src") end
              return vim.fn.getcwd()
            end,
          }
        )
      end

      -- Golang adapter
      local avail_go, golang = pcall(require, "neotest-golang")
      if avail_go then table.insert(opts.adapters, golang()) end

      -- Vitest adapter
      local avail_vitest, vitest = pcall(require, "neotest-vitest")
      if avail_vitest then table.insert(opts.adapters, vitest {}) end
    end,
  },
}
