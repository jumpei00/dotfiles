vim.g.mapleader = " "
local map = vim.keymap.set

map("n", "<leader>w", "<cmd>w<cr>")
map("n", "<leader>q", "<cmd>q<cr>")
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file tree" })
map("n", "<Esc>", "<cmd>nohlsearch<cr>")
map("n", "H", "^", { desc = "Go to first non-blank character" })
map("n", "L", "$", { desc = "Go to end of line" })

-- Insert mode cursor movement, matching common macOS text controls.
map("i", "<C-f>", "<Right>", { desc = "Move right" })
map("i", "<C-b>", "<Left>", { desc = "Move left" })
map("i", "<C-p>", "<Up>", { desc = "Move up" })
map("i", "<C-n>", "<Down>", { desc = "Move down" })
map("i", "<C-a>", "<Home>", { desc = "Move to start of line" })
map("i", "<C-e>", "<End>", { desc = "Move to end of line" })

-- Exit terminal mode without conflicting with toggleterm's <C-\> mapping.
map("t", "<Esc><Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode", nowait = true })

-- ウィンドウ移動
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- LSP definition jump (overrides default vim `gd`)
map("n", "gd", vim.lsp.buf.definition, { desc = "LSP goto definition" })

-- Diagnostic navigation and details
map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Next diagnostic" })
map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Previous diagnostic" })
map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic" })

-- GitHub PR review helpers (gh cli + diffview, no checkout)
local current_pr = nil

local function pr_pick_and_diff(list_cmd, prompt)
  local lines = vim.fn.systemlist(list_cmd)
  if vim.v.shell_error ~= 0 then
    vim.notify("gh pr list failed:\n" .. table.concat(lines, "\n"), vim.log.levels.ERROR)
    return
  end
  if #lines == 0 then
    vim.notify("No PRs found", vim.log.levels.WARN)
    return
  end
  vim.ui.select(lines, { prompt = prompt }, function(choice)
    if not choice then return end
    local num = choice:match("^(%d+)")
    if not num then
      vim.notify("Could not parse PR number", vim.log.levels.ERROR)
      return
    end
    local meta = vim.fn.trim(vim.fn.system(
      "gh pr view " .. num .. [[ --json headRefName,baseRefName -q '.headRefName + "\t" + .baseRefName']]
    ))
    if vim.v.shell_error ~= 0 then
      vim.notify("gh pr view failed:\n" .. meta, vim.log.levels.ERROR)
      return
    end
    local head, base = meta:match("^([^\t]+)\t(.+)$")
    if not head or not base then
      vim.notify("Could not parse branches: " .. meta, vim.log.levels.ERROR)
      return
    end
    local fetch_out = vim.fn.system("git fetch origin " .. head .. " " .. base)
    if vim.v.shell_error ~= 0 then
      vim.notify("git fetch failed:\n" .. fetch_out, vim.log.levels.ERROR)
      return
    end
    current_pr = num
    vim.cmd("DiffviewOpen origin/" .. base .. "...origin/" .. head)
  end)
end

local function pr_open_web()
  if current_pr then
    vim.fn.jobstart({ "gh", "pr", "view", current_pr, "--web" }, { detach = true })
    return
  end
  vim.ui.input({ prompt = "PR number: " }, function(num)
    if not num or num == "" then return end
    vim.fn.jobstart({ "gh", "pr", "view", num, "--web" }, { detach = true })
  end)
end

map("n", "<leader>gp", function()
  pr_pick_and_diff("gh pr list --limit 30", "Select PR to review:")
end, { desc = "PR: pick and show diff" })
map("n", "<leader>gP", function()
  pr_pick_and_diff("gh pr list --search 'review-requested:@me' --limit 30", "Select PR assigned to me:")
end, { desc = "PR: pick assigned-to-me and show diff" })
map("n", "<leader>gw", pr_open_web, { desc = "PR: open in browser" })

map("n", "<leader>gd", function()
  local view = require("diffview.lib").get_current_view()
  if view then
    vim.cmd("DiffviewClose")
  else
    vim.cmd("DiffviewOpen")
  end
end, { desc = "Diffview: toggle all changes" })
