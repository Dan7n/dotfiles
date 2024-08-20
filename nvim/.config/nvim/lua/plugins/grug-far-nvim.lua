return {
  -- AWESOME pluging to do find and replace with ripgrep
  "MagicDuck/grug-far.nvim",
  config = function()
    require("grug-far").setup {
      vim.keymap.set("n", "<leader>fr", ":GrugFar<CR>", { desc = "Find and replace (leader + fr)" }),
    }
  end,
}
