{config, pkgs, inputs, ... }:

let
  alacrittyConfigFile = import ./alacritty.nix { inherit config pkgs; };

  pkgs = import <nixpkgs> { 
    overlays = [
      inputs.mozilla.overlays.rust
    ];
  };

  zed-fhs = pkgs.buildFHSUserEnv {
    name="zed";
    targetPkgs=pkgs:
    with pkgs;[
      zed-editor
    ];
    runScript="zed";
  };

in {
  programs.home-manager.enable = true;
  fonts.fontconfig.enable=true;

  home ={
    username = "alex";
    homeDirectory="/home/alex";

    packages= with pkgs;[
      zed-fhs
      latest.rustChannels.stable.rust
      fira-code
      alacritty
      vlc
      nil
      exercism
      direnv
    ];
  };

  programs.alacritty=alacrittyConfigFile.alacrittyConfig;

  home.stateVersion = "23.05"; # Update this to match your Home Manager version

}
