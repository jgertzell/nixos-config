return {
  {
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("easy-dotnet").setup({
        lsp = {
          enabled = true,
          preload_roslyn = true,
          restart_roslyn_on_branch_change = true,
          razor = {
            enabled = true,
            html = {
              enabled = true,
              cmd = { "vscode-html-language-server", "--stdio" },
            },
          },
        },
        debugger = {
          auto_register_dap = true,
        },
      })
    end,
  },
}
