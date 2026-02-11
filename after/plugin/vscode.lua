if profile() ~= "vscode" then
  return
end

local vscode = require("vscode")

vim.notify = vscode.notify

wk.add({
  { "<leader>f",  function() vscode.action("workbench.action.quickOpen") end },
  { "<leader>r",  function() vscode.action("workbench.action.openRecent") end },
  { "<leader>,",  function() vscode.action("workbench.action.showAllEditors") end },
  { "<leader>'",  function() vscode.action("workbench.action.openNextRecentlyUsedEditorInGroup") end },
  { "<leader>e",  function() vscode.action("workbench.view.explorer") end },
  { "<leader>bn", function() vscode.action("workbench.action.files.newUntitledFile") end },

  { "<leader>t",  function() vscode.action("workbench.action.editor.changeLanguageMode") end },

  { "<leader>sk", function() vscode.action("workbench.action.openGlobalKeybindings") end },

  { "]d",         function() vscode.action("editor.action.marker.next") end },
  { "[d",         function() vscode.action("editor.action.marker.prev") end },
  { "<leader>sd", function() vscode.action("workbench.actions.view.problems") end },

  { "]h",         function() vscode.action("workbench.action.editor.nextChange") end },     -- next hunk
  { "[h",         function() vscode.action("workbench.action.editor.previousChange") end }, -- prev hunk

  { "<leader>ui", function() vscode.action("editor.action.inspectTMScopes") end },
  { "<leader>uC", function() vscode.action("workbench.action.selectTheme") end },
  { "<a-z>",      function() vscode.action("workbench.action.toggleZenMode") end },

  { "za",         function() vscode.action("editor.toggleFold") end },
  { "zc",         function() vscode.action("editor.fold") end },
  { "zC",         function() vscode.action("editor.foldRecursively") end },
  { "zo",         function() vscode.action("editor.unfold") end },
  { "zO",         function() vscode.action("editor.unfoldRecursively") end },
  { "zM",         function() vscode.action("editor.foldAll") end },
  { "zR",         function() vscode.action("editor.unfoldAll") end },

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
