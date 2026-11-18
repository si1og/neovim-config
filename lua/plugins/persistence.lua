return {
  {
    "folke/persistence.nvim",
    lazy = false,
    opts = {
      need = 1,
      branch = false,
    },
    init = function()
      vim.opt.sessionoptions = {
        "buffers",
        "curdir",
        "folds",
        "help",
        "tabpages",
        "winsize",
      }

      local group = vim.api.nvim_create_augroup("restore-project-session", { clear = true })
      vim.api.nvim_create_autocmd("User", {
        group = group,
        pattern = "PersistenceLoadPost",
        callback = function()
          require("config.session_persistence").restore_decorations()
        end,
      })
      vim.api.nvim_create_autocmd("VimEnter", {
        group = group,
        once = true,
        callback = function()
          if vim.fn.argc() == 0 then
            require("lazy").load({ plugins = { "nvim-treesitter" } })
            require("persistence").load()
            require("config.session_persistence").remove_directory_buffers()
            if vim.api.nvim_buf_get_name(0) ~= "" and vim.bo.filetype == "" then
              vim.cmd("filetype detect")
            end
          end
        end,
      })
    end,
    keys = {
      {
        "<leader>r",
        function()
          require("config.sessions").open()
        end,
        desc = "Open project sessions",
      },
    },
  },
}
