{
  description = "Flake to build GHDL from upstream source with gnat-bootstrap14";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    ghdl = {
      url = "github:Sheepheerd/nix-ghdl";
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      ghdl,
    }:
    let
      systems = [
        "aarch64-linux"
        "aarch64-darwin"
      ]; # adjust if needed
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f (import nixpkgs { inherit system; }));
    in
    {
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [
            ghdl.packages.aarch64-linux.default
            pkgs.gtkwave
          ];
          shellHook = '''';
        };
      });
    };
}
