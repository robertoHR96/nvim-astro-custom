-- Config principal de NvChad con nvim-tree mapeos extendidos

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

-- Setup mapleader antes de cargar lazy.nvim
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Habilitar mouse y portapapeles
vim.o.mouse = "a"
vim.opt.mouse = "a"
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
vim.opt.completeopt = "menu,menuone,noselect"
vim.api.nvim_set_keymap("v", "<C-c>", '"+y', { noremap = true, silent = true })

-- Línea de referencia
vim.opt.colorcolumn = "80"

-- Pegar desde portapapeles
vim.api.nvim_set_keymap("n", "<C-v>", '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-v>", "<C-r>+", { noremap = true, silent = true })

-- Configuración básica
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.api.nvim_create_autocmd("FileType", {
  pattern = "html",
  callback = function()
    vim.opt.tabstop = 2
    vim.opt.shiftwidth = 2
  end,
})

-- Remaps normales de ventanas
vim.api.nvim_set_keymap("n", "<S-h>", "<C-w>h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-l>", "<C-w>l", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-k>", "<C-w>k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-j>", "<C-w>j", { noremap = true, silent = true })

-- Redimensionar ventanas
vim.api.nvim_set_keymap("n", "<S-Up>", "<C-w>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Down>", "<C-w>-", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Right>", "<C-w>>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-Left>", "<C-w><", { noremap = true, silent = true })

-- Insert mode remaps
vim.api.nvim_set_keymap("i", "kj", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "KJ", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "kJ", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "Kj", "<Esc>", { noremap = true, silent = true })

-- Formateo
-- Formateo mejorado
vim.api.nvim_set_keymap("n", "<leader>f", ":lua vim.lsp.buf.format({ async = true })<CR>", { noremap = true, silent = true, desc = "Format file" })
vim.api.nvim_set_keymap("v", "<leader>f", ":lua vim.lsp.buf.format({ async = true })<CR>", { noremap = true, silent = true, desc = "Format selection" })

-- Mapeos para moverse entre terminal y editor usando Shift + H/J/K/L
local opts = { noremap = true, silent = true }

-- En modo terminal, volver a normal mode y moverse
vim.api.nvim_set_keymap("t", "H", [[<C-\><C-n><C-w>h]], opts)
vim.api.nvim_set_keymap("t", "J", [[<C-\><C-n><C-w>j]], opts)
vim.api.nvim_set_keymap("t", "K", [[<C-\><C-n><C-w>k]], opts)
vim.api.nvim_set_keymap("t", "L", [[<C-\><C-n><C-w>l]], opts)

-- En modo normal, mover foco a terminal y entrar en modo terminal automáticamente
vim.api.nvim_set_keymap("n", "H", [[<C-w>h:if &buftype == 'terminal' | startinsert | endif<CR>]], opts)
vim.api.nvim_set_keymap("n", "J", [[<C-w>j:if &buftype == 'terminal' | startinsert | endif<CR>]], opts)
vim.api.nvim_set_keymap("n", "K", [[<C-w>k:if &buftype == 'terminal' | startinsert | endif<CR>]], opts)
vim.api.nvim_set_keymap("n", "L", [[<C-w>l:if &buftype == 'terminal' | startinsert | endif<CR>]], opts)

-- ==============================
-- MEJORA: Configuración mejorada para salir con confirmación (DEFINIDA ANTES DE LOS PLUGINS)
-- ==============================

-- Definir funciones globales para que estén disponibles en los comandos
_G.confirm_quit = function()
  -- Verificar si hay buffers modificados
  local modified_buffers = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_option(buf, "modified") then
      local buf_name = vim.api.nvim_buf_get_name(buf)
      table.insert(modified_buffers, {
        buf = buf,
        name = buf_name ~= "" and vim.fn.fnamemodify(buf_name, ":t") or "[No Name]"
      })
    end
  end

  -- Si no hay cambios, salir normalmente
  if #modified_buffers == 0 then
    vim.cmd "quit"
    return
  end

  -- Crear opciones para vim.ui.select
  local options = {
    "💾 Guardar y salir",
    "❌ Salir sin guardar",
    "🚫 Cancelar"
  }

  -- Mostrar diálogo de confirmación
  vim.ui.select(options, {
    prompt = "📁 Tienes " .. #modified_buffers .. " archivo(s) sin guardar:",
    format_item = function(item)
      return item
    end,
  }, function(choice)
    if choice == options[1] then -- Guardar y salir
      vim.cmd "wall"
      vim.cmd "quit"
    elseif choice == options[2] then -- Salir sin guardar
      vim.cmd "quit!"
    end
    -- Si es Cancelar, no hacer nada
  end)
end

_G.confirm_quit_all = function()
  local modified_buffers = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_option(buf, "modified") then
      local buf_name = vim.api.nvim_buf_get_name(buf)
      table.insert(modified_buffers, {
        buf = buf,
        name = buf_name ~= "" and vim.fn.fnamemodify(buf_name, ":t") or "[No Name]"
      })
    end
  end

  if #modified_buffers == 0 then
    vim.cmd "quitall"
    return
  end

  local options = {
    "💾 Guardar todo y salir",
    "❌ Salir sin guardar nada",
    "🚫 Cancelar"
  }

  vim.ui.select(options, {
    prompt = "📂 Tienes " .. #modified_buffers .. " archivo(s) modificados:",
    format_item = function(item)
      return item
    end,
  }, function(choice)
    if choice == options[1] then
      vim.cmd "wall"
      vim.cmd "quitall"
    elseif choice == options[2] then
      vim.cmd "quitall!"
    end
  end)
end

-- Cargar plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },
  { import = "plugins" },
}, lazy_config)

