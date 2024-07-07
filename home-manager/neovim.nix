{ config, pkgs, ... }:

{

  neovimConfig = {
    enable = true;
    plugins= with pkgs; [

      vimPlugins.nvim-treesitter
      vimPlugins.nvim-treesitter.withAllGrammars
      vimPlugins.nvim-treesitter-textobjects
      vimPlugins.nvim-lspconfig
      
      ];
  };
}

