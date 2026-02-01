vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- Setup mapleader before loading lazy.nvim
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Habilitar el mouse
vim.o.mouse = "a"
vim.opt.mouse = "a"
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
vim.opt.completeopt = "menu,menuone,noselect"
-- Copiar al portapapeles del sistema
vim.api.nvim_set_keymap("v", "<C-c>", '"+y', { noremap = true, silent = true })

-- Mostrar línea vertical de referencia en la columna 80
vim.opt.colorcolumn = "80"

-- Pegar desde el portapapeles del sistema
vim.api.nvim_set_keymap("n", "<C-v>", '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-v>", "<C-r>+", { noremap = true, silent = true })

-- Configuraciones varias
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = false

-- Configuración global de tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Autocomando para archivos HTML
vim.api.nvim_create_autocmd("FileType", {
	pattern = "html",
	callback = function()
		vim.opt.tabstop = 2
		vim.opt.shiftwidth = 2
	end,
})

-- Remapeos para moverse entre ventanas
vim.api.nvim_set_keymap("n", "<S-h>", "<C-w>h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-l>", "<C-w>l", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-k>", "<C-w>k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-j>", "<C-w>j", { noremap = true, silent = true })

-- Redimensionar ventanas
-- Redimensionar altura
vim.api.nvim_set_keymap("n", "<S-Up>", "<C-w>+", { noremap = true, silent = true }) -- aumenta altura
vim.api.nvim_set_keymap("n", "<S-Down>", "<C-w>-", { noremap = true, silent = true }) -- disminuye altura

-- Redimensionar ancho
vim.api.nvim_set_keymap("n", "<S-Right>", "<C-w>>", { noremap = true, silent = true }) -- aumenta ancho
vim.api.nvim_set_keymap("n", "<S-Left>", "<C-w><", { noremap = true, silent = true }) -- disminuye ancho

-- Key mappings in insert mode
vim.api.nvim_set_keymap("i", "kj", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "KJ", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "kJ", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "Kj", "<Esc>", { noremap = true, silent = true })

-- Atajos para formateo
vim.api.nvim_set_keymap("n", "<leader>f", ":lua require('conform').format()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>f", ":lua require('conform').format()<CR>", { noremap = true, silent = true })


-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)
