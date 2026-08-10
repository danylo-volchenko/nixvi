{
	keymaps = [
		{
			mode = "n"; key = "<leader>ww"; action = "<C-W>p";
			options = { silent = true; desc = "Other window"; };
		}
		{
			mode = "n"; key = "<leader>wd"; action = "<C-W>c";
			options = { silent = true; desc = "Close window"; };
		}
		{
			mode = "n"; key = "<leader>w-"; action = "<C-W>s";
			options = { silent = true; desc = "Split window below"; };
		}
		{
			mode = "n"; key = "<leader>w|"; action = "<C-W>v";
			options = { silent = true; desc = "Split window right"; };
		}
	];
}
