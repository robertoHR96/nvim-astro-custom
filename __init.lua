-- =============================================================================
-- === Archivo de Configuración de Neovim: init.lua                        ===
-- === Descripción: Este archivo configura Neovim, incluyendo la gestión ===
-- ===              de plugins, ajustes generales, atajos de teclado y   ===
-- ===              autocomandos.                                        ===
-- =============================================================================

-- =============================================================================
-- === 1. Gestión de Plugins: Inicio de lazy.nvim                          ===
-- ===    Inicializa lazy.nvim, un moderno gestor de plugins para Neovim.===
-- =============================================================================
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- Clona el repositorio de lazy.nvim si aún no está instalado
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    -- Maneja los errores de clonación
    vim.api.nvim_echo({
      { "Fallo al clonar lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPresiona cualquier tecla para salir..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
-- Añade lazy.nvim a la ruta de ejecución (runtime path)
vim.opt.rtp:prepend(lazypath)

-- =============================================================================
-- === 2. Configuración Global de Neovim                                   ===
-- ===    Configura comportamientos y opciones fundamentales de Neovim.  ===
-- =============================================================================

-- Establece mapleader y maplocalleader para los atajos de teclado
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Habilita el soporte del ratón en todos los modos
vim.o.mouse = "a"
vim.opt.mouse = "a"

-- Configura la integración del portapapeles
-- Usa el portapapeles del sistema a menos que esté en una TTY SSH (para evitar problemas)
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"

-- Comportamiento del menú de autocompletado
vim.opt.completeopt = "menu,menuone,noselect"

-- Muestra números de línea y números de línea relativos
vim.opt.number = true
vim.opt.relativenumber = true

-- Configuración de indentación
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Deshabilita el ajuste de línea (word wrap)
vim.opt.wrap = false

-- Muestra una línea vertical de referencia en la columna 80 para guía visual
vim.opt.colorcolumn = "80"

-- Configuración global de tabs (por defecto 4 espacios)
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true -- Usa espacios en lugar de tabs

-- =============================================================================
-- === 3. Atajos de Teclado (Remaps)                                       ===
-- ===    Mapeos de teclas personalizados para una navegación y edición  ===
-- ===    mejoradas.                                                     ===
-- =============================================================================

-- Atajos de teclado para el portapapeles (Modo Visual: copiar, Modo Normal/Insertar: pegar)
vim.api.nvim_set_keymap(
  "v",
  "<C-c>",
  '"+y',
  { noremap = true, silent = true, desc = "Copiar al portapapeles del sistema" }
)
vim.api.nvim_set_keymap(
  "n",
  "<C-v>",
  '"+p',
  { noremap = true, silent = true, desc = "Pegar del portapapeles del sistema (Normal)" }
)
vim.api.nvim_set_keymap(
  "i",
  "<C-v>",
  "<C-r>+",
  { noremap = true, silent = true, desc = "Pegar del portapapeles del sistema (Insertar)" }
)

-- Atajos de teclado para la navegación entre ventanas (Shift + H/L/K/J para moverse)
vim.api.nvim_set_keymap(
  "n",
  "<S-h>",
  "<C-w>h",
  { noremap = true, silent = true, desc = "Mover a la ventana izquierda" }
)
vim.api.nvim_set_keymap("n", "<S-l>", "<C-w>l", { noremap = true, silent = true, desc = "Mover a la ventana derecha" })
vim.api.nvim_set_keymap("n", "<S-k>", "<C-w>k", { noremap = true, silent = true, desc = "Mover a la ventana superior" })
vim.api.nvim_set_keymap("n", "<S-j>", "<C-w>j", { noremap = true, silent = true, desc = "Mover a la ventana inferior" })

-- Atajos de teclado para redimensionar ventanas
-- Aumentar/disminuir altura de la ventana
vim.api.nvim_set_keymap(
  "n",
  "<S-Up>",
  "<C-w>+",
  { noremap = true, silent = true, desc = "Aumentar altura de la ventana" }
)
vim.api.nvim_set_keymap(
  "n",
  "<S-Down>",
  "<C-w>-",
  { noremap = true, silent = true, desc = "Disminuir altura de la ventana" }
)
-- Aumentar/disminuir ancho de la ventana
vim.api.nvim_set_keymap(
  "n",
  "<S-Right>",
  "<C-w>>",
  { noremap = true, silent = true, desc = "Aumentar ancho de la ventana" }
)
vim.api.nvim_set_keymap(
  "n",
  "<S-Left>",
  "<C-w><",
  { noremap = true, silent = true, desc = "Disminuir ancho de la ventana" }
)

-- Atajos de teclado para salir del modo Insertar (kj, KJ, kJ, Kj)
vim.api.nvim_set_keymap("i", "kj", "<Esc>", { noremap = true, silent = true, desc = "Salir del modo Insertar" })
vim.api.nvim_set_keymap("i", "KJ", "<Esc>", { noremap = true, silent = true, desc = "Salir del modo Insertar" })
vim.api.nvim_set_keymap("i", "kJ", "<Esc>", { noremap = true, silent = true, desc = "Salir del modo Insertar" })
vim.api.nvim_set_keymap("i", "Kj", "<Esc>", { noremap = true, silent = true, desc = "Salir del modo Insertar" })

-- Atajos de teclado para formatear con conform.nvim (leader + f)
vim.api.nvim_set_keymap(
  "n",
  "<leader>f",
  ":lua require('conform').format()<CR>",
  { noremap = true, silent = true, desc = "Formatear buffer actual (Normal)" }
)
vim.api.nvim_set_keymap(
  "v",
  "<leader>f",
  ":lua require('conform').format()<CR>",
  { noremap = true, silent = true, desc = "Formatear buffer actual (Visual)" }
)

-- Atajo de teclado global para refrescar NeoTree
vim.api.nvim_set_keymap(
  "n",
  "<leader>nr",
  "<cmd>NeoTreeFocus<cr>r",
  { noremap = true, silent = true, desc = "Refrescar NeoTree" }
)

-- =============================================================================
-- === 4. Autocomandos                                                     ===
-- ===    Comandos automatizados que se activan por eventos específicos. ===
-- =============================================================================

-- Autocomando para archivos HTML: establece tab/shiftwidth a 2
vim.api.nvim_create_autocmd("FileType", {
  pattern = "html",
  callback = function()
    vim.opt.tabstop = 2
    vim.opt.shiftwidth = 2
  end,
  desc = "Establecer tabs de 2 espacios para archivos HTML",
})

-- Autocomando para abrir Neo-tree automáticamente al iniciar Neovim si se abren archivos
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Solo abre Neo-tree si Neovim se inicia con argumentos (es decir, abriendo archivos)
    if vim.fn.argc() > 0 then
      -- Abre Neo-tree a la izquierda y luego devuelve el foco a la ventana del editor principal
      require("neo-tree.command").execute {
        action = "show",
        position = "left",
        toggle = true,
      }
      vim.cmd "wincmd p" -- Devuelve el foco a la ventana anterior (el archivo abierto)
    end
  end,
  desc = "Abrir Neo-tree al inicio cuando se abren archivos",
})

-- =============================================================================
-- === 5. Especificaciones y Configuración de Plugins (configuración de lazy.nvim) ===
-- ===    Define y configura todos los plugins gestionados por lazy.nvim.  ===
-- =============================================================================
require("lazy").setup {
  spec = {
    -- Plugin: bufferline.nvim (Pestañas para buffers) - CONFIGURACIÓN MEJORADA
    {
      "akinsho/bufferline.nvim",
      version = "*",
      dependencies = "nvim-tree/nvim-web-devicons",
      config = function()
        require("bufferline").setup {
          options = {
            mode = "buffers",
            style = "slant",
            always_show_bufferline = true,
            show_close_icon = false,
            show_buffer_close_icons = true,
            color_icons = true,
            persist_buffer_sort = true,
            separator_style = "slant",

            -- Configuración mejorada de cierre
            close_command = function(bufnum)
              -- Cerrar el buffer sin afectar el layout de ventanas
              local current_win = vim.api.nvim_get_current_win()
              local win_count = #vim.api.nvim_list_wins()

              if win_count > 1 then
                -- Si hay múltiples ventanas, cerrar el buffer pero mantener la ventana
                vim.cmd("bdelete " .. bufnum)
              else
                -- Si es la única ventana, usar el comportamiento normal
                vim.cmd("bdelete! " .. bufnum)
              end
            end,

            right_mouse_command = function(bufnum)
              local filetype = vim.bo[bufnum].filetype

              -- No cerrar buffers especiales con click derecho
              if filetype == "neo-tree" or filetype == "toggleterm" then
                print("No se puede cerrar " .. filetype .. " con click derecho")
                return
              end

              -- Cerrar el buffer de forma segura
              if vim.bo[bufnum].modified then
                local choice = vim.fn.confirm("¿Guardar cambios antes de cerrar?", "&Sí\n&No\n&Cancelar")
                if choice == 1 then
                  vim.cmd "w"
                  vim.cmd("bdelete " .. bufnum)
                elseif choice == 2 then
                  vim.cmd("bdelete! " .. bufnum)
                end
              else
                vim.cmd("bdelete " .. bufnum)
              end
            end,

            offsets = {
              {
                filetype = "neo-tree",
                text = "Explorador de Archivos",
                highlight = "Directory",
                text_align = "left",
                padding = 1,
              },
              {
                filetype = "toggleterm",
                text = "Terminal",
                highlight = "Directory",
                text_align = "left",
                padding = 1,
              },
            },
          },
        }

        -- Navegación entre buffers
        vim.keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Siguiente buffer" })
        vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Buffer anterior" })

        -- Función mejorada para cerrar buffers
        local function safe_close_buffer()
          local bufnum = vim.api.nvim_get_current_buf()
          local filetype = vim.bo[bufnum].filetype

          -- No cerrar buffers especiales
          if filetype == "neo-tree" or filetype == "toggleterm" then
            print("No se puede cerrar " .. filetype)
            return
          end

          -- Contar ventanas antes de cerrar
          local win_count_before = #vim.api.nvim_list_wins()

          -- Cerrar el buffer de forma segura
          if vim.bo.modified then
            local choice = vim.fn.confirm("¿Guardar cambios antes de cerrar?", "&Sí\n&No\n&Cancelar")
            if choice == 1 then
              vim.cmd "w"
              vim.cmd "bdelete"
            elseif choice == 2 then
              vim.cmd "bdelete!"
            else
              return
            end
          else
            vim.cmd "bdelete"
          end

          -- Si quedó una sola ventana después de cerrar, restaurar el layout
          vim.defer_fn(function()
            local win_count_after = #vim.api.nvim_list_wins()
            if win_count_after == 1 then
              restore_layout()
            end
          end, 50)
        end

        -- Reemplazar el mapeo existente
        vim.keymap.set("n", "<leader>bd", safe_close_buffer, { desc = "Cerrar buffer actual de forma segura" })
        vim.keymap.set("n", "<leader>tc", safe_close_buffer, { desc = "Cerrar buffer actual" })

        -- Nuevo buffer
        vim.keymap.set("n", "<leader>tn", "<Cmd>enew<CR>", { desc = "Nuevo buffer" })

        -- Atajos rápidos para buffers específicos
        for i = 1, 9 do
          vim.keymap.set("n", "<leader>" .. i, function()
            require("bufferline").go_to_buffer(i, true)
          end, { desc = "Ir al buffer " .. i })
        end
      end,
    },
    -- Plugin: toggleterm.nvim (Emulador de terminal)
    {
      "akinsho/toggleterm.nvim",
      version = "*",
      config = function()
        require("toggleterm").setup {
          start_in_insert = true, -- Iniciar en modo insertar al abrir
          open_mapping = "<C-t>", -- Atajo de teclado para alternar la terminal
          direction = "horizontal", -- La terminal se abre horizontalmente
          size = 8, -- Altura de la terminal
          shade_terminals = false, -- No sombrear el fondo de la terminal
          hide_numbers = true, -- Ocultar números de línea en la terminal
          persist_size = true, -- Recordar el tamaño de la terminal
        }

        -- Atajo de teclado para salir del modo terminal al modo normal
        vim.api.nvim_set_keymap(
          "t",
          "<Esc>",
          "<C-\\><C-n>",
          { noremap = true, silent = true, desc = "Salir del modo insertar de la terminal" }
        )

        -- Autocomando para abrir ToggleTerm automáticamente al iniciar Neovim
        vim.api.nvim_create_autocmd("VimEnter", {
          callback = function()
            require("toggleterm").toggle() -- Abrir la terminal

            -- Retrasar el envío de teclas para asegurar que la terminal esté lista y el mapeo aplicado
            vim.defer_fn(function()
              -- Primero, envía Esc para salir del modo insertar (si se inició en insertar)
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "t", true)
              -- Luego, envía Shift+k (ejemplo, ajusta si es necesario)
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-k>", true, false, true), "t", true)
            end, 100) -- Retraso aumentado para mayor robustez
          end,
          desc = "Abrir ToggleTerm al iniciar Neovim",
        })
      end,
    },

    -- Plugin: Comment.nvim (Comentado inteligente)
    {
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup {
          padding = true, -- Añadir un espacio entre el string de comentario y la línea
          sticky = true, -- Si el comentario es pegajoso (permanece en la misma línea)
          ignore = nil, -- Archivos a ignorar
          toggler = {
            line = "/", -- Atajo de teclado para comentar/descomentar línea (modo normal)
            block = "n", -- Atajo de teclado para comentar/descomentar bloque (modo normal)
          },
          opleader = {
            line = "/", -- Atajo de teclado para comentar/descomentar línea (modo pendiente de operador)
            block = "n", -- Atajo de teclado para comentar/descomentar bloque (modo pendiente de operador)
          },
          mappings = {
            basic = true, -- Habilitar mapeos básicos (gcc, gcb)
            extra = true, -- Habilitar mapeos extra (gc[count]{motion})
          },
          pre_hook = nil, -- Función a ejecutar antes de comentar
          post_hook = nil, -- Función a ejecutar después de comentar
        }
      end,
    },

    -- Plugin: nvim-treesitter (Resaltado de sintaxis y parseo)
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

    -- Plugin: lualine.nvim (Línea de estado)
    {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" }, -- Requiere web-devicons para los iconos
    },

    -- Plugin: neo-tree.nvim (Explorador de archivos)
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim", -- Dependencia requerida
        "nvim-tree/nvim-web-devicons", -- Requerido para los iconos
        "MunifTanjim/nui.nvim", -- Dependencia requerida
      },
      config = function()
        require("neo-tree").setup {
          use_libuv_file_watcher = true, -- Usar el observador de archivos nativo de Neovim
          enable_git_status = true, -- Mostrar el estado de Git en el árbol
          enable_refresh_on_write = true, -- Refrescar el árbol al escribir un archivo
          refresh_on_write = true, -- Asegurar que el refresco al escribir esté activo

          filesystem = {
            follow_current_file = {
              enabled = true, -- Neo-tree sigue el archivo actualmente abierto
            },
            use_libuv_file_watcher = true, -- Observador de archivos para el sistema de archivos
            hijack_netrw_behavior = "open_default", -- Reemplazar netrw con Neo-tree
            window = {
              position = "left", -- Posición de la ventana de Neo-tree
              width = 30, -- Ancho de la ventana de Neo-tree
              mappings = {
                ["i"] = "open_vsplit", -- Abrir archivo en división vertical
                ["s"] = "open_split", -- Abrir archivo en división horizontal
                ["o"] = "open", -- Abrir archivo en la ventana actual
                ["t"] = "open_tab_new", -- Abrir archivo en una nueva pestaña
                ["<C-r>"] = "refresh", -- Refresco manual con Ctrl+r
                ["r"] = "refresh", -- Refresco manual con r
              },
            },
            filtered_items = {
              visible = true, -- Mostrar elementos filtrados
              hide_dotfiles = false, -- No ocultar archivos ocultos (dotfiles)
              hide_gitignored = true, -- Ocultar archivos ignorados por Git
            },
          },
        }

        -- Autocomandos para refrescar NeoTree automáticamente al enfocar o cambiar de buffer
        vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
          callback = function()
            -- Refrescar NeoTree cuando se gana el foco o se cambia de buffer
            require("neo-tree.sources.manager").refresh "filesystem"
          end,
          desc = "Refrescar NeoTree al enfocar o entrar en un buffer",
        })

        -- Autocomando para refrescar NeoTree después de escribir un archivo o cambiar de directorio
        vim.api.nvim_create_autocmd({ "BufWritePost", "DirChanged" }, {
          callback = function()
            vim.defer_fn(function()
              require("neo-tree.sources.manager").refresh "filesystem"
            end, 100)
          end,
          desc = "Refrescar NeoTree al escribir un archivo o cambiar de directorio",
        })
      end,
    },

    -- Plugin: onedarkpro.nvim (Esquema de colores)
    {
      "olimorris/onedarkpro.nvim",
      priority = 1000, -- Asegura que se cargue primero
      config = function()
        vim.cmd "colorscheme onedark" -- Establece el esquema de colores
      end,
    },

    -- Plugin: supermaven-nvim (Autocompletado de código con IA)
    {
      "supermaven-inc/supermaven-nvim",
      config = function()
        require("supermaven-nvim").setup {
          keymaps = {
            accept_suggestion = "<Tab>i", -- Aceptar sugerencia
            clear_suggestion = "<C-]", -- Descartar sugerencia
            accept_word = "<C-j>", -- Aceptar palabra
            next = "<C-n>", -- Siguiente sugerencia
            prev = "<C-p>", -- Sugerencia anterior
            dismiss = "<C-]", -- Descartar sugerencia
          },
        }
      end,
    },

    -- Plugin: conform.nvim (Formateador de código)
    {
      "stevearc/conform.nvim",
      config = function()
        require("conform").setup {
          -- Formateadores por tipo de archivo
          formatters_by_ft = {
            lua = { "stylua" },
            python = { "black", "isort" },
            javascript = { "prettier" },
            typescript = { "prettier" },
            javascriptreact = { "prettier" },
            typescriptreact = { "prettier" },
            html = { "prettier" },
            css = { "prettier" },
            json = { "jq" },
            yaml = { "prettier" },
            markdown = { "prettier" },
            sh = { "shfmt" },
          },
          -- Formatear al guardar
          format_on_save = { timeout_ms = 500, lsp_fallback = true },
          -- Configuraciones de formateadores personalizados
          formatters = {
            black = { command = "black", args = { "-" } },
            isort = { command = "isort", args = { "-" } },
          },
        }
      end,
    },
  },

  -- Opciones de instalación de lazy.nvim
  install = { colorscheme = { "habamax" } }, -- Instalar el esquema de colores 'habamax' si no está presente
  checker = { enabled = true }, -- Habilitar el verificador de actualizaciones de plugins
}

