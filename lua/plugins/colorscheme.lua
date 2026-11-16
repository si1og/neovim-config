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
          autumnRed = "#ff9090",
          samuraiRed = "#ff9090",
          waveRed = "#ff9090",
          peachRed = "#ff8860",
          surimiOrange = "#ffb090",
          roninYellow = "#ffe8b8",
          boatYellow1 = "#ffe8b8",
          boatYellow2 = "#ffe8b8",
          carpYellow = "#ffe8b8",
          oldWhite = "#ffd0bd",
          fujiWhite = "#fffbf5",
          crystalBlue = "#a8c8e8",
          springBlue = "#98d0e8",
          lightBlue = "#a8e0d0",
          dragonBlue = "#98d0e8",
          waveAqua1 = "#a8e0d0",
          waveAqua2 = "#a8e0d0",
          springGreen = "#b8e0a8",
          sakuraPink = "#ffa8d0",
          oniViolet = "#ffa8d0",
          springViolet1 = "#ffa8d0",
          springViolet2 = "#a8c8e8",
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
      red = "#ff9090",
      orange = "#ff8860",
      peach = "#ffb090",
      yellow = "#ffe8b8",
      green = "#b8e0a8",
      aqua = "#a8e0d0",
      blue = "#a8c8e8",
      cyan = "#98d0e8",
      purple = "#ffa8d0",
      pink = "#ffc8b8",
      string = "#ffb89d",
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

    hl("Directory", { fg = c.orange })
    hl("NeoTreeDirectoryIcon", { fg = c.orange })
    hl("NeoTreeDirectoryName", { fg = c.orange })
    hl("NeoTreeExpander", { fg = c.muted })
    hl("NeoTreeRootName", { fg = c.orange })
    hl("NvimTreeFolderIcon", { fg = c.orange })
    hl("NvimTreeFolderName", { fg = c.orange })
    hl("NvimTreeOpenedFolderName", { fg = c.orange })

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
    hl("@keyword.modifier", { fg = c.orange })
    hl("@keyword.type", { fg = c.orange })
    hl("@keyword.function", { fg = c.orange, bold = true })
    hl("@keyword.operator", { fg = c.peach })
    hl("@keyword.conditional", { fg = c.orange })
    hl("@keyword.repeat", { fg = c.orange })
    hl("@keyword.return", { fg = c.orange, bold = true })
    hl("@keyword.import", { fg = c.orange })
    hl("@keyword.exception", { fg = c.red })
    hl("@keyword.coroutine", { fg = c.purple })
    hl("@keyword.directive", { fg = c.purple })
    hl("@keyword.directive.define", { fg = c.purple })
    hl("@keyword.debug", { fg = c.red })
    hl("@operator", { fg = c.peach })
    hl("@punctuation", { fg = c.soft })
    hl("@punctuation.bracket", { fg = c.soft })
    hl("@punctuation.delimiter", { fg = c.soft })
    hl("@punctuation.special", { fg = c.peach })
    hl("@comment", { fg = c.muted, italic = true })
    hl("@comment.documentation", { fg = "#a09080", italic = true })
    hl("@comment.todo", { fg = "#ffa860", bold = true })
    hl("@comment.note", { fg = c.blue, bold = true })
    hl("@comment.warning", { fg = c.yellow, bold = true })
    hl("@comment.error", { fg = c.red, bold = true })
    hl("@string", { fg = c.string })
    hl("@string.escape", { fg = c.pink })
    hl("@string.regexp", { fg = c.purple })
    hl("@string.special", { fg = c.pink })
    hl("@string.special.path", { fg = c.aqua })
    hl("@string.special.url", { fg = c.blue })
    hl("@character", { fg = c.pink })
    hl("@character.special", { fg = c.purple })
    hl("@number", { fg = c.pink })
    hl("@number.float", { fg = c.pink })
    hl("@boolean", { fg = c.pink })
    hl("@constant", { fg = c.pink })
    hl("@constant.builtin", { fg = c.pink })
    hl("@constant.macro", { fg = c.purple })
    hl("@variable", { fg = c.blue })
    hl("@variable.parameter", { fg = c.blue })
    hl("@variable.builtin", { fg = c.cyan })
    hl("@variable.member", { fg = c.cyan })
    hl("@variable.special", { fg = c.aqua })
    hl("@property", { fg = c.cyan })
    hl("@field", { fg = c.cyan })
    hl("@function", { fg = c.yellow })
    hl("@function.call", { fg = c.yellow })
    hl("@function.method", { fg = c.yellow })
    hl("@function.method.call", { fg = c.yellow })
    hl("@function.builtin", { fg = c.yellow })
    hl("@function.macro", { fg = c.purple })
    hl("@function.decorator", { fg = c.purple })
    hl("@constructor", { fg = c.green })
    hl("@type", { fg = c.green })
    hl("@type.builtin", { fg = c.green })
    hl("@type.definition", { fg = c.green, bold = true })
    hl("@type.interface", { fg = c.aqua })
    hl("@type.super", { fg = c.green, italic = true })
    hl("@attribute", { fg = c.yellow })
    hl("@label", { fg = c.orange })
    hl("@symbol", { fg = c.pink })
    hl("@embedded", { fg = c.peach })
    hl("@preproc", { fg = c.purple })
    hl("@module", { fg = c.soft })
    hl("@namespace", { fg = c.soft })
    hl("@tag", { fg = c.orange })
    hl("@tag.attribute", { fg = c.yellow })
    hl("@tag.delimiter", { fg = c.soft })
    hl("@tag.doctype", { fg = c.muted, italic = true })
    hl("@diff.plus", { fg = c.green })
    hl("@diff.minus", { fg = c.red })

    -- Markdown follows Zed's Rust & Brown markup palette.
    hl("@markup.heading", { fg = c.orange, bold = true })
    for level = 1, 6 do
      hl("@markup.heading." .. level .. ".markdown", { fg = c.orange, bold = true })
    end
    hl("@markup.list", { fg = c.orange })
    hl("@markup.list.checked", { fg = c.green })
    hl("@markup.list.unchecked", { fg = c.orange })
    hl("@markup.link", { fg = c.blue, underline = true })
    hl("@markup.link.label", { fg = c.blue, underline = true })
    hl("@markup.link.url", { fg = c.blue, underline = true })
    hl("@markup.raw", { fg = c.aqua })
    hl("@markup.raw.block", { fg = c.aqua })
    hl("@markup.italic", { fg = c.string, italic = true })
    hl("@markup.strong", { fg = c.yellow, bold = true })
    hl("@markup.quote", { fg = c.muted, italic = true })

    -- Legacy Markdown groups used when Tree-sitter is unavailable.
    hl("markdownH1", { fg = c.orange, bold = true })
    hl("markdownH2", { fg = c.orange, bold = true })
    hl("markdownH3", { fg = c.orange, bold = true })
    hl("markdownH4", { fg = c.orange, bold = true })
    hl("markdownH5", { fg = c.orange, bold = true })
    hl("markdownH6", { fg = c.orange, bold = true })
    hl("markdownListMarker", { fg = c.orange })
    hl("markdownOrderedListMarker", { fg = c.orange })
    hl("markdownLinkText", { fg = c.blue, underline = true })
    hl("markdownUrl", { fg = c.blue, underline = true })
    hl("markdownCode", { fg = c.aqua })
    hl("markdownCodeBlock", { fg = c.aqua })
    hl("markdownBold", { fg = c.yellow, bold = true })
    hl("markdownItalic", { fg = c.string, italic = true })

    local semantic = {
      c = true,
      cpp = true,
      haskell = true,
      python = true,
      go = true,
      java = true,
      scala = true,
      sql = true,
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
      hl("@lsp.type.typeParameter." .. lang, { fg = c.green })
      hl("@lsp.type.function." .. lang, { fg = c.yellow })
      hl("@lsp.type.method." .. lang, { fg = c.yellow })
      hl("@lsp.type.macro." .. lang, { fg = c.purple })
      hl("@lsp.type.decorator." .. lang, { fg = c.purple })
      hl("@lsp.type.property." .. lang, { fg = c.cyan })
      hl("@lsp.type.field." .. lang, { fg = c.cyan })
      hl("@lsp.type.parameter." .. lang, { fg = c.blue })
      hl("@lsp.type.namespace." .. lang, { fg = c.soft })
      hl("@lsp.type.variable." .. lang, { fg = c.blue })
      hl("@lsp.type.enumMember." .. lang, { fg = c.pink })
      hl("@lsp.type.regexp." .. lang, { fg = c.purple })
      hl("@lsp.type.operator." .. lang, { fg = c.peach })
      hl("@lsp.type.keyword." .. lang, { fg = c.orange })
      hl("@lsp.typemod.variable.readonly." .. lang, { fg = c.blue })
      hl("@lsp.typemod.property.readonly." .. lang, { fg = c.cyan })
    end

  end,
}
