{
  lib,
  fetchFromGitHub,
  stdenv,
  autoPatchelfHook,
  curl,
  cairo,
  xorg,
  gdk-pixbuf,
  pango,
  glib,
  gtk3,
  copyDesktopItems,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "SGDBoop";
  version = "1.2.8";

  src = fetchFromGitHub {
    owner = "SteamGridDB";
    repo = "SGDBoop";
    rev = "v${finalAttrs.version}";
    hash = "sha256-Hbo7i7D2+I2sVrX4nubdB2JRQ+3B7M54s7GejRcJ9LY=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    copyDesktopItems
  ];

  buildInputs = [
    curl
    cairo
    xorg.libX11
    gdk-pixbuf
    pango
    glib
    gtk3
  ];

  rpath = lib.strings.makeLibraryPath [
    curl
    cairo
    xorg.libX11
    gdk-pixbuf
    pango
    glib
    gtk3
  ];

  # Instead of moving libiup.so to /usr/lib like normal, read it straight from the directory it's already in.
  buildPhase = ''
    runHook preBuild
    gcc sgdboop.c curl-helper.c string-helpers.c crc.c -Llib/linux -Wl,-rpath-link=${finalAttrs.rpath} -liup -lcurl -o linux-release/SGDBoop
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    install -Dm755 linux-release/SGDBoop -t $out/bin
    install -Dm644 lib/linux/libiup.so -t $out/lib
    runHook postInstall
  '';

  desktopItems = [
    "${finalAttrs.src}/linux-release/com.steamgriddb.SGDBoop.desktop"
  ];

  meta = {
    description = "SGDBoop is a tool that automatically applies assets from SteamGridDB directly to your Steam library.";
    longDescription = ''
      Needs to be set as the default scheme-handler for sgdb:// to function.
      Run the following command after installation to set this.
      `xdg-mime default com.steamgriddb.SGDBoop.desktop x-scheme-handler/sgdb`
    '';
    homepage = "https://www.steamgriddb.com/boop";
    license = lib.licenses.zlib;
    platforms = [ "x86_64-linux" ];
    maintainers = with lib.maintainers; [ teknolog1k ];
  };
})
