if lazyvim_docs then
  -- LSP Server to use for PHP.
  -- Set to "intelephense" to use intelephense instead of phpactor.
  vim.g.lazyvim_php_lsp = "intelephense"
end

local lsp = vim.g.lazyvim_php_lsp or "phpactor"

return {

  -- Recommended trigger for LazyVim extras
  recommended = {
    ft = { "php", "blade" },
    root = { "composer.json", ".phpactor.json", ".phpactor.yml" },
  },

  { import = "lazyvim.plugins.extras.lang.php" },

  -- Blade syntax highlighting & navigation
  { "EmranMR/tree-sitter-blade", ft = "blade" },

  {
    "ricardoramirezr/blade-nav.nvim",
    ft = { "blade", "blade.php" },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "php",
        "php_only",
        "phpdoc",
        "sql",
        "blade",
      })

      opts.highlight = opts.highlight or {}
      opts.highlight.additional_vim_regex_highlighting = false

      opts.incremental_selection = opts.incremental_selection
        or {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        }

      opts.inject = { enable = true }

      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.blade = {
        install_info = {
          url = "https://github.com/EmranMR/tree-sitter-blade",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "blade",
      }

      local highlight_query = [[
        ((directive) @keyword)
        ((directive_start) @keyword)
        ((directive_end) @keyword)
        ((bracket_start) @punctuation.bracket)
        ((bracket_end) @punctuation.bracket)
        ((comment) @comment @spell)
      ]]

      local ok_query, ts_query = pcall(require, "vim.treesitter.query")
      if ok_query and ts_query.set then
        ts_query.set("blade", "highlights", highlight_query)
      elseif vim.treesitter.query.set then
        vim.treesitter.query.set("blade", "highlights", highlight_query)
      end

      return opts
    end,
  },

  -- Blade filetype detection
  {
    "nvim-lua/plenary.nvim",
    lazy = false,
    config = function()
      vim.api.nvim_create_augroup("BladeFiltypeRelated", { clear = true })
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = "*.blade.php",
        command = "set filetype=blade",
        group = "BladeFiltypeRelated",
      })
    end,
  },

  -- PHP LSP config
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        phpactor = {
          enabled = lsp == "phpactor",
        },
        intelephense = {
          enabled = lsp == "intelephense",
        },
        [lsp] = {
          enabled = true,
        },
      },
    },
  },

  -- Tools to install via Mason
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "phpcs",
        "php-cs-fixer",
      },
    },
  },

  -- Optional PHP Unit Testing
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "olimorris/neotest-phpunit",
    },
    opts = {
      adapters = {
        ["neotest-phpunit"] = {},
      },
    },
  },

  -- Optional PHP Debugger
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      local dap = require("dap")
      local path = require("mason-registry").get_package("php-debug-adapter"):get_install_path()
      dap.adapters.php = {
        type = "executable",
        command = "node",
        args = { path .. "/extension/out/phpDebug.js" },
      }
    end,
  },

  -- Optional: PHP linters & formatters via null-ls
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = opts.sources or {}
      table.insert(opts.sources, nls.builtins.formatting.phpcsfixer)
      table.insert(opts.sources, nls.builtins.diagnostics.phpcs)
    end,
  },

  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        php = { "phpcs" },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        php = { "php_cs_fixer" },
      },
    },
  },
  {
    "adalessa/laravel.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "tpope/vim-dotenv",
      "MunifTanjim/nui.nvim",
      "nvimtools/none-ls.nvim",
    },
    cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
    keys = {
      { "<leader>la", ":Laravel artisan<cr>" },
      { "<leader>lr", ":Laravel routes<cr>" },
      { "<leader>lm", ":Laravel related<cr>" },
    },
    lazy = true,
    config = true,
  },
}
