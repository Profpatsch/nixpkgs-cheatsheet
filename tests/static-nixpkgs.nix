(import (fetchFromGitHub {
  owner = "nixOS";
  repo = "nixpkgs";
  rev = "16.03";
  sha256 = "0m2b5ignccc5i5cyydhgcgbyl8bqip4dz32gw0c6761pd4kgw56v";
}) { /* nixpkgs arguments (e.g. config) here */ }).hello;
