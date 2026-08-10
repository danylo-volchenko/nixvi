{
	keymaps = [
		{
			mode = "n"; key = "<leader><tab>m";
			action = ":tabnew %<cr>";
			options = { silent = true; desc = "Open current file in new tab"; };
		}
		{
			mode = "n"; key = "<leader><tab><tab>"; action = "<cmd>tabnew<cr>";
			options = { silent = true; desc = "New tab"; };
		}
		{
			mode = "n"; key = "<leader><tab>d"; action = "<cmd>tabclose<cr>";
			options = { silent = true; desc = "Close tab"; };
		}
	];
}
