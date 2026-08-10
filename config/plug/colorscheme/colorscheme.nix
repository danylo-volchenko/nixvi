{ config, lib, ... }:
let
	themeData = lib.nixvim.toLuaObject config.themeData;
in
	{
	colorschemes = {
		base16 = {
			enable = true;
			setUpBar = true;
			colorscheme = import ../../colors/${config.theme}.nix { };
			settings = {
				cmp = true;
				lsp_semantic = true;
				lazygit = true;
				neotree = true;
				ts_rainbow = true;
				dapui = true;
				bufferline = true;
				lualine = true;
				todo-comments = true;
				snacks = true;
				markview = true;
				blink-cmp = true;
				mini = true;
			};
		};
	};

	extraConfigLua = lib.optionalString (config.theme == "paradise") ''
		local theme_data = ${themeData}
		local variant = "dark"

		local function apply_highlights(highlights)
			for name, spec in pairs(highlights) do
				vim.api.nvim_set_hl(0, name, spec)
			end
		end

		local function lualine_theme(palette)
			local function mode()
				return {
					a = { fg = palette.base05, bg = palette.base00, gui = "bold" },
					b = { fg = palette.base04, bg = palette.base00 },
					c = { fg = palette.base05, bg = palette.base00 },
					x = { fg = palette.base04, bg = palette.base00 },
					y = { fg = palette.base04, bg = palette.base00 },
					z = { fg = palette.base05, bg = palette.base00 },
				}
			end
			return {
				normal = mode(),
				insert = mode(),
				visual = mode(),
				replace = mode(),
				command = mode(),
				inactive = mode(),
			}
		end

		local function refresh_lualine(palette)
			if not package.loaded.lualine then
				return
			end
			require("lualine").setup({ options = { theme = lualine_theme(palette) } })
			require("lualine").refresh({ scope = "all" })
		end

		local function refresh_bufferline()
			if not package.loaded.bufferline then
				return
			end
			local ui = require("bufferline.ui")
			if type(ui.refresh) == "function" then
				ui.refresh()
			end
		end

		local function apply_paradise(next_variant)
			local palette = theme_data.palettes[next_variant]
			if not palette then
				return
			end

			variant = next_variant
			vim.g.paradise_variant = variant
			vim.o.background = variant
			require("base16-colorscheme").setup(palette)
			vim.o.background = variant
			apply_highlights(theme_data.highlights[variant])
			refresh_lualine(palette)
			refresh_bufferline()
			vim.cmd("redrawstatus")
		end

		function ToggleParadise()
			apply_paradise(variant == "dark" and "light" or "dark")
		end

		vim.api.nvim_create_user_command("ParadiseToggle", ToggleParadise, {})
		vim.api.nvim_create_user_command("ParadiseDark", function() apply_paradise("dark") end, {})
		vim.api.nvim_create_user_command("ParadiseLight", function() apply_paradise("light") end, {})

		vim.api.nvim_create_autocmd("User", {
			pattern = "DeferredUIEnter",
			callback = function()
				vim.schedule(function()
					apply_paradise(variant)
				end)
			end,
		})

		apply_paradise(variant)
	'';
}
