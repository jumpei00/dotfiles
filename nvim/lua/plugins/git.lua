return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewToggleFiles" },
  },
  {
    "isakbm/gitgraph.nvim",
    dependencies = { "sindrets/diffview.nvim" },
    keys = {
      {
        "<leader>gg",
        function()
          require("gitgraph").draw({}, { all = true, max_count = 5000 })
        end,
        desc = "Git graph",
      },
    },
    config = function()
      vim.api.nvim_create_user_command("GitGraph", function()
        require("gitgraph").draw({}, { all = true, max_count = 5000 })
      end, {})
      require("gitgraph").setup({
        symbols = {
          merge_commit = "M",
          commit = "*",
          merge_commit_end = "M",
          commit_end = "*",
          GVER = "│",
          GHOR = "─",
          GCLD = "╮",
          GCRD = "╭",
          GCLU = "╯",
          GCRU = "╰",
          GLRU = "┴",
          GLRD = "┬",
          GLUD = "┤",
          GRUD = "├",
          GFORKU = "┼",
          GFORKD = "┼",
          GRUDCD = "├",
          GRUDCU = "├",
          GLUDCD = "┤",
          GLUDCU = "┤",
          GLRDCL = "┬",
          GLRDCR = "┬",
          GLRUCL = "┴",
          GLRUCR = "┴",
        },
        format = {
          timestamp = "%Y-%m-%d %H:%M",
          fields = { "hash", "timestamp", "author", "branch_name", "tag" },
        },
        hooks = {
          on_select_commit = function(commit)
            vim.notify("DiffviewOpen " .. commit.hash .. "^!")
            vim.cmd(":DiffviewOpen " .. commit.hash .. "^!")
          end,
          on_select_range_commit = function(from, to)
            vim.notify("DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
            vim.cmd(":DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
          end,
        },
      })
    end,
  },
}
