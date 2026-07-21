# Setup Híbrido PHP - Intelephense + Phpactor

## Stack instalado

### LSP Principal: **Intelephense**
- Completado de código superior
- Mejor performance en proyectos grandes
- Goto definition/references más preciso
- Diagnósticos en tiempo real

### Refactoring: **Phpactor**
- Extract method/variable
- Generate getters/setters
- Import classes automático
- Create/move/copy files con namespace updates

### Testing: **Neotest + neotest-phpunit**
- Correr tests desde Neovim
- Ver resultados inline
- Output integrado

---

## Keymaps principales

### LSP (Intelephense)
- `gd` → Go to definition (con FzfLua)
- `gD` → Go to declaration
- `gI` → Go to implementation
- `gr` → Find references (con FzfLua)
- `K` → Hover documentation
- `<C-k>` → Signature help
- `<leader>rn` → Rename symbol
- `<leader>ca` → Code actions
- `<leader>am` → Code actions (FzfLua)
- `[d` / `]d` → Previous/Next diagnostic
- `<leader>e` → Show diagnostic float
- `<leader>f` → Format document (si LSP soporta)

### Phpactor (refactoring avanzado)
- `<leader>pm` → Phpactor context menu (menú con todas las opciones)
- `<leader>pn` → Create new class
- `<leader>pe` → Extract method (modo visual)
- `<leader>pi` → Import class under cursor
- `<leader>pg` → Generate getters/setters
- `<leader>pc` → Copy file (con namespace update)
- `<leader>pv` → Move file (con namespace update)
- `<leader>pt` → Transform code (conversiones automáticas)

### Testing (Neotest)
- `<leader>tt` → Run nearest test
- `<leader>tf` → Run test file
- `<leader>ts` → Toggle test summary
- `<leader>to` → Show test output

### Refactoring (refactoring.nvim)
- `<leader>ef` → Extract function (normal/visual)
- `<leader>iv` → Inline variable (normal/visual)

---

## Snippets PHP mejorados

### Clases y estructuras
- `class` → PHP class con declare(strict_types=1)
- `fclass` → Final class
- `interface` → Interface
- `trait` → Trait
- `enum` → Enum (PHP 8.1+)

### Funciones
- `pubf` → Public function con tipo de retorno
- `prif` → Private function
- `prof` → Protected function
- `pubsf` → Public static function
- `__con` → Constructor
- `__conp` → Constructor con promoted properties (PHP 8+)
- `__inv` → Invoke method

### Testing
- `test` → PHPUnit test method
- `aseq` → assertEquals
- `ast` → assertTrue
- `asf` → assertFalse
- `ass` → assertSame

### Symfony específico
- `symcon` → Symfony controller completo con Route attribute
- `route` → Route attribute

### Documentación
- `doc` → PHPDoc para función
- `docc` → PHPDoc para clase

### Otros
- `rop` → Readonly property (PHP 8.1+)
- `fore` → Foreach loop
- `try` → Try-catch block

---

## Configuración de Intelephense

### Licencia Premium (opcional)

Si tenés licencia de Intelephense, configurala así:

1. **Agregá la licencia como variable de entorno** (recomendado):

```bash
# En ~/.zshrc o ~/.bashrc
export INTELEPHENSE_LICENCE_KEY="tu-licencia-aqui"

# Recargá la config
source ~/.zshrc
```

2. **Verificá que se leyó**:
```bash
echo $INTELEPHENSE_LICENCE_KEY
```

3. **Reiniciá Neovim** → La config ya lee automáticamente la variable de entorno

### Features premium que desbloquea la licencia:
- Rename con preview interactivo
- Code folding mejorado
- Workspace symbols más rápido y preciso

### Versión de PHP

Ajustá la versión en `lua/plugins/lsp.lua`:

```lua
environment = {
  phpVersion = '8.2', -- Cambiá esto a tu versión
},
```

