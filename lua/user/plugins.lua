local fn = vim.fn
-- 替代手动安装，采取自动安装
local install_path=fn.stdpath "data".."/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "git@github.com:wbthomason/packer.nvim",
    install_path,
 }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end
-- 安装好插件需要重启neovim , 下面这段配置避免每次重启neovim
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]
-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end
-- 设置窗口弹出方式安装插件;浮动显示
packer.init {
  git = {
    clone_timeout = 60, -- Timeout, in seconds, for git clones
    default_url_format = 'git@github.com:%s' -- Lua format string used for "aaa/bbb" style plugins
  },
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
 },
}
-- 插件安装处
return packer.startup(function(use)
  -- 插件列表开始----------------------
  use "wbthomason/packer.nvim" -- 安装Packer插件
  use({ "nvim-lua/plenary.nvim", commit = "968a4b9afec0c633bc369662e78f8c5db0eba249" }) -- Useful lua functions used by lots of plugins
  use({ "windwp/nvim-autopairs", commit = "fa6876f832ea1b71801c4e481d8feca9a36215ec" }) -- Autopairs, integrates with both cmp and treesitter
  	use({ "numToStr/Comment.nvim", commit = "2c26a00f32b190390b664e56e32fd5347613b9e2" })
	use({ "JoosepAlviste/nvim-ts-context-commentstring", commit = "88343753dbe81c227a1c1fd2c8d764afb8d36269" })
	use({ "kyazdani42/nvim-web-devicons", commit = "8d2c5337f0a2d0a17de8e751876eeb192b32310e" })
	use({ "kyazdani42/nvim-tree.lua", commit = "bdb6d4a25410da35bbf7ce0dbdaa8d60432bc243" })
	use({ "akinsho/bufferline.nvim", commit = "c78b3ecf9539a719828bca82fc7ddb9b3ba0c353" })
	use({ "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" })
	use({ "nvim-lualine/lualine.nvim", commit = "3362b28f917acc37538b1047f187ff1b5645ecdd" })
	use({ "akinsho/toggleterm.nvim", commit = "aaeed9e02167c5e8f00f25156895a6fd95403af8" })
	use({ "ahmedkhalf/project.nvim", commit = "541115e762764bc44d7d3bf501b6e367842d3d4f" })
	use({ "lewis6991/impatient.nvim", commit = "969f2c5c90457612c09cf2a13fee1adaa986d350" })
	use({ "lukas-reineke/indent-blankline.nvim", commit = "6177a59552e35dfb69e1493fd68194e673dc3ee2" })
	use({ "goolord/alpha-nvim", commit = "ef27a59e5b4d7b1c2fe1950da3fe5b1c5f3b4c94" })
	use("folke/which-key.nvim")
  

	-- Colorschemes
	use({ "folke/tokyonight.nvim", commit = "8223c970677e4d88c9b6b6d81bda23daf11062bb" })
	-- use("lunarvim/darkplus.nvim")
  -- use('folke')
	-- cmp plugins
	use({ "hrsh7th/nvim-cmp", commit = "df6734aa018d6feb4d76ba6bda94b1aeac2b378a" }) -- The completion plugin
	use({ "hrsh7th/cmp-buffer", commit = "62fc67a2b0205136bc3e312664624ba2ab4a9323" }) -- buffer completions
	use({ "hrsh7th/cmp-path", commit = "466b6b8270f7ba89abd59f402c73f63c7331ff6e" }) -- path completions
	use({ "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" })
	use({ "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" })

	-- snippets
	-- use({ "L3MON4D3/LuaSnip", commit = "79b2019c68a2ff5ae4d732d50746c901dd45603a" }) --snippet engine
	use({ "rafamadriz/friendly-snippets", commit = "d27a83a363e61009278b6598703a763ce9c8e617" }) -- a bunch of snippets to use

	-- LSP
	use({ "neovim/nvim-lspconfig", commit = "148c99bd09b44cf3605151a06869f6b4d4c24455" }) -- enable LSP
	use({ "williamboman/nvim-lsp-installer", commit = "e9f13d7acaa60aff91c58b923002228668c8c9e6" }) -- simple to use language server installer
	use({ "jose-elias-alvarez/null-ls.nvim", commit = "ff40739e5be6581899b43385997e39eecdbf9465" }) -- for formatters and linters

	-- Telescope
  use "BurntSushi/ripgrep"
  use "sharkdp/fd"
	use({ "nvim-telescope/telescope.nvim", commit = "d96eaa914aab6cfc4adccb34af421bdd496468b0" })
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
  use({"nvim-telescope/telescope-ui-select.nvim"})
  use({"nvim-telescope/telescope-live-grep-raw.nvim"})
  use({"MattesGroeger/vim-bookmarks"})
  use({"tom-anders/telescope-vim-bookmarks.nvim"})
  --use({"nvim-telescope/telescope-fzy-native.nvim", run ='make'})


 -- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
    -- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation
	  run = ':TSUpdate'
  })
  use("p00f/nvim-ts-rainbow")
	
  -- Git
	use({ "lewis6991/gitsigns.nvim", commit = "c18e016864c92ecf9775abea1baaa161c28082c3" })

  -- hop
use {
  'phaazon/hop.nvim',
  branch = 'v2', -- optional but strongly recommended
  config = function()
    -- you can configure Hop the way you like here; see :h hop-config
    require'hop'.setup {
        multi_windows = true
      }
  end
}

-- neovim-session-manager  会话恢复
use({"Shatur/neovim-session-manager"})
  -- SnipRun
  -- use({"michaelb/sniprun", run= 'bash ./install.sh'})
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end

  -- 插件列表结束------------------
  -- clone好代码后自动安装 ， 必须得在放在最后才行
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
