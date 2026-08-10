{
	description = "neovim configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		nixvim.url = "github:nix-community/nixvim";
		#nixvim.inputs.nixpkgs.follows = "nixpkgs";
		#neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
	};

	outputs = { nixpkgs, nixvim, ... }: #neovim-nightly-overlay, ... }:
		let
		lib = nixpkgs.lib;
		system = "x86_64-linux";
	pkgs = import nixpkgs {
		inherit system;
		config.allowUnfree = true;
		overlays = [
			#neovim-nightly-overlay.overlays.default
			(import ./overlays/codediff/overlay.nix)
			(final: prev: {
				vimPlugins = prev.vimPlugins // {
					avante-nvim = prev.vimPlugins.avante-nvim.overrideAttrs (old: {
						doCheck = false;
					});
				};
			})
		];
	};
	configuration = nixvim.lib.evalNixvim {
		inherit system;
		modules = [
			./config
			{ nixpkgs.pkgs = pkgs; }
		];
	};
	nvim = configuration.config.build.package;
	gnvim = pkgs.runCommand "gnvim" { nativeBuildInputs = [ pkgs.makeWrapper ]; } ''
		mkdir -p $out/bin
		makeWrapper ${pkgs.writeShellScriptBin "gnvim" ''
			exec /usr/bin/neovide "$@"
		''}/bin/gnvim $out/bin/gnvim \
			--prefix PATH : ${lib.makeBinPath [ nvim ]}
		ln -s gnvim $out/bin/neovide
	'';
	combined = pkgs.symlinkJoin {
		name = "vi";
		paths = [ nvim gnvim ];
	};
	in {
		packages.${system} = {
			default = combined;
			nvim = nvim;
			gnvim = gnvim;
		};
		checks.${system}.nvim = configuration.config.build.test;
	};
}
