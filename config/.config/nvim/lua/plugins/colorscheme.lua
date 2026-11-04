return {
  "EmmanuelVernet/tokyoppuccin.nvim",
  lazy = false,
  priority = 1000,
  opts = {}, -- see Config; lazy.nvim passes this to setup()
  config = function(_, opts)
    require("tokyoppuccin").setup(opts)
    vim.cmd.colorscheme("tokyoppuccin")
  end,
}

-- return {
--   {
--     "Mofiqul/vscode.nvim",
--     lazy = false,
--     priority = 1000,
--     opts = {},
--     config = function(_, opts)
--       require("vscode").setup(opts)
--       vim.cmd.colorscheme("vscode")
--     end,
--   },
--   {
--     "LazyVim/LazyVim",
--     opts = {
--       colorscheme = "vscode",
--     },
--   },
-- }
--
