{
	plugins.mini.modules.clue = {
		window = {
			delay = 400;
			config = {
				border = "rounded";
				width.__raw = ''
					math.floor(0.318 * vim.o.columns)
					'';
				row = "auto";
				col = "auto";
				anchor = "SE";
			};
		};
		triggers = [
			{ mode = "n"; keys = "<leader>"; }
			{ mode = "x"; keys = "<leader>"; }
			{ mode = "i"; keys = "<C-x>"; }
			{ mode = "n"; keys = "g"; }
			{ mode = "x"; keys = "g"; }
			{ mode = "n"; keys = "'"; }
			{ mode = "n"; keys = "`"; }
			{ mode = "n"; keys = "]"; }
			{ mode = "n"; keys = "["; }
			{ mode = "x"; keys = "'"; }
			{ mode = "x"; keys = "`"; }
			{ mode = "n"; keys = "\""; }
			{ mode = "x"; keys = "\""; }
			{ mode = "i"; keys = "<C-r>"; }
			{ mode = "c"; keys = "<C-r>"; }
			{ mode = "n"; keys = "<C-w>"; }
			{ mode = "n"; keys = "z"; }
			{ mode = "x"; keys = "z"; }
		];
		clues = [
			{ mode = "n"; keys = "<Leader>a"; desc = "+ai"; }
			{ mode = "n"; keys = "<Leader>f"; desc = "+find/file"; }
			{ mode = "n"; keys = "<Leader>q"; desc = "+quit/session"; }
			{ mode = "n"; keys = "<Leader>g"; desc = "+git"; postkeys = "<Leader>g"; }
			{ mode = "n"; keys = "<Leader>u"; desc = "+ui"; }
			{ mode = "n"; keys = "<Leader>b"; desc = "+buffers"; }
			{ mode = "n"; keys = "<Leader>w"; desc = "+windows"; }
			{ mode = "n"; keys = "<Leader><Tab>"; desc = "+tabs"; }
			{ mode = "n"; keys = "<Leader>c"; desc = "+code"; }
			{ mode = "n"; keys = "<Leader>e"; desc = "+explorer"; }
			{ mode = "n"; keys = "<Leader>m"; desc = "+make/build"; }
			{ mode = "n"; keys = "<Leader>x"; desc = "+diagnostics"; }
			{ mode = "n"; keys ="<Leader>d"; desc="+debug";}
			{ __raw = "require('mini.clue').gen_clues.builtin_completion()"; }
			{ __raw = "require('mini.clue').gen_clues.g()"; }
			{ __raw = "require('mini.clue').gen_clues.marks()"; }
			{ __raw = "require('mini.clue').gen_clues.registers()"; }
			{ __raw = "require('mini.clue').gen_clues.windows()"; }
			{ __raw = "require('mini.clue').gen_clues.z()"; }
			{ __raw = "require('mini.clue').gen_clues.square_brackets()"; } 
		];

		highlight = {
			MiniClueBorder = { link = "Normal"; };
		};
	};
}
