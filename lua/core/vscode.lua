local vscode = require("vscode-neovim")

vim.notify = vscode.notify

vim.keymap.set({ "n", "x" }, "gs", function() vscode.action("workbench.action.gotoSymbol") end)
vim.keymap.set({ "n", "x" }, "gr", function() vscode.action("editor.action.referenceSearch.trigger") end)
vim.keymap.set("n", "<leader>z", function() vscode.action("workbench.action.toggleZenMode") end)
vim.keymap.set("n", "]h", function() vscode.action("workbench.action.editor.nextChange") end)
vim.keymap.set("n", "[h", function() vscode.action("workbench.action.editor.previousChange") end)
vim.keymap.set("n", "]d", function() vscode.action("editor.action.marker.next") end)
vim.keymap.set("n", "[d", function() vscode.action("editor.action.marker.prev") end)
