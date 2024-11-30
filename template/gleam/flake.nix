{
  description = "Gleam Project";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            name = "gleam-project";
            shellHook = ''
              git config pull.rebase true
              ${pkgs.neo-cowsay}/bin/cowsay -f sage "Gleam Project"
            '';
            buildInputs = with pkgs; [
              editorconfig-checker
              gleam
              erlang
              rebar3
            ];
          };
        }
      );
    };
}
