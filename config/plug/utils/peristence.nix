{
	extraConfigLua = ''
		local named_session_dir = vim.fn.stdpath("state") .. "/named-sessions"

		local function named_session_path(name)
			name = vim.trim(name)
			if name == "" or name:find("[/\\\\]") then
				vim.notify("Session name must be a simple name", vim.log.levels.WARN)
				return
			end
			vim.fn.mkdir(named_session_dir, "p")
			return named_session_dir .. "/" .. name .. ".vim"
		end

		function SaveNamedSession()
			local path = named_session_path(vim.fn.input("Save named session: "))
			if not path then
				return
			end
			vim.cmd("mksession! " .. vim.fn.fnameescape(path))
			vim.notify("Saved session: " .. vim.fn.fnamemodify(path, ":t:r"))
		end

		function LoadNamedSession()
			local paths = vim.fn.glob(named_session_dir .. "/*.vim", false, true)
			if #paths == 0 then
				vim.notify("No named sessions found", vim.log.levels.INFO)
				return
			end

			local choices = {}
			for _, path in ipairs(paths) do
				table.insert(choices, {
					name = vim.fn.fnamemodify(path, ":t:r"),
					path = path,
				})
			end

			vim.ui.select(choices, {
				prompt = "Load named session:",
				format_item = function(item) return item.name end,
			}, function(choice)
				if choice then
					vim.cmd("source " .. vim.fn.fnameescape(choice.path))
				end
			end)
		end
	'';

	plugins.persistence = {
		enable = true;
		settings = {
			# Minimum number of file buffers that need to be open to save a session
			need = 2;
			branch = true; # Use separate sessions for different git branches
		};
	};

	keymaps = [
		{
			mode = "n";
			key = "<leader>qs";
			action.__raw = ''function() require("persistence").load() end'';
			options = { desc = "Restore Session"; };
		}
		{
			mode = "n";
			key = "<leader>qS";
			action.__raw = ''function() require("persistence").select() end'';
			options = { desc = "Select saved session"; };
		}
		{
			mode = "n";
			key = "<leader>qn";
			action = "<cmd>lua SaveNamedSession()<cr>";
			options = { desc = "Save named session"; };
		}
		{
			mode = "n";
			key = "<leader>qN";
			action = "<cmd>lua LoadNamedSession()<cr>";
			options = { desc = "Load named session"; };
		}
		{
			mode = "n";
			key = "<leader>ql";
			action.__raw = ''function() require("persistence").load({ last = true }) end'';
			options = { desc = "Restore Last Session"; };
		}
		{
			mode = "n";
			key = "<leader>qd";
			action.__raw = ''function() require("persistence").stop() end'';
			options = { desc = "Don't Save Current Session"; };
		}
	];
}
