return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 32,
          side = "left",
        },
        git = {
          enable = true,
        },
        renderer = {
          group_empty = true,
          icons = {
            glyphs = {
              git = {
                unstaged  = "M",
                staged    = "A",
                unmerged  = "U",
                renamed   = "R",
                untracked = "?",
                deleted   = "D",
                ignored   = "I",
              },
            },
          },
        },
        update_focused_file = {
          enable = true,
          update_root = false,
        },
        filters = {
          dotfiles = false,
        },
      })
    end,
  },
}
