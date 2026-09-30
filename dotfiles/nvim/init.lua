vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.env.PATH = vim.fn.expand("~/.dotnet/tools") .. ":" .. vim.fn.expand("~/.nix-profile/bin") .. ":" .. vim.env.PATH

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 400
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "> ", trail = ".", nbsp = "+" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 8

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
vim.keymap.set("n", "<leader>w", "<cmd>write<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit window" })
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Toggle file explorer" })
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Search text" })
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Open buffers" })
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })
vim.keymap.set("n", "<leader>?", "<cmd>tabnew /etc/nixos/docs/neovim.md<CR>", { desc = "Open Neovim cheat sheet" })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "json",
  callback = function(event)
    vim.keymap.set("n", "<leader>j", "<cmd>%!jq .<CR>", {
      buffer = event.buf,
      desc = "Format JSON with jq",
    })
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local map = function(keys, rhs, desc)
      vim.keymap.set("n", keys, rhs, { buffer = event.buf, desc = desc })
    end

    map("gd", vim.lsp.buf.definition, "Go to definition")
    map("gr", vim.lsp.buf.references, "Go to references")
    map("K", vim.lsp.buf.hover, "Hover documentation")
    map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("<leader>f", vim.lsp.buf.format, "Format buffer")
  end,
})

require("config.lazy")
