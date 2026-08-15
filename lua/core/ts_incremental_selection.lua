--- Incremental node selection.
---
--- nvim-treesitter's `main` branch dropped its `incremental_selection` module
--- (the rewrite only ships parser installation + queries), and Neovim has no
--- built-in equivalent, so the behaviour lives here.
---
--- Selection history is kept as a per-buffer stack of ranges so that
--- decrementing returns to exactly what was selected before, rather than
--- guessing a child node.

local M = {}

---@alias TSRange { [1]: integer, [2]: integer, [3]: integer, [4]: integer }

---@type table<integer, TSRange[]>
local history = {}

---@param node TSNode
---@return TSRange
local function node_range(node)
	local sr, sc, er, ec = node:range()
	return { sr, sc, er, ec }
end

---@param a TSRange
---@param b TSRange
---@return boolean
local function same(a, b)
	return a[1] == b[1] and a[2] == b[2] and a[3] == b[3] and a[4] == b[4]
end

--- Whether `outer` fully covers `inner`.
---@param outer TSRange
---@param inner TSRange
---@return boolean
local function covers(outer, inner)
	local starts_before = outer[1] < inner[1] or (outer[1] == inner[1] and outer[2] <= inner[2])
	local ends_after = outer[3] > inner[3] or (outer[3] == inner[3] and outer[4] >= inner[4])
	return starts_before and ends_after
end

--- Current visual selection as a 0-indexed, end-exclusive range.
---@return TSRange
local function visual_range()
	local anchor = vim.fn.getpos("v")
	local cursor = vim.fn.getpos(".")
	local a = { anchor[2] - 1, anchor[3] - 1 }
	local c = { cursor[2] - 1, cursor[3] - 1 }
	if a[1] > c[1] or (a[1] == c[1] and a[2] > c[2]) then
		a, c = c, a
	end
	return { a[1], a[2], c[1], c[2] + 1 }
end

---@param range TSRange
local function select_range(range)
	local sr, sc, er, ec = range[1], range[2], range[3], range[4]

	-- End column is exclusive; visual mode needs the last covered character.
	if ec > 0 then
		ec = ec - 1
	else
		er = math.max(er - 1, sr)
		local line = vim.api.nvim_buf_get_lines(0, er, er + 1, false)[1] or ""
		ec = math.max(#line - 1, 0)
	end

	if vim.fn.mode():match("^[vV\22]") then
		vim.cmd("normal! \27")
	end
	vim.fn.setpos(".", { 0, sr + 1, sc + 1, 0 })
	vim.cmd("normal! v")
	vim.fn.setpos(".", { 0, er + 1, ec + 1, 0 })
end

--- Smallest node strictly larger than `range`.
---@param range TSRange
---@return TSNode?
local function enclosing_node(range)
	local ok, node = pcall(vim.treesitter.get_node, { bufnr = 0, pos = { range[1], range[2] } })
	if not ok then
		return nil
	end
	while node do
		local r = node_range(node)
		if covers(r, range) and not same(r, range) then
			return node
		end
		node = node:parent()
	end
	return nil
end

--- Select the node under the cursor, starting a fresh selection history.
function M.init_selection()
	local ok, node = pcall(vim.treesitter.get_node, { bufnr = 0 })
	if not ok or not node then
		return
	end
	local range = node_range(node)
	history[vim.api.nvim_get_current_buf()] = { range }
	select_range(range)
end

--- Grow the selection to the next enclosing node.
function M.node_incremental()
	local buf = vim.api.nvim_get_current_buf()
	local stack = history[buf]
	local current = (stack and stack[#stack]) or visual_range()

	local node = enclosing_node(current)
	if not node then
		return
	end

	local range = node_range(node)
	if not stack then
		stack = { current }
		history[buf] = stack
	end
	table.insert(stack, range)
	select_range(range)
end

--- Shrink back to the previously selected node.
function M.node_decremental()
	local stack = history[vim.api.nvim_get_current_buf()]
	if not stack or #stack < 2 then
		return
	end
	table.remove(stack)
	select_range(stack[#stack])
end

vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
	group = vim.api.nvim_create_augroup("TSIncrementalSelection", { clear = true }),
	callback = function(args)
		history[args.buf] = nil
	end,
})

return M
