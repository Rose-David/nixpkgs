{
  lib,
  stdenv,
  rustPlatform,
  fetchFromGitHub,
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

  nativeBuildInputs = [

  ];
  buildInputs = [

  ];

  meta = {
    description = "An installer, updater, and mod-manager for Titanfall 2's Northstar Mod.";
    homepage = "https://github.com/R2NorthstarTools/FlightCore";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ teknolog1k ];
  };
})