### Directorios excluidos por defecto:
- `**/node_modules/**`
- `**/vendor/**/Tests/**`
- `**/vendor/**/tests/**`

---

## Comandos útiles de Phpactor

Desde línea de comandos:

- `:PhpactorContextMenu` → Menú interactivo con todas las opciones
- `:PhpactorClassNew` → Crear nueva clase
- `:PhpactorImportClass` → Importar clase bajo cursor
- `:PhpactorGenerateAccessors` → Generar getters/setters
- `:PhpactorExtractMethod` → Extraer método (en modo visual)
- `:PhpactorCopyFile` → Copiar archivo actual
- `:PhpactorMoveFile` → Mover archivo actual
- `:PhpactorTransform` → Aplicar transformaciones de código

---

## Instalación de herramientas externas

### Intelephense
- Se instala automáticamente vía Mason al abrir Neovim
- Verificá: `:Mason` → buscar "intelephense"

### Phpactor
- Plugin oficial: `phpactor/phpactor`
- Al abrir Neovim por primera vez, lazy.nvim ejecuta automáticamente:
  ```bash
  composer install --no-dev --optimize-autoloader
  ```
- **Requiere composer instalado en el sistema**
- Si hay error, ejecutá manualmente: `:Lazy build phpactor`
- Verificá que funciona: `:PhpactorStatus`

### Herramientas adicionales vía Mason
- `phpstan` → Análisis estático
- `php-cs-fixer` → Formateo de código

### Vía Composer (recomendado para el proyecto)
```bash
# En el proyecto Symfony
composer require --dev phpstan/phpstan
composer require --dev friendsofphp/php-cs-fixer
```

### Vía Composer Global (para uso global)
```bash
composer global require phpstan/phpstan
composer global require friendsofphp/php-cs-fixer
```

---

## Troubleshooting

### Intelephense no arranca
1. Verificá que esté instalado: `:Mason`
2. Mirá logs: `:LspInfo`
3. Reiniciá el LSP: `:LspRestart`

### Phpactor no funciona

**Problema: "command not found" o comandos `:Phpactor*` no existen**

1. Verificá que composer esté instalado:
   ```bash
   which composer
   ```

2. Buildea manualmente el plugin:
   ```vim
   :Lazy build phpactor
   ```

3. Verificá el estado:
   ```vim
   :PhpactorStatus
   ```

4. Si sigue fallando, revisá logs:
   ```vim
   :Lazy log phpactor
   ```

**Problema: Phpactor funciona pero comandos específicos fallan**

- Algunos comandos requieren estar en un archivo PHP válido
- Otros requieren que el proyecto tenga `composer.json`
- `:PhpactorContextMenu` te muestra solo opciones disponibles para el contexto actual

### Tests no corren
1. Verificá que exista `vendor/bin/phpunit` en tu proyecto
2. Ajustá el comando en `lua/plugins/php.lua` si usás otro path

---

## Workflow recomendado

1. **Navegación de código**: Usar Intelephense (gd, gr, K)
2. **Refactoring simple**: LSP rename (`<leader>rn`)
3. **Refactoring avanzado**: Phpactor context menu (`<leader>pm`)
4. **Testing**: Neotest para correr tests (`<leader>tt`)
5. **Import rápido**: Phpactor import (`<leader>pi`)

---

## Diferencias vs setup anterior

### ✅ Agregado
- Intelephense como LSP principal
- Phpactor para refactoring (sin LSP)
- Neotest configurado correctamente
- 30+ snippets nuevos (enums, traits, promoted properties, etc.)
- LSP keymaps completos
- Mason auto-instalación de herramientas

### ❌ Removido
- `phpantom_lsp` (era experimental)
- `tsserver` y `vtsls` duplicados (dejamos solo tsserver)
- Mappings de testing viejos sin configuración

### 🔄 Mejorado
- Snippets con tipos de retorno
- PHPDoc automático
- Constructor con promoted properties (PHP 8+)
