return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    enabled = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require "harpoon"
      harpoon:setup {}

      -- Set up harpoon with telescope as the UI
      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require("telescope.pickers")
          .new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table {
              results = file_paths,
            },
            previewer = conf.file_previewer {},
            sorter = conf.generic_sorter {},
          })
          :find()
      end

      -- Open the telescope window by pressing Ctrl + e
      vim.keymap.set("n", "<C-p>", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window" })

      -- Add current file to harpoon by pressing leader + ha (Harpoon Add)
      vim.keymap.set(
        "n",
        "<leader>ha",
        function() harpoon:list():add() end,
        { desc = "Add current file to harpoon by pressing leader + ha (Harpoon Add)" }
      )

      -- Remove current file from harpoon by pressing leader + hr (Harpoon Remove)
      vim.keymap.set(
        "n",
        "<leader>hr",
        function() harpoon:list():remove() end,
        { desc = "Remove current file from harpoon by pressing leader + hr (Harpoon Remove)" }
      )
    end,
  },
}
