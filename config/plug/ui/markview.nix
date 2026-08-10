{ ... }:
{
	plugins.markview = {
		enable = true;

		settings = {
			preview = {
				filetypes = [ "markdown" "Avante" ];
				# avante uses `nofile` buffers, which markview skips by
				# default; clearing the ignore list lets it attach there.
				ignore_buftypes = { };
			};
			markdown = {
				headings = { __raw = "require('markview.presets').headings.glow"; };
				horizontal_rules = { __raw = "require('markview.presets').horizontal_rules.dashed"; };
				tables = { __raw = "require('markview.presets').single"; };
			};
		};
	};
}
