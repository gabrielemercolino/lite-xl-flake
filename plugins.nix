{
  pkgs,
  stdenv,
}: let
  mkPlugin = {
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

  mkSingleScriptPlugin = {
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
in {
  lsp = mkPlugin {
    name = "lite-xl-lsp";
    src = pkgs.fetchFromGitHub {
      owner = "lite-xl";
      repo = "lite-xl-lsp";
      rev = "master";
      sha256 = "sha256-42F8O7N7l4vQA8D+HgZNokknbWn/U7dv33GDXJ0yrPs=";
    };
    targetDir = "lite-xl/plugins/lsp";
  };

  widgets = mkPlugin {
    name = "lite-xl-widgets";
    src = pkgs.fetchFromGitHub {
      owner = "lite-xl";
      repo = "lite-xl-widgets";
      rev = "master";
      sha256 = "sha256-6oOxJPRzDwpFh9wp20WocT3gB0wQpA3LI4IarF0hMfw=";
    };
    targetDir = "lite-xl/libraries/widget";
  };

  autoinsert = mkSingleScriptPlugin {
    name = "autoinsert";
    src = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/refs/heads/master/plugins/autoinsert.lua";
      sha256 = "sha256-qbWsR0L3Fb3pVVe9BQ40NffUpiY7IXXxJ6J1nF//WBk=";
    };
  };

  colorpreview = mkSingleScriptPlugin {
    name = "colorpreview";
    src = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/refs/heads/master/plugins/colorpreview.lua";
      sha256 = "sha256-d7cLFPllpwLKWIek1zO88KNMb/aBjuZE2jWoOXziZe8=";
    };
  };

  code-plus = mkPlugin {
    name = "code-plus";
    src = pkgs.fetchFromGitHub {
      owner = "chqs-git";
      repo = "code-plus";
      rev = "main";
      sha256 = "sha256-uE5kATb8hDZOjiTGO3F3xs3ccRtjkqSz8Dm6pST0iWQ=";
    };
  };

  console = mkPlugin {
    name = "console";
    src = pkgs.fetchFromGitHub {
      owner = "lite-xl";
      repo = "console";
      rev = "master";
      sha256 = "sha256-ihU5du2+oEoltcDey88yKWAZxELXMaOZg7xSddkFEls=";
    };
  };

  gitstatus = mkSingleScriptPlugin {
    name = "gitstatus";
    src = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/lite-xl/lite-xl-plugins/refs/heads/master/plugins/gitstatus.lua";
      sha256 = "sha256-i4ZSjFXcqMGsABJac4movtnDY6BZ0m7xa1cnAa3VSoE=";
    };
  };

  gitblame = mkPlugin rec {
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

  gitdiff_highlight = mkPlugin {
    name = "gitdiff_highlight";
    src = pkgs.fetchFromGitHub {
      owner = "vincens2005";
      repo = "lite-xl-gitdiff-highlight";
      rev = "master";
      sha256 = "sha256-qeBy4+7l+YM0buAWYQZOvhco6f3kwKuQxuh1dUBXX74=";
    };
  };

  lintplus = mkPlugin {
    name = "lintplus";
    src = pkgs.fetchFromGitHub {
      owner = "liquidev";
      repo = "lintplus";
      rev = "master";
      sha256 = "sha256-CRfv6eFY4dZ9J937NHK+HE+e7fLkCH+cE6MQgn2OxNg=";
    };
  };
}
