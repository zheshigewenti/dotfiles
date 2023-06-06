require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'everforest',
section_separators = { left = '', right = ''},
component_separators = { left = '', right = ''},
  },
  sections = {
    lualine_a = {'filename'},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  }
}
