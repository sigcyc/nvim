return {
    "SUSTech-data/neopyter",
    dependencies = {
      'AbaoFromCUG/websocket.nvim',  -- for mode='direct'
    },

    ---@type neopyter.Option
    opts = { mode="direct",
        remote_address = "127.0.0.1:9001",
        file_pattern = { "*.ju.*" },
        on_attach = function(bufnr)
            -- Auto-continue the "# " comment leader on new lines, so opening a
            -- line in a markdown cell (o/O) or pressing <CR> keeps the prefix.
            vim.bo[bufnr].formatoptions = vim.bo[bufnr].formatoptions .. "ro"

            -- Insert a cell marker below the current line, then drop into
            -- insert mode on the line beneath the marker.
            local function new_cell(lines, at_eol)
                local row = vim.api.nvim_win_get_cursor(0)[1]
                vim.api.nvim_buf_set_lines(bufnr, row, row, false, lines)
                vim.api.nvim_win_set_cursor(0, { row + #lines, 0 })
                vim.cmd(at_eol and "startinsert!" or "startinsert")
            end

            -- <space>n: new code cell ("# %%"), cursor at the start of the next line
            vim.keymap.set("n", "<space>n", function()
                new_cell({ "# %%", "" }, false)
            end, { buffer = bufnr, desc = "Neopyter: new code cell" })

            -- <space>c: new markdown/comment cell ("# %% [markdown]"), cursor after "# "
            vim.keymap.set("n", "<space>c", function()
                new_cell({ "# %% [markdown]", "# " }, true)
            end, { buffer = bufnr, desc = "Neopyter: new markdown cell" })

            -- <space>r: run the current cell
            vim.keymap.set("n", "<space>r", "<cmd>Neopyter execute notebook:run-cell<cr>",
                { buffer = bufnr, desc = "Neopyter: run current cell" })
        end,
    },
}
