{ config, lib, ... }:
{

	plugins = {
		trouble = {
			enable = true;

			lazyLoad.settings = {
				keys = [
					{
						__unkeyed-1 = "<leader>xX";
						__unkeyed-2 = "<cmd>Trouble preview_split toggle<cr>";
						desc = "Diagnostics toggle";
						silent = true;
					}
					{
						__unkeyed-1 = "<leader>xt";
						__unkeyed-2 = "<cmd>Trouble todo toggle win.type=split win.position=right win.size=80 win.border=rounded<cr>";
						desc = "Todo toggle";
						silent = true;
					}
					{
						__unkeyed-1 = "<leader>xx";
						__unkeyed-2 = "<cmd>Trouble preview_split toggle filter.buf=0<cr>";
						desc = "Buffer Diagnostics toggle";
						silent = true;
					}
					{
						__unkeyed-1 = "<leader>xl";
						__unkeyed-2 = "<cmd>Trouble lsp focus=false win.position=right<cr>";
						desc = "LSP Definitions / references / ... toggle";
						silent = true;
					}
					{
						__unkeyed-1 = "<leader>xL";
						__unkeyed-2 = "<cmd>Trouble loclist toggle<cr>";
						desc = "Location List toggle";
						silent = true;
					}
					{
						__unkeyed-1 = "<leader>xQ";
						__unkeyed-2 = "<cmd>Trouble qflist toggle<cr>";
						desc = "Quickfix List toggle";
						silent = true;
					}
				];
			};

			settings = {
				modes = {
					lsp = {
						mode = "lsp";
						win = {
							type = "split";
							position = "right";
							size = 80;
							border = "rounded";
						};
					};
					preview_split = {
						mode = "diagnostics";
						preview = {
							type = "split";
							relative = "win";
							position = "right";
							size = 0.5;
						};
					};
					preview_float = {
						mode = "diagnostics";
						preview = {
							type = "float";
							relative = "editor";
							border = "rounded";
							title = "Preview";
							title_pos = "center";
							position = [
								0
								(-2)
							];
							size = {
								width = 0.3;
								height = 0.3;
							};
							zindex = 200;
						};
					};
				};
			};
		};

		which-key.settings.spec = lib.optionals config.plugins.trouble.enable [
		{
			__unkeyed = "<leader>x"; mode = "n"; group = "diagnostics";
		}
		];
	};

	highlight = {
		TroubleNormal = {
			link = "Normal";
		};
		TroubleNormalNC = {
			link = "NormalNC";
		};
	};

	keymaps = lib.mkIf (config.plugins.trouble.enable && !config.plugins.trouble.lazyLoad.enable) [
	{
		mode = "n"; key = "<leader>xX";
		action = "<cmd>Trouble preview_split toggle<cr>";
		options = { desc = "Diagnostics toggle"; silent = true; };
	}
	{
		mode = "n"; key = "<leader>xt";
		action = "<cmd>Trouble todo toggle win.type=split win.position=right win.size=80 win.border=rounded<cr>";
		options = { desc = "Todo toggle"; silent = true; };
	}
	{
		mode = "n"; key = "<leader>xx";
		action = "<cmd>Trouble preview_split toggle filter.buf=0<cr>";
		options = { desc = "Buffer Diagnostics toggle"; silent = true; };
	}
	{
		mode = "n"; key = "<leader>xl";
		action = "<cmd>Trouble lsp focus=false win.position=right<cr>";
		options = { desc = "LSP Definitions / references / ... toggle"; silent = true; };
	}
	{
		mode = "n"; key = "<leader>xL";
		action = "<cmd>Trouble loclist toggle<cr>";
		options = { desc = "Location List toggle"; silent = true; };
	}
	{
		mode = "n"; key = "<leader>xQ";
		action = "<cmd>Trouble qflist toggle<cr>";
		options = { desc = "Quickfix List toggle"; silent = true; };
	}
	];
}
