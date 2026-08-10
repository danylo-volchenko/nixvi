{
  plugins.todo-comments = {
	enable = true;

	# Coupled with trouble: lz.n loads every plugin registered under the same
	# trigger key, so pressing <leader>xt pulls in trouble's `todo` mode
	# provider (lua/trouble/sources/todo.lua) that lives in this plugin's rtp.
	lazyLoad.settings = {
	  keys = [
		{
		  __unkeyed-1 = "<leader>xt";
		  __unkeyed-2 = "<cmd>Trouble todo toggle win.type=split win.position=right win.size=80 win.border=rounded<cr>";
		  desc = "Todo toggle";
		  silent = true;
		}
	  ];
	};
  };
}
