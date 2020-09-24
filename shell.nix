{  }:
let
  pkgs = import <unstable> { overlays=[ (import ./neovim-overlay.nix) ]; };
in
  pkgs.mkShell {
    name = "neovim-shell";
    buildInputs = with pkgs; [
      neovim
    ];
    shellHook = ''
      export PATH=$PATH:$HOME/bin
    '';
  }
