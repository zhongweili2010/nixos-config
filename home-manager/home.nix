{config, pkgs, inputs, ... }:

let
  alacrittyConfigFile = import ./alacritty.nix { inherit config pkgs; };

  pkgs = import <nixpkgs> { 
    overlays = [
      inputs.mozilla.overlays.rust
    ];
  };

in {
  programs.home-manager.enable = true;
  fonts.fontconfig.enable=true;

  home ={
    username = "alex";
    homeDirectory="/home/alex";

    packages= with pkgs;[
      zed-editor
      latest.rustChannels.stable.rust
      fira-code
      alacritty
      vlc
      nil
      exercism
    ];

  };

  programs.alacritty=alacrittyConfigFile.alacrittyConfig;
  
  programs.zsh.enable = true;
  home.stateVersion = "23.05"; # Update this to match your Home Manager version

}
