-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
  rocks = {
    -- The XXH payload is intentionally self-contained and cannot rely on
    -- development headers being installed on the remote host. image.nvim uses
    -- the magick_cli processor there, so LuaRocks is not needed.
    enabled = vim.env.NVIM_CONFIG_HS == nil,
  },
  ui = {
    border = "rounded",
  },
  spec = {
    { import = "plugins" },
  },
  change_detection = { notify = false },
})

