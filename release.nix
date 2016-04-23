with import <nixpkgs> {};

let
  # import nixpkgs in the tests
  nixpkgsContext = fl: runCommand "nixpkgs-context" {} ''
    echo 'with import <nixpkgs> {};' >> $out
    cat ${fl} >> $out
  '';
  drv = callPackage ./. {};
  inherit (drv.passthru) test-files;
  test-drvs = lib.mapAttrs (_: v: import (nixpkgsContext v)) test-files;

in {
  rendered = drv;
  # execute all tests
  tests = recurseIntoAttrs test-drvs;
}
