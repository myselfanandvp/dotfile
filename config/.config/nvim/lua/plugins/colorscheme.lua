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
