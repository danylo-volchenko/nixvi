{pkgs, ...} :
{
	extraPlugins = with pkgs.vimPlugins; [
		blink-ripgrep-nvim
	];

	plugins = {
		blink-cmp-dictionary.enable = true;
		blink-cmp-spell.enable = true;
		blink-cmp-git.enable = false;
		blink-emoji.enable = true;
		blink-ripgrep.enable = true;
		blink-cmp = {
			enable = true;
			setupLspCapabilities = true;
			lazyLoad.settings = {
				event = [ "InsertEnter" ];
			};
			settings = {
				keymap = {
					preset = "none";
					"<C-space>" = [ "show" "show_documentation" "hide_documentation" ];
					"<C-e>" = [ "hide" "fallback" ];
					"<CR>" = [ "accept" "fallback" ];
					"<Tab>" = [ "accept" "snippet_forward" "fallback" ];
					"<S-Tab>" = [ "snippet_backward" "fallback" ];
					"<C-b>" = [ "scroll_documentation_up" "fallback" ];
					"<C-f>" = [ "scroll_documentation_down" "fallback" ];
					"<C-k>" = [ "show_signature" "hide_signature" "fallback" ];
					"<Up>" = [ "select_prev" "fallback" ];
					"<Down>" = [ "select_next" "fallback" ];
				};
				signature = {
					enabled = true;
				};

				sources = {
					default = [
						"lsp" "path" "snippets" "buffer"
					];
					# Prose filetypes drop the workspace-wide `ripgrep` source,
					# which fired on every keystroke and caused heavy input lag.
					per_filetype = {
						markdown  = [ "lsp" "path" "snippets" "buffer" "dictionary" "spell" "emoji" ];
						text      = [ "lsp" "path" "snippets" "buffer" "dictionary" "spell" "emoji" ];
						gitcommit = [ "lsp" "path" "snippets" "buffer" "dictionary" "spell" "emoji" ];
					};
					providers = {
						lsp = {
							name = "lsp";
							enabled = true;
							module = "blink.cmp.sources.lsp";
							score_offset = 10000;
						};
						ripgrep = {
							name = "Ripgrep";
							enabled = true;
							module = "blink-ripgrep";
							score_offset = 2000;
							min_keyword_length = 3;
						};
						buffer = {
							name = "Buffer";
							enabled = true;
							module = "blink.cmp.sources.buffer";
							min_keyword_length = 3;
						};
						path = {
							name = "Path";
							enabled = true;
							module = "blink.cmp.sources.path";
							score_offset = 1500;
						};
						snippets = {
							name = "Snippets";
							module = "blink.cmp.sources.snippets";
							score_offset = 1000;
						};
						dictionary = {
							name = "Dict";
							enabled = true;
							module = "blink-cmp-dictionary";
							min_keyword_length = 5;
						};
						spell = {
							name = "Spell";
							enabled = true;
							module = "blink-cmp-spell";
							score_offset = 5;
						};
						emoji = {
							name = "Emoji";
							enabled = true;
							module = "blink-emoji";
							score_offset = 1;
						};
					};
				};

				appearance = {
					nerd_font_variant = "mono";
					kind_icons = {
						Text = "󰉿";
						Method = "";
						Function = "󰊕";
						Constructor = "󰒓";

						Field = "󰜢";
						Variable = "󰆦";
						Property = "󰖷";

						Class = "󱡠";
						Interface = "󱡠";
						Struct = "󱡠";
						Module = "󰅩";

						Unit = "󰪚";
						Value = "󰦨";
						Enum = "󰦨";
						EnumMember = "󰦨";

						Keyword = "󰻾";
						Constant = "󰏿";

						Snippet = "󱄽";
						Color = "󰏘";
						File = "󰈔";
						Reference = "󰬲";
						Folder = "󰉋";
						Event = "󱐋";
						Operator = "󰪚";
						TypeParameter = "󰬛";
						Error = "󰏭";
						Warning = "󰏯";
						Information = "󰏮";
						Hint = "󰏭";

						Emoji = "!";
					};
				};
				completion = {
					ghost_text.enabled = true;
					list.selection = {
						preselect = true; 
						auto_insert = false;
					};
					menu = {
						border = "none";
						draw = {
							gap = 1;
							treesitter = [ ];
							columns = [
								{
									__unkeyed-1 = "label";
								}
								{
									__unkeyed-1 = "kind_icon";
									__unkeyed-2 = "kind";
									gap = 1;
								}
								{ __unkeyed-1 = "source_name"; }
							];
						};
					};
					trigger = {
						show_in_snippet = false;
					};
					documentation = {
						auto_show = true;
						window = {
							border = "rounded";
						};
						auto_show_delay_ms = 350;
					};
					accept = {
						auto_brackets = {
							enabled = true;
						};
					};
				};
			};
		};
	};
}
