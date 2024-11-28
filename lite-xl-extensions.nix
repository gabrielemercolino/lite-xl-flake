{ pkgs, stdenv }:

let
  mkExtension =
    {
      name,
      src,
      targetDir ? "lite-xl/plugins/${name}",
      postInstall ? "",
    }:
    stdenv.mkDerivation rec {
      inherit name src postInstall;

      passthru.targetDir = targetDir;

      installPhase = ''
        mkdir -p $out/share/${name}
        cp -r $src/* $out/share/${name}

        runHook postInstall
      '';
    };

  mkSingleScriptExtension =
    {
      name,
      src,
      targetDir ? "lite-xl/plugins/${name}",
      postInstall ? "",
    }:
    stdenv.mkDerivation rec {
      inherit name src postInstall;
      dontUnpack = true;

      passthru.targetDir = targetDir;

      installPhase = ''
        mkdir -p $out/share/${name}
        cp $src $out/share/${name}/init.lua

        runHook postInstall
      '';
    };
in
{
  lsp = mkExtension {
    name = "lite-xl-lsp";
    src = pkgs.fetchFromGitHub {
      owner = "lite-xl";
      repo = "lite-xl-lsp";
      rev = "master";
      sha256 = "sha256-IOjQvWKrt/jUFPCU7T8l8mBSWjYn2CqfVQGVZr9NOTg=";
    };
    targetDir = "lite-xl/plugins/lsp";
  };

  widgets = mkExtension {
    name = "lite-xl-widgets";
    src = pkgs.fetchFromGitHub {
      owner = "lite-xl";
      repo = "lite-xl-widgets";
      rev = "master";
      sha256 = "sha256-NTQTEt2QiexQbx1CKYF+hGZxtqAFdNrwdl+TznGlUfU=";
    };
    targetDir = "lite-xl/libraries/widget";
  };

  autoinsert = mkSingleScriptExtension {
    name = "autoinsert";
    src = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/refs/heads/master/plugins/autoinsert.lua";
      sha256 = "sha256-qbWsR0L3Fb3pVVe9BQ40NffUpiY7IXXxJ6J1nF//WBk=";
    };
  };

  colorpreview = mkSingleScriptExtension {
    name = "colorpreview";
    src = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/refs/heads/master/plugins/colorpreview.lua";
      sha256 = "sha256-d7cLFPllpwLKWIek1zO88KNMb/aBjuZE2jWoOXziZe8=";
    };
  };

  code-plus = mkExtension {
    name = "code-plus";
    src = pkgs.fetchFromGitHub {
      owner = "chqs-git";
      repo = "code-plus";
      rev = "main";
      sha256 = "sha256-uE5kATb8hDZOjiTGO3F3xs3ccRtjkqSz8Dm6pST0iWQ=";
    };
  };

  console = mkExtension {
    name = "console";
    src = pkgs.fetchFromGitHub {
      owner = "lite-xl";
      repo = "console";
      rev = "master";
      sha256 = "sha256-ihU5du2+oEoltcDey88yKWAZxELXMaOZg7xSddkFEls=";
    };
  };

  gitstatus = mkSingleScriptExtension {
    name = "gitstatus";
    src = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/refs/heads/master/plugins/gitstatus.lua";
      sha256 = "sha256-i4ZSjFXcqMGsABJac4movtnDY6BZ0m7xa1cnAa3VSoE=";
    };
  };

  gitblame = mkExtension rec {
    name = "gitblame";
    src = pkgs.fetchFromGitHub {
      owner = "juliardi";
      repo = "lite-xl-gitblame";
      rev = "main";
      sha256 = "sha256-1/2FAsCH/qJP7LV5bnLkcTpRzAYhF/QEvzjuZJDOdsc=";
    };
    postInstall = ''
      substituteInPlace $out/share/${name}/init.lua \
      --replace-fail "/usr/bin/git" "${pkgs.git}/bin/git"
    '';
  };

}
