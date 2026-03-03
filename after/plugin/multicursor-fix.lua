-- was being overridden by builtin snippet plugin
wk.add({ "<tab>", function() require("multicursor-nvim").toggleCursor() end, desc = 'MultiCursor: Add/remove main cursor', mode = { "n", "x" } })
