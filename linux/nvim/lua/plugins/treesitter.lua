return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "c_sharp", "lua", "javascript", "typescript", "tsx",
      "html", "css", "json", "yaml", "markdown", "bash", "vim", "vimdoc",
    },
    highlight = { enable = true },
    indent = { enable = true },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
