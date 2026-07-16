local servers = {
  "gopls",
  "ts_ls",
  "lua_ls",
  "jsonls",
  "yamlls",
  "dockerls",
  "zls",
  "pyright",
  "ruby_lsp",
  "jdtls",
  "kotlin_lsp",
  "terraformls",
}

return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = servers,
      automatic_enable = servers,
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })

      vim.lsp.config("kotlin_lsp", {
        cmd = { "intellij-server", "--stdio" },
      })

      vim.diagnostic.config({
        virtual_lines = { current_line = true },
        severity_sort = true,
        float = { border = "rounded", source = true },
      })
    end,
  },
}
