{
	plugins.mini = {
		enable = true;
		modules = {
			surround = { };
			hipatterns = {
				highlighters = {
					hex_color.__raw = ''require("mini.hipatterns").gen_highlighter.hex_color()'';
				};
			};
		};
	};

	imports = [
		./clue.nix
		./pick.nix
	];
}
