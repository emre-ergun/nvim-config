vim.opt.runtimepath:append("/Users/emre/.local/share/nvim/site")

-- fix the deprecated get_active_clients
if not vim.lsp.get_active_clients then
	vim.lsp.get_active_clients = vim.lsp.get_clients
end

require("engram.core")
require("engram.lazy")
require("current-theme")
