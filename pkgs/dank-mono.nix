# Dank Mono is paid, so the zip never goes in this (public) repo. Nix only knows its hash;
# on a new machine, add your purchased copy to the store once (the filename must match):
#   cp "Dank Mono 15 Oct 2020.zip" DankMono-2020-10-15.zip
#   nix-store --add-fixed sha256 DankMono-2020-10-15.zip
{ lib, stdenvNoCC, requireFile, unzip }:

stdenvNoCC.mkDerivation {
  pname = "dank-mono";
  version = "2020-10-15";

  src = requireFile {
    name = "DankMono-2020-10-15.zip";
    hash = "sha256-zppKaEfi56WPYDS+r/uOkIFDqKdYtTmPm30KxvG3A8Q=";
    message = ''
      Dank Mono is a licensed font. Add your purchased zip to the Nix store:
        cp "Dank Mono 15 Oct 2020.zip" DankMono-2020-10-15.zip
        nix-store --add-fixed sha256 DankMono-2020-10-15.zip
    '';
  };

  nativeBuildInputs = [ unzip ];
  sourceRoot = "DankMono"; # the zip also contains a __MACOSX junk folder

  installPhase = ''
    runHook preInstall
    install -Dm644 OpenType-PS/*.otf -t $out/share/fonts/opentype
    runHook postInstall
  '';

  meta.license = lib.licenses.unfree;
}
