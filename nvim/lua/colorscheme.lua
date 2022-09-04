local present = pcall(require, "material")
if not present then
  return
end

vim.g.material_style = "deep ocean"
vim.cmd 'colorscheme material'
