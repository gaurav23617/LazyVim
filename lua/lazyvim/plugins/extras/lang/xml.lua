return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = { "xml" },
      root = {
        "*.xml",
        ".project", -- common in Eclipse-based XML projects
        "pom.xml", -- common in Maven projects
      },
    })
  end,

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "xml",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lemminx = {},
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lemminx",
      },
    },
  },
}
