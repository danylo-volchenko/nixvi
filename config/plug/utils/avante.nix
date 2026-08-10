{ config, lib, ... }: {
	plugins = {
		blink-cmp-avante = {
			enable = true;
			lazyLoad.settings = {
				ft = [ "AvanteInput" ];
			};
		};

		avante = {
			enable = true;
			lazyLoad.settings = {
				keys = [
					{
						__unkeyed-1 = "<leader>aa";
						__unkeyed-2 = "<cmd>AvanteAsk<cr>";
						desc = "Agent chat";
					}
					{
						__unkeyed-1 = "<leader>ae";
						__unkeyed-2 = "<cmd>AvanteEdit<cr>";
						desc = "Inline edit with agent";
					}
					{
						__unkeyed-1 = "<leader>as";
						__unkeyed-2 = "<cmd>lua require('avante.api').toggle_suggestions()<cr>";
						desc = "Toggle avante auto-suggestions";
					}
				];
				cmd = [ "AvanteAsk" "AvanteEdit" "AvanteToggle" "AvanteSuggestions" ];
			};
			settings = {
				provider = "gemini";
				auto_suggestions_provider = null;
				providers = {
					gemini = {
						model = "gemini-2.0-flash";
					};
				};
				hints.enabled = true;
				windows = {
					wrap = true;
					width = 30;
					sidebar_header = {
						enabled = false;
						align = "center";
						rounded = true;
					};
				};
				highlights.diff = {
					current = "DiffText";
					incoming = "DiffAdd";
				};
			};
		};

		blink-cmp.settings.sources = {
			default = lib.mkAfter [ "avante" ];
			# Avante's prompt input is a normal (nofile) buffer, so blink runs the
			# full default source list there — including ripgrep (spawns `rg` per
			# keystroke) and buffer scans. That causes heavy input lag. Scope the
			# input to only the avante source for snappy typing.
			per_filetype.AvanteInput = [ "avante" ];
			providers.avante = {
				module = "blink-cmp-avante";
				name = "Avante";
				score_offset = 500;
				opts = { };
			};
		};
	};

	keymaps = lib.mkIf (!config.plugins.avante.lazyLoad.enable) [
		{
			mode = "n"; key = "<leader>aa";
			action = "<cmd>AvanteAsk<cr>";
			options = { desc = "Agent chat"; };
		}
		{
			mode = "n"; key = "<leader>ae";
			action = "<cmd>AvanteEdit<cr>";
			options = { desc = "Inline edit with agent"; };
		}
		{
			mode = [ "n" "v" ]; key = "<leader>as";
			action.__raw = ''
				function()
					require("avante.api").toggle_suggestions()
				end
			'';
			options = { desc = "Toggle avante auto-suggestions"; };
		}
	];
}
