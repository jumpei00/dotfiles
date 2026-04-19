vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    local ok, conform = pcall(require, "conform")
    if ok then
      conform.format({ bufnr = args.buf, lsp_format = "fallback" })
    end
  end,
})
