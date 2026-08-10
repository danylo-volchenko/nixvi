{
  extraConfigLua = ''
    vim.cmd.packadd("nvim.undotree")
  '';
  keymaps = [
    {
      mode = "n";
      key = "<leader>ut";
      action = "<cmd>Undotree<CR>";
      options = {
        silent = true;
        desc = "Undotree";
      };
    }
  ];
}
