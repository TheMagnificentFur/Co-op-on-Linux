{ stdenv }:

stdenv.mkDerivation rec {
  pname = "coop-linux";
  version = "unstable";
  src = ./.;

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin

    # install the main script with correct name
    if [ -f "$src/Co-Op-On-Linux.sh" ]; then
      install -m755 "$src/Co-Op-On-Linux.sh" $out/bin/coop-linux
    fi

    # install other scripts if present
    for f in adaptive-sync.sh install.sh; do
      if [ -f "$src/$f" ]; then
        install -m755 "$src/$f" $out/bin/"${f%.*}"
      fi
    done

    # optional: copy helper-scripts
    if [ -d "$src/helper-scripts" ]; then
      mkdir -p $out/lib/coop/helper-scripts
      cp -r "$src/helper-scripts"/* $out/lib/coop/helper-scripts/
    fi
  '';
}
