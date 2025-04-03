return {

  -- Single tabpage interface for easily cycling through diffs for all modified files for any git rev.
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Open DiffView for git" },
      { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Close DiffView for git" },
      { "<leader>gD", "<cmd>DiffviewFileHistory<cr>", desc = "Diff Repo" },
      { "<leader>gF", "<cmd>DiffviewFileHistory %<cr>", desc = "Diff Current File" },
    },
  },

  {
    "NeogitOrg/neogit",
    optional = true,
    opts = {
      integrations = {
        diffview = true,
      },
    },
  },
}
