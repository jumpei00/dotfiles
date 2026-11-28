return {
  {
    "Julian/lean.nvim",
    event = { "BufReadPre *.lean", "BufNewFile *.lean" },
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    init = function()
      vim.g.lean_config = { mappings = true }
    end,
  },
}
