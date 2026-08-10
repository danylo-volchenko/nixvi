{
	plugins.treesitter-context = {
		enable = true;
		lazyLoad.settings = {
			event = [
				"BufReadPost"
				"BufNewFile"
			];
		};
		settings = {
			max_lines = 3;
		};
	};
}
