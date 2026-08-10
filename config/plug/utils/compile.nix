{
  extraConfigLua = ''
    local compile_job
    local compile_buf
    local compile_win
    local compile_cwd

    local function compile_close()
      if compile_job and compile_job > 0 and vim.fn.jobwait({ compile_job }, 0)[1] == -1 then
        vim.fn.jobstop(compile_job)
      end
      compile_job = nil
      if compile_win and vim.api.nvim_win_is_valid(compile_win) then
        vim.api.nvim_win_close(compile_win, true)
      end
      if compile_buf and vim.api.nvim_buf_is_valid(compile_buf) then
        vim.api.nvim_buf_delete(compile_buf, { force = true })
      end
      compile_win = nil
      compile_buf = nil
    end

    local function compile_parse(lines)
      local items = {}
      for _, line in ipairs(lines) do
        line = line
          :gsub("\27%][^\7]*\7", "")
          :gsub("\27%[[0-?]*[ -/]*[@-~]", "")
          :gsub("\r", "")
        local file, row, col, text = line:match("([%w%._/%-]+):(%d+):(%d+):%s*(.*)")
        if not file then
          file, row, col = line:match("%-%->%s*([^:]+):(%d+):(%d+)")
          text = line
        end
        if file and row and col then
          if not vim.fn.isabsolutepath(file) then
            file = vim.fs.normalize(vim.fs.joinpath(compile_cwd or vim.fn.getcwd(), file))
          end
          table.insert(items, {
            filename = file,
            lnum = tonumber(row),
            col = tonumber(col),
            text = text or line,
            type = line:find("warning", 1, true) and "W" or "E",
          })
        end
      end
      return items
    end

    function Compile()
      if compile_job and compile_job > 0 and vim.fn.jobwait({ compile_job }, 0)[1] == -1 then
        vim.notify("A compile job is already running", vim.log.levels.WARN)
        return
      end

      local makefile = vim.fs.find({ "Makefile", "makefile", "GNUmakefile" }, {
        upward = true,
        path = vim.fn.getcwd(),
        type = "file",
      })[1]
      if not makefile then
        compile_cwd = vim.fn.getcwd()
        vim.notify("No Makefile found; <leader>mo opens a terminal here", vim.log.levels.WARN)
        return
      end
      local cwd = vim.fs.dirname(makefile)
      compile_cwd = cwd
      compile_close()

      compile_buf = vim.api.nvim_create_buf(false, true)
      vim.api.nvim_buf_set_name(compile_buf, "CompileTerm")
      compile_win = vim.api.nvim_open_win(compile_buf, true, {
        split = "below",
        height = math.max(8, math.floor(vim.o.lines * 0.4)),
      })
      vim.bo[compile_buf].bufhidden = "wipe"
      vim.bo[compile_buf].filetype = "snacks_terminal"

      local output = {}
      local function collect(_, data)
        if data then
          vim.list_extend(output, data)
        end
      end

      compile_job = vim.fn.jobstart({ "make", "-B" }, {
        cwd = cwd,
        term = true,
        on_stdout = collect,
        on_stderr = collect,
        on_exit = function(_, code)
          vim.schedule(function()
            local items = compile_parse(output)
            vim.fn.setqflist({}, "r", {
              title = "make -B",
              items = items,
            })
            vim.notify(
              code == 0
                and "Compile succeeded; <leader>mo opens a terminal"
                or "Compile failed; quickfix updated, <leader>mo opens a terminal",
              code == 0 and vim.log.levels.INFO or vim.log.levels.ERROR
            )
            compile_job = nil
          end)
        end,
      })

      if compile_job <= 0 then
        vim.notify("Unable to start make", vim.log.levels.ERROR)
        compile_close()
      end
    end

    function CompileNextError()
      vim.cmd("cnext")
    end

    function CompilePreviousError()
      vim.cmd("cprevious")
    end

    function CompileClose()
      compile_close()
    end

    function CompileOpenTerminal()
      Snacks.terminal.toggle(nil, {
        cwd = compile_cwd or vim.fn.getcwd(),
        win = { position = "bottom", height = 10 },
      })
    end
  '';

  keymaps = [
    {
      mode = "n";
      key = "<leader>mc";
      action = "<cmd>lua Compile()<CR>";
      options = { desc = "Compile"; silent = true; };
    }
    {
      mode = "n";
      key = "<leader>mn";
      action = "<cmd>lua CompileNextError()<CR>";
      options = { desc = "Next compilation error"; silent = true; };
    }
    {
      mode = "n";
      key = "<leader>mp";
      action = "<cmd>lua CompilePreviousError()<CR>";
      options = { desc = "Previous compilation error"; silent = true; };
    }
    {
      mode = "n";
      key = "<leader>mq";
      action = "<cmd>lua CompileClose()<CR>";
      options = { desc = "Close compile terminal"; silent = true; };
    }
    {
      mode = "n";
      key = "<leader>mo";
      action = "<cmd>lua CompileOpenTerminal()<CR>";
      options = { desc = "Open terminal in compile directory"; silent = true; };
    }
  ];
}
