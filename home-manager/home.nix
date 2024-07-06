{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    neovim
  ];

  programs.zsh.enable = true;
  programs.home-manager.enable = true;

  home.stateVersion = "23.05"; # Update this to match your Home Manager version
}
