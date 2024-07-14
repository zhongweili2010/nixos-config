{ config, pkgs, lib, ... }:

let
  alacrittyConfigFile = import ./alacritty.nix { inherit config pkgs; };
  neovimConfigFile = import ./neovim.nix { inherit config pkgs; };


  overlays=
    let
      moz-url = builtins.fetchTarball {url="https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz";};
      rust-overlay=(import "${moz-url}/rust-overlay.nix");
    in
    [
      rust-overlay
    ];
    pkgs= import <nixpkgs>{
      inherit overlays;
    };
in
{

  programs.home-manager.enable = true;
  fonts.fontconfig.enable=true;

  home ={
    username = "alex";
    homeDirectory="/home/alex";

    packages= with pkgs;[
      latest.rustChannels.stable.rust

      fira-code
      alacritty
      vlc
      nil
      exercism
    ];
  };


  home.activation = {
    updateNvChad = lib.hm.dag.entryAfter ["writeBoundary"] ''
      if [ -d ~/.config/nvim ]; then
        rm -rf ~/.config/nvim
      fi
      cp -r ${./nvchad-config} ~/.config/nvim
    '';
  };


  # Add the LSP configurations
  home.file = {
    ".config/nvim/lua/custom/chadrc.lua" = {
      text = ''
        local M = {}
        M.ui = {theme = 'gruvbox'}
        M.plugins = "custom.plugins"
        M.mappings = require "custom.mappings"
        return M
      '';
    };

    ".config/nvim/lua/custom/plugins.lua" = {
      text = ''
        local plugins = {
          -- Add your plugins here
          { "neovim/nvim-lspconfig" },
        }
        return plugins
      '';
    };

    ".config/nvim/lua/custom/mappings.lua" = {
      text = ''
        local M = {}
        -- Add your key mappings here
        return M
      '';
    };
  };





  programs.alacritty=alacrittyConfigFile.alacrittyConfig;
  programs.neovim=neovimConfigFile.neovimConfig;
  
  programs.zsh.enable = true;
  home.stateVersion = "23.05"; # Update this to match your Home Manager version
}
