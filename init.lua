vim.opt.runtimepath:append("/Users/emre/.local/share/nvim/site")

-- Add this at the top of init.lua to fix older plugins
if not vim.lsp.get_active_clients then
	vim.lsp.get_active_clients = vim.lsp.get_clients
end

require("engram.core")
require("engram.lazy")
