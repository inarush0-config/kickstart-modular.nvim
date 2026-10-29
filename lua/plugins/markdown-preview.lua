return {
  'sammaji/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  ft = { 'markdown' },
  opts = {
    markdown_css = vim.fn.stdpath('config') .. '/assets/mkdp-markdown.css',
  },
}
