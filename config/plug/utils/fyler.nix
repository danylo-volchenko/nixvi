{ pkgs, ... }:
{
	extraPlugins = with pkgs.vimUtils; [
		(buildVimPlugin {
			pname = "fyler.nvim";
			version = "unstable-2026-08-08";
			src = pkgs.fetchFromGitHub {
				owner = "FylerOrg";
				repo = "fyler.nvim";
				rev = "33b2ef22acf7eb683cfc652bf3d1049546f28661";
				hash = "sha256-O9fRImtLow7nR+2LZ/dZnDVUICQ1Smp+duY9okLS1sM=";
			};
			# Fyler initializes runtime globals during setup, so the static
			# require-check cannot validate it reliably.
			doCheck = false;
		})
	];

		extraConfigLua = ''
		local fyler = require('fyler')
		fyler.setup({
			integrations = {
				icon = 'nvim_web_devicons',
			},
			extensions = {
				git = { enabled = true, inline = true },
				watcher = { enabled = true },
				trash = { enabled = true },
			},
			kind = 'split_left',
			kind_presets = {
				split_left = { width = 25 },
				split_left_most = {
					width = 25,
					win_opts = { winfixwidth = true },
				},
			},
			use_as_default_explorer = true,
			mappings = {
				n = {
					['<space>'] = { action = 'select' },
					['s'] = { action = 'select', args = { vsplit = true } },
					['-'] = { action = 'visit', args = { parent = true } },
					['.'] = { action = 'visit', args = { cursor = true } },
					['/'] = {
						action = function(instance)
							vim.schedule(function()
							require('mini.pick').builtin.files(nil, { source = { cwd = instance.dir } })
							end)
						end,
					},
				},
			},
		})
	'';

	keymaps = [
		{
			mode = [ "n" "v" ];
			key = "<leader>e";
			action = "<cmd>Fyler<cr>";
			options = {
				silent = true;
				desc = "Toggle file explorer";
			};
		}
	];
}
