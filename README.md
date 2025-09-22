# Neovim Configuration

A high-performance Neovim configuration optimized for DevOps and software
development workflows. Features lazy loading, comprehensive LSP support, and
seamless terminal integration.

## Performance

```text
  Startuptime: 113.98ms

  Based on the actual CPU time of the Neovim process till UIEnter.
  This is more accurate than `nvim --startuptime`.
    LazyStart 54.78ms
    LazyDone  100.6ms (+45.82ms)
    UIEnter   113.98ms (+13.37ms)
```

## Key Features

- **Languages**: Python, Go, Terraform, JavaScript/TypeScript, YAML, JSON, Lua, Bash, Docker
- **Tools**: LSP, debugging, formatting, git integration, fuzzy finding, file management
- **Integration**: Tmux navigation, database access, dotfile management
- **UI**: Gruvbox theme, which-key discovery, enhanced notifications

## File Structure

```
nvim/
├── init.lua                        # Entry point - loads core modules
├── lazy-lock.json                  # Locked plugin versions
├── lua/
│   ├── bootstrap.lua               # Plugin manager setup
│   ├── keymaps.lua                 # Core keybindings
│   ├── options.lua                 # Editor settings
│   └── plugins/                    # Plugin configurations
│       ├── lsp.lua                 # Language servers (15+ languages)
│       ├── telescope.lua           # Fuzzy finder
│       ├── treesitter.lua          # Syntax highlighting
│       ├── neo-tree.lua            # File explorer
│       ├── gitsigns.lua            # Git integration
│       ├── conform.lua             # Code formatting
│       ├── debug.lua               # DAP debugging
│       ├── grapple.lua             # File tagging
│       ├── blink.lua               # Completion engine
│       ├── oil.lua                 # Directory editor
│       ├── noice.lua               # Enhanced UI
│       ├── which-key.lua           # Keybinding discovery
│       ├── vim-tmux-navigator.lua  # Tmux integration
│       ├── terraform-doc.lua       # Terraform registry docs
│       ├── yaml-companion.lua      # YAML schemas
│       ├── chezmoi.lua             # Dotfile management
│       ├── dadbod.lua              # Database interface
│       ├── mini.lua                # Text objects & utilities
│       └── ...                     # Additional plugins
├── ftplugin/                       # Filetype-specific settings
│   └── python.lua                  # Python debugging keybinds
├── ftdetect/                       # Custom filetype detection
│   ├── terraform.lua               # .tfvars detection
│   ├── docker.lua                  # Dockerfile patterns
│   └── cloudformation.lua          # AWS template detection
└── .amazonq/                       # Memory bank documentation
    ├── projectbrief.md             # Project overview
    ├── productContext.md           # User experience goals
    ├── systemPatterns.md           # Architecture patterns
    ├── techContext.md              # Technology stack
    ├── activeContext.md            # Current state
    └── progress.md                 # Completion status
```

## Quick Start

1. **Prerequisites**: Neovim 0.9+, Git, Node.js, Python, Go
2. **Clone**: `git clone <repo> ~/.config/nvim`
3. **Launch**: `nvim` (plugins auto-install on first run)
4. **Discover**: Press `<Space>` to see available commands

## Key Bindings

- `<Space>`: Leader key for all custom commands
- `<Space>sf`: Find files
- `<Space>sg`: Live grep
- `<Space>sb`: Switch buffers
- `<C-e>`: Toggle file explorer
- `<Space>m`: Tag file with Grapple
- `<Space>k`: Show tagged files

## Architecture

Built on lazy loading principles with modular plugin architecture. Each plugin
loads only when needed, ensuring fast startup while maintaining full
functionality.
