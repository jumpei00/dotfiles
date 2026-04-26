return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      options = {
        theme = "tokyonight",
        globalstatus = true,
      },
    },
  },
  {
    "romgrk/barbar.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {},
    keys = {
      { "[b", "<cmd>BufferPrevious<cr>", desc = "Previous buffer" },
      { "]b", "<cmd>BufferNext<cr>", desc = "Next buffer" },
      { "<leader>bd", "<cmd>BufferClose<cr>", desc = "Close buffer" },
      { "<leader>bp", "<cmd>BufferPin<cr>", desc = "Pin buffer" },
    },
  },
}
