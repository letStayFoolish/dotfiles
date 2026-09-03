return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {},
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>tt", "<cmd>NvimTreeToggle<cr>" },
    },
    opts = {},
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },
}
