{ config, lib, pkgs, ... }:
let
  pickerMappings = {
    trouble_open = {
      char = "<C-t>";
      func.__raw = "MiniPickTrouble";
    };
  };
in
{
  extraPackages = with pkgs; [ ripgrep ];

  plugins.mini.modules = {
    pick = {
      mappings = pickerMappings;
      window.config = {
        width = 50;
        height = 14;
      };
    };
    extra = { };
  };

  extraConfigLuaPre = lib.mkOrder 700 ''
    local pick = require("mini.pick")

    local function start_list(name, items, choose)
      return pick.start({
        source = {
          name = name,
          items = items,
          choose = choose,
        },
      })
    end

    function MiniPickProjects()
      local markers = { ".git", "Makefile", "makefile", "GNUmakefile", "package.json" }
      local seen, items = {}, {}

      local function add(path)
        local full_path = vim.fn.fnamemodify(path, ":p")
        local directory = vim.fn.isdirectory(full_path) == 1 and full_path or vim.fs.dirname(full_path)
        local marker = vim.fs.find(markers, { path = directory, upward = true })[1]
        local root = marker and vim.fs.dirname(marker)
        if root and not seen[root] then
          seen[root] = true
          table.insert(items, { text = vim.fn.fnamemodify(root, ":~"), path = root })
        end
      end

      add(vim.fn.getcwd())
      for _, path in ipairs(vim.v.oldfiles or {}) do add(path) end
      table.sort(items, function(a, b) return a.text < b.text end)
      return start_list("Projects", items, function(item)
        vim.cmd.tcd(vim.fn.fnameescape(item.path))
      end)
    end

    function MiniPickAutocmds()
      local items = {}
      for _, autocmd in ipairs(vim.api.nvim_get_autocmds({})) do
        table.insert(items, {
          text = string.format("%-18s %-24s %s", autocmd.event or "", autocmd.pattern or "", autocmd.desc or autocmd.command or ""),
        })
      end
      return start_list("Autocmds", items, function() end)
    end

    function MiniPickGitStatus()
      local items = {}
      for _, line in ipairs(vim.fn.systemlist({ "git", "status", "--short", "--renames" })) do
        local path = line:sub(4):match(" -> (.+)$") or line:sub(4)
        table.insert(items, { text = line, path = path })
      end
      return start_list("Git status", items, pick.default_choose)
    end

    function MiniPickTrouble()
      local matches = pick.get_picker_matches() or {}
      local selected = #(matches.marked or {}) > 0 and matches.marked or (matches.all or {})
      local items = {}

      for _, item in ipairs(selected) do
        local filename, lnum, col, text
        if type(item) == "table" then
          filename = item.path or item.file or item.filename
          lnum, col = item.lnum or 1, item.col or 1
          text = item.text or item.line or item.label or ""
        elseif type(item) == "string" then
          filename, lnum, col, text = item:match("^(.-):(%d+):(%d+):(.*)$")
          lnum, col = tonumber(lnum), tonumber(col)
        end
        if filename then table.insert(items, { filename = filename, lnum = lnum, col = col, text = text }) end
      end

      if #items > 0 then
        vim.fn.setqflist({}, " ", { title = "MiniPick", items = items })
        vim.schedule(function() vim.cmd("Trouble qflist") end)
      end
      return true
    end
  '';

  keymaps = [
    { mode = "n"; key = "<leader>fa"; action = "<cmd>lua MiniPickAutocmds()<cr>"; options.desc = "Find autocmds"; }
    { mode = "n"; key = "<leader>fh"; action = "<cmd>Pick help<cr>"; options.desc = "Find help tags"; }
    { mode = "n"; key = "<leader>fk"; action = "<cmd>Pick keymaps<cr>"; options.desc = "Find keymaps"; }
    { mode = "n"; key = "<leader>fp"; action = "<cmd>lua MiniPickProjects()<cr>"; options.desc = "Find projects"; }
    { mode = "n"; key = "<leader>fs"; action = "<cmd>Pick lsp scope='document_symbol'<cr>"; options.desc = "Find lsp document symbols"; }
    { mode = "n"; key = "<leader>fT"; action = "<cmd>Pick colorschemes<cr>"; options.desc = "Find theme"; }
    { mode = "n"; key = "<leader>fw"; action = "<cmd>Pick grep_live<cr>"; options.desc = "Live grep"; }
    { mode = "n"; key = "<leader>fO"; action = "<cmd>Pick oldfiles current_dir=true<cr>"; options.desc = "Find Smart (Frecency)"; }
    { mode = "n"; key = "<leader>f?"; action = "<cmd>Pick buf_lines scope='all'<cr>"; options.desc = "Fuzzy find in open buffers"; }
  ] ++ lib.optionals (!config.plugins.fzf-lua.enable) [
    { mode = "n"; key = "<leader>f'"; action = "<cmd>Pick marks<cr>"; options.desc = "Find marks"; }
    { mode = "n"; key = "<leader>f/"; action = "<cmd>Pick buf_lines scope='current'<cr>"; options.desc = "Fuzzy find in current buffer"; }
    { mode = "n"; key = "<leader>fr"; action = "<cmd>Pick resume<cr>"; options.desc = "Resume find"; }
    { mode = "n"; key = "<leader>fb"; action = "<cmd>Pick buffers<cr>"; options.desc = "Find buffers"; }
    { mode = "n"; key = "<leader>ff"; action = "<cmd>Pick files<cr>"; options.desc = "Find files"; }
    { mode = "n"; key = "<leader><space>"; action = "<cmd>Pick files<cr>"; options.desc = "Find files"; }
    { mode = "n"; key = "<leader>fm"; action = "<cmd>Pick manpages<cr>"; options.desc = "Find man pages"; }
    { mode = "n"; key = "<leader>fo"; action = "<cmd>Pick oldfiles<cr>"; options.desc = "Find old files"; }
    { mode = "n"; key = "<leader>fq"; action = "<cmd>Pick list scope='quickfix'<cr>"; options.desc = "Find quickfix"; }
    { mode = "n"; key = "<leader>fD"; action = "<cmd>Pick lsp scope='references'<cr>"; options.desc = "Find references"; }
    { mode = "n"; key = "<leader>fS"; action = "<cmd>Pick spellsuggest<cr>"; options.desc = "Find spelling suggestions"; }
    { mode = "n"; key = "<leader>fH"; action = "<cmd>Pick hl_groups<cr>"; options.desc = "Find highlights"; }
    { mode = "n"; key = "<leader>gB"; action = "<cmd>Pick git_branches<cr>"; options.desc = "Find git branches"; }
    { mode = "n"; key = "<leader>gs"; action = "<cmd>lua MiniPickGitStatus()<cr>"; options.desc = "Find git status"; }
    { mode = "n"; key = "<leader>gS"; action = ''<cmd>lua MiniPick.builtin.cli({ command = { "git", "stash", "list" } })<cr>''; options.desc = "Find git stashes"; }
  ];
}
