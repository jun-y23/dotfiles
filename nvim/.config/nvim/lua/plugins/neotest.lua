---@type LazySpec
return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "haydenmeade/neotest-jest",
      "marilari88/neotest-vitest",
      "nvim-neotest/neotest-go",
    },
    config = function(_, opts)
      local adapters = {}

      -- Golang adapter (neotest-go with coverage output)
      local avail_go, neotest_go = pcall(require, "neotest-go")
      if avail_go then
        table.insert(adapters, neotest_go({
          args = { "-coverprofile=coverage.out" },
        }))
      end

      -- Jest adapter
      local avail_jest, jest = pcall(require, "neotest-jest")
      if avail_jest then
        table.insert(
          adapters,
          jest {
            jestCommand = "yarn test --",
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

      -- Vitest adapter
      local avail_vitest, vitest = pcall(require, "neotest-vitest")
      if avail_vitest then table.insert(adapters, vitest {}) end

      -- Merge with existing opts if any
      opts = opts or {}
      opts.adapters = adapters

      require("neotest").setup(opts)
    end,
  },
}
