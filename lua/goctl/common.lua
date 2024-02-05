local M = {}

local job = require("goctl.job")
local notify = require("goctl.notify")

---Check goctl binary
function M.goctl_check()
	local status = false
	local gopath = os.getenv("GOPATH")
	notify.info("Start to Check goctl binary")
	if gopath == "" then
		notify.error("%GOPATH not found")
		return status
	end
	local goctl, _ = io.open(os.getenv("GOPATH") .. "/bin/goctl", "r")
	if goctl ~= nil then
		status = true
		goctl:close()
	end
	return status
end

---Check goctl environment
function M.goctl_env()
	local cmd = { "goctl", "env" }
	job.new(cmd)
end

return M
