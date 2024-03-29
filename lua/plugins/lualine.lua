local opts={
  options = {
    globalstatus = true,
    section_separators = { left = "", right = "" },
    component_separators = { left = "", right = "" }
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = {
      "branch",
      {
        "diff",
        symbols = {
          added = " ",
          modified = " ",
          removed = " "
        }
      },
      "diagnostics"
    },
    lualine_c = {
      {
        "filename",
        -- path = 4,
        symbols = {
          modified = " ",
          readonly = " ",
          unnamed = "No Name  ",
          newfile = "New  "
        }
      }
    },
    lualine_x = { 
      {
        require('noice').api.statusline.mode.get,
        cond=require('noice').api.statusline.mode.has,
        color={fg='orange'},
      },
      "encoding",
      "fileformat",
      "filetype" 
    },
      lualine_y = { "progress" },
      lualine_z = { "location" }
    },
    extensions = {
      "lazy",
      "mason",
      "toggleterm",
      "trouble",
    },
  }

  require('lualine').setup(opts)
