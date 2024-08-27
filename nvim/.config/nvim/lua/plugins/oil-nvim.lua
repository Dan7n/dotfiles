vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

return {
  "stevearc/oil.nvim",
  opts = {
    default_file_explorer = false,
    view_options = {
      show_hidden = true,
    },
  },
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
}
