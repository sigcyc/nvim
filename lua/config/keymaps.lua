--- keymaps include all the maps that don't need any plugin
--- it also includes the Alt commands as those are typically the mostly used keymaps

local function map(mode, shortcut, func)
  local platform_key = vim.fn.has('mac') == 1 and '<D-' or '<A-'
  vim.keymap.set(mode, platform_key .. shortcut .. '>', func)
end
local function nmap(shortcut, func)
  map('n', shortcut, func)
end
local function tmap(shortcut, func)
  map('t', shortcut, "<C-\\><C-N>" .. func)
end
local function ntmap(shortcut, func)
  nmap(shortcut, func)
  tmap(shortcut, func)
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
ntmap('v', '<cmd>vsplit<CR>')
ntmap('i', '<cmd>split<CR>')
ntmap('t', '<cmd>tabnew<CR>')
ntmap('x', '<C-w>x')
ntmap('H', '<C-w>H')
ntmap('J', '<C-w>J')
ntmap('K', '<C-w>K')
ntmap('L', '<C-w>L')
ntmap('-', '<C-w>_') --- maximize that window
ntmap('=', '<C-w>=')
ntmap('\\', '<C-w><Bar>')
ntmap('.', '2<C-w>>')
ntmap(',', '2<C-w><')
ntmap('Left', 'gT')
ntmap('Right', 'gt')

--- fzf-lua
ntmap('F', '<cmd>FzfLua files<CR>')
ntmap('o', '<cmd>FzfLua buffers<CR>')
ntmap('s', '<cmd>FzfLua grep_project<CR>')
ntmap('m', '<cmd>Cdpick<CR>')

--- terminal
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
nmap('r', ":execute_in_terminal()<CR>")
tmap('r', "pi") --- vim yank
tmap('\'', "\"+pi") --- execute clipboard
nmap('u', "mz\"+yaf<C-w>j%paste<CR><C-\\><C-N>\'z")
nmap('c', "mz\"+yac<C-w>j%paste<CR><C-\\><C-N>\'z")

--- editting
vim.keymap.set("n", "<Leader>s", ":.,$s/")

--- add workspaces json for fzf-lua
function add_workspace(name)
  local workspace_filename = vim.fn.stdpath('config') .. '/lua/config/workspaces.json'
  local file = io.open(workspace_filename, 'r')
  if file then
    local contents = file:read("*a")
    content_json = vim.json.decode(contents)
    content_json[name] = vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
    io.close(file)
    local tkeys = {}
    for k in pairs(content_json) do table.insert(tkeys, k) end
    table.sort(tkeys)
    local file = io.open(workspace_filename, 'w')
    file:write('{\n')
    for idx, k in ipairs(tkeys) do
      if (idx ~= #tkeys) then
        file:write("\"", k, "\": \"", content_json[k], "\", \n")
      else
        file:write("\"", k, "\": \"", content_json[k], "\"\n")
      end
    end
    file:write('}')
    io.close(file)
  end
end
nmap('M', ":lua add_workspace('")
