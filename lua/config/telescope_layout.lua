local M = {}

local function dimension(available, ratio, minimum)
  return math.min(available, math.max(minimum, math.floor(available * ratio)))
end

function M.width(_, max_columns)
  return dimension(max_columns, 0.55, 80)
end

function M.height(_, _, max_lines)
  return dimension(max_lines, 0.45, 24)
end

function M.config(overrides)
  return vim.tbl_deep_extend("force", {
    width = M.width,
    height = M.height,
  }, overrides or {})
end

return M
