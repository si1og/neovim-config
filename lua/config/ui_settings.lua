local M = {}

local state_path = vim.fn.stdpath("state") .. "/ui-settings.json"
local defaultSettings = {
  transparent_background = false,
}
local currentSettings = vim.deepcopy(defaultSettings)

local flag = {
  key = "transparent_background",
  label = "Transparent background",
}

local transparent_groups = {
  Normal = "#1a1612",
  NormalNC = "#1a1612",
  CursorLine = "#302822",
  EndOfBuffer = "#1a1612",
  SignColumn = "#1a1612",
  WinSeparator = "#1a1612",
  NeoTreeNormal = "#1a1612",
  NeoTreeNormalNC = "#1a1612",
  NeoTreeEndOfBuffer = "#1a1612",
  NeoTreeSignColumn = "#1a1612",
  TroubleNormal = "#28211c",
  TroubleNormalNC = "#28211c",
}

local menu_backgrounds = {
  NormalFloat = "#28211c",
  FloatBorder = "#28211c",
  TelescopeNormal = "#28211c",
  TelescopeBorder = "#28211c",
  TelescopePromptNormal = "#302822",
  TelescopePromptBorder = "#302822",
  Pmenu = "#28211c",
  PmenuSbar = "#28211c",
  CmpPmenu = "#28211c",
  CmpBorder = "#28211c",
}

local original_bar_highlights = {}

local function read_settings()
  local ok, lines = pcall(vim.fn.readfile, state_path)
  if not ok or #lines == 0 then
    return
  end

  local decoded_ok, decoded = pcall(vim.json.decode, table.concat(lines, "\n"))
  if decoded_ok and type(decoded) == "table" and type(decoded[flag.key]) == "boolean" then
    currentSettings[flag.key] = decoded[flag.key]
  end
end

local function write_settings()
  vim.fn.mkdir(vim.fn.fnamemodify(state_path, ":h"), "p")
  vim.fn.writefile({ vim.json.encode(currentSettings) }, state_path)
end

local function update_group(group, values)
  local attributes = vim.api.nvim_get_hl(0, { name = group, link = false })
  for key, value in pairs(values) do
    attributes[key] = value
  end
  vim.api.nvim_set_hl(0, group, attributes)
end

function M.apply()
  local transparent = currentSettings[flag.key]

  for group, background in pairs(transparent_groups) do
    update_group(group, { bg = transparent and "NONE" or background })
  end

  for group, background in pairs(menu_backgrounds) do
    update_group(group, { bg = background })
  end

  -- These surfaces cannot use window blending, so remove their backgrounds.
  -- Keep the active state visible through a softer orange foreground.
  for name, attributes in pairs(vim.api.nvim_get_hl(0, {})) do
    if name:match("^lualine_") or name:match("^BufferLine") then
      if original_bar_highlights[name] == nil then
        original_bar_highlights[name] = vim.deepcopy(attributes)
      end
      local values = vim.deepcopy(original_bar_highlights[name])
      if transparent then
        values.bg = "NONE"
        if name:match("lualine_a_") or name:match("BufferSelected") or name:match("IndicatorSelected") then
          values.fg = "#d47857"
        elseif name:match("lualine_transitional_") or name:match("BufferLineSeparator") then
          values.fg = "#5a4d42"
        end
      end
      vim.api.nvim_set_hl(0, name, values)
    end
  end

  -- Telescope, completion menus and floating windows stay subtly tinted.
  vim.o.winblend = transparent and 20 or 0
  vim.o.pumblend = transparent and 20 or 0
end

function M.setup()
  read_settings()
  M.apply()

  local group = vim.api.nvim_create_augroup("ui-settings-highlights", { clear = true })
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = group,
    callback = function()
      original_bar_highlights = {}
      M.apply()
    end,
  })
  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "LazyDone",
    callback = M.apply,
  })
end

function M.open()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local themes = require("telescope.themes")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local modal_layout = require("config.telescope_layout")

  local picker
  local function finder()
    return finders.new_table({
      results = { flag },
      entry_maker = function(item)
        local checked = currentSettings[item.key] and "x" or " "
        return {
          value = item,
          display = string.format("[%s]  %s", checked, item.label),
          ordinal = item.label,
        }
      end,
    })
  end

  local function toggle()
    local entry = action_state.get_selected_entry()
    if not entry then
      return
    end

    currentSettings[entry.value.key] = not currentSettings[entry.value.key]
    write_settings()
    M.apply()
    picker:refresh(finder(), { reset_prompt = false })
  end

  picker = pickers.new(themes.get_dropdown({
    initial_mode = "normal",
    previewer = false,
    layout_config = modal_layout.config(),
  }), {
    prompt_title = "Appearance  •  <Space>/<CR> toggle",
    finder = finder(),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(_, map)
      actions.select_default:replace(toggle)
      map("n", "<Space>", toggle)
      map("n", "x", toggle)
      return true
    end,
  })

  picker:find()
end

return M
