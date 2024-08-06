return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      -- "ibhagwan/fzf-lua", -- optional
    },
    vim.keymap.set("n", "<leader>gt", ":Neogit<CR>", { desc = "Start Neogit (leader GiT)" }),
    config = true,
  },
  {
    "tpope/vim-fugitive",
    vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { desc = "Git blame for current file (leader + Git Blame)" }),
    vim.keymap.set("n", "<leader>gs", ":Git status<CR>", { desc = "Git status" }),
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function() require("gitsigns").setup() end,

    vim.keymap.set(
      "n",
      "<leader>gp",
      ":Gitsigns preview_hunk<CR>",
      { desc = "Preview hunk for current line (leader + Git Preview)" }
    ),
  },
}
