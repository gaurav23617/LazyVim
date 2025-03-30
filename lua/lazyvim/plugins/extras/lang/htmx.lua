return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = {
        "html",
        "htmldjango", -- if using Django templates
        "templ", -- Go HTML templates
        "twig", -- Laravel/PHP templates
      },
      root = {
        "*.html",
        "*.htmx.html",
        "*.htm",
        "*.templ",
        "*.twig",
      },
    })
  end,

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        htmx = {},
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "htmx-lsp",
      },
    },
  },

  -- Optional: Add Emmet for quick HTML editing
  {
    "mattn/emmet-vim",
    ft = {
      "html",
      "htmldjango",
      "templ",
      "twig",
    },
  },
}
