vim.keymap.set("n", "<leader>go", "<cmd>OpenFileInRepo<cr>", { desc = "Open in web browser" })
vim.keymap.set("n", "<leader>gO", "<cmd>OpenLineInRepo<cr>", { desc = "Open in web browser, including current line" })
vim.keymap.set("n", "<leader>gy", "<cmd>YankFileUrl +<cr>", { desc = "Yank Url to system clipboard" })
vim.keymap.set(
	"n",
	"<leader>gY",
	"<cmd>YankLineUrl +<cr>",
	{ desc = "Yank Url to system clipboard, including current line" }
)
vim.keymap.set("n", "<leader>gm", "<cmd>OpenFileInMain<cr>", { desc = "Open in web browser on main branch" })
vim.keymap.set("n", "<leader>gyM", "<cmd>YankFileUrlOnMain +<cr>", { desc = "Yank Url on main branch to clipboard" })
