{
  pkgs,
  stdenv,
}:
stdenv.mkDerivation rec {
  name = "gitblame";

  passthru.targetDir = "lite-xl/plugins/${name}";

  src = pkgs.fetchFromGitHub {
    owner = "juliardi";
    repo = "lite-xl-gitblame";
    rev = "main";
    sha256 = "sha256-1/2FAsCH/qJP7LV5bnLkcTpRzAYhF/QEvzjuZJDOdsc=";
  };

  installPhase = ''
    mkdir -p $out/share/${name}
    cp -r $src/* $out/share/${name}

    runHook postInstall
  '';

  postInstall = ''
    substituteInPlace $out/share/${name}/init.lua \
    --replace-fail "/usr/bin/git" "${pkgs.git}/bin/git"
  '';
}
