if not vim.g.vscode then
	local function get_attached_clients()
		-- Get active clients for current buffer
		local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
		if #buf_clients == 0 then
			return ""
		end
		local buf_ft = vim.bo.filetype
		local buf_client_names = {}
		local num_client_names = #buf_client_names

		-- Add linters for the current filetype (nvim-lint)
		local lint_success, lint = pcall(require, "lint")
		if lint_success then
			for ft, ft_linters in pairs(lint.linters_by_ft) do
				if ft == buf_ft then
					if type(ft_linters) == "table" then
						for _, linter in pairs(ft_linters) do
							num_client_names = num_client_names + 1
							buf_client_names[num_client_names] = linter .. "..L"
						end
					else
						num_client_names = num_client_names + 1
						buf_client_names[num_client_names] = ft_linters .. "..L"
					end
				end
			end
		end

		-- Add formatters (conform.nvim)
		local conform_success, conform = pcall(require, "conform")
		if conform_success then
			for _, formatter in pairs(conform.list_formatters_for_buffer(0)) do
				if formatter then
					num_client_names = num_client_names + 1
					buf_client_names[num_client_names] = formatter .. "..F"
				end
			end
		end

		table.sort(buf_client_names)
		local client_names_str = table.concat(buf_client_names, ", ")
		local language_servers = string.format("[%s]", client_names_str)

		return language_servers
	end

	return {
		"nvim-lualine/lualine.nvim",
		event = { "VimEnter", "BufReadPost", "BufNewFile" },
		config = function()
			local attached_clients = { get_attached_clients }
			-- Example lualine setup
			require("lualine").setup({
				options = {
					section_separators = { left = "", right = "" },
					component_separators = { left = "", right = "" },
					icons_enabled = true,
					theme = "OceanicNext",
					globalstatus = true,
				},

				sections = {
					lualine_x = { attached_clients, "lsp_status" },
					lualine_y = { "filetype", "progress" },
				},
			})
		end,
	}
end

return {}
