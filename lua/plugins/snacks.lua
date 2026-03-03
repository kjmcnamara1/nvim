local blend_colors = function(base, tint, amount)
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

local function toggle_terminal_preserving_state()
  local term
  local function term_is_visible()
    return #Snacks.terminal.list() > 0 and Snacks.terminal.get():valid()
  end

  if not term_is_visible() then
    local view = vim.fn.winsaveview()
    term = Snacks.terminal.toggle()
    term._previous_win_state = view
    return term
  end
  term = Snacks.terminal.toggle()
  if term._previous_win_state then
    vim.fn.winrestview(term._previous_win_state)
    term._previous_win_state = nil
  end
  return term
end

local function uv_run_py_file()
  vim.cmd("silent! write")
  local file = vim.fn.expand("%:p")
  Snacks.terminal.open("uv run " .. file, {
    auto_close = false,
    win = {
      position = "bottom",
    },
  })
end

return {
  "folke/snacks.nvim",
  dependencies = {
    "echasnovski/mini.icons",
  },
  cond = profile() == "default",
  priority = 1000,
  lazy = false,
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        --- Dump to notification
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        --- Dump at cursor (use from command line)
        _G.dc = function(...)
          local args = table.pack(...)
          local formatted = ""
          for i = 1, args.n do
            formatted = formatted .. vim.inspect(args[i]) .. "\n"
          end
          vim.api.nvim_paste(formatted .. "\n", true, -1)
        end

        --- Dump to scratch buffer
        _G.ds = function(...)
          local args = table.pack(...)
          local buf = vim.api.nvim_create_buf(false, true)
          local formatted = ""
          for i = 1, args.n do
            formatted = formatted .. vim.inspect(args[i]) .. "\n"
          end
          local lines = vim.split(formatted, "\n", { plain = true, trimempty = false })
          vim.api.nvim_buf_set_lines(buf, 0, -1, true, lines)
          vim.api.nvim_win_set_buf(0, buf)
        end

        -- Blend colors of indentation guides
        for i, color in ipairs({ 'yellow', 'purple', 'cyan', 'red', 'green', 'blue', 'orange', 'pink' }) do
          vim.api.nvim_set_hl(0, "SnacksIndent" .. i,
            { fg = blend_colors(colors.bg, colors[color], 0.30) })
          vim.api.nvim_set_hl(0, "SnacksIndentScope" .. i,
            { fg = colors[color] })
        end

        -- Toggle keymaps
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<localleader>w")
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<localleader>s")
        Snacks.toggle.line_number():map("<localleader>l")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<localleader>L")
        Snacks.toggle.option("showtabline", { off = 0, on = 2, name = "Bufferline" }):map("<localleader>B")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map(
          "<localleader>b")
        Snacks.toggle.option("conceallevel", {
          off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2,
        }):map("<localleader>c")
        Snacks.toggle.animate():map("<localleader>a")
        Snacks.toggle.dim():map("<localleader>D")
        Snacks.toggle.diagnostics():map("<localleader>d")
        Snacks.toggle.inlay_hints():map("<localleader>h")
        Snacks.toggle.indent():map("<localleader>I")
        Snacks.toggle.treesitter():map("<localleader>t")
        Snacks.toggle.zoom():map("<a-m>", { mode = { "n", "x", "i", "t" } })
        Snacks.toggle.zen():map("<a-z>")
      end
    })
  end,
  keys = {
    mode = { "n", "x" },
    -- Terminal
    { "<c-'>",           toggle_terminal_preserving_state,                                                    desc = "Terminal: Toggle",                         mode = { "n", "i", "t" } },
    -- { "<c-'>",      Snacks.terminal.toggle,              desc = "Terminal: Toggle",          mode = { "n", "i", "t" } },
    -- BUG: multiple terminals breaks toggling
    { "<c-s-'>",         function() Snacks.terminal.open() end,                                               desc = "Terminal: New",                            mode = { "n", "i", "t" } },
    { "<c-a-n>",         uv_run_py_file,                                                                      desc = "Terminal: Run Current Python File with uv" },

    -- Cursor
    { "gd",              function() Snacks.picker.lsp_definitions() end,                                      desc = "LSP: Goto Definition" },
    { "grd",             function() Snacks.picker.lsp_declarations() end,                                     desc = "LSP: Goto Declaration" },
    { "grr",             function() Snacks.picker.lsp_references() end,                                       desc = "LSP: References",                          nowait = true },
    { "gri",             function() Snacks.picker.lsp_implementations() end,                                  desc = "LSP: Goto Implementation" },
    { "grt",             function() Snacks.picker.lsp_type_definitions() end,                                 desc = "LSP: Goto Type Definition" },
    { "gai",             function() Snacks.picker.lsp_incoming_calls() end,                                   desc = "LSP: C[a]lls Incoming" },
    { "gao",             function() Snacks.picker.lsp_outgoing_calls() end,                                   desc = "LSP: C[a]lls Outgoing" },

    -- Right
    { "go",              function() Snacks.picker.lsp_symbols() end,                                          desc = "LSP: Symbols" },
    { "gO",              function() Snacks.picker.lsp_workspace_symbols() end,                                desc = "LSP: Workspace Symbols" },
    { "<leader>st",      function() Snacks.picker.todo_comments({ keywords = { 'TODO', 'BUG', 'FIX' } }) end, desc = "Pick: Todo/Fix/Fixme" },
    { "<leader>sT",      function() Snacks.picker.todo_comments() end,                                        desc = "Pick: Todo" },

    -- Vscode
    { "<leader>,",       function() Snacks.picker.buffers() end,                                              desc = "Pick: Buffers" },
    { "<leader>:",       function() Snacks.picker.command_history() end,                                      desc = "Pick: Command History" },
    { "<leader>si",      function() Snacks.picker.icons() end,                                                desc = "Pick: Icons" },

    -- Left
    { "<leader>e",       function() Snacks.explorer.open() end,                                               desc = "Pick: File Explorer" },
    { "<leader>f",       function() Snacks.picker.files() end,                                                desc = "Pick: Files" },
    { "<leader>r",       function() Snacks.picker.recent() end,                                               desc = "Pick: Recent" },
    { "<leader>p",       function() Snacks.picker.projects() end,                                             desc = "Pick: Projects" },
    { "<leader>z",       function() Snacks.picker.chezmoi_files() end,                                        desc = "Pick: Chezmoi Files" },
    { "<leader>/",       function() Snacks.picker.grep() end,                                                 desc = "Pick: Grep" },
    { "<leader>sm",      function() Snacks.picker.marks() end,                                                desc = "Pick: Marks" },
    { "<leader>sj",      function() Snacks.picker.jumps() end,                                                desc = "Pick: Jumps" },

    -- Bottom
    { "<leader>sd",      function() Snacks.picker.diagnostics() end,                                          desc = "Pick: Diagnostics" },
    { "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,                                   desc = "Pick: Buffer Diagnostics" },

    -- Default
    { "<leader>sp",      function() Snacks.picker.lazy() end,                                                 desc = "Pick: Plugin Specs" },
    { "<leader>sP",      function() Snacks.picker.pickers() end,                                              desc = "Pick: Pickers" },
    { "<leader>sh",      function() Snacks.picker.help() end,                                                 desc = "Pick: Help Pages" },
    { "<leader>sH",      function() Snacks.picker.highlights() end,                                           desc = "Pick: Highlights" },
    { "<leader>sM",      function() Snacks.picker.man() end,                                                  desc = "Pick: Man Pages" },
    { "<leader>sa",      function() Snacks.picker.autocmds() end,                                             desc = "Pick: Autocmds" },
    { "<leader>so",      function() Snacks.picker.nvim_options() end,                                         desc = "Pick: Neovim Options" },
    { "<leader>sk",      function() Snacks.picker.keymaps() end,                                              desc = "Pick: Keymaps" },
    { "<leader>sn",      function() Snacks.picker.notifications() end,                                        desc = "Pick: Search Notifications" },
    { "<leader>n",       function() Snacks.notifier.hide() end,                                               desc = "Notifications: Dismiss All" },
    { "<leader>N",       function() Snacks.notifier.show_history() end,                                       desc = "Notifications: History" },

    -- Not sure yet...
    { "<leader>su",      function() Snacks.picker.undo() end,                                                 desc = "Pick: Undo History" },

    -- SE Corner
    { "<leader>t",       function() Snacks.picker.filetypes() end,                                            desc = "Pick: Filetypes" },
    { "<leader>uC",      function() Snacks.picker.colorschemes() end,                                         desc = "Pick: Colorschemes" },

    -- Other
    { "<leader><space>", function() Snacks.picker.resume() end,                                               desc = "Pick: Resume" },
    { "<leader>.",       function() Snacks.scratch.open() end,                                                desc = "Scratch: Buffer" },
    { "<leader>S",       function() Snacks.scratch.select() end,                                              desc = "Scratch: Select" },
    { "<leader>gg",      function() Snacks.lazygit.open() end,                                                desc = "Lazygit" },
    { "<leader>gf",      function() Snacks.lazygit.log_file() end,                                            desc = "Lazygit Current File History" },
    { "<leader>ghi",     function() Snacks.picker.gh_issue() end,                                             desc = "Pick: GitHub Issues (open)" },
    { "<leader>ghI",     function() Snacks.picker.gh_issue({ state = "all" }) end,                            desc = "Pick: GitHub Issues (all)" },
    { "<leader>ghp",     function() Snacks.picker.gh_pr() end,                                                desc = "Pick: GitHub Pull Requests (open)" },
    { "<leader>ghP",     function() Snacks.picker.gh_pr({ state = "all" }) end,                               desc = "Pick: GitHub Pull Requests (all)" },
    { "<a-c>",           function() Snacks.bufdelete.delete() end,                                            desc = "Buffer: Delete" },
    { "grf",             function() Snacks.rename.rename_file() end,                                          desc = "LSP: Rename File" },
    { "]]",              function() Snacks.words.jump(vim.v.count1) end,                                      desc = "Next Reference" },
    { "[[",              function() Snacks.words.jump(-vim.v.count1) end,                                     desc = "Prev Reference" },

  },
  opts = {
    bigfile = {},
    explorer = {},
    image = {},
    input = {},
    words = {},
    notifier = {},
    scratch = { ft = "lua" },
    terminal = { win = { wo = { winbar = "" } } },
    statuscolumn = {
      folds = {
        open = true,
        git_hl = true,
      }
    },
    scroll = {
      enabled = true,
      animate = {
        duration = { step = 10, total = 100 },
        easing = 'inOutCubic',
      },
    },
    styles = {
      notification = { wo = { wrap = true } },
      notification_history = { wo = { wrap = true } },
      lazygit = {
        width = 0,
        height = 0,
      },
    },
    dashboard = {
      sections = {
        { section = "header" },
        { section = "projects", icon = " ", title = "Projects", padding = 2, indent = 2 },
        { section = "keys" --[[ , gap = 1 ]], padding = 1 },
        -- { section = "startup" },
      },
      preset = {
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", action = ":lua require('persistence').load()" },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
    indent = {
      enabled = true,
      indent = {
        -- char = "│",
        hl = {
          "SnacksIndent1",
          "SnacksIndent2",
          "SnacksIndent3",
          "SnacksIndent4",
          "SnacksIndent5",
          "SnacksIndent6",
          "SnacksIndent7",
          "SnacksIndent8",
        },
      },
      scope = {
        char = "┃",
        only_current = true,
        hl = {
          "SnacksIndentScope1",
          "SnacksIndentScope2",
          "SnacksIndentScope3",
          "SnacksIndentScope4",
          "SnacksIndentScope5",
          "SnacksIndentScope6",
          "SnacksIndentScope7",
          "SnacksIndentScope8",
        },
      },
    },
    zen = {
      win = {
        minimal = true,
        backdrop = {
          bg = "#3b4252",
          transparent = false,
        },
      },
      toggles = {
        dim = true,
        indent = false,
        diagnostics = false,
      },
      zoom = { win = { minimal = false } },
    },
    picker = {
      -- layout = "left",
      formatters = { file = { filename_first = true } },
      previewers = { diff = { style = "terminal" } },
      win = {
        input = {
          keys = {
            ["<c-c>"] = { "stopinsert", mode = "i" },
            -- ["<cr>"] = { "stopinsert", mode = "i" }, -- want cr to still 'confirm' when in normal mode
            ["<esc>"] = { "cancel", mode = { "i", "n" } },
            ["<a-s-h>"] = { "toggle_hidden", mode = { "i", "n" } },
            ["<a-h>"] = false,
            ["<a-s>"] = { "flash", mode = { "n", "i" } },
            ["s"] = { "flash" },
          },
        },
        list = {
          keys = {
            ["<c-j>"] = false,
            ["<c-k>"] = false,
          }
        }
      },
      actions = {
        stopinsert = function(_)
          vim.cmd.stopinsert()
        end,
        flash = function(picker)
          require("flash").jump({
            pattern = "^",
            search = {
              mode = "search",
              exclude = {
                function(win)
                  return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "snacks_picker_list"
                end,
              },
            },
            action = function(match)
              local idx = picker.list:row2idx(match.pos[1])
              picker.list:_move(idx, true, true)
            end,
          })
        end,
      },
      layouts = {
        ---@type snacks.picker.layout.Config
        code_action = {
          auto_hide = { "input" },
          ---@type snacks.layout.Box
          layout = {
            box = "vertical",
            width = 0.5,
            min_width = 80,
            max_width = 100,
            -- height = 0.4,
            min_height = 2,
            max_height = 20,
            border = true,
            title = "{title}",
            title_pos = "center",
            { win = "input",   border = "bottom", height = 1, },
            { win = "list",    border = "none", },
            { win = "preview", border = "top",    title = "{preview}", height = 10, },
          }
        },
      },
      sources = {
        explorer = { hidden = true, exclude = { ".jj", ".pytest_cache", ".ruff_cache" }, layout = { preview = "main" } },
        files = { hidden = true, layout = "left" },
        recent = { hidden = true, layout = "left" },
        grep = { hidden = true, layout = "left" },
        marks = { layout = "left" },
        jumps = { layout = "left" },
        lsp_symbols = { --[[ focus = "list", ]] auto_close = false, layout = "right" },
        lsp_workspace_symbols = { --[[ focus = "list", ]] auto_close = false, layout = "right" },
        todo_comments = { focus = "list", auto_close = false, layout = "right" },
        diagnostics = { focus = "list", auto_close = false, layout = { preset = "bottom", preview = "main" } },
        diagnostics_buffer = { focus = "list", auto_close = false, layout = { preset = "bottom", preview = "main" } },
        -- keymaps = { layout = "bottom" },
        projects = { hidden = true, layout = "vscode" },
        buffers = {
          current = false,
          layout = {
            preset = "vscode",
            preview = "main",
            hidden = {},
          }
        },

        -- Custom Sources
        filetypes = {
          ---@type snacks.picker.finder
          ---@return snacks.picker.finder.Item[]
          finder = function(opts, ctx)
            return vim.iter(vim.fn.getcompletion("", "filetype")):map(function(ft)
              return { text = ft }
            end):totable()
          end,
          ---@type snacks.picker.format
          ---@param item snacks.picker.Item
          ---@return snacks.picker.Text[]
          format = function(item)
            local icon, icon_hl = Snacks.util.icon(item.text, "filetype")
            return {
              { icon or "", icon_hl or "SnacksPickerIcon" },
              { " ",        "" },
              { item.text,  "SnacksPickerLabel" },
            }
          end,
          ---@type snacks.picker.Action.spec
          confirm = function(picker, item)
            picker:close()
            vim.bo.filetype = item.text
          end,
          layout = {
            reverse = true,
            layout = {
              backdrop = false,
              row = -1,
              col = -1,
              box = "vertical",
              border = true,
              width = 20,
              height = 10,
              title = "{title}",
              { win = "list",  border = "none" },
              { win = "input", height = 1,     border = "top" },
            }
          },
        },

        chezmoi_files = {
          layout = "left",
          ---@type snacks.picker.finder
          finder = function(_opts, _ctx)
            local czc = require('chezmoi.commands')
            local targets = czc.list({ args = { "--include=files", "--path-style=absolute" } })
            return vim.iter(targets):map(function(absolute)
              return { text = absolute, file = absolute }
            end):totable()
          end,
          ---@type snacks.picker.Action.spec
          confirm = function(picker, item)
            picker:close()
            local czc = require('chezmoi.commands')
            czc.edit({ targets = item.file, args = { "--watch" } })
          end,
        },

        -- TODO: add preview to show help page for option (like FzfLua does)
        nvim_options = {
          layout = "default",
          preview = "preview",
          ---@type snacks.picker.finder
          ---@param opts vim.api.keyset.option Options for nvim_get_option_value
          ---@param ctx snacks.picker.finder.ctx
          ---@return snacks.picker.finder.Item[]
          finder = function(opts, ctx)
            local item
            local items = {}
            for name, info in pairs(vim.api.nvim_get_all_options_info()) do
              local ok, value = pcall(vim.api.nvim_get_option_value, name, {})
              if ok then
                item = {
                  name = name,
                  value = value,
                  type = (info.type or ""):gsub("^%l", string.upper),
                  info = info,
                }
                item.text = Snacks.picker.util.text(item, { "name", "value", "type" })
                -- item.file=
                item.preview = {
                  ft = "lua",
                  text = vim.iter(item.info):map(function(k, v)
                    v = type(v) == "string" and string.format("%q", v) or tostring(v)
                    return string.format("%s = %s", k, v)
                  end):fold("", function(acc, v)
                    return acc .. v .. "\n"
                  end)
                }
                items[#items + 1] = item
              end
            end
            -- table.sort(items, function(a, b) return a.name < b.name end)
            return ctx.filter:filter(items)
          end,
          ---@type snacks.picker.format
          format = function(item, picker)
            local shortname = item.info.shortname == "" and "" or "(" .. item.info.shortname .. ")"
            return {
              { picker.opts.icons.kinds[item.type] or "", "SnacksPickerIcon" .. item.type },
              { " ", "" },
              { ("%-20s"):format(item.name), "SnacksPickerLabel" },
              { ("%10s"):format(shortname), "SnacksPickerComment" },
              { "│ ", "SnacksPickerCol" },
              { tostring(item.value), item.value == item.info.default and "SnacksPickerUnselected" or "SnacksPickerSelected" },
            }
          end,
          -- When the user confirms an entry: prompt for new value.
          ---@type snacks.picker.Action.spec
          confirm = function(picker, item)
            picker:close()

            -- Prompt for a new value. Try to evaluate Lua literal input first.
            local prompt = "New value for " .. item.name .. ": "
            local default = vim.inspect(item.value)
            vim.ui.input({ prompt = prompt, default = default, completion = "lua" }, function(input)
              vim.cmd("stopinsert")
              if input == nil or input == "" then return end

              local parsed = input
              local ok, val = pcall(loadstring("return " .. input))
              if ok then parsed = val end

              if (item.type or ""):lower():match("number") then
                parsed = tonumber(input) or parsed
              elseif (item.type or ""):lower():match("boolean") then
                local lower = input:lower()
                if lower == "true" or lower == "1" then
                  parsed = true
                elseif lower == "false" or lower == "0" then
                  parsed = false
                end
              end

              local ok_set, err = pcall(vim.api.nvim_set_option_value, item.name, parsed, {})
              if not ok_set then
                vim.notify("Failed to set option " .. item.name .. ": " .. tostring(err), vim.log.levels.ERROR)
              else
                vim.notify("Set " .. item.name .. " = " .. vim.inspect(parsed), vim.log.levels.INFO)
              end
            end)
          end,
        },
      }
    }
  }
}
