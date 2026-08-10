{
pkgs,
lib,
...
}:
let
	text = pkgs.writeShellScriptBin "text"
		''
		#!/usr/bin/env sh
		echo -e "
        ┓  •   •     ┓        •
   ┏┓┏┓┏┫  ┓┏  ┓┏┓  ╋┣┓┏┓  ┓┏┏┓┏┓┏┓
   ┗┫┗┛┗┻  ┗┛  ┗┛┗  ┗┛┗┗   ┗┻┛┗┛ ┗
    ┛
	"
		'';
in
	{
	plugins.snacks = {
		settings = {
			dashboard = {
				enabled = true;
				preset = {
					keys = [
						{
							icon = " ";
							key = "f";
							desc = "Find File";
							action = ":Pick files";
						}
						{
							icon = " ";
							key = "n";
							desc = "New File";
							action = ":ene | startinsert";
						}
						{
							icon = " ";
							key = "p";
							desc = "Projects";
							action = ":lua MiniPickProjects()";
						}
						{
							icon = " ";
							key = "s";
							desc = "Restore Session";
							action = ":lua require('persistence').load()";
						}
						{
							icon = " ";
							key = "/";
							desc = "Find Text";
							action = ":Pick grep_live";
						}
						{
							icon = " ";
							key = "r";
							desc = "Recent Files";
							action = ":Pick oldfiles";
						}
						{
							icon = "";
							key = "o";
							desc = "LazyGit";
							action = "<leader>gg";
						}
						{
							icon = " ";
							key = "q";
							desc = "Quit";
							action = ":qa";
						}
					];
				};
				sections = [
					{
						section = "terminal";
						cmd = "${lib.getExe text}; sleep .4";
						height = 25;
						padding = 1;
						align = "left";
					}
					{
						icon = " ";
						pane = 2;
						title = "Keymaps";
						section = "keys";
						padding = 1;
						indent = 3;
					}
					{
						icon = " ";
						pane = 2;
						title = "Recent Files";
						section = "recent_files";
						padding = 1;
						indent = 3;
					}
					{
						icon = " ";
						pane = 2;
						title = "Projects";
						section = "projects";
						session = false;
						padding = 1;
						indent = 3;
					}
					{
						pane = 2;
						icon = " ";
						title = "Git Status";
						section = "terminal";
						enabled.__raw = '' Snacks.git.get_root() ~= nil '';
						cmd = "${pkgs.hub}/bin/hub status --short --branch --renames";
						height = 5;
						padding = 1;
						ttl = 5 * 60;
						indent = 3;
					}
				];
			};
		};
	};

	extraConfigLua = ''
		local dashboard = require("snacks.dashboard")
		local Dashboard = dashboard.Dashboard
		local dashboard_update = Dashboard.update
		local dashboard_size = Dashboard.size

		Dashboard.size = function(self)
			if not self.win or not vim.api.nvim_win_is_valid(self.win) then
				return { width = vim.o.columns, height = vim.o.lines }
			end
			return dashboard_size(self)
		end

		Dashboard.update = function(self)
			if not self.win or not vim.api.nvim_win_is_valid(self.win) then
				return
			end
			return dashboard_update(self)
		end
	'';
}
