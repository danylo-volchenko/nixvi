{ ... }:
{
	plugins.codediff = {
		enable = true;

		lazyLoad.settings = {
			cmd = [ "CodeDiff" ];
			keys = [
				{
					__unkeyed-1 = "<leader>ga";
					__unkeyed-2 = "codediff";
					mode = [ "n" "v" ];
					desc = "+accept";
					silent = true;
				}
				{
					__unkeyed-1 = "<leader>gai";
					__unkeyed-2 = ":lua require('codediff.ui.conflict.actions').accept_incoming()<CR>";
					desc = "Accept Incoming (Left)";
					silent = true;
				}
				{
					__unkeyed-1 = "<leader>gac";
					__unkeyed-2 = ":lua require('codediff.ui.conflict.actions').accept_current()<CR>";
					desc = "Accept Current (Right)";
					silent = true;
				}
				{
					__unkeyed-1 = "<leader>gab";
					__unkeyed-2 = ":lua require('codediff.ui.conflict.actions').accept_both()<CR>";
					desc = "Accept Both";
					silent = true;
				}
				{
					__unkeyed-1 = "<leader>gax";
					__unkeyed-2 = ":lua require('codediff.ui.conflict.actions').discard()<CR>";
					desc = "Discard Both";
					silent = true;
				}
				{
					__unkeyed-1 = "]x";
					__unkeyed-2 = ":lua require('codediff.ui.conflict.navigation').next()<CR>";
					desc = "Next Conflict";
					silent = true;
				}
				{
					__unkeyed-1 = "[x";
					__unkeyed-2 = ":lua require('codediff.ui.conflict.navigation').prev()<CR>";
					desc = "Previous Conflict";
					silent = true;
				}
				{
					__unkeyed-1 = "2do";
					__unkeyed-2 = "2do";
					desc = "DiffGet: Incoming (Buf 2)";
					silent = true;
				}
				{
					__unkeyed-1 = "3do";
					__unkeyed-2 = "3do";
					desc = "DiffGet: Current (Buf 3)";
					silent = true;
				}
				{
					__unkeyed-1 = "<leader>gd";
					__unkeyed-2 = ":CodeDiff<CR>";
					desc = "Diff This";
					silent = true;
				}
			];
		};

		settings = {
			keymaps = {
				explorer = {
					hover = "K";
					refresh = "R";
					select = "<CR>";
					toggle_view_mode = "i";
				};
				view = {
					next_file = "]f";
					next_hunk = "]c";
					prev_file = "[f";
					prev_hunk = "[c";
					quit = "q";
					toggle_explorer = "<leader>b";
				};
				conflict = {
					accept_incoming = "<leader>gai";
					accept_current = "<leader>gac";
					accept_both = "<leader>gab";
					discard = "<leader>gax";
					next_conflict = "]x";
					prev_conflict = "[x";
					diffget_incoming = "2do";
					diffget_current = "3do";
				};
			};
		};
	};
}
