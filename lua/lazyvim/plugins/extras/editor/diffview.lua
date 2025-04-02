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

      -- File Panel Specific Keymaps
      { "n", "s", actions.toggle_stage_entry, { desc = "Stage / unstage the selected entry" } },
      { "n", "S", actions.stage_all, { desc = "Stage all entries" } },
      { "n", "U", actions.unstage_all, { desc = "Unstage all entries" } },
      { "n", "X", actions.restore_entry, { desc = "Restore entry to the state on the left side" } },
      { "n", "L", actions.open_commit_log, { desc = "Open the commit log panel" } },
    },
    config = function()
      require("diffview").setup({
        diff_binaries = false,
        enhanced_diff_hl = false,
        git_cmd = { "git" },
        hg_cmd = { "hg" },
        use_icons = true,
        show_help_hints = true,
        watch_index = true,
        view = {
          win_config = {
            position = "left",
            width = 30,
          },
        },
      })
    end,
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
