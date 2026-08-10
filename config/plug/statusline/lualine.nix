{
	plugins.lualine = {
		enable = true;
		lazyLoad.settings = {
			event = [ "DeferredUIEnter" ];
		};
		settings = {
			options = {
				theme = "base16";
				globalstatus = true;
				disabled_filetypes = {
					statusline = [
						"dashboard"
						"alpha"
						"starter"
						"dap-repl"
						"dapui_scopes"
						"dapui_stacks"
						"dapui_watches"
						"dapui_repl"
						"LspTrouble"
						"qf"
						"NvimTree"
						"dashboard"
					];
					winbar = ["*"];
				};
			};
			inactive_sections = {
				lualine_x = [
					"filename"
					"filetype"
				];
			};
			sections = {
				lualine_a = [
					{
						__unkeyed = "mode";
						icon = " ";
						fmt = "string.lower";
						separator.left = "";
						separator.right = "";
					}
				];
				lualine_b = [
					{
						__unkeyed = "branch";
						icon.__unkeyed = "";
						separator.left = "";
						separator.right = "";
					}
					{
						__unkeyed = "diff";
						separator.left = "";
						separator.right = "";
					}
				];
			lualine_c = [
					{
						__unkeyed-1 = "navic";
					separator.left = "";
					separator.right = "";
				}
				{
					__unkeyed = "diagnostics";
					symbols = {
						error = " ";
						warn = " ";
						info = " ";
						hint = "󰝶 ";
					};
					separator.left = "";
					separator.right = "";
				}
			];
				lualine_x = [
					""
				];
				lualine_y = [
					{
						__unkeyed = "filetype";
						colored = false;
						icon_only = true;
						separator.left = "";
						separator.right = "";
					}
					{
						__unkeyed = "filename";
							symbols = {
								modified = "";
								readonly = "󰌾 ";
								unnamed = "";
							};
						separator.left = "";
						separator.right = "";
					}
				];
				lualine_z = [
					{
						__unkeyed  = "progress";
						separator.left = "";
						separator.right = "";
					}
					{
						__unkeyed = "location";
						separator.left = "";
						separator.right = "";
					}
				];
			};
			extensions = [
				"nvim-dap-ui"
			];
		};
	};
}
