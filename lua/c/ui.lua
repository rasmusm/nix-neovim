--- Terminal UI
-- @module l.style.terminal

local edit_mode = require("c.edit_mode")
local keybind = require("c.keybind")
local autocmd = require("c.autocmd")

a = vim.api

uiwm = {}

uiwm.win = {
}

uiwm.wintype = {
 main = function ()
   vim.cmd("wincmd t")
   vim.cmd("vsplit")
   return a.nvim_get_current_win()
 end,
 repl = function ()
   vi
   vim.cmd("wincmd t")
   vim.cmd("10 wincmd j")
   lay=vim.fn.winlayout()
   vim.inspect(lay[2])
   vim.cmd("wincmd t")
}

function vl_node (node, row_fn, col_fn, leaf_fn)
  function do_node(node)
    local typ = node [1]
    local val = node [2]
    if typ == "leaf" then
      return leaf_fn(val)
    end
    local ret = {}
    for _, subnode in ipairs(val) do
      table.insert (ret, (do_node(subnode)))
    end
    if typ == "row" then
      return row_fn(ret)
    elseif typ == "col" then
      return col_fn(ret)
    else
      print("unknow node type :" .. tostring(typ) .. " for: " .. vim.inspect(node))
      return {"err", {}}
    end
  end
  i
  return do_node(node)[2]
end
vim.inspect(vim.fn.winlayout())
vim.inspect(vim.fn.winsaveview())
vim.inspect(vl_node(vim.fn.winlayout(), row_fn, col_fn, leaf_fn))

function row_fn(v)
  local ret = {}
  local found = ""
  for _, i in ipairs (v) do
    if i[1] == "found" then
      found = "found"
    end
    table.insert (ret, i[2])
  end

  return {found, {"row", ret}}
end
function col_fn(v)
  local ret = {}
  local found = false
  for _, i in ipairs (v) do
    if i[1] == "found" then
      found = true
    end
    table.insert (ret, i[2])
  end
  if found then
    table.insert (ret, {"leaf", 60})
  end

  return {"", {"col", ret}}
end

function leaf_fn(v)
  if v == 1000 then
    return {"found", {"leaf", v}}
  else
    return {"", {"leaf", v}}
  end
end



function uiwm:win_mk(name)
  local w
  local cmd = self.wintype[name]
  if cmd then
    w = cmd()
  else
    print("cant make " .. tostring(name).. " win type")
    return nil
  end
  self.win[name] = w
  return w
end

function uiwm:win_switch(name, buf)
  local w = self.win[name]
  if w and a.nvim_win_is_valid(w)  then
    vim.api.nvim_set_current_win(w)
  else
    w = mk_win(name)
    if not w then
      return nil
    end
  end
  if buf and a.nvim_buf_is_valid(buf)  then
    a.nvim_win_set_buf(w, buf)
  end
  return w
end


local TERMINAL_BUF_NAME = "Popup terminal"

local function get_buf_by_name(name)
  for _, v in pairs(vim.api.nvim_list_bufs()) do
    if vim.endswith(vim.api.nvim_buf_get_name(v), name) then
      return v
    end
  end

  return nil
end

local function find_win_with_buf(buf)
  local tabpage = vim.api.nvim_get_current_tabpage()

  for _, v in pairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(v) == buf and vim.api.nvim_win_get_tabpage(v) == tabpage then
      return v
    end
  end

  return nil
end

local function open_bottom_split()
  -- Open a window and shove it to the bottom
  vim.cmd("split")
  vim.cmd("wincmd J")
  vim.api.nvim_win_set_height(0, 16)
end

local function open_or_focus_term()
  local terminal_buf = get_buf_by_name(TERMINAL_BUF_NAME)
  if terminal_buf == nil then
    -- We need to create a terminal buffer
    open_bottom_split()
    vim.cmd("terminal")
    vim.api.nvim_buf_set_name(0, TERMINAL_BUF_NAME)
  else
    local terminal_win = find_win_with_buf(terminal_buf)
    if terminal_win == nil then
      open_bottom_split()
      vim.api.nvim_win_set_buf(0, terminal_buf)
    else
      vim.api.nvim_set_current_win(terminal_win)
    end
  end

  -- Enter insert mode
  vim.cmd("startinsert")
end

local function hide_term()
  local terminal_buf = get_buf_by_name(TERMINAL_BUF_NAME)
  if terminal_buf == nil then return end
  local terminal_win = find_win_with_buf(terminal_buf)
  if terminal_win == nil then return end

  vim.api.nvim_win_close(terminal_win, false)
end

-- Save and restore terminal height {{{

local last_term_win_size = nil

local function save_term_win()
  local terminal_buf = get_buf_by_name(TERMINAL_BUF_NAME)
  if terminal_buf == nil then return end
  local terminal_win = find_win_with_buf(terminal_buf)
  if terminal_win == nil then return end

  last_term_win_size = vim.api.nvim_win_get_height(terminal_win)
end

local function restore_term_win()
  local terminal_buf = get_buf_by_name(TERMINAL_BUF_NAME)
  if terminal_buf == nil then return end
  local terminal_win = find_win_with_buf(terminal_buf)
  if terminal_win == nil then return end

  vim.api.nvim_win_set_height(terminal_win, last_term_win_size)
end

-- }}}

function uiwm.init_config()
  keybind.bind_function(edit_mode.NORMAL, "<leader>tt", open_or_focus_term, { noremap = true }, "Focus terminal")
  keybind.bind_function(edit_mode.NORMAL, "<leader>tT", hide_term, { noremap = true }, "Hide terminal")

  autocmd.bind_quit_pre(save_term_win)
  autocmd.bind_win_closed(function() vim.schedule(restore_term_win) end)
end

return uiwm
