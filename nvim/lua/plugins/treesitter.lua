return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    opts = {
      install_dir = vim.fn.stdpath("data") .. "/site",
    },
    config = function(_, opts)
      require("nvim-treesitter").setup(opts)
      require("nvim-treesitter").install({
        "go",
        "java",
        "javascript",
        "kotlin",
        "lua",
        "python",
        "query",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
      })
    end,
  },
}
