# System Patterns - Neovim Configuration

## Architecture Overview

The Neovim configuration follows a modular, lazy-loading architecture designed for performance and maintainability. The system is built around three core principles: modularity, performance, and extensibility.

## Core Architecture Patterns

### Lazy Loading Strategy
```
init.lua (minimal bootstrap)
├── options.lua (editor settings)
├── keymaps.lua (core keybindings)
└── bootstrap.lua (plugin manager setup)
    └── plugins/ (lazy-loaded plugin configurations)
```

### Plugin Organization Pattern
- **Single Responsibility**: Each plugin file configures one primary plugin
- **Dependency Management**: Explicit dependency declarations in plugin specs
- **Error Handling**: Graceful degradation when plugins fail to load
- **Conditional Loading**: Plugins load based on events, commands, or file types

### Configuration Layering
1. **Core Layer**: Essential editor behavior (options, keymaps)
2. **Bootstrap Layer**: Plugin manager and loading strategy
3. **Plugin Layer**: Feature-specific configurations
4. **Filetype Layer**: Language and file-specific customizations

## Key Design Patterns

### Error-Resilient Loading
```lua
local ok, module = pcall(require, 'module_name')
if not ok then
  vim.notify('Failed to load module: ' .. err, vim.log.levels.WARN)
  return
end
```

### Consistent Keybinding Structure
- `<leader>` prefix for custom commands
- Grouped keybindings by functionality (s=search, g=git, etc.)
- Which-key integration for discoverability
- Consistent patterns across plugins

### LSP Configuration Pattern
- Centralized server configuration in `lsp.lua`
- Per-language settings with filetype-specific options
- Automatic formatting on save for specific file types
- Telescope integration for LSP functions

### Plugin Specification Pattern
```lua
return {
  'plugin/name',
  event = 'LazyEvent',  -- When to load
  cmd = 'Command',      -- Commands that trigger loading
  ft = 'filetype',      -- Filetypes that trigger loading
  keys = { ... },       -- Keybindings that trigger loading
  dependencies = { ... }, -- Required plugins
  opts = { ... },       -- Plugin options
  config = function() end -- Custom configuration
}
```

## File Organization Patterns

### Directory Structure
```
nvim/
├── init.lua                 # Entry point
├── lua/
│   ├── options.lua         # Editor options
│   ├── keymaps.lua         # Core keybindings
│   ├── bootstrap.lua       # Plugin manager setup
│   └── plugins/            # Plugin configurations
│       ├── lsp.lua         # Language server setup
│       ├── telescope.lua   # Fuzzy finder
│       ├── treesitter.lua  # Syntax highlighting
│       └── ...
├── ftplugin/               # Filetype-specific settings
├── ftdetect/               # Custom filetype detection
└── after/                  # Post-load configurations
```

### Naming Conventions
- Plugin files named after primary plugin
- Descriptive function and variable names
- Consistent use of `opts` for plugin options
- Clear separation of concerns

## Integration Patterns

### Telescope Integration
- Consistent use of Telescope for all fuzzy finding
- LSP functions routed through Telescope
- Custom pickers for specialized workflows
- Unified search interface

### LSP Integration
- Mason for automatic server installation
- Consistent keybinding patterns across languages
- Blink.cmp for completion
- Fidget for progress indication

### Git Integration
- Gitsigns for inline git status
- Telescope for git history and commits
- Consistent git workflow patterns

### Terminal Integration
- Tmux navigator for seamless pane switching
- Oil for file system operations
- Integrated terminal workflows

## Performance Patterns

### Startup Optimization
- Minimal `init.lua` with essential-only loading
- Lazy loading based on actual usage patterns
- Disabled unused built-in plugins
- Optimized RTP (runtime path) management

### Memory Management
- Event-based plugin loading
- Conditional plugin loading based on environment
- Efficient caching strategies
- Resource cleanup patterns

### Loading Strategies
- **Event-based**: Load on specific Neovim events
- **Command-based**: Load when specific commands are used
- **Filetype-based**: Load for specific file types
- **Key-based**: Load when specific keys are pressed

## Error Handling Patterns

### Graceful Degradation
- Plugin loading failures don't break the entire config
- Fallback behaviors when optional dependencies are missing
- User notifications for important failures
- Continue operation with reduced functionality

### Validation Patterns
- Check for plugin availability before configuration
- Validate external dependencies (executables, etc.)
- Provide helpful error messages
- Suggest remediation steps

## Extensibility Patterns

### Plugin Addition
1. Create new file in `plugins/` directory
2. Follow established plugin specification pattern
3. Add appropriate loading triggers
4. Include error handling and validation

### Configuration Override
- Work-specific plugins in `plugins/work/` (conditionally loaded)
- Local overrides through git-ignored files
- Environment-based configuration switching

### Customization Points
- Centralized options in `options.lua`
- Modular keybinding system
- Pluggable LSP server configurations
- Extensible telescope pickers
