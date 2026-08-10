{ config, lib, ... }:
let
colors = import ../../colors/${config.theme}.nix { }; 
in
{
	plugins.snacks = {
		settings = {
			terminal = {
				bo = {
					filetype = "snacks_terminal";
				};
				wo = {
					winbar = false;
				};
				stack = true; 
				keys = {
					q = "hide";
					gf = {
						__raw = ''
							function(self)
							local f = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
							if f == "" then
								Snacks.notify.warn("No file under cursor")
							else
								self:hide()
									vim.schedule(function()
											vim.cmd("e " .. f)
											end)
									end
									end
									'';
					};
					"<esc>" = {
						mode = "t";
						expr = true;
						desc = "Double escape to normal mode";
						action.__raw = ''
							function(self)
							self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
							if self.esc_timer:is_active() then
								self.esc_timer:stop()
									vim.cmd("stopinsert")
							else
								self.esc_timer:start(200, 0, function() end)
									return "<esc>"
									end
									end
									'';
					};
				};
			};
		};
	};
	keymaps = [
		{
			mode = [ "n" "t" ]; 
			key = "<leader>t";
			action = ''<cmd>lua Snacks.terminal.toggle(nil, { win = { position = "bottom", height = 10 } })<cr>'';
			options = { desc = "Toggle Terminal (Split)"; silent = true; };
		}
	];
	autoCmd = [
		{
			event = "TermOpen";
			pattern = "*";
			callback = {
				__raw = ''
					function()
						if vim.bo.filetype == "snacks_terminal" then
							vim.opt_local.winbar = nil
						end
					end
				'';
			};
		}
	];
}
