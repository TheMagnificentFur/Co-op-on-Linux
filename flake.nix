{
  description = "Co-op on Linux packaged for Nix/NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages.${system}.default = pkgs.stdenv.mkDerivation {
      pname = "coop-linux";
      version = "unstable";

      src = self;

      installPhase = ''
        mkdir -p $out/bin

        # install the main scripts
        for f in Co-Op-On-Linux.sh install-steamos.sh create-new-profile.sh; do
          if [ -f "$f" ]; then
            install -m755 "$f" $out/bin/"$f"
          fi
        done

        # install helper-scripts 
        if [ -d helper-scripts ]; then
          mkdir -p $out/lib/coop/helper-scripts
          cp -r helper-scripts/* $out/lib/coop/helper-scripts/
        fi
      '';

      meta = {
        description = "Nix package for Co-op on Linux";
        homepage = "https://github.com/TheMagnificentFur/Co-op-on-Linux";
        license = pkgs.lib.licenses.gpl2;
        platforms = pkgs.lib.platforms.linux;
      };
    };

    # Optional: a NixOS module (recommended!)
    nixosModules.default = import ./nixos-module.nix;
  };
}
