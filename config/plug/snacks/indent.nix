{ config, lib, ... }:
{
	plugins.snacks = {
		settings = {
			indent = {
				indent = {
					enabled = false;
				};
				chunk = {
					enabled = true;
					only_current = true;
					char = {
						arrow = "─";
						corner_top = "╭";
						corner_bottom = "╰";
					};
					hl = "SnacksIndentScope";
				};
			};
		};
	};
	highlight = lib.mkIf (config.plugins.snacks.enable && lib.hasAttr "indent" config.plugins.snacks.settings) {
		SnacksIndent = {
			link = "NonText";
		};
		SnacksIndentScope = {
			link = "Comment";
		};
	};
}
