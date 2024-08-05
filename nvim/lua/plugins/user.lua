-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:
--
local startScreens = {
  simple = {
    "                                                     ",
    "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    "                                                     ",
  },
  complex = {
    "              ,----------------,              ,---------,       ",
    "         ,-----------------------,          ,'        ,'|       ",
    "       ,'                      ,'|        ,'        ,'  |       ",
    "      +-----------------------+  |      ,'        ,'    |       ",
    "      |  .-----------------.  |  |     +---------+      |       ",
    "      |  |                 |  |  |     | -==----'|      |       ",
    "      |  |  DAN7N.NVIM     |  |  |     |         |      |       ",
    "      |  |                 |  |  |/----|`---=    |      |       ",
    "      |  |                 |  |  |   ,/|==== ooo |      ;       ",
    "      |  |                 |  |  |  // |(((( [33]|    ,'        ",
    "      |  `-----------------'  |,' .;'| |((((     |  ,'          ",
    "      +-----------------------+  ;;  | |         |,'            ",
    "         /_)______________(_/  //'   | +---------+              ",
    "    ___________________________/___  `,                         ",
    "   /  oooooooooooooooo  .o.  oooo /,   ,''-------------------  ",
    "  / ==ooooooooooooooo==.o.  ooo= //   ,` no mouse required ,'   ",
    " /_==__==========__==_ooo__ooo=_/'   /___________________,'     ",
    " `-----------------------------'                                ",
    "                                                                ",
  },
}

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = startScreens.complex
      return opts
    end,
  },

  -- You can disable default plugins as follows:
  -- { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip" (plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs" (plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
          -- don't add a pair if the next character is %
              :with_pair(cond.not_after_regex "%%")
          -- don't add a pair if  the previous character is xxx
              :with_pair(
                cond.not_before_regex("xxx", 3)
              )
          -- don't move right when repeat character
              :with_move(cond.none())
          -- don't delete if the next character is xx
              :with_del(cond.not_after_regex "xx")
          -- disable adding a newline when you press <cr>
              :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },

  -- override neo-tree setup to show hidden files
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            ".git",
            ".DS_Store",
          },
          never_show = {},
        },
      },
    },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      keywords = {
        fix = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        todo = { icon = " ", color = "info" },
        hack = { icon = " ", color = "warning" },
        warn = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        perf = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        note = { icon = " ", color = "hint", alt = { "INFO" } },
        test = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "tpope/vim-surround",
  },
  -- Plugin for generating code comments (JSDoc style)
  {
    "danymat/neogen",
    config = true,
    version = "*",
    vim.api.nvim_set_keymap(
      "n",
      "<Leader>nf",
      ":lua require('neogen').generate()<CR>",
      { noremap = true, silent = true, desc = "Generate a code comment by pressing Leader+nf" }
    ),
  },
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  {
    "marilari88/twoslash-queries.nvim",
    config = function()
      require("twoslash-queries").setup {
        multi_line = true,
        is_enabled = true,
        highlight = "Type",
      }
    end,
  },
}
