--- keymaps include all the maps that don't need any plugin
--- it also includes the Alt commands as those are typically the mostly used keymaps

local function map(mode, shortcut, func, opt)
  local platform_key = vim.fn.has('mac') == 1 and '<M-' or '<A-'
  vim.keymap.set(mode, platform_key .. shortcut .. '>', func, opt)
end
local function nmap(shortcut, func, opt)
  map('n', shortcut, func, opt)
end
local function tmap(shortcut, func, opt)
  map('t', shortcut, "<C-\\><C-N>" .. func, opt)
end
local function ntmap(shortcut, func, opt)
  nmap(shortcut, func, opt)
  tmap(shortcut, func, opt)
end

local function ntmapi(shortcut, func, opt)
  nmap(shortcut, func, opt)
  tmap(shortcut, func .. 'i', opt)
end

--- movement
ntmap('k', '<C-w>k')
ntmap('l', '<C-w>l')
ntmap('j', '<C-w>j')
ntmap('h', '<C-w>h')
ntmap('f', '<C-d>')
ntmap('d', '<C-u>')

--- window
ntmap('w', '<cmd>hid<CR>')
ntmap('q', '<cmd>q<CR>')
ntmapi('v', '<cmd>vsplit<CR>')
ntmapi('i', '<cmd>split<CR>')
ntmapi('t', '<cmd>tabnew<CR>')
ntmapi('x', '<C-w>x')
ntmapi('H', '<C-w>H')
ntmapi('J', '<C-w>J')
ntmapi('K', '<C-w>K')
ntmapi('L', '<C-w>L')
ntmapi('-', '<C-w>_') --- maximize that window
ntmapi('=', '<C-w>=')
ntmapi('\\', '<C-w><Bar>')
ntmapi('.', '2<C-w>>')
ntmapi(',', '2<C-w><')
ntmap('Left', 'gT')
ntmap('Right', 'gt')

--- fzf-lua
ntmap('F', '<cmd>FzfLua files<CR>')
ntmap('o', '<cmd>FzfLua buffers<CR>')
ntmap('s', '<cmd>FzfLua grep search=""<CR>')
ntmap('m', '<cmd>FzfWorkspaces<CR>')
vim.keymap.set("n", "<space>m", '<cmd>FzfFiles<CR>')

--- aerial
nmap('g', '<cmd>AerialToggle!<CR>')

--- vimtest
nmap('T', '<cmd>TestFile<CR>')
nmap('N', '<cmd>TestNearest<CR>')

--- add workspaces json for fzf-lua
function add_shortcut(type, name)
  local filename
  if type == "workspaces" then
    filename = vim.fn.stdpath('config') .. '/lua/config/workspaces.json'
  elseif type == "files" then
    filename = vim.fn.stdpath('config') .. '/lua/config/files.json'
  end
  local file = io.open(filename, 'r')
  if file then
    local contents = file:read("*a")
    local content_json = vim.json.decode(contents)
    if type == "workspaces" then
      content_json[vim.fn.fnamemodify(vim.fn.getcwd(), ":t")] = vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
    elseif type == "files" then
      content_json[vim.fn.expand("%:t")] = vim.fn.expand('%:p')
    end
    io.close(file)
    local tkeys = {}
    for k in pairs(content_json) do table.insert(tkeys, k) end
    table.sort(tkeys)
    local file_out = io.open(filename, 'w')
    if file_out then
      file_out:write('{\n')
      for idx, k in ipairs(tkeys) do
        if (idx ~= #tkeys) then
          file_out:write("\"", k, "\": \"", content_json[k], "\", \n")
        else
          file_out:write("\"", k, "\": \"", content_json[k], "\"\n")
        end
      end
      file_out:write('}')
      io.close(file_out)
    end
  end
end
nmap('M', ":lua add_shortcut(\"workspaces\")<CR>")
vim.keymap.set("n", "<space>M", function() add_shortcut("files") end)

--- terminal
map('t', 'p', '%paste<CR>')
map('t', 'R', "%autoreload<CR>")
ntmap('e', '<cmd>sp <Bar> term<CR>i')
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    if vim.bo.buftype == "terminal" then
      vim.cmd("startinsert")
    end
  end,
})
nmap('n', 'i')
tmap('n', '') --- map D-n to <C-\><C-N> 
function change_terminal_name(name)
  vim.api.nvim_command('file '..vim.fn.fnamemodify(vim.fn.bufname('%'), ':p:h').. '/' .. name)
end
tmap('F', '<cmd>change_terminal_name(vim.fn.input("terminal name: "))<CR>')

function execute_in_terminal()
  vim.cmd("normal! yap")
  local current_win = vim.api.nvim_get_current_win()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].buftype == 'terminal' then
      vim.api.nvim_set_current_win(win)
      break
    end
  end
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-N>pi<CR><C-\\><C-N>", true, true, true), "t", false)
  vim.defer_fn(function()
      vim.api.nvim_set_current_win(current_win)
      vim.cmd("normal! }j")
  end, 10)
end
nmap('r', ":lua execute_in_terminal()<CR>")
tmap('r', "pi") --- vim yank
tmap('\'', "\"+pi") --- execute clipboard
nmap('u', function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("mz\"+yaf", true, true, true), "m", false)
  vim.defer_fn(function()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>j%paste<CR><C-\\><C-N><C-w>k\'z", true, true, true), "m", false)
  end, 300)
end)
nmap('c', function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("mz\"+yac", true, true, true), "m", false)
  vim.defer_fn(function ()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>j%paste<CR><C-\\><C-N><C-w>k\'z", true, true, true), "m", false)
  end, 300)
end)


--- editting
vim.keymap.set("n", "<Leader>s", ":.,$s/")
vim.keymap.set("n", "<Leader>db", "oimport pdb; pdb.set_trace()<ESC>")
vim.keymap.set("n", "<Leader>f", ":Black<CR>")
vim.keymap.set("i", "<C-.>.", function()
  vim.snippet.expand("[\"${1}\"]${0}")
end)
vim.keymap.set("i", "<C-.>c", function()
  vim.snippet.expand("pl.col(\"${1}\")${0}")
end)


--- codecompanion
map('n', 'a', ':CodeCompanionChat<CR>i')
map('v', 'a', ':CodeCompanionChat<CR>o')
