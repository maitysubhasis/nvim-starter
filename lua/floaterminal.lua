
local state = {
    buf = nil,
    win = nil,
}

-- Function to create a centered floating window
local function create_floating_window(opts)
    opts = opts or {}

    -- Get editor dimensions
    local width = vim.o.columns
    local height = vim.o.lines

    -- Calculate window size (80% by default, or use provided percentages)
    local win_width = math.floor(width * (opts.width_percent or 0.8))
    local win_height = math.floor(height * (opts.height_percent or 0.8))

    -- Calculate starting position to center the window
    local row = math.floor((height - win_height) / 2)
    local col = math.floor((width - win_width) / 2)

    -- Create a new buffer if it doesn't exist
    if not state.buf or not vim.api.nvim_buf_is_valid(state.buf) then
        state.buf = vim.api.nvim_create_buf(false, true) -- not listed, scratch buffer
    end

    -- Define window configuration
    local win_opts = {
        relative = 'editor',
        width = win_width,
        height = win_height,
        row = row,
        col = col,
        style = 'minimal',
        border = 'rounded', -- rounded border
    }

    -- Create the floating window
    state.win = vim.api.nvim_open_win(state.buf, true, win_opts)

    -- Start terminal in the buffer if not already started
    if vim.bo[state.buf].buftype ~= 'terminal' then
        vim.fn.termopen(vim.o.shell)
    end

    -- Enter insert mode automatically
    vim.cmd('startinsert')

    return { buf = state.buf, win = state.win }
end

-- Function to toggle the floating terminal
local function toggle_floating_terminal()
    -- Check if window is open and valid
    if state.win and vim.api.nvim_win_is_valid(state.win) then
        -- Close the window
        vim.api.nvim_win_close(state.win, true)
        state.win = nil
    else
        -- Open the floating terminal
        create_floating_window()
    end
end

-- Set up the keymap for Ctrl+j
vim.keymap.set({'n', 't'}, '<C-j>', toggle_floating_terminal, {
    noremap = true,
    silent = true,
    desc = 'Toggle floating terminal'
})

-- Optional: Add Escape key in terminal mode to exit to normal mode
-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', {
--     noremap = true,
--     silent = true,
--     desc = 'Exit terminal mode'
-- 