-- =============================================================================
-- === 6. Configuraciones de Plugins (Después de la configuración de lazy.nvim) ===
-- ===    Configuraciones para plugins que necesitan ser configurados      ===
-- ===    después de que lazy.nvim los haya cargado.                     ===
-- =============================================================================

-- Configuración de lualine.nvim
require("lualine").setup {
  options = {
    theme = "onedarkpro", -- Establece el tema para lualine
    section_separators = { left = "", right = "" }, -- Separadores de sección personalizados
    component_separators = { left = "", right = "" }, -- Separadores de componentes personalizados
    globalstatus = true, -- Mostrar siempre la línea de estado
    refresh = {
      statusline = 1000, -- Refrescar la línea de estado cada 1000ms
      tabline = 1000, -- Refrescar la línea de pestañas cada 1000ms
      winbar = 1000, -- Refrescar la barra de ventana cada 1000ms
    },
  },
}

-- Configuración de nvim-treesitter
require("nvim-treesitter.configs").setup {
  -- Asegura que estos parsers estén instalados
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
  sync_install = false, -- No sincronizar la instalación (instalar asincrónicamente)
  auto_install = true, -- Instalar automáticamente los parsers faltantes
  highlight = {
    enable = true, -- Habilitar el resaltado de Treesitter
    -- Deshabilitar el resaltado para archivos muy grandes para mejorar el rendimiento
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
    additional_vim_regex_highlighting = false, -- Deshabilitar el resaltado adicional de expresiones regulares de Vim
  },
}

