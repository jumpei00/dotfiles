return {
  {
    "AlexandrosAlexiou/kotlin.nvim",
    ft = { "kotlin" },
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      {
        "stevearc/oil.nvim",
        opts = {},
      },
      {
        "folke/trouble.nvim",
        opts = {},
      },
    },
    config = function()
      require("kotlin").setup({})
    end,
  },
}
