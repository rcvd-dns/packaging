# Local build entry point: nix-build nix
{
  pkgs ? import <nixpkgs> { },
}:
pkgs.callPackage ./package.nix { }
