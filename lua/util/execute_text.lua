local M = {}
M.options = {}

local defaults = {
  quote_printed_strings = false,
}

M.options = vim.tbl_deep_extend("force", {}, defaults)

--- Execute string of text
--- Can output multiline statements w/ print, or single line expressions, but
--- not both
---@param text string The text to execute
---@param quote_printed_strings? boolean Whether to quote strings printed by `print`
---@return string result Result of the execution
function M.execute_text(text, quote_printed_strings)
  quote_printed_strings = quote_printed_strings or M.options.quote_printed_strings
  local output_lines = {}
  local system_print = print

  -- Mock `print` function
  _G.print = function(...)
    local args = table.pack(...)
    local print_call_output = {}
    for i = 1, args.n do
      local arg = not quote_printed_strings and type(args[i]) == "string" and args[i] or vim.inspect(args[i])
      table.insert(print_call_output, arg)
    end
    table.insert(output_lines, table.concat(print_call_output, " "))
  end

  -- Try to return results of code or the original code itself if it fails
  local function populate_output(code)
    -- Load first as an expression to capture 'returned' results
    local chunk, err = load("return " .. text)
    -- If not an expression, load as a statement
    -- (capturing mocked print statements)
    if not chunk then
      chunk, err = load(code)
    end
    -- Finally default to error and return original code
    if not chunk then
      vim.notify_once("Lua Syntax Error: " .. err, vim.log.levels.ERROR)
      return code
    end

    -- Execute code
    local chunk_call_output = table.pack(pcall(chunk))
    if not chunk_call_output[1] then
      vim.notify_once("Lua Runtime Error: " .. chunk_call_output, vim.log.levels.ERROR)
      return code
    end

    -- Concatenate expression outputs into single line with ", "
    local chunk_output = {}
    for i = 2, chunk_call_output.n do
      table.insert(chunk_output, vim.inspect(chunk_call_output[i]))
    end
    table.insert(output_lines, table.concat(chunk_output, ", "))

    -- Concatenate all output lines into a single multiline string
    return table.concat(output_lines, "\n")
  end

  local output = populate_output(text)
  -- Restore original print function
  _G.print = system_print
  return output
end

local function test_execute_text()
  local code1 = [[
for _, p in ipairs(vim.pack.get(nil, { info = false })) do
  print(p.spec.name)
end
]]

  local code2 = "vim.lsp.get_clients()[1].capabilities.textDocument.completion"

  local code3 = "5*4+2"

  local code4 = [[
for i = 1, 3 do
  print(i)
end
vim.pack.get({ "plenary.nvim" }, { info = false })
]]

  local x = M.execute_text(code1)
  print(x)

  local y = M.execute_text(code2)
  print(y)

  local z = M.execute_text(code3)
  print(z)

  local w = M.execute_text(code4)
  print(w)
end

return M
