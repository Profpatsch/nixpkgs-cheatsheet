{ stdenv, lib, substituteAll, pandoc
, test-strings }:

with lib;

let
  orgfile = substituteAll (
    ## WHYYYY are you not reading in the file?!
    { src = ./cheatsheet.org; inherit (test-strings) static-nixpkgs; foo = "foo!"; } // { bar = "bar!"; }
  );
  traceValSeq = v: lib.traceVal (builtins.deepSeq v v);

in
stdenv.mkDerivation rec {
  name = "nixpkgs-cheatsheet-${version}";
  version = "0.1";

  phases = [ "buildPhase" "installPhase" ];

  buildPhase = ''
    cat ${orgfile}
    pandoc --standalone --type html5 ./cheatsheet.org > cheatsheet.html
  '';

  installPhase = ''
    mkdir $out
    # cp cheatsheet.html $out/index.html
  '';

}
