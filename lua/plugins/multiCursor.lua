if not vim.g.vscode then
	return {
		"jake-stewart/multicursor.nvim",
		branch = "1.0",
		event = "VeryLazy",
		config = function()
			local mc = require("multicursor-nvim")

			mc.setup()

			-- Add cursors above/below the main cursor.
			vim.keymap.set({ "n", "v" }, "<m-up>", function()
				mc.addCursor("k")
			end)
			vim.keymap.set({ "n", "v" }, "<m-down>", function()
				mc.addCursor("j")
			end)

			-- Add a cursor and jump to the next word under cursor.
			vim.keymap.set({ "n", "v" }, "<c-n>", function()
				mc.addCursor("*")
			end)

			-- Jump to the next word under cursor but do not add a cursor.
			vim.keymap.set({ "n", "v" }, "<c-s>", function()
				mc.skipCursor("*")
			end)

			-- Rotate the main cursor.
			vim.keymap.set({ "n", "v" }, "<m-left>", mc.nextCursor)
			vim.keymap.set({ "n", "v" }, "<m-right>", mc.prevCursor)

			-- Delete the main cursor.
			vim.keymap.set({ "n", "v" }, "<leader>x", mc.deleteCursor, { desc = "Delete Cursor" })

			-- Add and remove cursors with control + left click.
			vim.keymap.set("n", "<c-leftmouse>", mc.handleMouse)

			vim.keymap.set({ "n", "v" }, "<c-q>", function()
				if mc.cursorsEnabled() then
					-- Stop other cursors from moving.
					-- This allows you to reposition the main cursor.
					mc.disableCursors()
				else
					mc.addCursor()
				end
			end)

			vim.keymap.set("n", "<esc>", function()
				if not mc.cursorsEnabled() then
					mc.enableCursors()
				elseif mc.hasCursors() then
					mc.clearCursors()
				else
					-- Default <esc> handler.
				end
			end)

			-- Align cursor columns.
			vim.keymap.set("n", "<leader>a", mc.alignCursors)

			-- Split visual selections by regex.
			vim.keymap.set("v", "S", mc.splitCursors)

			-- Append/insert for each line of visual selections.
			vim.keymap.set("v", "I", mc.insertVisual)
			vim.keymap.set("v", "A", mc.appendVisual)

			-- match new cursors within visual selections by regex.
			vim.keymap.set("v", "M", mc.matchCursors)

			-- Rotate visual selection contents.
			vim.keymap.set("v", "<leader>t", function()
				mc.transposeCursors(1)
			end)
			vim.keymap.set("v", "<leader>T", function()
				mc.transposeCursors(-1)
			end)

			-- Customize how cursors look.
			vim.api.nvim_set_hl(0, "MultiCursorCursor", { link = "Cursor" })
			vim.api.nvim_set_hl(0, "MultiCursorVisual", { link = "Visual" })
			vim.api.nvim_set_hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
			vim.api.nvim_set_hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
		end,
	}
end

return {}
