{
  lib,
  stdenv,
  rustPlatform,
  fetchFromGitHub,
  fetchNpmDeps,
  npmHooks,
  cargo-tauri,
  nodejs,

}:

stdenv.mkDerivation (finalAttrs: {
  pname = "FlightCore";
  version = "2.26.2";

  src = fetchFromGitHub {
    owner = "R2NorthstarTools";
    repo = "FlightCore";
    rev = "v${finalAttrs.version}";
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  npmDeps = fetchNpmDeps {
    name = "${finalAttrs.pname}- ${finalAttrs.version}-npm-deps";
    inherit (finalAttrs) src;
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  cargoDeps = rustPlatform.fetchCargoTarball {
    inherit (finalAttrs)
      pname
      version
      src
      cargoRoot
      ;
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  cargoRoot = "src-tauri";

  buildAndTestSubdir = finalAttrs.cargoRoot;

  nativeBuildInputs = [

  ];
  buildInputs = [

  ];

  meta = {
    description = "An installer, updater, and mod-manager for Titanfall 2's Northstar Mod.";
    homepage = "https://github.com/R2NorthstarTools/FlightCore";
    mainProgram = "flightcore";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ teknolog1k ];
  };
})
