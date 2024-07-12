{ config, pkgs, ... }:

let
  vscode-with-extensions=pkgs.vscode-with-extensions.override {
    vscodeExtensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
    ];
  };

  alacrittyConfigFile = import ./alacritty.nix { inherit config pkgs; };
  neovimConfigFile = import ./neovim.nix { inherit config pkgs; };
in
{
  programs.home-manager.enable = true;
  fonts.fontconfig.enable=true;

  home ={
    username = "alex";
    homeDirectory="/home/alex";

    packages=with pkgs; [
      fira-code
      vscode-with-extensions
      alacritty

      vlc
      nil
      ### LSPs TODO: get lsps working
      bash-language-server
      rust-analyzer
      luajitPackages.lua-lsp
      pyright
      vscode-langservers-extracted

      ];
  };



  programs.alacritty=alacrittyConfigFile.alacrittyConfig;
  programs.neovim=neovimConfigFile.neovimConfig;
  programs.zsh.enable = true;

  home.stateVersion = "23.05"; # Update this to match your Home Manager version
}
