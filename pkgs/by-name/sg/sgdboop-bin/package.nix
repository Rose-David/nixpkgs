{
  lib,
  stdenvNoCC,
  fetchzip,
  autoPatchelfHook,
  cairo,
  xorg,
  gdk-pixbuf,
  pango,
  glib,
  gtk3,
  curl,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "SGDBoop-bin";
  version = "1.2.8";

  src = fetchzip {
    url = "https://github.com/SteamGridDB/SGDBoop/releases/download/v${finalAttrs.version}/sgdboop-linux64.tar.gz";
    hash = "sha256-xDFvyw3gtRg2fu3QKfAOqvyN8pzqNSCGC5A6MmJRdas=";
    stripRoot = false;
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    cairo
    xorg.libX11
    gdk-pixbuf
    pango
    glib
    gtk3
    curl
  ];

  desktopItems = [ "${finalAttrs.src}/com.steamgriddb.SGDBoop.desktop" ];

  installPhase = ''
    install -Dm755 ${finalAttrs.src}/SGDBoop -t $out/bin
    install -Dm644 ${finalAttrs.src}/libiup.so -t $out/lib
  '';

  meta = {
    description = "A tool that automatically applies assets from SteamGridDB directly to your Steam library.";
    homepage = "https://www.steamgriddb.com/boop";
    license = lib.licenses.zlib;
    platforms = [ "x86_64-linux" ];
    maintainers = with lib.maintainers; [  ];
  };
})
