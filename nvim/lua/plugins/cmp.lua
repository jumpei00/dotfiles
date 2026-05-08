return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-n>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_next_item()
            else
              vim.api.nvim_feedkeys(vim.keycode("<Down>"), "n", false)
            end
          end, { "i", "s" }),
          ["<C-p>"] = cmp.mapping(function()
            if cmp.visible() then
              cmp.select_prev_item()
            else
              vim.api.nvim_feedkeys(vim.keycode("<Up>"), "n", false)
            end
          end, { "i", "s" }),
          ["<C-a>"] = cmp.mapping(function()
            vim.api.nvim_feedkeys(vim.keycode("<Home>"), "n", false)
          end, { "i", "s" }),
          ["<C-e>"] = cmp.mapping(function()
            vim.api.nvim_feedkeys(vim.keycode("<End>"), "n", false)
          end, { "i", "s" }),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = {
          { name = "nvim_lsp" },
        },
      })

      cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
        sources = {
          { name = "vim-dadbod-completion" },
          { name = "nvim_lsp" },
        },
      })
    end,
  },
}
