{ pkgs, lib, config, ... }:

{
  #Enable the Niri Window Manager
  programs.niri.enable = true;
  systemd.user.services.niri.enableDefaultPath = false;
  security.polkit.enable = true; # polkit
services.gnome.gnome-keyring.enable = true; # secret service
security.pam.services.swaylock = {};

programs.waybar.enable = true; # top bar
}
