{
	autoCmd = [
		# Vertically center document when entering insert mode
		{
			event = "InsertEnter";
			command = "norm zz";
		}

		# Open help in a vertical split
		{
			event = "FileType";
			pattern = "help";
			command = "wincmd L";
		}

		# Enable spellcheck for some filetypes
		{
			event = "FileType";
			pattern = [
				"markdown"
				"neorg"
			];
			command = "setlocal nospell | set conceallevel=2 | set et | set linebreak | set textwidth=120 | set wrap";
		}

		{
			event = "FileType";
			pattern = [ "nix" ];
			command = "set ts=4 | set sw=4 | set noet";
		}

		{
			event = "FileType";
			pattern = [ "cpp" "hpp" "rust" ];
			command = "set ts=4 | set sw=4 | set noet";
		}

		{
			event = "FileType";
			pattern = [ "c" "h"];
			command = "set tags=./tags,tags,/opt/toolchains/zephyr/tags,/home/wired/esp/esp-idf/tags;";
		}

		{
			event = "TermOpen";
			pattern = "*";
			command = "setlocal nospell";
		}

		{
			event = [
				"BufNewFile"
			];
			pattern = [
				"*.h"
			];
			callback = { __raw =  ''
				function()
				if not vim.bo.modifiable then return end
				local filename = vim.fn.expand("%:t:r"):upper()
				local include_guard = "__" .. filename .. "_H__"
				local boilerplate = string.format(
				[[
/**
  * @file
  * @brief
  */
/* vim: set noet tw=8 sw=8: */
#if !defined(%s)
#define %s 1

#ifdef __cplusplus
extern "C" {
#endif
/* include files */

/* macro definitions */

/* type definitions */

/* variable declarations */

/* function Prototypes */

/* function definitions */

#ifdef __cplusplus
}
#endif

#endif /* %s */
]], include_guard, include_guard, include_guard)
				vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(boilerplate, "\n"))
				end
				'';
			};
		}
		{
			event = [
				"BufNewFile"
			];
			pattern = [
				"*.c"
			];
			callback = {__raw = ''
				function()
				if not vim.bo.modifiable then return end
				local boilerplate = [[
/**
  * @file
  * @brief
  */
/* vim: set noet tw=4 sw=4: */
/* include files */

/* macro definitions */

/* type definitions */

/* variable declarations */

/* function Prototypes */

/* function definitions */
]]
				vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(boilerplate, "\n"))
				end
			'';
			};
		}
		{
			event = [
				"BufNewFile"
			];
			pattern = [
				"*.rs"
			];
			callback = {
				__raw = ''
					function()
					if not vim.bo.modifiable then return end
					local boilerplate = [[ /* vim: set noet tw=4 sw=4: */ ]]
						vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(boilerplate, "\n"))
					end
				'';
			};
		}
		{
			event = [ "BufNewFile" ];
			pattern = [ "*.hpp" "*.cpp" ];
			callback = {
				__raw = ''
					function()
					if not vim.bo.modifiable then return end
						local function get_relative_path_parts()
							local full_path = vim.api.nvim_buf_get_name(0)
							local parts = vim.split(full_path, "/", { trimempty = true })
							local rel_parts = {}
							local found_root = false

							for _, p in ipairs(parts) do
								if found_root then
									table.insert(rel_parts, p)
								elseif p == "src" or p == "include" then
									found_root = true
								end
							end

							if #rel_parts > 0 then
								return rel_parts
							end

							return { vim.fn.expand("%:t") }
						end

						local function infer_namespace(rel_parts)
							local ns_parts = {}
							for i = 1, #rel_parts - 1 do
								table.insert(ns_parts, rel_parts[i])
							end

							if #ns_parts == 0 then
								return nil
							end
							return table.concat(ns_parts, "::")
						end

						local function cpp_boilerplate(kind)
							local rel_parts = get_relative_path_parts()
							local file_tag = table.concat(rel_parts, "/")
							local pragma_parts = vim.deepcopy(rel_parts)
							local last_idx = #pragma_parts
							pragma_parts[last_idx] = vim.fn.fnamemodify(pragma_parts[last_idx], ":r")
							local pragma_tag = table.concat(pragma_parts, "/")
							local basename = vim.fn.fnamemodify(rel_parts[#rel_parts], ":t:r")
							local namespace_name = infer_namespace(rel_parts)
							if not namespace_name then
								namespace_name = basename
							end

							local namespace_open = "namespace " .. namespace_name .. " {"
							local namespace_close = "} /* namespace " .. namespace_name .. " */"

							if kind == "hpp" then
								return string.format([[
/**
 * @file %s
 * @brief 
 */
/* vim: set noet tw=4 sw=4: */
#pragma once /* %s */

#if defined(USE_PCH)

#else

#endif

%s

%s

]], file_tag, pragma_tag, namespace_open, namespace_close)

							elseif kind == "cpp" then
								local include_line = ""
								if basename == "main" then
									namespace_open = ""
									namespace_close = ""
								else
									-- This is simple, but assumes .hpp is just basename
									include_line = string.format('#include "%s.hpp"\n', basename)
								end

								return string.format([[
/**
 * @file %s
 * @brief
 */
/* vim: set noet tw=4 sw=4: */
#if defined(USE_PCH)

#else

#endif

%s
%s

%s
]], file_tag, include_line, namespace_open, namespace_close)
							end
						end

						local ext = vim.fn.expand("%:e")
						local text = cpp_boilerplate(ext)
						vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(text, "\n"))

						vim.api.nvim_win_set_cursor(0, { 3, 11 })
					end
			'';
			};
		}
		# Keep Neovim open when closing the last buffer
		{
			event = "BufDelete";
			callback = {
				__raw = ''
					function()
						if #vim.fn.getbufinfo({ buflisted = 1 }) == 0 then
							vim.cmd("enew")
						end
					end
				'';
			};
		}

#		{
#		  event = "ExitPre";
#		  desc = "Terminal exit confirmation";
#		  callback = {
#			__raw = ''
#			  function()
#				local safe_processes = { 
#				  ["zsh"]=true, ["bash"]=true, ["sh"]=true, ["fish"]=true, 
#				  ["env"]=true 
#				}
#				local unsafe_jobs = {}
#				local has_terminals = false
#
#				for _, buf in ipairs(vim.api.nvim_list_bufs()) do
#				  if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == "terminal" then
#					 local job_id = vim.b[buf].terminal_job_id
#					 if job_id and vim.fn.jobwait({job_id}, 0)[1] == -1 then
#					   has_terminals = true
#					   -- Smart Name Extraction
#					   local title = vim.b[buf].term_title or "unknown"
#					   -- If title is a path/URI (common in Nix), get the tail (e.g. /usr/bin/env -> env)
#					   local cmd_name = vim.fn.fnamemodify(title, ":t")
#					   -- Get first word (e.g. "python main.py" -> "python")
#					   cmd_name = cmd_name:match("^(%S+)") or cmd_name
#
#					   if not safe_processes[cmd_name] then
#						 table.insert(unsafe_jobs, string.format("• %s (Buf %d)", title, buf))
#					   end
#					 end
#				  end
#				end
#				if #unsafe_jobs > 0 then
#				   local msg = "Background jobs are still running:\n" .. table.concat(unsafe_jobs, "\n") .. "\n\nForce quit?"
#				   local choice = vim.fn.confirm(msg, "&Yes\n&No", 2)
#				   if choice == 1 then
#					 for _, buf in ipairs(vim.api.nvim_list_bufs()) do
#						if vim.bo[buf].buftype == "terminal" then
#							vim.api.nvim_buf_delete(buf, { force = true })
#						end
#					 end
#				   else
#					 return
#				   end
#				elseif has_terminals then
#				   for _, buf in ipairs(vim.api.nvim_list_bufs()) do
#					  if vim.bo[buf].buftype == "terminal" then
#						  vim.api.nvim_buf_delete(buf, { force = true })
#					  end
#				   end
#				end
#			  end '';
#		  };
#		}
	];
}
