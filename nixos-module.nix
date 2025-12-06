{ config, pkgs, lib, ... }:

let
  coop = pkgs.callPackage ./. { };
in
{
  options.coop-linux.enable = lib.mkEnableOption "Enable Co-op on Linux tools";

  config = lib.mkIf config.coop-linux.enable {

    environment.systemPackages = [ coop ];

    # optional future ideas:
    # - systemd service to apply adaptive sync
    # - udev rules
    # - auto-update functionality
  };
}
