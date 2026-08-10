{ pkgs, ... }:

{
	config = {
		performance = {
			byteCompileLua = {
				enable = true;
				nvimRuntime = true;
				configs = true;
				plugins = true;
			};
		};
		diagnostic.settings = {
			update_in_insert = true;
			severity_sort = true;
			float = {
				border = "rounded";
			};
			jump = {
				severity.__raw = "vim.diagnostic.severity.ERROR";
			};
			virtual_text = {
				prefix.__raw = ''
				  function(diagnostic)
					  local icons = {
						  [vim.diagnostic.severity.ERROR] = " ",
						  [vim.diagnostic.severity.WARN]  = " ",
						  [vim.diagnostic.severity.HINT]  = "󰌵 ",
						  [vim.diagnostic.severity.INFO]  = " ",
					  }
					  return icons[diagnostic.severity]
				  end
				 '';
				spacing = 1;
			};
			signs = {
				text.__raw = ''
					{
						[vim.diagnostic.severity.ERROR] = " ",
						[vim.diagnostic.severity.WARN]  = " ",
						[vim.diagnostic.severity.HINT]  = "󰌵 ",
						[vim.diagnostic.severity.INFO]  = " ",
					}
				'';
			};
		};
		clipboard.providers.wl-copy.enable = true;
		opts = {
			# Enable relative line numbers
			number = true;
			relativenumber = true;

			# Set tabs to 8 chars
			tabstop = 4;
			shiftwidth = 4;
			softtabstop = 0;
			expandtab = false;

			showtabline = 2;
			# Enable auto indenting
			smartindent = true;

			# Enable smart indenting (see https://stackoverflow.com/questions/1204149/smart-wrap-in-vim)
			breakindent = true;

			# Enable incremental searching
			hlsearch = true;
			incsearch = true;

			# Disable text wrap
			wrap = false;

			# Better splitting
			splitbelow = true;
			splitright = true;

			# Enable mouse mode
			mouse = "a"; # Mouse

			confirm = true; # asks for confirmation instead of giving errors (e.g., on quitting without saving)
			mousemoveevent = true; # allows mouse hover to be detected
			#pumblend = 10; # popups transparency
			#winblend = 10; # floating windows transparency

			# Enable ignorecase + smartcase for better searching
			ignorecase = true;
			smartcase = true; # Don't ignore case with capitals
			grepprg = "rg --vimgrep";
			grepformat = "%f:%l:%c:%m";

			# Decrease updatetime
			updatetime = 300; # faster completion (4000ms default)

			# Set completeopt to have a better completion experience
			completeopt = [
				"menuone"
				"noselect"
				"noinsert"
			];

			# Enable persistent undo history
			swapfile = false;
			autoread = true;
			backup = false;
			undofile = true;
			#autochdir = true;
			shell = "/usr/bin/env zsh";

			# Enable 24-bit colors
			termguicolors = true;

			# Enable the sign column to prevent the screen from jumping
			signcolumn = "yes";

			# Enable cursor line highlight
			cursorline = true; # Highlight the line where the cursor is located

			# Set fold settings
			# Keep folds open by default while using native Tree-sitter folding.
			foldcolumn = "0";
			foldlevel = 99;
			foldlevelstart = 99;
			foldenable = true;
			foldmethod = "expr";
			foldexpr = "v:lua.vim.treesitter.foldexpr()";

			# Always keep 10 lines above/below cursor unless at start/end of file
			scrolloff = 10;

			# Place a column line
			colorcolumn = "105";

			# Timeout for multi-key mappings (e.g. g., gc, <space>e).
			# 10ms was too short for human typing speed.
			timeoutlen = 300;

			# Set encoding type
			encoding = "utf-8";
			fileencoding = "utf-8";

			# More space in the neovim command line for displaying messages
			cmdheight = 2;

			# We don't need to see things like INSERT anymore
			showmode = false;

			# Spell
			spelllang = "en_us";
			spell = false;


			list = true;
			listchars = {
				tab = " ";
				trail = "~";
				extends = "»";
				precedes = "«";
				nbsp = "·";
			};
			fillchars = {
				fold = " ";
				foldopen = " ";
				foldsep = " ";
				foldclose = " ";
				eob = "~";
			};
		};
	};
}
