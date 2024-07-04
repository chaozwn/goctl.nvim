local M = {}

local api, fn = vim.api, vim.fn
local ns = api.nvim_create_namespace("goctl.nvim")

---
--- validate stderr event
---
local function on_validate_stderr(_, data)
	vim.diagnostic.reset(ns, 0)

	for _, item in ipairs(data) do
		local msg = string.match(item, "%d+:%d+[^\n]+")
		if msg ~= nil and msg ~= "" then
			local i = string.find(msg, ":")
			local j = string.find(msg, " ")
			local row = tonumber(string.sub(msg, 0, i - 1))
			local col = tonumber(string.sub(msg, i + 1, j))
			msg = string.sub(msg, j + 1)
      -- stylua: ignore
      vim.diagnostic.set(ns, 0, { {
        bufnr = 0,
        lnum = row - 1,
        col = col,
        source = "goctl",
        message = msg,
      } }, nil)
		end
	end
end

---
---Validate api file
---
function M.validate()
	local cmd = { "goctl", "api", "format", "--stdin" }
	local job_id = fn.jobstart(cmd, {
		on_stderr = on_validate_stderr,
		stderr_buffered = true,
	})
	local lines = api.nvim_buf_get_lines(0, 0, -1, false)
	fn.chansend(job_id, lines)
	fn.chanclose(job_id, "stdin")
end

local function on_format(job_id, data, event)
	if event == "stdout" and not vim.tbl_isempty(data) then
		vim.cmd([[edit!]])
	elseif event == "stderr" and not vim.tbl_isempty(data) then
		vim.notify(table.concat(data, "\n"), vim.log.levels.ERROR)
	end
end

---
--- Format api file and save it before formatting
---
function M.format()
	vim.cmd([[update]])

	local path = vim.api.nvim_buf_get_name(0)
	local cmd = { "goctl", "api", "format", "--dir", path }
	vim.fn.jobstart(cmd, {
		on_stdout = on_format,
		on_stderr = on_format,
	})
end

return M
