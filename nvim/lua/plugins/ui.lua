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
  {
    "Bekaboo/dropbar.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>;", function() require("dropbar.api").pick() end, desc = "Pick symbols in winbar" },
      { "[;", function() require("dropbar.api").goto_context_start() end, desc = "Go to start of current context" },
      { "];", function() require("dropbar.api").select_next_context() end, desc = "Select next context" },
    },
  },
  {
    "petertriho/nvim-scrollbar",
    lazy = false,
    dependencies = {
      "lewis6991/gitsigns.nvim",
    },
    opts = {
      exclude = {
        filetypes = {
          NvimTree = true,
        },
      },
      providers = {
        gitsigns = true,
      },
      scrollbar = {
        preset = "vscode",
      },
      minimap = {
        enabled = true,
        preset = "vscode",
      },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      scope = { enabled = true },
    },
  },
}
