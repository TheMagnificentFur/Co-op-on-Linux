#ouch

{ stdenv }:

stdenv.mkDerivation rec {
  pname = "coop-linux";
  version = "unstable";
  src = ./.;

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin

    # install the main script
    if [ -f "$src/Co-Op-On-Linux.sh" ]; then
      install -m755 "$src/Co-Op-On-Linux.sh" $out/bin/coop-linux
    fi
  '';
}
