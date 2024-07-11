{ config, lib, pkgs, modulesPath, ... }:
{
    services.xserver.videoDrivers="modesetting";
}