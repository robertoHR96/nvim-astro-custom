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
    *   Se requiere un JDK para `jdtls` (Java).

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

## Atajos de Teclado

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