-- =============================================================================
-- === 7. Comandos de Usuario Personalizados                               ===
-- ===    Define comandos personalizados para acciones específicas.      ===
-- =============================================================================

-- Comando personalizado: :Wqall (Guardar todos los buffers y salir, cerrando terminales de forma segura)
vim.api.nvim_create_user_command("Wqall", function()
  vim.cmd "wall" -- Guarda todos los buffers modificados

  -- Función para cerrar terminales de ToggleTerm de forma segura
  local function close_terminals()
    local ok, toggleterm = pcall(require, "toggleterm")
    if ok and toggleterm then
      -- Intenta cerrar todas las terminales usando la API de ToggleTerm
      pcall(function()
        require("toggleterm").toggle_all "close"
      end)

      -- Fallback: cierra las terminales individualmente si lo anterior no funciona
      local ok_term, terms = pcall(require, "toggleterm.terminal")
      if ok_term and terms then
        for _, term in pairs(terms.get_all()) do
          if term and term.close then
            pcall(term.close, term)
          end
        end
      end
    end
  end

  close_terminals() -- Ejecuta la lógica de cierre de terminales

  -- Retrasa el comando de salida para permitir que las terminales se cierren correctamente
  vim.defer_fn(function()
    local success, result = pcall(vim.cmd, "qa") -- Intenta salir de todo
    if not success then
      -- Si la salida normal falla (ej. debido a cambios sin guardar o procesos activos), fuerza la salida
      print "Forzando salida debido a procesos activos o cambios sin guardar..."
      vim.cmd "qa!"
    end
  end, 150) -- Retraso aumentado para mayor seguridad
end, { desc = "Guardar todos los buffers y salir (cerrando terminales de forma segura)" })

