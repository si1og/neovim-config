return {
  "rebelot/kanagawa.nvim",
  priority = 1000,

  config = function()
    vim.o.background = "dark"

    require("kanagawa").setup({
      compile = false,
      undercurl = true,
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = false },
      statementStyle = {},
      typeStyle = {},
      transparent = true,
      dimInactive = false,
      terminalColors = true,
      theme = "wave",
      background = {
        dark = "wave",
        light = "lotus",
      },
      colors = {
        palette = {
          sumiInk0 = "#0f0d0a",
          sumiInk1 = "#15110e",
          sumiInk2 = "#1a1612",
          sumiInk3 = "#221e1a",
          sumiInk4 = "#2a241f",
          sumiInk5 = "#332b25",
          sumiInk6 = "#3d352e",
          autumnRed = "#ff705c",
          samuraiRed = "#ff705c",
          waveRed = "#ff795f",
          peachRed = "#ff8860",
          surimiOrange = "#ff8860",
          roninYellow = "#e6c384",
          boatYellow1 = "#d8b46a",
          boatYellow2 = "#c9b27c",
          carpYellow = "#e6c384",
          oldWhite = "#ffd0bd",
          fujiWhite = "#fffbf5",
          crystalBlue = "#9abbd3",
          springBlue = "#7fb4ca",
          lightBlue = "#a3d4d5",
          dragonBlue = "#658594",
          waveAqua1 = "#6f9b8d",
          waveAqua2 = "#8ea4a2",
          springGreen = "#98bb6c",
          sakuraPink = "#dca6b2",
          oniViolet = "#b8a3d3",
          springViolet1 = "#938aa9",
          springViolet2 = "#9cabca",
        },
      },
    })

    vim.cmd.colorscheme("kanagawa-wave")

    -- Rust & Brown palette, shared with Zed and tmux.
    local c = {
      bg = "#1a1612",
      surface = "#28211c",
      panel = "#302822",
      select = "#3d352e",
      border = "#3d352e",
      fg = "#fffbf5",
      soft = "#d4c5b9",
      muted = "#8a7d72",
      faint = "#5a4d42",
      red = "#ff705c",
      orange = "#ff8860",
      peach = "#f2ad85",
      yellow = "#e6c384",
      green = "#98bb6c",
      aqua = "#8ea4a2",
      blue = "#9abbd3",
      cyan = "#7fb4ca",
      purple = "#b8a3d3",
      pink = "#dca6b2",
    }

    local function hl(group, opts)
      vim.api.nvim_set_hl(0, group, opts)
    end

    hl("Normal", { fg = c.fg, bg = c.bg })
    hl("NormalNC", { fg = c.fg, bg = c.bg })
    hl("EndOfBuffer", { fg = c.bg, bg = c.bg })
    hl("SignColumn", { bg = c.bg })
    hl("Cursor", { fg = c.bg, bg = c.orange })
    hl("CursorLine", { bg = c.panel })
    hl("CursorLineNr", { fg = c.soft, bold = true })
    hl("LineNr", { fg = c.muted })
    hl("Visual", { bg = c.select })
    hl("Search", { fg = c.bg, bg = c.orange })
    hl("IncSearch", { fg = c.bg, bg = c.yellow })
    hl("NormalFloat", { fg = c.fg, bg = c.surface })
    hl("FloatBorder", { fg = c.border, bg = c.surface })
    hl("WinSeparator", { fg = c.border, bg = c.bg })

    -- File explorer shares the editor background.
    hl("NeoTreeNormal", { fg = c.fg, bg = c.bg })
    hl("NeoTreeNormalNC", { fg = c.soft, bg = c.bg })
    hl("NeoTreeEndOfBuffer", { fg = c.bg, bg = c.bg })
    hl("NeoTreeSignColumn", { bg = c.bg })

    -- Other auxiliary panels stay slightly raised.
    hl("TelescopeNormal", { fg = c.fg, bg = c.surface })
    hl("TelescopeBorder", { fg = c.border, bg = c.surface })
    hl("TelescopePromptNormal", { fg = c.fg, bg = c.panel })
    hl("TelescopePromptBorder", { fg = c.border, bg = c.panel })
    hl("TroubleNormal", { fg = c.fg, bg = c.surface })
    hl("TroubleNormalNC", { fg = c.soft, bg = c.surface })

    hl("Directory", { fg = c.blue })
    hl("NeoTreeDirectoryIcon", { fg = c.blue })
    hl("NeoTreeDirectoryName", { fg = c.blue })
    hl("NeoTreeExpander", { fg = c.muted })
    hl("NeoTreeRootName", { fg = c.orange })
    hl("NvimTreeFolderIcon", { fg = c.blue })
    hl("NvimTreeFolderName", { fg = c.blue })
    hl("NvimTreeOpenedFolderName", { fg = c.blue })

    hl("Pmenu", { fg = c.fg, bg = c.surface })
    hl("PmenuSel", { fg = c.fg, bg = c.panel, bold = true })
    hl("PmenuSbar", { bg = c.surface })
    hl("PmenuThumb", { bg = c.faint })
    hl("CmpPmenu", { fg = c.fg, bg = c.surface })
    hl("CmpPmenuSel", { fg = c.fg, bg = c.panel, bold = true })
    hl("CmpBorder", { fg = c.border, bg = c.surface })

    hl("DiagnosticError", { fg = c.red })
    hl("DiagnosticWarn", { fg = c.yellow })
    hl("DiagnosticInfo", { fg = c.blue })
    hl("DiagnosticHint", { fg = c.aqua })
    hl("DiagnosticUnderlineError", { undercurl = true, sp = c.red })
    hl("DiagnosticUnderlineWarn", { undercurl = true, sp = c.yellow })
    hl("DiagnosticUnderlineInfo", { undercurl = true, sp = c.blue })
    hl("DiagnosticUnderlineHint", { undercurl = true, sp = c.aqua })

    hl("@keyword", { fg = c.orange, bold = true })
    hl("@keyword.conditional", { fg = c.orange })
    hl("@keyword.repeat", { fg = c.orange })
    hl("@keyword.return", { fg = c.orange, bold = true })
    hl("@keyword.import", { fg = c.orange })
    hl("@keyword.exception", { fg = c.red })
    hl("@operator", { fg = c.peach })
    hl("@punctuation.bracket", { fg = c.soft })
    hl("@punctuation.delimiter", { fg = c.soft })
    hl("@punctuation.special", { fg = c.peach })
    hl("@comment", { fg = c.muted, italic = true })
    hl("@string", { fg = c.peach })
    hl("@string.special", { fg = c.pink })
    hl("@number", { fg = c.pink })
    hl("@boolean", { fg = c.pink })
    hl("@constant", { fg = c.pink })
    hl("@constant.builtin", { fg = c.pink })
    hl("@variable", { fg = c.blue })
    hl("@variable.parameter", { fg = c.blue })
    hl("@variable.builtin", { fg = c.cyan })
    hl("@property", { fg = c.cyan })
    hl("@field", { fg = c.cyan })
    hl("@function", { fg = c.yellow })
    hl("@function.call", { fg = c.yellow })
    hl("@function.method", { fg = c.yellow })
    hl("@function.method.call", { fg = c.yellow })
    hl("@constructor", { fg = c.green })
    hl("@type", { fg = c.green })
    hl("@type.builtin", { fg = c.green, italic = true })
    hl("@module", { fg = c.soft })
    hl("@namespace", { fg = c.soft })
    hl("@tag", { fg = c.orange })
    hl("@tag.attribute", { fg = c.yellow })
    hl("@tag.delimiter", { fg = c.soft })

    local semantic = {
      c = true,
      cpp = true,
      haskell = true,
      typescript = true,
      typescriptreact = true,
      javascript = true,
      javascriptreact = true,
    }

    for lang in pairs(semantic) do
      hl("@lsp.type.class." .. lang, { fg = c.green })
      hl("@lsp.type.struct." .. lang, { fg = c.green })
      hl("@lsp.type.interface." .. lang, { fg = c.aqua })
      hl("@lsp.type.enum." .. lang, { fg = c.aqua })
      hl("@lsp.type.type." .. lang, { fg = c.green })
      hl("@lsp.type.function." .. lang, { fg = c.yellow })
      hl("@lsp.type.method." .. lang, { fg = c.yellow })
      hl("@lsp.type.property." .. lang, { fg = c.cyan })
      hl("@lsp.type.field." .. lang, { fg = c.cyan })
      hl("@lsp.type.parameter." .. lang, { fg = c.blue })
      hl("@lsp.type.namespace." .. lang, { fg = c.soft })
      hl("@lsp.type.variable." .. lang, { fg = c.blue })
      hl("@lsp.typemod.variable.readonly." .. lang, { fg = c.pink })
      hl("@lsp.typemod.property.readonly." .. lang, { fg = c.pink })
    end

  end,
}
