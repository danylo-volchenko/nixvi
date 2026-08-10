{ config, ... }:
{
	plugins.treesitter = {
		enable = true;
		folding.enable = true;
		indent.enable = true;
		highlight = {
			enable = true;
			disable = [ "diff" ];
		};
		grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
			c
			rust
			make
			bash
			zsh
			kdl
			kconfig
			cpp
			cmake
			lua
			nix
			markdown
			markdown_inline
			doxygen
			regex
		];
	};

}
