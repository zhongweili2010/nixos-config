{ config, pkgs, ... }:

let
  vscode-with-extensions=pkgs.vscode-with-extensions.override {
    vscodeExtensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
    ];
  };

  alacrittyConfigFile = import ./alacritty.nix { inherit config pkgs; };
  neovimConfigFile = import ./neovim.nix { inherit config pkgs; };
  rustPackages= with mozillaPkgs.latest.rustChannels.stable;[
    rust
    cargo
    rust-analyzer
  ];
  commonPkgs= with pkgs; [
    fira-code
    alacritty
    vlc
    nil
  ];
in
{
  programs.home-manager.enable = true;
  fonts.fontconfig.enable=true;

  home ={
    username = "alex";
    homeDirectory="/home/alex";

    packages= with pkgs;[
      mozillaPkgs.latest.rustChannels.stable
      mozillaPkgs.cargo
      mozillaPkgs.rust-analyzer

      fira-code
      alacritty
      vlc
      nil
    ];
  };



  programs.alacritty=alacrittyConfigFile.alacrittyConfig;
  programs.neovim=neovimConfigFile.neovimConfig;
  
  programs.zsh.enable = true;
  home.stateVersion = "23.05"; # Update this to match your Home Manager version
}
