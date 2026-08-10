{
	keymaps = [
		{
			mode = "n"; key = "gx"; action = ":lua OpenUnderCursor()<cr>";
			options = { desc = "Open URL under cursor"; noremap = true; silent = true; };
		}
		{
			mode = "n"; key = "<leader>cs"; action = ":ClangdSwitchSourceHeader<cr>";
			options = { noremap = true; desc = "Switch source/header"; };
		}
		{
			mode = "n"; key = "<leader>ct"; action = "<C-]>";
			options = { noremap = true; desc = "Search tag"; };
		}
		{
			mode = "n"; key = "<leader>cl"; action = ":lua CopyCursorLocation()<cr>";
			options = { silent = true; desc = "Copy permalink"; };
		}
		{
			mode = [ "n" "v" ]; key = "<leader>cv"; action = ":lua ShowConversions()<cr>";
			options = { silent = true; desc = "Show conversions"; };
		}
		{
			mode = [ "n" "v" ]; key = "<leader>ch"; action = ":lua ToggleHex()<cr>";
			options = { silent = true; desc = "Toggle hex view"; };
		}
		{
			mode = "n"; key = "<leader>ci"; action = ":lua toggleInlayHints()<cr>";
			options = { silent = true; desc = "Toggle inlay hints"; };
		}
		{
			mode = "n"; key = "<leader>cz";
			action = "<cmd>lua Snacks.zen()<cr>";
			options = { silent = true; desc = "Toggle Zen mode"; };
		}
	];
}
