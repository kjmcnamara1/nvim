if profile() ~= "vscode" then
  return
end

local vscode = require("vscode-neovim")

vim.notify = vscode.notify

wk.add({
  { "n", "<leader>f",  function() vscode.action("workbench.action.quickOpen") end },
  { "n", "<leader>r",  function() vscode.action("workbench.action.openRecent") end },
  { "n", "<leader>,",  function() vscode.action("workbench.action.showAllEditors") end },
  { "n", "<leader>'",  function() vscode.action("workbench.action.openNextRecentlyUsedEditorInGroup") end },
  { "n", "<leader>e",  function() vscode.action("workbench.view.explorer") end },
  { "n", "<leader>bn", function() vscode.action("workbench.action.files.newUntitledFile") end },

  { "n", "<leader>t",  function() vscode.action("workbench.action.editor.changeLanguageMode") end },

  { "n", "<leader>sk", function() vscode.action("workbench.action.openGlobalKeybindings") end },

  { "n", "]d",         function() vscode.action("editor.action.marker.next") end },
  { "n", "[d",         function() vscode.action("editor.action.marker.prev") end },
  { "n", "<leader>sd", function() vscode.action("workbench.actions.view.problems") end },

  { "n", "]h",         function() vscode.action("workbench.action.editor.nextChange") end },     -- next hunk
  { "n", "[h",         function() vscode.action("workbench.action.editor.previousChange") end }, -- prev hunk

  { "n", "<leader>ui", function() vscode.action("editor.action.inspectTMScopes") end },
  { "n", "<leader>uC", function() vscode.action("workbench.action.selectTheme") end },
  { "n", "<a-z>",      function() vscode.action("workbench.action.toggleZenMode") end },

  { "n", "za",         function() vscode.action("editor.toggleFold") end },
  { "n", "zc",         function() vscode.action("editor.fold") end },
  { "n", "zC",         function() vscode.action("editor.foldRecursively") end },
  { "n", "zo",         function() vscode.action("editor.unfold") end },
  { "n", "zO",         function() vscode.action("editor.unfoldRecursively") end },
  { "n", "zM",         function() vscode.action("editor.foldAll") end },
  { "n", "zR",         function() vscode.action("editor.unfoldAll") end },

  {
    mode = { "n", "x" },
    { "grr",       function() vscode.action("editor.action.referenceSearch.trigger") end },
    { "grn",       function() vscode.action("editor.action.rename") end },
    { "g.",        function() vscode.action("editor.action.quickFix") end },
    { "go",        function() vscode.action("workbench.action.gotoSymbol") end },
    { "gO",        function() vscode.action("workbench.action.showAllSymbols") end },
    { "<leader>k", function() vscode.action("editor.action.showHover") end },
  }
})
