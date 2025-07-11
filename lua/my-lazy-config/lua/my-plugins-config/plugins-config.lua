local config_path = debug.getinfo(1, "S").source:sub(2):match("(.*/)")
package.path = config_path .. "lua/?.lua;" .. package.path
require("nvim-tree-config")

require("nvim-web-devicons").setup({
	default = true, -- Enable default icons
})

require("cmp").setup({
	mapping = require("cmp").mapping.preset.insert({
		["<Down>"] = require("cmp").mapping.select_next_item({ behavior = require("cmp").SelectBehavior.Select }),
		["<Up>"] = require("cmp").mapping.select_prev_item({ behavior = require("cmp").SelectBehavior.Select }),
		["<CR>"] = require("cmp").mapping.confirm({ select = true }),
	}),
	-- Enable sources for completion
	sources = {
		{ name = "copilot" }, -- Copilot completion
		{ name = "nvim_lsp" }, -- LSP (Language Server Protocol)
		{ name = "buffer" }, -- Completion from current buffer
		{ name = "path" }, -- File path completion
	},
})

require("CopilotChat").setup({
	window = {
		position = "vertical right", -- Position of the chat window
		width = 30, -- Height of the chat window
	},
	mappings = {
		complete = false, -- disables the <Tab> mapping for completion
	},
	chat_autocomplete = true,
	auto_insert_mode = true,
	insert_at_end = true,
})

local theme = {
	fill = "TabLineFill",
	-- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
	head = "TabLine",
	current_tab = "TabLineSel",
	tab = "TabLine",
	win = "TabLine",
	tail = "TabLine",
}
require("tabby.tabline").set(function(line)
	return {
		{
			{ "  ", hl = theme.head },
			line.sep("", theme.head, theme.fill),
		},
		line.tabs().foreach(function(tab)
			local hl = tab.is_current() and theme.current_tab or theme.tab
			return {
				line.sep("", hl, theme.fill),
				tab.is_current() and "" or "󰆣",
				tab.number(),
				tab.name(),
				tab.close_btn(""),
				line.sep("", hl, theme.fill),
				hl = hl,
				margin = " ",
			}
		end),
		line.spacer(),
		line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
			return {
				line.sep("", theme.win, theme.fill),
				win.is_current() and "" or "",
				win.buf_name(),
				line.sep("", theme.win, theme.fill),
				hl = theme.win,
				margin = " ",
			}
		end),
		{
			line.sep("", theme.tail, theme.fill),
			{ "  ", hl = theme.tail },
		},
		hl = theme.fill,
	}
end)

require("vgit").setup()
require("gitsigns").setup()
require("gitblame").setup()
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"javascript",
		"typescript",
		"json",
		"tsx",
		"lua",
		"java",
	}, -- Install all parsers
	highlight = {
		enable = true, -- Enable syntax highlighting
	},
	indent = {
		enable = true, -- Enable indentation
	},
})

require("fzf-lua").setup({})
