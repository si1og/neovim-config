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
  BufferLineBottomBorder = "#1a1612",
  NeoTreeNormal = "#1a1612",
  NeoTreeNormalNC = "#1a1612",
  NeoTreeEndOfBuffer = "#1a1612",
  NeoTreeSignColumn = "#1a1612",
  TroubleNormal = "#28211c",
  TroubleNormalNC = "#28211c",
}

local fill_groups = { "BufferLineFill", "TabLineFill" }
local original_fill_backgrounds = {}

local function capture_fill_backgrounds()
  for _, group in ipairs(fill_groups) do
    local background = vim.api.nvim_get_hl(0, { name = group, link = false }).bg
    if background ~= nil then
      original_fill_backgrounds[group] = background
    end
  end
end

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

local function update_background(group, background)
  local attributes = vim.api.nvim_get_hl(0, { name = group, link = false })
  attributes.bg = background
  vim.api.nvim_set_hl(0, group, attributes)
end

function M.apply()
  local transparent = currentSettings[flag.key]

  for group, background in pairs(transparent_groups) do
    update_background(group, transparent and "NONE" or background)
  end

  for _, group in ipairs(fill_groups) do
    if transparent then
      update_background(group, "NONE")
    elseif original_fill_backgrounds[group] ~= nil then
      update_background(group, original_fill_backgrounds[group])
    end
  end
end

function M.setup()
  read_settings()
  capture_fill_backgrounds()
  M.apply()
  vim.keymap.set("n", "<Space>s", M.open, { desc = "Open UI settings" })

  local group = vim.api.nvim_create_augroup("ui-settings-highlights", { clear = true })
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = group,
    callback = function()
      capture_fill_backgrounds()
      M.apply()
    end,
  })
  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "LazyDone",
    callback = function()
      vim.schedule(function()
        capture_fill_backgrounds()
        M.apply()
      end)
    end,
  })
  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "VeryLazy",
    callback = function()
      vim.schedule(function()
        capture_fill_backgrounds()
        M.apply()
      end)
    end,
  })
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = "neo-tree",
    callback = function(event)
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(event.buf) then
          for _, win in ipairs(vim.fn.win_findbuf(event.buf)) do
            vim.wo[win].winhighlight = table.concat({
              "Normal:NeoTreeNormal",
              "NormalNC:NeoTreeNormalNC",
              "EndOfBuffer:NeoTreeEndOfBuffer",
              "SignColumn:NeoTreeSignColumn",
            }, ",")
          end
        end
      end)
    end,
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
