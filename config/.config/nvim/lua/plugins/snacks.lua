return {
  {
    "folke/snacks.nvim",
    opts = {
      terminal = {
        win = {
          keys = {
            term_normal = {
              "<esc>",
              "<c-\\><c-n>",
              mode = "t",
              desc = "Enter Normal Mode",
            },
          },
        },
      },
    },
  },
}
