{
	keymaps = [
		{
			mode = "v"; key = "J"; action = ":m '>+1<cr>gv=gv";
			options = { desc = "Move selected lines down"; };
		}
		{
			mode = "v"; key = "K"; action = ":m '>-2<cr>gv=gv";
			options = { desc = "Move selected lines up"; };
		}
		{
			mode = "n"; key = "J"; action = "mzJ`z";
			options = { desc = "Join lines without moving cursor"; };
		}
		{
			mode = "n"; key = "<C-d>"; action = "<C-d>zz";
			options = { desc = "Scroll down and center cursor"; };
		}
		{
			mode = "n"; key = "<C-u>"; action = "<C-u>zz";
			options = { desc = "Scroll up and center cursor"; };
		}
		{
			mode = "n"; key = "n"; action = "nzzzv";
			options = { desc = "Next search result and center cursor"; };
		}
		{
			mode = "n"; key = "N"; action = "Nzzzv";
			options = { desc = "Previous search result and center cursor"; };
		}
		{
			mode = "t"; key = "<Esc>"; action = "<C-\\><C-n>";
			options = { noremap = true; silent = true; };
		}
		{
			mode = "n"; key = "<leader>R"; action = ":%s/\<C-r><C-w>//g<Left><Left>";
			options = { desc = "Replace word under cursor"; };
		}
		{
			mode = "x"; key = "<leader>p"; action = ''"_dP'';
			options = { desc = "Paste without overwriting register"; };
		}
		{
			mode = [ "n" "v" ]; key = "<leader>y"; action = ''"+y'';
			options = { desc = "Yank to system clipboard"; };
		}
		{
			mode = [ "n" "v" ]; key = "<leader>Y"; action = ''"+Y'';
			options = { desc = "Yank line to system clipboard"; };
		}
		{
			mode = "v"; key = "<C-c>";
			action.__raw = ''
				function()
					vim.cmd('normal! "+y')
				end
			'';
			options = { desc = "Copy selection to clipboard"; };
		}
		{
			mode = "i"; key = "<C-c>"; action = "<Esc>";
			options = { desc = "Exit insert mode"; };
		}
		{
			mode = [ "n" "v" ]; key = "<leader>D"; action = ''"_d'';
			options = { desc = "Delete without overwriting register"; };
		}
		{
			mode = "n"; key = "<leader>fy";
			action = ":let @+ = '''' | g//y A | call setreg('+', @a)<CR>";
			options = { desc = "Yank all matches to clipboard"; };
		}
		{
			mode = "n"; key = "<C-s>"; action = "<cmd>w<cr><esc>";
			options = { silent = true; desc = "Save file"; };
		}
		{
			mode = [ "n" "v" "s" ];
			key = "<C-S-v>";
			action = ''"+p'';
			options = { desc = "Paste from system clipboard"; };
		}
		{
			mode = [ "i" "c" ];
			key = "<C-S-v>";
			action = "<C-r>+";
			options = { desc = "Paste from system clipboard"; };
		}
		{
			mode = "t";
			key = "<C-S-v>";
			action = "<C-\\><C-n>\"+pa";
			options = { desc = "Paste from system clipboard"; };
		}
	];
}
