{ config, lib, pkgs, ... }:
{ imports = [
		# Base settings
		./autocommands.nix
		./keymaps/helpers.nix
		./keymaps/editing.nix
		./keymaps/code.nix
		./keymaps/ui.nix
		./keymaps/windows.nix
		./keymaps/tabs.nix
		./keymaps/lifecycle.nix
		./sets.nix
		./gui.nix
		./highlight.nix
		# Colorschemes
		./plug/colorscheme/colorscheme.nix
		# Completion and LSP
		./plug/cmp/blink.nix
		./plug/lsp/lsp.nix
		./plug/lsp/clangd-extensions.nix
		./plug/lsp/rustaceanvim.nix
		# Git integration
		./plug/git/gitsigns.nix
		./plug/git/codediff.nix
		# Statusline
		./plug/statusline/lualine.nix
		# Treesitter
		./plug/treesitter/treesitter-context.nix
		./plug/treesitter/treesitter-textobjects.nix
		./plug/treesitter/treesitter.nix
		# UI Enhancements
		./plug/ui/web-devicons.nix
		./plug/ui/bufferline.nix
		./plug/ui/noice.nix
		./plug/ui/markview.nix
		./plug/ui/dap-ui.nix
		./plug/ui/dap-virtual-text.nix
		# Utility Plugins
		./plug/utils/dap.nix
		./plug/utils/navic.nix
		./plug/utils/lz-n.nix
		./plug/utils/smart-splits.nix
		./plug/utils/trouble.nix
		./plug/utils/fyler.nix
		./plug/utils/undotree.nix
		./plug/utils/compile.nix
		./plug/utils/todo-comments.nix
		./plug/utils/peristence.nix
		./plug/utils/flash.nix
		./plug/utils/avante.nix

		./plug/snacks/default.nix
		./plug/mini/default.nix
	];
	# Theme options
	options = {
		theme = lib.mkOption {
			default = lib.mkDefault "paradise";
			type = lib.types.enum [
				"paradise"
			];
		};
	};
	# Configuration
	config = {
		theme = "paradise";
		extraConfigLua = ''
			_G.theme = "${config.theme}"
		'';
	};
}
