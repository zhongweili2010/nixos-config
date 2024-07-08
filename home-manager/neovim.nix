{ config, pkgs, ... }:

{

  neovimConfig = 
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in 
  {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;


    
    plugins= with pkgs.vimPlugins; [

      nvim-lspconfig
      nvim-treesitter
      nvim-treesitter.withAllGrammars
      nvim-treesitter-textobjects
      rose-pine

      telescope-fzf-native-nvim
      comment-nvim
      gruvbox-nvim
      neodev-nvim

      vim-nix
      # {
      #   plugin = nvim-lspconfig;
      #   config = toLuaFile ./nvim/plugin/lsp.lua;
      # }

      {
        plugin = comment-nvim;
        config = toLua "require(\"Comment\").setup()";
      }

      {
        plugin = gruvbox-nvim;
        config = "colorscheme gruvbox";
      }

      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-rust
          p.tree-sitter-json
        ]));
        config = toLuaFile ./nvim/treesitter.lua;
      }

      ];

    extraLuaConfig =''
        ${builtins.readFile ./nvim/options.lua}
      '';
  };
}

