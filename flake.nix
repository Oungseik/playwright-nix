{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };
  outputs =
    {
      self,
      nixpkgs,
      utils,
    }:
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            nodejs_24
          ];

          LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib";
          PLAYWRIGHT_BROWSERS_PATH = "${pkgs.playwright.browsers}";
          PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS = true;
          PLAYWRIGHT_NODEJS_PATH = "${pkgs.nodejs_24}/bin/node";
          PLAYWRIGHT_HOST_PLATFORM_OVERRIDE = "";
          PLAYWRIGHT_LAUNCH_OPTIONS_EXECUTABLE_PATH = "${pkgs.playwright.browsers}/chromium-1181/chrome-linux/chrome";
        };
      }
    );
}
