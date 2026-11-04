return {
  {
    "folke/noice.nvim",
    opts = {
      routes = {
        {
          filter = {
            event = "lsp",
            kind = "progress",
          },
          opts = {
            skip = true,
          },
        },
      },
      views = {
        cmdline_popup = {
          position = {
            row = "50%",
            col = "50%",
          },
        },
      },
    },
  },
}
