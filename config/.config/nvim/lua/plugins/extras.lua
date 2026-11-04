return {
  -- Add CSS to TreeSitter for accurate syntax and indentation
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "css",
        "scss",
      },
    },
  },

  -- Enable CSS Language Server (css-lsp) for suggestions
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        cssls = {}, -- CSS language server
        tailwindcss = {}, -- (Optional) Uncomment if you use Tailwind CSS
      },
    },
  },
}
