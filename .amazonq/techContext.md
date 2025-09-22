# Technical Context - Neovim Configuration

## Technology Stack

### Core Platform
- **Neovim**: Latest stable version (0.9+)
- **Lua**: Primary configuration language
- **Lazy.nvim**: Plugin manager for performance optimization
- **Mason**: LSP server and tool management

### Plugin Ecosystem

#### Core Infrastructure
- **lazy.nvim**: Plugin manager with lazy loading
- **plenary.nvim**: Lua utility library (dependency for many plugins)
- **nui.nvim**: UI component library

#### Language Support & LSP
- **nvim-lspconfig**: LSP client configuration
- **mason.nvim**: LSP server installer
- **mason-lspconfig.nvim**: Bridge between Mason and LSP config
- **blink.cmp**: Completion engine
- **fidget.nvim**: LSP progress indicator

#### Syntax & Parsing
- **nvim-treesitter**: Syntax highlighting and parsing
- **nvim-treesitter-context**: Show code context
- **nvim-treesitter-textobjects**: Enhanced text objects

#### File Management & Navigation
- **telescope.nvim**: Fuzzy finder and picker
- **telescope-fzf-native.nvim**: Native FZF integration
- **neo-tree.nvim**: File explorer
- **oil.nvim**: Directory editor
- **grapple.nvim**: Project file tagging

#### Git Integration
- **gitsigns.nvim**: Git status in sign column
- **Telescope git integration**: Git history and commits

#### Development Tools
- **conform.nvim**: Code formatting
- **nvim-dap**: Debug Adapter Protocol
- **nvim-dap-ui**: Debug UI
- **nvim-dap-go**: Go debugging
- **nvim-dap-python**: Python debugging

#### UI & UX
- **which-key.nvim**: Keybinding discovery
- **noice.nvim**: Enhanced UI for messages and cmdline
- **gruvbox.nvim**: Color scheme
- **nvim-web-devicons**: File type icons

#### Productivity
- **mini.nvim**: Collection of small utilities
  - mini.ai: Enhanced text objects
  - mini.surround: Surround operations
  - mini.comment: Commenting
  - mini.move: Move lines/blocks
  - mini.align: Text alignment
- **nvim-autopairs**: Auto-close brackets
- **neoclip.lua**: Clipboard manager

#### Specialized Tools
- **vim-dadbod**: Database interface
- **vim-dadbod-ui**: Database UI
- **chezmoi.nvim**: Dotfile management
- **yaml-companion.nvim**: YAML schema support
- **telescope-terraform-doc.nvim**: Terraform documentation via registry API

## Language Server Configuration

### Supported Languages & Servers

#### Infrastructure & DevOps
- **Terraform**: `terraformls` - Formatting, validation, completion
- **Docker**: `dockerls` - Dockerfile support
- **YAML**: `yamlls` - Schema validation, CloudFormation support
- **JSON**: `jsonls` - Schema validation via schemastore
- **Bash**: `bashls` - Shell script support

#### Programming Languages
- **Python**: 
  - `basedpyright` - Type checking and analysis
  - `ruff` - Linting and formatting
- **Go**: 
  - `gopls` - Official Go language server
  - `golangci_lint_ls` - Additional linting
- **JavaScript/TypeScript**: `ts_ls` - Language support
- **Lua**: `lua_ls` - Neovim configuration support
- **PHP**: `phpactor` - PHP development
- **Markdown**: `marksman` - Documentation support

#### Specialized
- **Cypher**: `cypher_ls` - Neo4j query language
- **Templ**: `templ` - Go templating
- **Svelte**: `svelte` - Frontend framework

## Development Environment

### External Dependencies

#### Required Tools
- **Git**: Version control
- **Node.js**: For various LSP servers and tools
- **Python**: For Python development and some tools
- **Go**: For Go development
- **Make**: For building native extensions

#### Optional Tools
- **fd**: Fast file finder (fallback to find)
- **rg (ripgrep)**: Fast text search
- **tmux**: Terminal multiplexer integration
- **chezmoi**: Dotfile management

### File Type Associations

#### Custom Filetype Detection
- **Terraform**: `.tf`, `.tfvars`, `.tfstate` files
- **HCL**: `.hcl` files and Terraform lock files
- **Docker**: Dockerfile patterns
- **CloudFormation**: YAML files with AWS template format
- **Cypher**: `.cypher` files

#### Language-Specific Settings
- **Terraform**: 2-space indentation
- **Python**: 4-space indentation, spell check enabled
- **YAML**: Schema validation, custom tags for CloudFormation

## Performance Optimizations

### Startup Performance
- **Lazy Loading**: Plugins load only when needed
- **Disabled Plugins**: Unused built-in plugins disabled
- **Module Caching**: Lua module caching enabled
- **RTP Optimization**: Minimal runtime path

### Runtime Performance
- **Treesitter**: Incremental parsing for large files
- **LSP**: Debounced updates and efficient diagnostics
- **File Watching**: Optimized file system watchers
- **Completion**: Fast completion with blink.cmp

### Memory Management
- **Event-Based Loading**: Plugins load on specific events
- **Conditional Loading**: Work-specific plugins only when needed
- **Resource Cleanup**: Proper cleanup of unused resources

## Configuration Management

### Modular Architecture
- **Core Configuration**: Essential settings in separate files
- **Plugin Configuration**: One file per major plugin
- **Filetype Configuration**: Language-specific settings
- **Local Overrides**: Git-ignored local customizations

### Version Control
- **Git Repository**: Full configuration under version control
- **Lock File**: `lazy-lock.json` for reproducible plugin versions
- **Ignored Files**: Local overrides and generated files excluded

### Environment Adaptation
- **Conditional Loading**: Work plugins load only in work directory
- **Platform Detection**: macOS-specific optimizations
- **Feature Detection**: Graceful degradation when tools unavailable

## Integration Points

### Terminal Integration
- **Tmux Navigator**: Seamless pane navigation
- **Terminal Emulator**: Optimized for modern terminals
- **Shell Integration**: Proper shell command execution

### System Integration
- **Clipboard**: System clipboard integration
- **File System**: Native file operations
- **Process Management**: Background process handling

### External Tool Integration
- **Database**: Direct database connections via dadbod
- **Git**: Native git operations and history
- **Documentation**: Integrated help and documentation systems

## Security Considerations

### Plugin Security
- **Trusted Sources**: Plugins from reputable maintainers
- **Version Pinning**: Locked plugin versions for stability
- **Code Review**: Configuration changes reviewed before commit

### Data Protection
- **No Secrets**: No hardcoded credentials or sensitive data
- **Local Configuration**: Sensitive settings in git-ignored files
- **Secure Defaults**: Conservative security settings
