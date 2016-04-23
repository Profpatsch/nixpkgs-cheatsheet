{ stdenv, lib, substituteAll, pandoc }:

with lib;

let

  test-files = {
    static_nixpkgs = ./tests/static_nixpkgs.nix;
  };
  test-strings = lib.mapAttrs (_: v: builtins.readFile v) (test-files);

  orgfile = substituteAll (
    { src = ./cheatsheet.org; } // test-strings
  );

in
stdenv.mkDerivation rec {
  name = "nixpkgs-cheatsheet-${version}";
  version = "0.1";

  phases = [ "buildPhase" "installPhase" ];

  buildInputs = [ pandoc ];
  buildPhase = ''
    pandoc --standalone -t html5 ${orgfile} > cheatsheet.html
  '';

  installPhase = ''
    mkdir $out
    cp cheatsheet.html $out/index.html
  '';

  passthru = { inherit test-files; };

}
