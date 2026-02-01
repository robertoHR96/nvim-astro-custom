# Mi Configuración Personal de AstroNvim: Una Guía Completa

Este repositorio contiene mi configuración personal de Neovim, construida sobre la base de [AstroNvim](https://astronvim.com/). El objetivo es crear un entorno de desarrollo moderno, portátil y altamente productivo que se sienta como un IDE completo pero manteniendo la velocidad y eficiencia de Vim.

## La Filosofía de esta Configuración

Esta no es una configuración minimalista. El enfoque es "baterías incluidas", buscando un equilibrio entre funcionalidades avanzadas y rendimiento. La filosofía se basa en tres pilares:

1.  **Eficiencia del Flujo de Trabajo**: La configuración está diseñada para minimizar la fricción. Tareas comunes como navegar entre el código y la terminal, gestionar archivos, formatear y obtener ayuda del LSP deben ser instantáneas.
2.  **Inteligencia del Entorno (IDE-like)**: Gracias a la integración profunda con LSPs (Language Server Protocol) a través de Mason, el editor "entiende" el código, proporcionando autocompletado, diagnósticos, definiciones y refactorización de forma nativa.
3.  **Seguridad y Consistencia**: Características como la "salida con confirmación" evitan la pérdida de trabajo, mientras que los formateadores automáticos aseguran un estilo de código consistente en todos los proyectos.

## El Flujo de Trabajo Diario

Esta configuración está pensada para ser usada de una manera específica para maximizar la productividad.

### Al Iniciar Neovim

Al ejecutar `nvim`, el entorno se prepara automáticamente para una sesión de codificación:
-   A la izquierda, se abre el explorador de archivos **NvimTree**.
-   A la derecha, el cursor se posiciona en una ventana de editor vacía, lista para trabajar.
-   En la parte inferior, se despliega una **terminal flotante**, ideal para ejecutar comandos de Git, scripts o servidores de desarrollo.
-   El foco inicial está en la ventana del editor, permitiéndote empezar a escribir o abrir un archivo inmediatamente.

### Navegación: El Corazón de la Configuración

La navegación entre ventanas es una de las personalizaciones más importantes:
-   Usa **`H`, `J`, `K`, `L`** (sin Shift) para moverte de forma inteligente entre el editor y la terminal. Si te mueves hacia la terminal, entrarás en modo inserción automáticamente. Si estás en la terminal, usar estas teclas te devolverá al modo normal y te moverá a la ventana del editor.
-   Usa **`<Shift> + H/J/K/L`** para mover el foco entre cualquier división de ventana, siguiendo la lógica de Vim (izquierda, abajo, arriba, derecha).

### Edición y Programación

-   **Autocompletado Inteligente**: Simplemente empieza a escribir. `nvim-cmp` te ofrecerá sugerencias del LSP, los buffers abiertos y snippets. Usa `<Tab>` y `<S-Tab>` para navegar y `<CR>` para confirmar.
-   **Ayuda del LSP**: Usa `gd` para saltar a la definición, `K` para ver la documentación de una función o tipo, y `<Líder> ca` para ver acciones de código contextuales (como "extraer a una variable").
-   **Formateo**: Olvídate del formato manual. Usa `<Líder> f` para formatear el archivo actual según las reglas de `prettier`, `stylua`, etc.
-   **Gestión de Archivos**: Realiza todas las operaciones de archivos (crear, renombrar, eliminar) desde NvimTree usando los atajos intuitivos (`a`, `r`, `d`).

---

## Instalación Detallada

#### Paso 1: Requisitos Previos

Asegúrate de tener todo lo necesario.

-   **Neovim**: Versión `0.9.0` o superior.
-   **Git**: Esencial para clonar y para que `lazy.nvim` gestione los plugins.
-   **Nerd Font**: Para que los iconos de la UI y los plugins se vean correctamente. Recomiendo [FiraCode Nerd Font](https://www.nerdfonts.com/font-downloads).
-   **Herramientas de Build y Runtimes**: Los LSPs y formateadores son programas externos. Necesitarás los runtimes de los lenguajes que uses.
    -   `node` y `npm`: Para `tsserver`, `prettier`, `jsonls`, etc.
    -   `python`: Para `pyright`, `black`.
    -   `go`: Para `gopls`.
    -   `rustup`: Para `rust_analyzer`.
    -   Un **JDK** (Java Development Kit): Para `jdtls`.

#### Paso 2: Copia de Seguridad (Recomendado)

```bash
# Mueve tu configuración actual a una carpeta de respaldo
mv ~/.config/nvim ~/.config/nvim.bak
```

#### Paso 3: Clonación de la Configuración

```bash
git clone https://github.com/tu-usuario/tu-repositorio.git ~/.config/nvim
```
*(No olvides reemplazar la URL por la de tu repositorio)*

#### Paso 4: Primer Inicio - ¡Paciencia!

La primera vez que ejecutes `nvim`, ocurrirán varias cosas automáticamente:
1.  **Instalación de `lazy.nvim`**: El gestor de plugins se auto-instalará.
2.  **Sincronización de Plugins**: `lazy.nvim` leerá tu configuración y procederá a descargar e instalar todos los plugins. Verás su interfaz en pantalla.
3.  **Instalación de LSPs y Formateadores**: Una vez los plugins estén instalados, `mason.nvim` empezará a descargar e instalar todos los LSPs y herramientas definidas en `lua/plugins/init.lua`. Esto puede tardar varios minutos y requiere conexión a internet.

> Puedes ver el progreso de Mason ejecutando el comando `:Mason`.

---

## Anatomía de la Configuración

Entender la estructura de archivos es clave para poder modificar y mantener la configuración.

-   `init.lua` (**El Cerebro**): Es el punto de entrada. Se encarga de:
    -   Establecer opciones globales de Neovim.
    -   Cargar el gestor de plugins `lazy.nvim`.
    -   Definir la lógica de "salida con confirmación".
    -   Orquestar el layout de inicio (NvimTree + Terminal).
    -   Cargar el resto de archivos de configuración en el orden correcto.

-   `lua/chadrc.lua` (**El Estilo**): Este es el archivo estándar de AstroNvim para configurar la **interfaz de usuario (UI)**. Aquí es donde se define el tema (`gatekeeper`), las fuentes, y otros aspectos visuales.

-   `lua/plugins/init.lua` (**La Caja de Herramientas**): Aquí se define la lista de todos los plugins *adicionales* que no vienen con AstroNvim base. Cada entrada en la tabla `return` es un plugin. Algunos de los más importantes que has añadido son:
    -   `mason.nvim`: Un gestor universal para instalar y gestionar LSPs, linters y formateadores.
    -   `mason-lspconfig.nvim`: Un puente que le dice a `lspconfig` que use los servidores que Mason instala.
    -   `nvim-cmp`: El motor de autocompletado.
    -   `null-ls.nvim` / `conform.nvim`: Herramientas para registrar y ejecutar formateadores de código.

-   `lua/configs/` (**La Sala de Control**): Este directorio contiene los archivos que configuran los plugins definidos en `lua/plugins/init.lua`.
    -   `lspconfig.lua`: Contiene la configuración específica para cada servidor de lenguaje (LSP).
    -   `cmp.lua`: Define el comportamiento del menú de autocompletado, sus atajos y sus fuentes.
    -   `conform.lua`: Especifica qué formateador (`prettier`, `stylua`, etc.) se debe usar para cada tipo de archivo.

-   `lua/mappings.lua` (**El Mapa de Atajos**): Aquí se definen tus atajos de teclado personalizados y globales.

---

## Personalización

Esta configuración es un punto de partida. Aquí tienes cómo puedes adaptarla a tus necesidades.

#### Cambiar el Tema

1.  Encuentra un tema compatible con `base46` (la mayoría de temas populares lo son).
2.  Edita `lua/chadrc.lua` y cambia el valor de `M.base46.theme`. Por ejemplo:
    ```lua
    M.base46.theme = "catppuccin"
    ```

#### Añadir un Nuevo Plugin

1.  Abre `lua/plugins/init.lua`.
2.  Añade una nueva entrada a la tabla. Para un plugin de GitHub, sería:
    ```lua
    {
      "autor/nombre-del-plugin",
      -- Opcional: si el plugin necesita configuración
      config = function()
        require("nombre-del-plugin").setup({ ... })
      end,
    }
    ```
3.  Reinicia Neovim y `lazy.nvim` lo instalará.

#### Añadir un Nuevo LSP o Formateador

El proceso suele ser de dos pasos:

1.  **Instalación**: Abre `lua/plugins/init.lua` y busca la sección de `mason-lspconfig`. Añade el nombre del paquete de Mason a la lista `ensure_installed`. Por ejemplo, para `dockerls`:
    ```lua
    ensure_installed = { "lua_ls", "pyright", ..., "dockerls" },
    ```
2.  **Configuración**:
    -   **Para un LSP**: Abre `lua/configs/lspconfig.lua` y añade su `setup`, siguiendo el patrón de los demás.
        ```lua
        lspconfig.dockerls.setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
        ```
    -   **Para un Formateador**: Abre `lua/configs/conform.lua` y añade una entrada en `formatters_by_ft`.
        ```lua
        formatters_by_ft = {
          ...,
          dockerfile = { "hadolint" }, -- Suponiendo que 'hadolint' es el formateador
        },
        ```

---
## Atajos de Teclado (Guía Completa)

*(Esta sección se mantiene igual que la versión anterior, ya que es exhaustiva)*

La tecla `Líder` está mapeada a la **Barra espaciadora**.

> **Nota Importante**: La gran mayoría de estos atajos son universales y funcionarán igual en Windows, macOS y Linux. Las diferencias o problemas suelen venir del programa "Terminal" que utilices, no de la configuración de Neovim. Consulta las **Notas de Compatibilidad** al final de esta sección.

### Navegación y Gestión de Ventanas

| Atajo                 | Modo(s)      | Acción                                                       |
| --------------------- | ------------ | ------------------------------------------------------------ |
| `<Shift> + H/J/K/L`   | Normal       | Mover el foco entre ventanas (izquierda/abajo/arriba/derecha). |
| `H/J/K/L`             | Normal       | Mover foco al editor/terminal adyacente (y entra en modo inserción si es terminal). |
| `H/J/K/L`             | Terminal     | Salir de modo terminal y mover el foco a la ventana adyacente. |
| `<Shift> + Flechas`   | Normal       | Redimensionar la ventana actual.                             |
| `<Líder> t`           | Normal, Terminal | Muestra/Oculta la terminal flotante.                         |

### Edición de Código

| Atajo       | Modo(s)      | Acción                                                       |
| ----------- | ------------ | ------------------------------------------------------------ |
| `kj` o `KJ` | Inserción    | Salir del modo inserción (alternativa a `<Esc>`).            |
| `;`         | Normal       | Entrar en modo de comandos (reemplaza a `:`).                |
| `<C-v>`     | Normal, Inserción | Pegar desde el portapapeles del sistema.                     |
| `<C-c>`     | Visual       | Copiar la selección al portapapeles del sistema.             |
| `<Líder> f` | Normal, Visual | Formatear el archivo completo o la selección actual.         |

### Autocompletado (nvim-cmp)

| Atajo       | Modo      | Acción                                  |
| ----------- | --------- | --------------------------------------- |
| `<C-Space>` | Inserción | Activar el menú de autocompletado.      |
| `<CR>`      | Inserción | Confirmar la selección.                 |
| `<Tab>`     | Inserción | Seleccionar el siguiente ítem del menú. |
| `<S-Tab>`   | Inserción | Seleccionar el ítem anterior del menú.  |
| `<C-e>`     | Inserción | Abortar el autocompletado.              |
| `<C-b>`/`<C-f>` | Inserción | Desplazarse por la documentación (scroll). |

### Funciones de LSP (Language Server)

| Atajo        | Modo   | Acción                                |
| ------------ | ------ | ------------------------------------- |
| `gd`         | Normal | Ir a la definición de lo que está bajo el cursor. |
| `K`          | Normal | Mostrar documentación (hover).        |
| `gi`         | Normal | Ir a la implementación.               |
| `gr`         | Normal | Mostrar referencias del símbolo.       |
| `<Líder> rn` | Normal | Renombrar el símbolo en todo el proyecto. |
| `<Líder> ca` | Normal | Ver acciones de código disponibles (ej. "extraer a función"). |

### Gestión de Archivos (NvimTree)

*Estos atajos solo funcionan con el foco en el explorador de archivos NvimTree.*

| Atajo | Modo   | Acción                        |
| ----- | ------ | ----------------------------- |
| `L` o `<CR>` | Normal | Abrir archivo o expandir carpeta. |
| `H`   | Normal | Volver a la carpeta padre.    |
| `J/K` | Normal | Moverse entre archivos.       |
| `a`   | Normal | Crear archivo/carpeta.        |
| `r`   | Normal | Renombrar.                    |
| `d`   | Normal | Eliminar.                     |
| `x`   | Normal | Cortar.                       |
| `y`   | Normal | Copiar.                       |
| `p`   | Normal | Pegar.                        |

### Salida de Neovim

| Atajo        | Modo   | Acción                                     |
| ------------ | ------ | ------------------------------------------ |
| `<Líder> q`  | Normal | Salir de la ventana actual (con confirmación si hay cambios). |
| `<Líder> qa` | Normal | Salir de Neovim (con confirmación si hay cambios). |

---

### Notas sobre Compatibilidad entre Sistemas Operativos

Tu configuración de Neovim es universal. Si un atajo no funciona, casi siempre el problema está en el **programa de Terminal** que usas, que "intercepta" la combinación de teclas antes de que llegue a Neovim.

Aquí tienes los casos más comunes y cómo solucionarlos:

-   **Atajo `<C-Space>` (Autocompletado)**:
    -   **Problema**: Muchos terminales en Linux y macOS no envían una señal única para `<C-Space>`, por lo que Neovim no lo detecta. En Windows, a veces está reservado para cambiar el idioma del teclado.
    -   **Solución**: Si no te funciona, puedes cambiarlo en `lua/configs/cmp.lua`. Una alternativa común y universal es `<C-e>` (aunque en esta config se usa para abortar) o mapear otra combinación que te sea cómoda.

-   **Atajos con `Shift + Flechas` (Redimensionar ventanas)**:
    -   **Problema**: En algunos terminales de Linux, esto puede estar asignado a otra función.
    -   **Solución**: Generalmente funciona bien, pero si falla, deberás buscar en las preferencias de tu terminal cómo deshabilitar ese atajo específico para que la combinación llegue a Neovim.

-   **Atajos con la tecla `Alt` (No usados en esta config)**:
    -   **Contexto**: Esta configuración no usa la tecla `Alt` (`<A-...>`) para evitar problemas, pero es bueno saberlo.
    -   **Problema**: En **macOS**, la tecla `Option` (equivalente a `Alt`) se usa para escribir caracteres especiales (ej. `Option + n` = `˜`). En **Linux**, a veces se usa para mover las ventanas del sistema operativo.
    -   **Solución**: Si en el futuro añades un atajo con `Alt`, en macOS y algunos terminales de Linux necesitarás configurar el terminal para que envíe la tecla `Option`/`Alt` como "Meta" o "Esc+".

-   **Atajos `<C-c>` y `<C-v>` (Copiar/Pegar)**:
    -   **Contexto**: Esta configuración los remapea para usar el portapapeles del sistema de forma integrada en Neovim.
    -   **Comportamiento**: Esto es intencional y funciona en todos los SO, pero anula el comportamiento por defecto de algunos terminales (donde `<C-c>` cancela un proceso). Dentro de Neovim, esto no es un problema.