return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",

  init = function()
    vim.fn.mkdir(vim.fn.expand("~/vaults/personal"), "p")
    vim.fn.mkdir(vim.fn.expand("~/vaults/work"), "p")
  end,

  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = "personal",
        path = "~/vaults/personal",
      },
      {
        name = "work",
        path = "~/vaults/work",
      },
    },
  },
}
