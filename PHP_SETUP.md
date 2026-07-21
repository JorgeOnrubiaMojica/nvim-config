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

Ajustá la versión de PHP en `lua/plugins/lsp.lua`:

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

### Vía Mason (automático al abrir Neovim)
- `intelephense`
- `phpstan`
- `php-cs-fixer`

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
1. Verificá instalación: `:PhpactorStatus`
2. Update phpactor: `:PhpactorUpdate`

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
