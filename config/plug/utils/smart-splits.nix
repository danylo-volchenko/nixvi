{ config, lib, ... }:
{
  plugins.smart-splits = {
    enable = true;

    lazyLoad.settings = {
      keys = [
        {
          __unkeyed-1 = "<C-h>";
          __unkeyed-2 = ":lua require('smart-splits').move_cursor_left()<CR>";
          desc = "Move cursor left";
          silent = true;
        }
        {
          __unkeyed-1 = "<C-j>";
          __unkeyed-2 = ":lua require('smart-splits').move_cursor_down()<CR>";
          desc = "Move cursor down";
          silent = true;
        }
        {
          __unkeyed-1 = "<C-k>";
          __unkeyed-2 = ":lua require('smart-splits').move_cursor_up()<CR>";
          desc = "Move cursor up";
          silent = true;
        }
        {
          __unkeyed-1 = "<C-l>";
          __unkeyed-2 = ":lua require('smart-splits').move_cursor_right()<CR>";
          desc = "Move cursor right";
          silent = true;
        }
        {
          __unkeyed-1 = "<A-h>";
          __unkeyed-2 = ":lua require('smart-splits').resize_left()<CR>";
          desc = "Resize left";
          silent = true;
        }
        {
          __unkeyed-1 = "<A-j>";
          __unkeyed-2 = ":lua require('smart-splits').resize_down()<CR>";
          desc = "Resize down";
          silent = true;
        }
        {
          __unkeyed-1 = "<A-k>";
          __unkeyed-2 = ":lua require('smart-splits').resize_up()<CR>";
          desc = "Resize up";
          silent = true;
        }
        {
          __unkeyed-1 = "<A-l>";
          __unkeyed-2 = ":lua require('smart-splits').resize_right()<CR>";
          desc = "Resize right";
          silent = true;
        }
      ];
    };

    settings = {
      ignored_filetypes = [
        "nofile"
        "quickfix"
        "prompt"
        "trouble"
      ];
      default_amount = 10;
      at_edge = "wrap";
      move_cursor_same_row = true;
      cursor_follows_swapped_panes = true;
    };
  };

  keymaps = lib.mkIf (!config.plugins.smart-splits.lazyLoad.enable) [
    {
      mode = "n"; key = "<C-h>";
      action = ":lua require('smart-splits').move_cursor_left()<CR>";
      options.silent = true;
    }
    {
      mode = "n"; key = "<C-j>";
      action = ":lua require('smart-splits').move_cursor_down()<CR>";
      options.silent = true;
    }
    {
      mode = "n"; key = "<C-k>";
      action = ":lua require('smart-splits').move_cursor_up()<CR>";
      options.silent = true;
    }
    {
      mode = "n"; key = "<C-l>";
      action = ":lua require('smart-splits').move_cursor_right()<CR>";
      options.silent = true;
    }
    {
      mode = "n"; key = "<A-h>";
      action = ":lua require('smart-splits').resize_left()<CR>";
      options.silent = true;
    }
    {
      mode = "n"; key = "<A-j>";
      action = ":lua require('smart-splits').resize_down()<CR>";
      options.silent = true;
    }
    {
      mode = "n"; key = "<A-k>";
      action = ":lua require('smart-splits').resize_up()<CR>";
      options.silent = true;
    }
    {
      mode = "n"; key = "<A-l>";
      action = ":lua require('smart-splits').resize_right()<CR>";
      options.silent = true;
    }
  ];
}
