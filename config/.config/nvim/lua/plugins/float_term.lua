return {
  "akinsho/toggleterm.nvim",
  opts = {
    direction = "float",
    float_opts = {
      border = "rounded",
      width = 100,
      height = 20,
    },
    on_open = function(term)
      -- Esc: terminal mode -> normal mode
      vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], {
        buffer = term.bufnr,
        silent = true,
      })

      -- q: quit/kill this terminal instance
      vim.keymap.set("n", "q", function()
        term:shutdown()
      end, {
        buffer = term.bufnr,
        silent = true,
      })
    end,
  },
  keys = {
    {
      "<leader>ft",
      function()
        -- Get the absolute path of the current buffer's directory
        local current_dir = vim.fn.expand("%:p:h")

        -- Fallback to CWD if current buffer is not a valid file (e.g. empty buffer/dashboard)
        if current_dir == "" or vim.bo.buftype ~= "" then
          current_dir = vim.fn.getcwd()
        end

        require("toggleterm").toggle(nil, nil, current_dir, "float")
      end,
      desc = "Toggle floating terminal (file dir)",
    },
    {
      "<leader>fm",
      function()
        local Terminal = require("toggleterm.terminal").Terminal

        -- Get the existing terminal or create it once
        if not _G.my_float_terminal then
          _G.my_float_terminal = Terminal:new({
            direction = "float",
            float_opts = {
              border = "rounded",
              width = 100,
              height = 20,
            },
          })
        end

        _G.my_float_terminal:toggle()
      end,
      desc = "Minimize / restore floating terminal",
    },
  },
}
