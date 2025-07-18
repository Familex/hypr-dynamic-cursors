{
  description = "A plugin to make your hyprland cursor more realistic, also adds shake to find";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    systems = ["x86_64-linux"];
    eachSystem = nixpkgs.lib.genAttrs systems;
    pkgsFor = nixpkgs.legacyPackages;
  in {
    packages = eachSystem (system: {
      default = self.packages.${system}.hypr-dynamic-cursors;
      hypr-dynamic-cursors = let
        inherit (pkgsFor.${system}) hyprland;
        inherit (pkgsFor.${system}) stdenvNoCC gcc14;

        name = "hypr-dynamic-cursors";
      in
        stdenvNoCC.mkDerivation {
          inherit name;
          pname = name;
          src = ./.;

          inherit (hyprland) buildInputs;
          nativeBuildInputs = hyprland.nativeBuildInputs ++ [hyprland gcc14];
          enableParallelBuilding = true;

          dontUseCmakeConfigure = true;
          dontUseMesonConfigure = true;
          dontUseNinjaBuild = true;
          dontUseNinjaInstall = true;

          installPhase = ''
            runHook preInstall

            mkdir -p "$out/lib"
            cp -r out/dynamic-cursors.so "$out/lib/lib${name}.so"

            runHook postInstall
          '';
        };
    });

    devShells = eachSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      default = pkgs.mkShell {
        name = "hypr-dynamic-cursors-shell";
        nativeBuildInputs = with pkgs; [gnumake gcc14 clang-tools bear];
        buildInputs = [pkgs.hyprland];
        inputsFrom = [
          pkgs.hyprland
          self.packages.${system}.hypr-dynamic-cursors
        ];
        shellHook = ''
          make clean
          bear -- make -j$(nproc) ./out/dynamic-cursors.so
          sed -i -e 's/c++23/c++2b/g' ./compile_commands.json
        '';
      };
    });
  };
}
