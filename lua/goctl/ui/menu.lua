local M = {}

local Menu = require("nui.menu")

---
--- new menu component
---
---@param  title string
---@param  items table
---@param  on_submit function
---@param  on_change? function
function M:new(title, items, on_submit, on_change)
	M.items = items

	local lines = {}
	for _, v in ipairs(items) do
		table.insert(lines, Menu.item(v.text, v))
	end
	local menu = Menu({
		position = "50%",
		size = {
			width = 25,
			height = 10,
		},
		border = {
			style = "single",
			text = {
				top = "[" .. title .. "]",
				top_align = "center",
			},
		},
		win_options = {
			winhighlight = "Normal:Normal,FloatBorder:Normal",
		},
	}, {
		lines = lines,
		max_width = 30,
		keymap = {
			focus_next = { "j", "<Down>", "<Tab>" },
			focus_prev = { "k", "<Up>", "<S-Tab>" },
			close = { "<Esc>", "<C-c>" },
			submit = { "<CR>", "<Space>" },
		},
		on_close = function() end,
		on_submit = on_submit,
		on_change = on_change,
	})

	M.payload = menu

	return M
end

function M:display()
	M.payload:mount()
end

return M