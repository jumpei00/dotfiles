return {
  {
    "tpope/vim-dadbod",
    cmd = { "DB" },
    dependencies = {
      {
        "kristijanhusak/vim-dadbod-ui",
        cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
        init = function()
          vim.g.db_ui_use_nerd_fonts = 1
          vim.g.db_ui_show_database_icon = 1
          vim.g.db_ui_win_position = "left"
          vim.g.db_ui_winwidth = 40
          vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"
        end,
      },
      {
        "kristijanhusak/vim-dadbod-completion",
        ft = { "sql", "mysql", "plsql" },
      },
    },
    keys = {
      { "<leader>du", "<cmd>DBUIToggle<cr>", desc = "DBUI toggle" },
      { "<leader>df", "<cmd>DBUIFindBuffer<cr>", desc = "DBUI find buffer" },
      { "<leader>da", "<cmd>DBUIAddConnection<cr>", desc = "DBUI add connection" },
    },
  },
}
