# Mi Configuración Personal de AstroNvim

Este repositorio contiene mi configuración personal para [AstroNvim](https://astronvim.com/), diseñada para ser modular, eficiente y fácil de replicar en cualquier máquina. El objetivo es tener un entorno de desarrollo listo para usar con todas mis herramientas y atajos preferidos.

## Requisitos Previos

Antes de instalar, asegúrate de tener lo siguiente:

1.  **Neovim**: Versión `0.9.0` o superior.
2.  **Git**: Para clonar el repositorio y gestionar los plugins.
3.  **Nerd Font**: Necesaria para que los iconos se muestren correctamente. Recomiendo [FiraCode Nerd Font](https://www.nerdfonts.com/font-downloads).
4.  **Dependencias de LSP y Formateadores**:
    *   `node`/`npm`: Para `tsserver`, `prettier`, `jsonls`, etc.
    *   `python`: Para `pyright`, `black`.
    *   `go`: Para `gopls`.
    *   `rustup`: Para `rust_analyzer`.

## Instalación

Sigue estos pasos para instalar la configuración:

1.  **Haz una copia de seguridad de tu configuración actual de Neovim (si la tienes):**
    ```bash
    # Mueve tu configuración actual a una carpeta de respaldo
    mv ~/.config/nvim ~/.config/nvim.bak
    mv ~/.local/share/nvim ~/.local/share/nvim.bak
    mv ~/.local/state/nvim ~/.local/state/nvim.bak
    mv ~/.cache/nvim ~/.cache/nvim.bak
    ```

2.  **Clona este repositorio en tu directorio de configuración de Neovim:**
    ```bash
    git clone https://github.com/tu-usuario/tu-repositorio.git ~/.config/nvim
    ```
    *(Reemplaza `tu-usuario/tu-repositorio` con la URL de tu repositorio)*

3.  **Inicia Neovim:**
    ```bash
    nvim
    ```
    La primera vez que inicies Neovim, [lazy.nvim](https://github.com/folke/lazy.nvim) se instalará automáticamente y sincronizará todos los plugins definidos en la configuración.

## Estructura del Repositorio

La configuración está organizada de manera modular para facilitar su mantenimiento:

-   `init.lua`: El punto de entrada principal. Carga `lazy.nvim`, los plugins, y el resto de la configuración. También contiene personalizaciones clave como el layout de inicio y el sistema de salida con confirmación.
-   `lua/chadrc.lua`: Archivo de configuración de la UI de AstroNvim. Aquí se define el tema (`gatekeeper`).
-   `lua/mappings.lua`: Define los atajos de teclado globales.
-   `lua/options.lua`: Establece las opciones base de Neovim (números de línea, sangrado, etc.).
-   `lua/plugins/init.lua`: Define la lista de plugins personalizados que se añaden a la base de AstroNvim.
-   `lua/configs/`: Contiene la configuración específica para ciertos plugins:
    -   `lspconfig.lua`: Configuración de los servidores de lenguaje (LSP).
    -   `cmp.lua`: Personalización del menú de autocompletado.
    -   `conform.lua`: Define los formateadores de código por tipo de archivo.

## Características Principales

-   **Layout de Inicio Automático**: Al iniciar `nvim`, se abre automáticamente `NvimTree` a la izquierda y una terminal flotante en la parte inferior, dejando el foco listo en una ventana de edición.
-   **Salida Segura con Confirmación**: Al intentar salir con `:q` o `:qa`, un menú de confirmación aparecerá si hay archivos sin guardar, evitando pérdidas accidentales.
-   **Gestión de LSPs con Mason**: Los servidores de lenguaje se instalan y gestionan automáticamente, proporcionando autocompletado, diagnósticos y formato para múltiples lenguajes.
-   **Atajos de Teclado Intuitivos**: Mapeos diseñados para una navegación fluida entre ventanas, terminal y el explorador de archivos.
-   **Formateo al Guardar**: Configurado a través de `conform.nvim` para formatear el código automáticamente.

## Atajos de Teclado

La tecla `Líder` está mapeada a la `Barra espaciadora`.

### Navegación General y Ventanas

| Atajo             | Acción                                                                  |
| ----------------- | ----------------------------------------------------------------------- |
| `<Líder> t`       | Muestra/Oculta la terminal flotante.                                    |
| `<Shift> + H/J/K/L` | Mueve el foco entre ventanas (izquierda/abajo/arriba/derecha).            |
| `<Shift> + Flechas` | Redimensiona la ventana actual.                                         |
| `H/J/K/L` (Normal)  | Mueve el foco entre el editor y la terminal.                            |
| `H/J/K/L` (Terminal)| Vuelve al modo normal y mueve el foco a la ventana adyacente.           |

### Gestión de Archivos (NvimTree)

*Estos atajos solo funcionan con el foco en NvimTree.*

| Atajo | Acción                        |
| ----- | ----------------------------- |
| `L`   | Abrir archivo o expandir carpeta. |
| `H`   | Volver a la carpeta padre.    |
| `J/K` | Moverse entre archivos.       |
| `a`   | Crear archivo/carpeta.        |
| `r`   | Renombrar.                    |
| `d`   | Eliminar.                     |
| `x`   | Cortar.                       |
| `y`   | Copiar.                       |
| `p`   | Pegar.                        |

### Edición y LSP

| Atajo          | Acción                                       |
| -------------- | -------------------------------------------- |
| `kj` / `KJ`    | Salir del modo inserción (alternativa a `Esc`). |
| `<Líder> f`    | Formatear el archivo o la selección actual.  |
| `gd`           | Ir a la definición.                          |
| `K`            | Mostrar documentación (hover).               |
| `<Líder> ca`   | Ver acciones de código disponibles.          |
| `<Líder> rn`   | Renombrar símbolo.                           |
| `<C-c>` (Visual) | Copiar al portapapeles del sistema.          |
| `<C-v>`        | Pegar desde el portapapeles del sistema.     |

### Salida

| Atajo       | Comando     | Acción                                     |
| ----------- | ----------- | ------------------------------------------ |
| `<Líder> q` | `:Q` / `:q` | Salir de la ventana actual (con confirmación). |
| `<Líder> qa`| `:Qa` / `:qa`| Salir de Neovim (con confirmación).        |

## Plugins y Configuración

### Plugins Añadidos

-   **[mason.nvim](https://github.com/williamboman/mason.nvim)**: Para gestionar LSPs, formateadores y linters.
-   **[mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim)**: Puente entre Mason y `nvim-lspconfig`.
-   **[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)**: Configuración base para los LSPs.
-   **[nvim-cmp](https://github.com/hrsh7th/nvim-cmp)**: Motor de autocompletado.
-   **[LuaSnip](https://github.com/L3MON4D3/LuaSnip)**: Motor de snippets.
-   **[null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim)**: Para integrar formateadores y linters que no son LSPs (reemplazado en parte por `conform.nvim`).
-   **[Comment.nvim](https://github.com/numToStr/Comment.nvim)**: Para comentar código fácilmente (`gcc`, `gc`).
-   **[gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)**: Muestra indicadores de cambios de Git en el lateral.

### Servidores de Lenguaje (LSP)

Los siguientes LSPs están configurados para instalarse automáticamente a través de Mason:

-   `lua_ls`: Para Lua.
-   `pyright`: Para Python.
-   `tsserver`: Para TypeScript/JavaScript.
-   `rust_analyzer`: Para Rust.
-   `gopls`: Para Go.
-   `html`: Para HTML.
-   `cssls`: Para CSS.
-   `jsonls`: Para JSON.
-   `yamlls`: Para YAML.
-   `bashls`: Para Bash.

### Formateadores

La configuración de `conform.nvim` está preparada para usar:

-   `stylua`: Para Lua.
-   `black`: Para Python.
-   `prettier`: Para web (HTML, CSS, JS, etc.).