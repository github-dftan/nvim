vim.opt.clipboard = "unnamedplus" --nvim的粘贴操作可以同步复制到系统的粘贴板

vim.opt.number = true
vim.opt.numberwidth = 2

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.smartcase = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

vim.opt.undofile = true -- 启用撤销文件,退出后再进来可以进行撤销操作

vim.opt.splitbelow = true -- 水平分割窗口时，新的窗口位于当前窗口下方
vim.opt.splitright = true -- 垂直分割窗口时，新的窗口位于当前窗口右侧


-- 设置 Vim 的 listchars 选项，用于显示不可见字符的方式
vim.opt.list = true
vim.opt.listchars = {
	tab = "» ", -- 制表符（Tab）显示为 “» ”（右箭头加空格）
	trail = "·", -- 行尾多余空格（trailing space）显示为 “·”（小圆点）
	nbsp = "␣", -- 不间断空格（non-breakable space, NBSP）显示为 “␣”（特殊空格符号）
}


vim.o.winborder = "rounded" -- 设置窗口边框样式为圆角

if(vim.loop.os_uname().sysname == "Windows_NT") then
  vim.o.shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell"
end
