{ config, lib, ... }:
{
	plugins.flash = {
		enable = true;

		lazyLoad.settings = {
			keys = [
				{
					__unkeyed-1 = "s";
					__unkeyed-2 = "<cmd>lua _G.flash_2char_jump()<cr>";
					mode = [ "n" "x" "o" ];
					desc = "Flash 2-char jump";
				}
				{
					__unkeyed-1 = "S";
					__unkeyed-2 = "<cmd>lua require('flash').treesitter()<cr>";
					mode = [ "n" "x" "o" ];
					desc = "Flash Treesitter";
				}
				{
					__unkeyed-1 = "r";
					__unkeyed-2 = "<cmd>lua require('flash').remote()<cr>";
					mode = "o";
					desc = "Remote Flash";
				}
				{
					__unkeyed-1 = "R";
					__unkeyed-2 = "<cmd>lua require('flash').treesitter_search()<cr>";
					mode = [ "o" "x" ];
					desc = "Treesitter Search";
				}
				{
					__unkeyed-1 = "<c-s>";
					__unkeyed-2 = "<cmd>lua require('flash').toggle()<cr>";
					mode = "c";
					desc = "Toggle Flash Search";
				}
			];
		};

		luaConfig.content = ''
			function _G.flash_2char_jump()
				local Flash = require("flash")
				---@param opts Flash.Format
				local function format(opts)
					-- always show first and second label
					return {
						{ opts.match.label1, "FlashMatch" },
						{ opts.match.label2, "FlashLabel" },
					}
				end
				Flash.jump({
					search = { mode = "search" },
					label = { after = false, before = { 0, 0 }, uppercase = false, format = format },
					pattern = [[\<]],
					action = function(match, state)
						state:hide()
						Flash.jump({
							search = { max_length = 0 },
							highlight = { matches = false },
							label = { format = format },
							matcher = function(win)
								-- limit matches to the current label
								return vim.tbl_filter(function(m)
									return m.label == match.label and m.win == win
								end, state.results)
							end,
							labeler = function(matches)
								for _, m in ipairs(matches) do
									m.label = m.label2 -- use the second label
								end
							end,
						})
					end,
					labeler = function(matches, state)
						local labels = state:labels()
						for m, match in ipairs(matches) do
							match.label1 = labels[math.floor((m - 1) / #labels) + 1]
							match.label2 = labels[(m - 1) % #labels + 1]
							match.label = match.label1
						end
					end,
				})
			end
			'';
	};
	keymaps = lib.mkIf (!config.plugins.flash.lazyLoad.enable) [
		{
			mode = [ "n" "x" "o" ];
			key = "s";
			action = "<cmd>lua _G.flash_2char_jump()<cr>";
			options.desc = "Flash 2-char jump";
		}
		{
			mode = [ "n" "x" "o" ];
			key = "S";
			action = "<cmd>lua require('flash').treesitter()<cr>";
			options.desc = "Flash Treesitter";
		}
		{
			mode = "o";
			key = "r";
			action = "<cmd>lua require('flash').remote()<cr>";
			options.desc = "Remote Flash";
		}
		{
			mode = [ "o" "x" ];
			key = "R";
			action = "<cmd>lua require('flash').treesitter_search()<cr>";
			options.desc = "Treesitter Search";
		}
		{
			mode = "c";
			key = "<c-s>";
			action = "<cmd>lua require('flash').toggle()<cr>";
			options.desc = "Toggle Flash Search";
		}
	];
}
