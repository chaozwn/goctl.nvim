local config = {}
local common = require("goctl.common")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values
local goctl_api = require("goctl.api")
local goctl_rpc = require("goctl.rpc")
local goctl_model = require("goctl.model")

local function subcommands(opts)
	if config.theme then
		opts = vim.tbl_deep_extend("force", opts or {}, config.theme)
	end
	local cmds = require("telescope.command").get_extensions_subcommand().goctl
	cmds = vim.tbl_filter(function(v)
		return v ~= "goctl"
	end, cmds)

	pickers
			.new(opts, {
				prompt_title = "Telescope Goctl",
				finder = finders.new_table({
					results = cmds,
				}),
				-- sorter = conf.generic_sorter(opts),
				attach_mappings = function(prompt_bufnr)
					actions.select_default:replace(function()
						local selection = action_state.get_selected_entry()
						actions.close(prompt_bufnr)
						vim.defer_fn(function()
							require("telescope").extensions.goctl[selection.value](opts)
						end, 20)
					end)
					return true
				end,
			})
			:find()
end

return require("telescope").register_extension({
	setup = function(ext_config)
		if ext_config.theme then
			config.theme = require("telescope.themes")["get_" .. ext_config.theme]()
		end
		if ext_config.prefer_locations then
			config.prefer_locations = true
		end
	end,
	exports = {
		goctl = subcommands,
		env = common.goctl_env,
		upgrade = common.install_or_upgrade,
		format = goctl_api.format,
		api_new = goctl_api.new,
		api_doc = goctl_api.doc,
		api_generate = goctl_api.generate,
		api_menu = goctl_api.menu,
		rpc_new = goctl_rpc.new,
		rpc_protoc = goctl_rpc.protoc,
		model_menu = goctl_model.menu,
	},
})
