-- XXX: GENERATED FILE - DO NOT EDIT (matugen)
-- hl search: primary
local hls_color = { bg = "{{colors.primary.default.hex}}", fg = "{{colors.on_primary.default.hex}}" }
vim.api.nvim_set_hl(0, "Search", hls_color)
vim.api.nvim_set_hl(0, "CurSearch", hls_color)

-- Cursor: secondary
-- vim.api.nvim_set_hl(0, "Cursor", { fg = "{{colors.primary_container.default.hex}}" })

-- Selection: tertiary
vim.api.nvim_set_hl(0, "Visual", {
	bg = "{{colors.tertiary.default.hex}}",
	fg = "{{colors.on_tertiary.default.hex}}",
})

-- lsp auto hover: surface
vim.api.nvim_set_hl(0, "LspReferenceText", { bg = "{{colors.surface.default.hex}}" })
vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = "{{colors.surface.default.hex}}" })
vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = "{{colors.surface.default.hex}}" })
