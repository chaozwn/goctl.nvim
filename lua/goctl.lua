local M = {}
local api = vim.api

local common = require("goctl.common")
local goctl_api = require("goctl.api")

-- variable
local FILETYPE = "goctl"
local AUGROUP = "Goctl"

local function set_autocommands()
	api.nvim_create_augroup(AUGROUP, { clear = true })

	local atcmd = api.nvim_create_autocmd

	atcmd({ "BufRead", "BufNewFile" }, {
		pattern = "*.api",
		group = AUGROUP,
		nested = true,
		callback = function()
			vim.cmd("set filetype=" .. FILETYPE)
		end,
	})

	atcmd({ "BufRead", "TextChanged", "TextChangedI" }, {
		pattern = "*.api",
		group = AUGROUP,
		nested = true,
		callback = goctl_api.validate,
	})
end

local function set_commands()
	local cmd = api.nvim_create_user_command
	cmd("GoctlEnv", common.goctl_env, {})
	-- util ---
	cmd("GoctlApiFormat", goctl_api.format, {})
end

function M.setup()
	set_autocommands()
	set_commands()
end

return M
