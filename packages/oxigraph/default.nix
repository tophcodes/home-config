{
  lib,
  stdenv,
  fetchurl,
}:

stdenv.mkDerivation rec {
  pname = "oxigraph";
  version = "0.5.3-post.1";

  src = fetchurl {
    url = "https://github.com/oxigraph/oxigraph/releases/download/v${version}/oxigraph_v${version}_x86_64_linux_gnu";
    hash = "sha256-6yLJ8wuhGu2GoCWMji+Lt1WoDZxRmTLXVMwKb3+ByRQ=";
  };

  dontUnpack = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp $src $out/bin/oxigraph
    chmod +x $out/bin/oxigraph
    runHook postInstall
  '';

  meta = with lib; {
    description = "SPARQL graph database";
    homepage = "https://github.com/oxigraph/oxigraph";
    license = with licenses; [asl20 mit];
    maintainers = [];
    mainProgram = "oxigraph";
    platforms = ["x86_64-linux"];
  };
}
