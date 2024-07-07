{ config, pkgs, ... }:

let
  vscode-with-extensions=pkgs.vscode-with-extensions.override {
    vscodeExtensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
    ];
  };

  alacrittyConfig = import ./alacritty.nix { inherit config pkgs; };
in
{
  programs.home-manager.enable = true;

  home ={
    username = "alex";
    homeDirectory="/home/alex";

    packages=with pkgs; [
      vscode-with-extensions
      alacritty
    ];

    # Import and apply the Alacritty configuration
    inherit (alacrittyConfig.programs) alacritty;

    

  };


  programs.zsh.enable = true;

  home.stateVersion = "23.05"; # Update this to match your Home Manager version
}
