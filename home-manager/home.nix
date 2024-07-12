{ config, pkgs, ... }:

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
    ];
  };



  programs.alacritty=alacrittyConfigFile.alacrittyConfig;
  programs.neovim=neovimConfigFile.neovimConfig;
  
  programs.zsh.enable = true;
  home.stateVersion = "23.05"; # Update this to match your Home Manager version
}
