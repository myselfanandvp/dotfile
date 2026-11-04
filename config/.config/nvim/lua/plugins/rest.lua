return {
  "heilgar/nvim-http-client",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
  },

  event = "VeryLazy",
  ft = { "http", "rest" },

  config = function()
    require("http_client").setup({
      default_env_file = ".env.json",

      request_timeout = 30000,

      -- Open response on the right
      split_direction = "right",

      -- Let the plugin create the keymaps
      create_keybindings = true,

      user_agent = "heilgar/nvim-http-client",

      profiling = {
        enabled = true,
        show_in_response = true,
        detailed_metrics = true,
      },

      keybindings = {
        select_env_file = "<leader>hf",
        set_env = "<leader>he",

        run_request = "<leader>hr",
        stop_request = "<leader>hx",

        toggle_verbose = "<leader>hv",
        toggle_profiling = "<leader>hp",

        dry_run = "<leader>hd",

        copy_curl = "<leader>hc",
        save_response = "<leader>hs",

        set_project_root = "<leader>hg",
        get_project_root = "<leader>hpg",
      },
    })

    ---------------------------------------------------------------------------
    -- Telescope
    ---------------------------------------------------------------------------

    if pcall(require, "telescope") then
      require("telescope").load_extension("http_client")
    end

    ---------------------------------------------------------------------------
    -- HTTP response buffer appearance
    ---------------------------------------------------------------------------

    vim.api.nvim_create_autocmd("BufWinEnter", {
      callback = function(args)
        local buf = args.buf

        if not vim.api.nvim_buf_is_valid(buf) then
          return
        end

        local name = vim.api.nvim_buf_get_name(buf)

        -- Only touch HTTP client response buffers.
        --
        -- The exact buffer name can change between plugin versions,
        -- so we use common HTTP response indicators.
        if not (name:lower():match("http") or name:lower():match("response")) then
          return
        end

        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = "no"
        vim.opt_local.wrap = true
        vim.opt_local.cursorline = true
        vim.opt_local.scrolloff = 5

        -- Don't show unnecessary UI elements
        vim.opt_local.foldcolumn = "1"
      end,
    })

    ---------------------------------------------------------------------------
    -- HTTP response window appearance
    ---------------------------------------------------------------------------

    vim.api.nvim_create_autocmd("WinEnter", {
      callback = function()
        local buf = vim.api.nvim_get_current_buf()

        if not vim.api.nvim_buf_is_valid(buf) then
          return
        end

        local name = vim.api.nvim_buf_get_name(buf):lower()

        if not (name:match("http") or name:match("response")) then
          return
        end

        -- Response window width
        vim.cmd("vertical resize 80")
      end,
    })

    ---------------------------------------------------------------------------
    -- Custom colors
    ---------------------------------------------------------------------------

    vim.api.nvim_set_hl(0, "HttpResponseHeader", {
      fg = "#7aa2f7",
      bold = true,
    })

    vim.api.nvim_set_hl(0, "HttpResponseSection", {
      fg = "#bb9af7",
      bold = true,
    })

    vim.api.nvim_set_hl(0, "HttpResponseStatus", {
      fg = "#9ece6a",
      bold = true,
    })
  end,
}
