return {
  {
    "neovimhaskell/nvim-hs.vim",
    lazy = false,
    config = function()
      local project = vim.fn.stdpath("config") .. "/haskell"
      local prebuilt = vim.env.NVIM_CONFIG_HS
      if prebuilt and prebuilt ~= "" and vim.fn.executable(prebuilt) == 1 then
        vim.g.nvim_config_hs_executable = prebuilt
        vim.cmd([[
          function! NvimConfigPrebuiltBuildCommand(name) abort
            return []
          endfunction

          function! NvimConfigPrebuiltExePath(working_directory, name) abort
            return g:nvim_config_hs_executable
          endfunction

          let g:nvimhsPluginStarter = {
                \ 'buildCommand': function('NvimConfigPrebuiltBuildCommand'),
                \ 'exePath': function('NvimConfigPrebuiltExePath'),
                \ }
        ]])
      end
      vim.fn["nvimhs#start"](project, "nvim-config-hs", {})
    end,
  },
}
