{
  description = "xv6";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs, ... }:
    let
      supportedSystems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];
      perSystem =
        system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          devShells.default = pkgs.pkgsCross.x86_64-embedded.mkShell {
            name = "bochs";
            packages = with pkgs; [
              nasm
              gdb
              bochs
            ];
            shellHook = ''
              export BXSHARE=${pkgs.bochs}/share/bochs
              echo "BXSHARE set to $BXSHARE"
            '';
          };
        };
    in
    {
      devShells = nixpkgs.lib.genAttrs supportedSystems (system: (perSystem system).devShells);
    };
}
