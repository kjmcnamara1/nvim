return {
  settings = {
    Lua = {
      -- Added to repo root .luarc.json instead
      -- workspace = {
      --   library = {
      --     vim.env.VIMRUNTIME .. "/lua",
      --   },
      -- },
      hint = {
        arrayIndex = "Disable",
      },
      format = {
        defaultConfig = {
          quote_style = "double",
          indent_style = "space",
          indent_size = 2,
          max_line_length = 120,
          trailing_table_separator = "smart",
        }
      }
    }
  }
}
