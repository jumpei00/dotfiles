return {
  {
    "rainbowhxch/accelerated-jk.nvim",
    -- Load at startup so the h/l mappings from acceleration_motions exist before the first press.
    event = "VeryLazy",
    keys = {
      { "j", "<Plug>(accelerated_jk_j)", desc = "Accelerated down" },
      { "k", "<Plug>(accelerated_jk_k)", desc = "Accelerated up" },
    },
    opts = {
      acceleration_motions = { "h", "l" },
      -- A single press moves 1 line; holding the key speeds up gradually.
      acceleration_table = { 4, 9, 16, 25, 36, 49 },
    },
  },
  {
    "DNLHC/glance.nvim",
    cmd = "Glance",
    keys = {
      { "gpd", "<cmd>Glance definitions<cr>", desc = "Glance definitions" },
      { "gpr", "<cmd>Glance references<cr>", desc = "Glance references" },
      { "gpy", "<cmd>Glance type_definitions<cr>", desc = "Glance type definitions" },
      { "gpi", "<cmd>Glance implementations<cr>", desc = "Glance implementations" },
    },
    opts = {},
  },
}