-- Cargar tema
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)

-- ==============================
-- Configuración de nvim-tree con auto-refresh y remaps extendidos
-- ==============================
require("nvim-tree").setup {
  on_attach = function(bufnr)
    local api = require "nvim-tree.api"
    local opts = function(desc)
      return { desc = desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- Navegación dentro de nvim-tree
    vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Abrir archivo con Enter"))
    vim.keymap.set("n", "L", api.node.open.edit, opts("Abrir archivo"))
    vim.keymap.set("n", "H", api.node.navigate.parent_close, opts("Cerrar nodo/volver arriba"))
    vim.keymap.set("n", "J", api.node.navigate.sibling.next, opts("Siguiente hermano abajo"))
    vim.keymap.set("n", "K", api.node.navigate.sibling.prev, opts("Siguiente hermano arriba"))

    -- Remaps de ventanas dentro de nvim-tree
    vim.keymap.set("n", "<S-h>", "<C-w>h", opts("Mover ventana izquierda"))
    vim.keymap.set("n", "<S-l>", "<C-w>l", opts("Mover ventana derecha"))
    vim.keymap.set("n", "<S-j>", "<C-w>j", opts("Mover ventana abajo"))
    vim.keymap.set("n", "<S-k>", "<C-w>k", opts("Mover ventana arriba"))

    -- Gestión de archivos
    vim.keymap.set("n", "a", api.fs.create, opts("Crear archivo/carpeta"))
    vim.keymap.set("n", "r", api.fs.rename, opts("Renombrar archivo/carpeta"))
    vim.keymap.set("n", "d", api.fs.remove, opts("Eliminar archivo/carpeta"))
    vim.keymap.set("n", "x", api.fs.cut, opts("Cortar archivo/carpeta"))
    vim.keymap.set("n", "y", api.fs.copy.node, opts("Copiar archivo/carpeta"))
    vim.keymap.set("n", "p", api.fs.paste, opts("Pegar archivo/carpeta"))

    -- Cerrar nvim-tree
    vim.keymap.set("n", "<leader>q", api.tree.close, opts("Cerrar árbol"))
  end,

  -- ==============================
  -- Auto refrescar cuando cambian archivos
  -- ==============================
  auto_reload_on_write = true,
  reload_on_bufenter = true,
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
}

-- Autocomando global para refrescar nvim-tree al detectar cambios externos
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "FocusGained", "DirChanged" }, {
  callback = function()
    require("nvim-tree.api").tree.reload()
  end,
})

-- =========================
-- Keymap para togglear terminal en normal y terminal mode
-- =========================

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local nvim_tree = require "nvim-tree.api"
    local nv_term = require "nvchad.term"

    -- Abrir nvim-tree inmediatamente
    nvim_tree.tree.open()

    -- Mover el foco a la ventana derecha
    vim.cmd "wincmd l"

    -- Abrir terminal después de 100ms, cuando el buffer ya está listo
    nv_term.toggle { pos = "sp", size = 0.2, id = "floatTerm" }

    vim.cmd "wincmd k"
  end,
})

-- always map it in "t" i.e terminal mode too
vim.keymap.set({ "n", "t" }, "<leader>t", function()
  require("nvchad.term").toggle { pos = "sp", id = "floatTerm", size = 0.2 }
end)

-- ==============================
-- CONFIGURACIÓN DE LOS COMANDOS DE SALIDA MEJORADA
-- ==============================

-- Crear comandos de usuario
vim.api.nvim_create_user_command("Q", function() _G.confirm_quit() end, { desc = "Salir con confirmación" })
vim.api.nvim_create_user_command("Qa", function() _G.confirm_quit_all() end, { desc = "Salir todo con confirmación" })

-- Configurar los abreviados de comandos después de que Vim esté completamente cargado
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Pequeña espera para asegurar que todo esté cargado
    vim.defer_fn(function()
      -- Usar cnoreabbrev para reemplazar :q y :qa
      vim.cmd [[
        cnoreabbrev <expr> q getcmdtype() == ":" && getcmdline() == 'q' ? 'confirm q' : 'q'
        cnoreabbrev <expr> qa getcmdtype() == ":" && getcmdline() == 'qa' ? 'confirm qa' : 'qa'
      ]]
    end, 50)
  end,
})

-- Mapeos directos
vim.api.nvim_set_keymap("n", "<leader>q", "<cmd>lua _G.confirm_quit()<CR>", { noremap = true, silent = true, desc = "Salir con confirmación" })
vim.api.nvim_set_keymap("n", "<leader>qa", "<cmd>lua _G.confirm_quit_all()<CR>", { noremap = true, silent = true, desc = "Salir todo con confirmación" })

