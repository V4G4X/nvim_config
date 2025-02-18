local M = {}

function M.get_visual_selection()
    local current_clipboard_content = vim.fn.getreg('"')
    vim.cmd('noau normal! "vy"')
    local text = vim.fn.getreg('v')
    vim.fn.setreg('v', {})
    vim.fn.setreg('"', current_clipboard_content)
    text = string.gsub(text, "\n", "")
    if #text > 0 then
        return text
    else
        return ''
    end
end

return M
