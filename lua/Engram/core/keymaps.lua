local opts = { noremap = true, silent = true }
vim.g.mapleader = " "
local keymap = vim.keymap -- for conciseness

-- source the current file - :source %
-- keymap.set("n", "<leader><leader>", function()
--     vim.cmd("so")
-- end)

keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) 
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) 

keymap.set("n", "J", "mzJ`z", { desc = "join the lines" })
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })
keymap.set("n", "n", "nzzzv", { desc = "go to next item in buffer with cursor centered" })
keymap.set("n", "N", "Nzzzv", { desc = "go to prev item in buffer with cursor centered" })

-- indent selection in visual mode
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Del w/o yanked" })
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste w/o losing" })

keymap.set("i", "<C-c>", "<Esc>", { desc = "Return the normal mode"})
keymap.set("n", "<C-c>", ":nohl<CR>", { desc = "Clear search hl", silent = true })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal size
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split

-- tab management
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close new tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) -- go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to prev tab" }) -- go to prev tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) -- open current buffer in new tab

-- Copy filepath to the clipboard
vim.keymap.set("n", "<leader>cfp", function()
    local filePath = vim.fn.expand("%:~")
    vim.fn.setreg("+", filePath)
    print("File path copied to clipboard: " .. filePath)
end, { desc = "Copy file path to clipboard" })

-- restart 
vim.keymap.set("n", "<leader>rsv", "<cmd>restart<cr>", { desc = "Restart Neovim (:restart)", })
