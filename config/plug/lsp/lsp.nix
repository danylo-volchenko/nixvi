{ ... }:
{
	plugins = {
		lspconfig.enable = true;
	};

	lsp = {
		servers = {
				clangd = {
					enable = true;
					config = {
						cmd = [
							"clangd"
							"--clang-tidy"
							"--inlay-hints"
							"--background-index"
							"--completion-style=detailed"
							"--function-arg-placeholders=true"
							"--all-scopes-completion"
							"--cross-file-rename"
							"--header-insertion-decorators"
							"--header-insertion=never"
							"--limit-results=10"
							"--pch-storage=memory"
							"--suggest-missing-includes"
							"--malloc-trim"
						];
						init_options = {
							usePlaceholders = true;
							completeUnimported = true;
							clangdFileStatus = true;
						};
						settings = {
							clangd = {
								InlayHints = {
									Enabled = true;
									ParameterNames = true;
									DeducedTypes = true;
									Designators = true;
								};
							};
						};
					};
				};
		};
	};
	lsp.keymaps = [
		{ key = "gd"; lspBufAction = "definition"; options.desc = "Goto Definition"; }
		{ key = "gr"; lspBufAction = "references"; options.desc = "Goto References"; }
		{ key = "gD"; lspBufAction = "declaration"; options.desc = "Goto Declaration"; }
		{ key = "gI"; lspBufAction = "implementation"; options.desc = "Goto Implementation"; }
		{ key = "gT"; lspBufAction = "type_definition"; options.desc = "Type Definition"; }
		{ key = "K"; lspBufAction = "hover"; options.desc = "Hover"; }
		{ key = "<leader>cw"; lspBufAction = "workspace_symbol"; options.desc = "Workspace Symbol"; }
		{ key = "<leader>cr"; lspBufAction = "rename"; options.desc = "Rename"; }
		{ key = "<leader>ca"; lspBufAction = "code_action"; options.desc = "Code Action"; }
		{ key = "<leader>co"; lspBufAction = "document_symbol"; options.desc = "Document Symbols"; }
	];
	keymaps = [
		{
			mode = [ "n" "v" ]; key = "<leader>cf";
			action = "<cmd>lua vim.lsp.buf.format({ async = true })<cr>";
			options = { desc = "Format"; silent = true; };
		}
		{
			mode = "n"; key = "<leader>cd";
			action = "<cmd>lua vim.diagnostic.open_float()<cr>";
			options = { desc = "Line Diagnostics"; silent = true; };
		}
		{
			mode = "n"; key = "[d";
			action = "<cmd>lua vim.diagnostic.jump({ count = -1 })<cr>";
			options = { desc = "Previous Diagnostic"; silent = true; };
		}
		{
			mode = "n"; key = "]d";
			action = "<cmd>lua vim.diagnostic.jump({ count = 1 })<cr>";
			options = { desc = "Next Diagnostic"; silent = true; };
		}
		{
			mode = "n"; key = "cp";
			action.__raw = ''
				function()
					local params = vim.lsp.util.make_position_params()
					vim.lsp.buf_request(0, "textDocument/definition", params, function(err, result, ctx)
						if not result or vim.tbl_isempty(result) then return end
						local loc = type(result) == "table" and result[1] or result
						vim.lsp.util.preview_location(loc, { border = "rounded" })
					end)
				end
			'';
			options = { desc = "Peek Definition"; silent = true; };
		}
		{
			mode = "n"; key = "cP";
			action.__raw = ''
				function()
					local params = vim.lsp.util.make_position_params()
					vim.lsp.buf_request(0, "textDocument/typeDefinition", params, function(err, result, ctx)
						if not result or vim.tbl_isempty(result) then return end
						local loc = type(result) == "table" and result[1] or result
						vim.lsp.util.preview_location(loc, { border = "rounded" })
					end)
				end
			'';
			options = { desc = "Peek Type Definition"; silent = true; };
		}
	];
	extraConfigLua = ''
	local _border = "rounded"
	
	vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
		config = config or {}
		config.border = _border
		return vim.lsp.handlers.hover(err, result, ctx, config)
	end

	vim.diagnostic.config {
		float = { border = _border }
	};
	'';
}
