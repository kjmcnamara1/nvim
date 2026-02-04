return {
  settings = {
    Lua = {
      workspace = {
        library = {
          vim.env.VIMRUNTIME .. "/lua",
        },
      },
      hint = {
        arrayIndex = "Disable",
      },
      format = {
        defaultConfig = {
          quote_style = "double",
          indent_style = "space",
          indent_size = 2,
          max_lin_length = 120,
          trailing_table_separator = "smart",
        }
      }
    }
  }
}
