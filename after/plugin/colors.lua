-- require('base16').setup({
--     options = {
--         theme = "nordfox",
--         transparent = true,
--     },
-- })

function ColorMyPencils(color)
	color = color or "monokai_pro"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
