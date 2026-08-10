{
	plugins.noice = {
		enable = true;
		lazyLoad.settings = {
			event = [ "DeferredUIEnter" ];
		};
		settings = {
			notify = { enabled = true; };
			messages = { enabled = true; };
			lsp = {
				signature = { enabled = false; };
				hover = {
					enabled = true;
					opts = {
						border = { style = "rounded"; };
						focusable = true;
					};
				};
				message = { enabled = true; };
				progress = { enabled = true; view = "mini"; };
			};
			popupmenu = { enabled = true; backend = "nui"; };
			presets = {bottom_search = true; long_message_to_split = true; lsp_doc_border = true;};
			cmdline = {
				enabled = true;
				view = "cmdline";
			};
			format = {
				filter = {
					pattern = [
						":%s*%%s*s:%s*"
						":%s*%%s*s!%s*"
						":%s*%%s*s/%s*"
						"%s*s:%s*"
						":%s*s!%s*"
						":%s*s/%s*"
					];
					icon = "";
					lang = "regex";
				};
				replace = {
					pattern = [
						":%s*%%s*s:%w*:%s*"
						":%s*%%s*s!%w*!%s*"
						":%s*%%s*s/%w*/%s*"
						"%s*s:%w*:%s*"
						":%s*s!%w*!%s*"
						":%s*s/%w*/%s*"
					];
					icon = "󱞪";
					lang = "regex";
				};
			};
		};
	};
}
