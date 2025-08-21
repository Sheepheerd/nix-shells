{
  pkgs ? import <nixpkgs> { },
}:

let
  ghdlWithGnat14 = pkgs.ghdl-llvm.overrideAttrs (oldAttrs: {
    nativeBuildInputs = [ pkgs.gnat-bootstrap14 ];

    buildInputs = oldAttrs.buildInputs;
  });
in

pkgs.mkShell {
  buildInputs = [
    pkgs.gtkwave
    ghdlWithGnat14
  ];

  shellHook = ''
    echo "GHDL (LLVM) with GNAT Bootstrap 14 is ready!"
    ghdl --version
  '';
}
