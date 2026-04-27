return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<leader>ld", desc = "Lazydocker" },
    },
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<c-\>]],
        direction = "horizontal",
        size = 15,
      })

      local Terminal = require("toggleterm.terminal").Terminal
      local lazydocker = Terminal:new({
        cmd = "lazydocker",
        hidden = true,
        direction = "float",
        float_opts = {
          border = "curved",
          width = function()
            return math.floor(vim.o.columns * 0.9)
          end,
          height = function()
            return math.floor(vim.o.lines * 0.9)
          end,
        },
      })

      vim.keymap.set("n", "<leader>ld", function()
        lazydocker:toggle()
      end, { desc = "Lazydocker" })
    end,
  },
}
