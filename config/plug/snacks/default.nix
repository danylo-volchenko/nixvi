{ self, ... }:
{
	plugins.snacks = {
		enable = true;
		settings = {
			bufdelete.enabled = true;
			input.enabled = true;
			scroll.enabled = true;
			animate.enabled = true;
			rename.enabled = true;
			statuscolumn.enabled = true;
			words.enabled = true;
			image.enabled = true;
			notifier.enabled = false;
			zen = {
				center = true;
				show = {
					statusline = false;
					tabline = false;
				};
				toggles = {
					dim = true;
					git_signs = false;
					mini_diff_signs = false;
				};
			};
		};
	};

	imports = [
		./dashboard.nix
		./indent.nix
		./lazygit.nix
		./terminal.nix
	];

	keymaps = [
		{
			mode = "n"; key = "<leader>bs"; action = ":lua Snacks.scratch()<cr>";
			options = { noremap = true; desc = "Scratch buffer"; };
		}
		{
			mode = "n"; key = "<leader>bS"; action = ":lua Snacks.scratch({ file = vim.fn.input('Scratch name: ') })<cr>";
			options = { noremap = true; desc = "Named scratch buffer"; };
		}
	];

}
