-- Initialiez LuaLine

function InitLuaLine()
	-- Function that returns string for git status
	local function get_git_status()
		local status = vim.fn.systemlist("git status --porcelain")
		local added, unstaged, modified, deleted, untracked = 0, 0, 0, 0, 0

		for _, line in ipairs(status) do
			local change = line:sub(1, 2)
			if change == "A " or change == "AM" or change == "M " or change == "MM" then
				added = added + 1
			end
			if change == " M" or change == "MM" then
				unstaged = unstaged + 1
				-- modified = modified + 1
			end
			if change == " D" or change == "MD" then
				deleted = deleted + 1
			end
			if change == "??" then
				untracked = untracked + 1
			end
		end

		local statusFinal = ""
		if added > 0 then statusFinal = statusFinal .. string.format("+%d ", added) end
		if unstaged > 0 then statusFinal = statusFinal .. string.format("!%d ", unstaged) end
		if modified > 0 then statusFinal = statusFinal .. string.format("!%d ", modified) end
		if deleted > 0 then statusFinal = statusFinal .. string.format("-%d ", deleted) end
		if untracked > 0 then statusFinal = statusFinal .. string.format("?%d", untracked) end

		return statusFinal
		--return string.format("*%d +%d -%d ?%d", added, modified, deleted, untracked)
	end

	require('lualine').setup {
		options = {
			icons_enabled = true,
			theme = 'auto',
			component_separators = { left = '', right = '' },
			section_separators = { left = '', right = '' },
			disabled_filetypes = {
				statusline = {},
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = false,
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
			}
		},
		sections = {
			lualine_a = { 'mode' },
			lualine_b = { 'branch', 'diff', 'diagnostics', get_git_status },
			lualine_c = { 'filename' },
			lualine_x = { 'encoding', 'fileformat', 'filetype' },
			lualine_y = { 'progress' },
			lualine_z = { 'location' }
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { 'filename' },
			lualine_x = { 'location' },
			lualine_y = {},
			lualine_z = {}
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {}
	}
end

if not vim.g.vscode then InitLuaLine() end
