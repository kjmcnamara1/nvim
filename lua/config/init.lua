local M={}

function M.map_keys(mode,lhs,rhs,opts)
	local default_opts={noremap=true,silent=true}
	local new_opts=vim.tbl_deep_extend('force',default_opts,opts or {})

	return vim.keymap.set(mode,lhs,rhs,new_opts)
end

function M.augroup(name)
  return vim.api.nvim_create_augroup("custom_" .. name, { clear = true })
end

return M
