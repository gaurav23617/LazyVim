return {
  {
    "Dan7h3x/LazyDo",
    branch = "main",
    cmd = { "LazyDoToggle", "LazyDoPin", "LazyDoToggleStorage" },
    keys = {
      {
        "<F2>",
        "<ESC><CMD>LazyDoToggle<CR>",
        mode = { "n", "i" },
        desc = "Toggle LazyDo",
      },
      {
        "<leader>lp",
        "<ESC><CMD>LazyDoToggleStorage mode project<CR>",
        mode = { "n", "i" },
        desc = "Change LazyDo to project storage",
      },
      {
        "<leader>li",
        "<ESC><CMD>LazyDoPin position bottomright<CR>",
        mode = { "n", "i" },
        desc = "Pin LazyDo task to bottom right",
      },
    },
    event = "VeryLazy",
    opts = {
      -- your config here
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        function()
          return require("lazydo").get_lualine_stats() -- status
        end,
        cond = function()
          return require("lazydo")._initialized -- condition for lualine
        end,
      })
    end,
  },
}
