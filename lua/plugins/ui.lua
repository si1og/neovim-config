return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local bufferline = require("bufferline")
    local bg = "#1a1612"
    local inactive = "#211c18"
    local active = "#2b2521"
    local border = "#3d352e"
    local bottom_border = inactive
    local text = "#d4c5b9"
    local muted = "#8a7d72"
    local accent = "#ff8860"

    bufferline.setup({
      options = {
        mode = "buffers",
        offsets = {
          {
            filetype = "neo-tree",
            text = "",
            separator = false,
          },
        },
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",

        separator_style = "slant",
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
      },
      highlights = {
        fill = { bg = bg },
        background = { fg = muted, bg = inactive },
        buffer_visible = { fg = text, bg = inactive },
        buffer_selected = { fg = accent, bg = active, bold = true, italic = false },
        separator = { fg = bg, bg = inactive },
        separator_visible = { fg = bg, bg = inactive },
        separator_selected = { fg = bg, bg = active },
        indicator_selected = { fg = accent, bg = active },
        close_button = { fg = muted, bg = inactive },
        close_button_visible = { fg = text, bg = inactive },
        close_button_selected = { fg = accent, bg = active },
        modified = { fg = accent, bg = inactive },
        modified_visible = { fg = accent, bg = inactive },
        modified_selected = { fg = accent, bg = active },
        offset_separator = { fg = border, bg = bg },
      },
    })

    local function highlight_border()
      vim.api.nvim_set_hl(0, "BufferLineBottomBorder", {
        fg = bottom_border,
        bg = bg,
      })
    end

    highlight_border()
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("bufferline-bottom-border", { clear = true }),
      callback = highlight_border,
    })
    vim.o.winbar = "%#BufferLineBottomBorder#%{repeat('▔', winwidth(0))}"
  end,
}
