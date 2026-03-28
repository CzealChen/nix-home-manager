{ config, pkgs, lib, ... }:
{

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.package = lib.mkDefault pkgs.nix;
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    tailscale
    #netavark

    anki-sync-server

    podman
    podman-tui
  ];

  programs.home-manager.enable = true;
  # backupFileExtension = "backup";
}