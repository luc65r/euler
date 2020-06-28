{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  buildInputs = [
    (haskellPackages.ghcWithPackages (p: [
      p.markdown-unlit
    ]))
  ];
}
