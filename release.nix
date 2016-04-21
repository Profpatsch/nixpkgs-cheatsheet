with import <nixpkgs> {};

let

  traceValSeq = v: lib.traceVal (builtins.deepSeq v v);
  seqVal = v: builtins.seq v v;
  compose = f: g: x: f (g x);
  test-files = {
    static-nixpkgs = ./tests/static-nixpkgs.nix;
  };
  test-imports = lib.mapAttrs (f: import f) test-files;
  test-strings = lib.mapAttrs (_: v: builtins.readFile v) test-files;

in {
  rendered = callPackage ./. { inherit test-strings; };
}
