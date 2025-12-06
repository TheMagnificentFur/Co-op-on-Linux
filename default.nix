{ stdenv }:

stdenv.mkDerivation {
  pname = "coop-linux";
  version = "unstable";
  src = ./.;

  installPhase = ''
    mkdir -p $out/bin
    install -m755 coop.sh $out/bin/coop
    install -m755 adaptive-sync.sh $out/bin/adaptive-sync

    if [ -d helper-scripts ]; then
      mkdir -p $out/lib/coop/helper-scripts
      cp -r helper-scripts/* $out/lib/coop/helper-scripts/
    fi
  '';
}
