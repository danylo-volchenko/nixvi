{
	keymaps = [
		{
			mode = "n"; key = "<leader>uT"; action = "<cmd>ParadiseToggle<cr>";
			options = { silent = true; desc = "Toggle Paradise theme variant"; };
		}
		{
			mode = "n"; key = "<leader>ul"; action = ":lua ToggleLineNumber()<cr>";
			options = { silent = true; desc = "Toggle line numbers"; };
		}
		{
			mode = "n"; key = "<leader>uL"; action = ":lua ToggleRelativeLineNumber()<cr>";
			options = { silent = true; desc = "Toggle relative line numbers"; };
		}
		{
			mode = "n"; key = "<leader>uw"; action = ":lua ToggleWrap()<cr>";
			options = { silent = true; desc = "Toggle wrap"; };
		}
		{
			mode = "n"; key = "<leader>um"; action = "<cmd>Markview toggle<cr>";
			options = { silent = true; desc = "Toggle Markview"; };
		}
		{
			mode = "n"; key = "<leader>uv";
			action.__raw = ''
				function()
					local config = vim.diagnostic.config()
					if config.virtual_text then
						_G.diagnostic_vt_cache = config.virtual_text
						vim.diagnostic.config({ virtual_text = false })
						vim.notify("Virtual text: OFF", vim.log.levels.INFO)
					else
						vim.diagnostic.config({ virtual_text = _G.diagnostic_vt_cache or true })
						vim.notify("Virtual text: ON", vim.log.levels.INFO)
					end
				end
			'';
			options = { desc = "Toggle diagnostic virtual text"; silent = true; };
		}
	];
}
