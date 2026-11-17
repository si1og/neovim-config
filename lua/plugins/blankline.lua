return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPost", "BufNewFile" },

  config = function()
    local hooks = require "ibl.hooks"

    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "MutedIndentGuide", { fg = "#5a4d42" })
    end)

    require("ibl").setup {
      indent = {
        char = { "┊", "╎", "┆" },
        highlight = "MutedIndentGuide",
      },
      scope = {
        char = "│",
        highlight = "MutedIndentGuide",
      },
    }
  end
}
