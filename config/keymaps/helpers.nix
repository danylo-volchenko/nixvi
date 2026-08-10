{
	globals.mapleader = " ";

	extraConfigLua = ''
	function toggleInlayHints()
		vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
		vim.notify("Inlay hints: " .. (vim.lsp.inlay_hint.is_enabled({}) and "on" or "off"))
	end

	function ToggleLineNumber()
		if vim.wo.number then
			vim.wo.number = false
		else
			vim.wo.number = true
			vim.wo.relativenumber = false
		end
	end

	function ToggleRelativeLineNumber()
		if vim.wo.relativenumber then
			vim.wo.relativenumber = false
		else
			vim.wo.relativenumber = true
			vim.wo.number = false
		end
	end

	function ToggleWrap()
		vim.wo.wrap = not vim.wo.wrap
	end

	function CopyCursorLocation()
		local full_path = vim.fn.expand("%:p")
		local line = vim.fn.line(".")

		local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
		if git_root == nil or git_root == "" then
			print("Not in a git repo.")
			return
		end

		local rel_path = full_path:gsub("^" .. git_root .. "/", "")
		local location = rel_path .. " +" .. line

		vim.fn.setreg("+", location)
		print("Copied: " .. location)
	end

	function searchTag()
		vim.cmd("tag " .. vim.fn.expand("<cword>"))
	end

	local function get_selected_text()
		local mode = vim.api.nvim_get_mode().mode
		local text = ""
		if mode:match("[vV]") then
			local _, ls, cs = unpack(vim.fn.getpos("'<"))
			local _, le, ce = unpack(vim.fn.getpos("'>"))
			local lines = vim.fn.getline(ls, le)
			if #lines == 0 then
				return
			end
			lines[1] = string.sub(lines[1], cs)
			lines[#lines] = string.sub(lines[#lines], 1, ce)
			local text = table.concat(lines, "\n")
		else
			text = vim.fn.expand('<cword>')
		end
		return text ~= "" and text or nil
	end

	function ShowConversions()
		local text = get_selected_text()
		if not text then
			vim.notify("No text selected", vim.log.levels.WARN)
			return
		end

		local lines = {
			"Conversions for: "..text,
			""
		}

		local num = tonumber(text)
		if num then
			local function to_binary(n)
				if n == 0 then return "0" end
				local bits = {}
				while n > 0 do
					table.insert(bits, 1, n % 2)
					n = math.floor(n / 2)
				end
				return table.concat(bits)
			end
			table.insert(lines, string.format("Hex:    %-15s", "0x"..string.format("%X", num)))
			table.insert(lines, string.format("Bin:    %-15s", "0b"..to_binary(num)))
			table.insert(lines, string.format("Dec:    %-15s", tostring(num)))
			table.insert(lines, string.format("Oct:    %-15s", "0"..string.format("%o", num)))
			table.insert(lines, string.format("ASCII:  %-15s", num >= 0 and num <= 127 and string.char(num) or "N/A"))
		end

		table.insert(lines, "b64enc: "..(vim.base64.encode(text:gsub("%z", "")) or "N/A"))
		table.insert(lines, "b64dec: "..(function()
			local t = text:gsub("%z", ""):gsub("=+$", "")
			local pad = (4 - (#t % 4)) % 4
			t = t .. ('='):rep(pad)
			local ok, decoded = pcall(vim.base64.decode, t)
			return ok and decoded:gsub("%z", "") or "N/A"
		end)())
		table.insert(lines, "")

		local bufnr, winid = vim.lsp.util.open_floating_preview(lines, "markdown", {
			border = "rounded",
			focusable = true,
			close_events = { "CursorMoved", "CursorMovedI", "BufHidden", "InsertCharPre" },
			relative = "cursor",
			row = 1,
			col = 0,
		})

		vim.keymap.set('n', 'y', function()
			local line = vim.api.nvim_get_current_line()
			local value = line:match(":%s*(.+)%s*$")
			if value then
				vim.fn.setreg('+', value)
				vim.notify("Copied: "..value, vim.log.levels.INFO)
				vim.api.nvim_win_close(winid, true)
			end
		end, {buffer = bufnr})

		vim.keymap.set('n', 'p', function()
			local line = vim.api.nvim_get_current_line()
			local value = line:match(":%s*(.+)%s*$")
			if value then
				vim.api.nvim_paste(value, true, -1)
				vim.api.nvim_win_close(winid, true)
			end
		end, {buffer = bufnr})
	end

	function OpenUnderCursor()
		local url = vim.fn.expand("<cfile>")
		if url == "" then
			vim.notify("No URL/file found under cursor", vim.log.levels.WARN)
			return
		end

		local opener = "xdg-open"

		vim.notify("Opened URL in browser", vim.log.levels.INFO)
		vim.system({opener, url}, { detach = true })
	end

	function ToggleHex()
		local modified = vim.bo.modified
		local old_readonly = vim.bo.readonly
		local old_modifiable = vim.bo.modifiable
		vim.bo.readonly = false
		vim.bo.modifiable = true

		if not vim.b.editHex then
		vim.b.old_ft = vim.bo.filetype
		vim.b.old_bin = vim.bo.binary
		vim.opt_local.binary = true
		local status, _ = pcall(vim.cmd, "silent e")
		if not status then
			print("Error: Save changes before toggling Hex Mode!")
			vim.bo.readonly = old_readonly
			vim.bo.modifiable = old_modifiable
			if not vim.b.old_bin then vim.opt_local.binary = false end
			return
			end
			vim.bo.filetype = "xxd"
			vim.b.editHex = true
			vim.cmd("%!xxd")
		else
			if vim.b.old_ft then
			vim.bo.filetype = vim.b.old_ft
			end
			if not vim.b.old_bin then
			vim.opt_local.binary = false
			end
			vim.b.editHex = false
			vim.cmd("%!xxd -r")
			end
			vim.bo.modified = modified
			vim.bo.readonly = old_readonly
			vim.bo.modifiable = old_modifiable
			end
	'';
}
