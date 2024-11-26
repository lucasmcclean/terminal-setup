return {
  'windwp/nvim-ts-autotag',
  ft = { 'html', 'xml', 'svelte', 'tsx', 'vue', 'js', 'ts' },
  aliases = {
    ['templ'] = 'html',
  },
  dependencies = { 'nvim-treesitter' },
  config = function()
    require('nvim-ts-autotag').setup {}
  end,
}
