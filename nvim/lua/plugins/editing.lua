return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      max_lines = 3,
    },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)

      local ok_cmp, cmp = pcall(require, "cmp")
      local ok_autopairs, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
      if ok_cmp and ok_autopairs then
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end
    end,
  },
}
