return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPre", "BufNewFile" },
  main = "ibl",
  opts = {
    indent = { 
      char = "┊",
      highlight = "IblIndent", -- Standard dim color
    },
    scope = { 
      enabled = true,
      show_start = true, 
      show_end = false,
      highlight = "IblScope", -- This makes the current scope line a different color
    },
  }
}
