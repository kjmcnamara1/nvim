pack_add({ "https://github.com/monaqa/dial.nvim" })

local aug = require("dial.augend")
local map = require("dial.map").manipulate

local assignment = aug.constant.new({ elements = { "let", "const" } })
local hexcolor = aug.hexcolor.new({ case = "prefer_upper" })
local logical = aug.constant.new({
  elements = { "and", "or" },
  word = true,
  cyclic = true,
})
local logical_alias = aug.constant.new({
  elements = { "&&", "||" },
  word = false,
  cyclic = true,
})
local months = aug.constant.new({
  elements = {
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  },
  word = true,
  cyclic = true,
})
local cases = aug.case.new({
  types = {
    "snake_case",
    "camelCase",
    "PascalCase",
    "kebab-case",
    "SCREAMING_SNAKE_CASE",
  },
  cyclic = true,
})

require("dial.config").augends:register_group({
  default = {
    aug.integer.alias.decimal,  -- nonnegative decimal number (0, 1, 2, 3, ...)
    aug.integer.alias.hex,      -- nonnegative hex number  (0x01, 0x1a1f, etc.)
    aug.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
    aug.date.alias["%m/%d"],
    aug.date.alias["%H:%M"],
    aug.constant.alias.en_weekday,
    aug.constant.alias.en_weekday_full,
    aug.constant.alias.bool,
    aug.constant.alias.Bool,
    aug.semver.alias.semver,
    logical,
    logical_alias,
    months,
    cases, -- TODO: need separate keymap
    assignment,
    hexcolor,
    aug.misc.alias.markdown_header,
  }
})

-- require("dial.config").augends:on_filetype({
--   lua = { logical },
--   python = { logical },
--   markdown = { aug.misc.alias.markdown_header },
--   css = { hexcolor, Hexcolor },
--   javascript = { assignment },
--   typescript = { assignment },
-- })

-- 2021/11/03
-- 11/02
-- 02:09
-- 0
-- 0
-- 0
-- 0x1b4
-- Mon
-- Monday
-- 1.3.4
-- &&
-- and
-- true
-- True
-- March
-- let
-- #445667
-- #3B42FF
-- #3942C2

wk.add({
  { "<c-a>",  function() map("increment", "normal") end,  desc = "Dial: Increment" },
  { "<c-x>",  function() map("decrement", "normal") end,  desc = "Dial: Decrement" },
  { "g<c-a>", function() map("increment", "gnormal") end, desc = "Dial: Increment" },
  { "g<c-x>", function() map("decrement", "gnormal") end, desc = "Dial: Decrement" },
  {
    mode = { "x" },
    {
      "<c-a>",
      function()
        map("increment", "visual")
        vim.cmd("normal! gv")
      end,
      desc = "Dial: Increment",
    },
    {
      "<c-x>",
      function()
        map("decrement", "visual")
        vim.cmd("normal! gv")
      end,
      desc = "Dial: Decrement",
    },
    {
      "g<c-a>",
      function()
        map("increment", "gvisual")
        vim.cmd("normal! gv")
      end,
      desc = "Dial: Increment",
    },
    {
      "g<c-x>",
      function()
        map("decrement", "gvisual")
        vim.cmd("normal! gv")
      end,
      desc = "Dial: Decrement",
    },
  }
})
