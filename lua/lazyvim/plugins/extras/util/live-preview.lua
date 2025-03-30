return {

  -- live-preview.nvim is a plugin for Neovim that allows
  -- you to view Markdown, HTML (along with CSS, JavaScript),
  -- AsciiDoc and SVG files in a web browser with live updates.
  -- No external dependencies or runtime like NodeJS or Python are required,

  {
    "brianhuster/live-preview.nvim",
    cmd = "LivePreview",
    opts = {
      port = 5500,
      browser = "default",
      dynamic_root = false,
      sync_scroll = false,
      picker = "",
    },
    keys = {
      { "<leader>lv", "<cmd>LivePreview start<cr>" },
      { "<leader>lx", "<cmd>LivePreview stop<cr>" },
    },
  },
}
