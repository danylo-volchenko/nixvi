{ pkgs, ... }:
{
	extraPackages = with pkgs; [ lazygit ];

	plugins.snacks = {
		settings = {
			lazygit.enabled = true;
			win = {
				style = "lazygit";
				wo = {
					winhighlight = "NormalFloat:Normal,FloatBorder:Normal";
				};
			};
			theme = {
				activeBorderColor    = { fg = "String"; bold = true; };
				defaultFgColor       = { fg = "Normal"; };
				inactiveBorderColor  = { fg = "Comment"; };
				optionsTextColor     = { fg = "Function"; };
				selectedLineBgColor  = { bg = "CursorLine"; };
				unstagedChangesColor = { fg = "DiagnosticError"; };
			};
		};
	};
	keymaps = [
	{
		mode = "n";
		key = "<leader>gg";
		action = ":lua Snacks.lazygit.open()<CR>";
		options = {
			desc = "Open LazyGit";
		};
	}
	];
}
