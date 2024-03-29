local map=require('config').map_keys

require('Comment').setup({
  ignore = "^%s*$", -- Ignore blank lines
})

map('i','<c-_>',require('Comment.api').toggle.linewise.current,{desc='Toggle comment'})
