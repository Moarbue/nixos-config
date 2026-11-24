{
  description = "C/C++ development shell";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      # Uses GCC (default stdenv). To switch a project to Clang, replace the line below with:
      # devShells.${system}.default = (pkgs.mkShell.override { stdenv = pkgs.clangStdenv; }) {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          gnumake
          bear
          gdb
          clang-tools
        ];
      };
    };
}