-- Alias para :Wqall (error tipográfico común)
vim.api.nvim_create_user_command("Wqal", function()
  vim.cmd "Wqall"
end, { desc = "Alias para :Wqall" })

-- Abreviaturas de comandos para uso insensible a mayúsculas/minúsculas
vim.cmd "cnoreabbrev wqall Wqall"
vim.cmd "cnoreabbrev wqal Wqal"

-- =============================================================================
-- === 8. Lógica de Modo de Inserción Automática en Terminal               ===
-- ===    Asegura que Neovim entre automáticamente en modo Insertar al   ===
-- ===    enfocar un buffer de terminal (ej. ToggleTerm).                ===
-- =============================================================================

-- Función auxiliar para verificar si un buffer es un buffer de terminal
local function is_terminal_buf(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local ok1, btype = pcall(vim.api.nvim_buf_get_option, bufnr, "buftype")
  local ok2, ft = pcall(vim.api.nvim_buf_get_option, bufnr, "filetype")
  btype = btype or ""
  ft = ft or ""
  -- Comprueba la variable de buffer específica de toggleterm
  local has_toggle_number = pcall(function()
    return vim.b[bufnr] and vim.b[bufnr].toggle_number ~= nil
  end)
  return btype == "terminal" or ft == "toggleterm" or (has_toggle_number and vim.b[bufnr].toggle_number ~= nil)
end

-- Autocomando para entrar en modo Insertar cuando se entra/enfoca un buffer de terminal
vim.api.nvim_create_autocmd({ "TermOpen", "TermEnter", "BufWinEnter", "WinEnter", "BufEnter" }, {
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    if not is_terminal_buf(bufnr) then
      return -- No es un buffer de terminal, no hacer nada
    end

    -- Retrasa el comando startinsert para evitar condiciones de carrera
    vim.defer_fn(function()
      -- Vuelve a verificar si todavía estamos en un buffer de terminal después del retraso
      local curbuf = vim.api.nvim_get_current_buf()
      if not is_terminal_buf(curbuf) then
        return
      end
      -- Solo entra en modo insertar si aún no estamos en él
      if vim.api.nvim_get_mode().mode ~= "i" then
        pcall(vim.cmd, "startinsert")
      end
    end, 20) -- Un retraso de 20ms suele ser suficiente
  end,
  desc = "Entrar automáticamente en modo Insertar en buffers de terminal",
})

-- Envoltorios para los atajos de teclado de movimiento de ventana para asegurar el auto-insertar en terminales
-- Estos mantienen el comportamiento existente de movimiento de ventana y fuerzan startinsert si el destino es una terminal.
local opts = { noremap = true, silent = true }
local move_and_maybe_insert = function(cmd)
  return function()
    vim.cmd("wincmd " .. cmd) -- Ejecuta el comando de movimiento de ventana
    vim.defer_fn(function()
      if is_terminal_buf() and vim.api.nvim_get_mode().mode ~= "i" then
        pcall(vim.cmd, "startinsert") -- Entra en modo insertar si está en la terminal
      end
    end, 20)
  end
end

-- Aplica los atajos de teclado envueltos para la navegación de ventanas en modo normal
vim.keymap.set("n", "<S-h>", move_and_maybe_insert "h", opts)
vim.keymap.set("n", "<S-l>", move_and_maybe_insert "l", opts)
vim.keymap.set("n", "<S-k>", move_and_maybe_insert "k", opts)
vim.keymap.set("n", "<S-j>", move_and_maybe_insert "j", opts)

-- Atajos de teclado en modo terminal para permitir moverse entre ventanas y volver a entrar en insertar
local function term_move(dir)
  return function()
    -- Sale del modo insertar de la terminal al modo normal
    pcall(vim.api.nvim_feedkeys, vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", true)

    vim.cmd("wincmd " .. dir) -- Mueve la ventana

    -- Vuelve a entrar en modo insertar si la ventana de destino es una terminal
    vim.defer_fn(function()
      if is_terminal_buf() then
        if vim.api.nvim_get_mode().mode ~= "i" then
          pcall(vim.cmd, "startinsert")
        end
      end
    end, 30) -- Un retraso de 30ms para mayor robustez
  end
end

-- Aplica los atajos de teclado del modo terminal para la navegación de ventanas
vim.keymap.set(
  "t",
  "<S-h>",
  term_move "h",
  { noremap = true, silent = true, desc = "Mover a la ventana izquierda (Terminal)" }
)
vim.keymap.set(
  "t",
  "<S-l>",
  term_move "l",
  { noremap = true, silent = true, desc = "Mover a la ventana derecha (Terminal)" }
)
vim.keymap.set(
  "t",
  "<S-k>",
  term_move "k",
  { noremap = true, silent = true, desc = "Mover a la ventana superior (Terminal)" }
)
vim.keymap.set(
  "t",
  "<S-j>",
  term_move "j",
  { noremap = true, silent = true, desc = "Mover a la ventana inferior (Terminal)" }
)

-- Abrir Neo-tree automáticamente al abrir un archivo, pero mantener foco en editor
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() > 0 then
      -- Abrir Neo-tree a la derecha usando la API nueva
      require("neo-tree.command").execute { action = "show", position = "left", toggle = true } -- Mantener el foco en el primer buffer (archivo principal)
      vim.cmd "wincmd p"
    end
  end,
})

-- Mapeo global para refrescar NeoTree
vim.api.nvim_set_keymap(
  "n",
  "<leader>nr",
  "<cmd>NeoTreeFocus<cr>r",
  { noremap = true, silent = true, desc = "Refresh NeoTree" }
)
