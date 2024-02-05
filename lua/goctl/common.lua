local M = {}

local job = require("goctl.job")

---Check goctl environment
function M.goctl_env()
	local cmd = { "goctl", "env" }
	job.new(cmd)
end

return M
