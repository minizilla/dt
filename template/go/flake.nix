{
  description = "Go Project";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
    in
    {
      devShells = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = pkgs.mkShell {
            name = "go-project";
            shellHook = ''
              git config pull.rebase true
              ${pkgs.neo-cowsay}/bin/cowsay -f sage "Go Project"
            '';
            buildInputs = with pkgs; [
              editorconfig-checker
              go
            ];
          };
        }
      );
    };
}
