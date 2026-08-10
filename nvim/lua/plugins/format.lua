return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        go = { "gofmt", "goimports" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        zig = { "zigfmt" },
        python = { "ruff_format" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        dockerfile = { "dockerfmt" },
        sql = { "sql_formatter" },
        terraform = { "terraform_fmt" },
      },
    },
  },
}
