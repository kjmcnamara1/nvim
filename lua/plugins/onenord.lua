local theme_colors = require("onenord.colors").load()
local colors = { "Red", "Yellow", "Blue", "Orange", "Green", "Purple", "Cyan" }

local function blend_colors(base, tint, amount)
  base = base:gsub("#", "")
  base = { tonumber(base:sub(1, 2), 16), tonumber(base:sub(3, 4), 16), tonumber(base:sub(5, 6), 16) }
  tint = tint:gsub("#", "")
  tint = { tonumber(tint:sub(1, 2), 16), tonumber(tint:sub(3, 4), 16), tonumber(tint:sub(5, 6), 16) }
  local result = "#"
  for i = 1, #base do
    result = result .. string.format("%02x", base[i] + amount * (tint[i] - base[i]))
  end
  return result
end

local opts = {
  fade_nc = false,
  styles = {
    comments = "italic",
    keywords = "bold",
    -- diagnostics = "underline",
  },
  disable = {
    float_background = true,
  },
  custom_highlights = {},
}

for _, color in ipairs(colors) do
  local hl = "Ibl" .. color
  opts.custom_highlights[hl] = { bg = blend_colors(theme_colors.bg, theme_colors[color:lower()], 0.05) }
end

require("onenord").setup(opts)
--vim.cmd.colorscheme('onenord')
