return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    setup = function()
      require("neotest").setup {
        adapters = {
          require "nvim-neotest/neotest-jest" {
            dap = { justMyCode = true },
          },
        },
      }
    end,
  },
}
