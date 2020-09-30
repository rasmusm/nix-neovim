{  }:
let
  pkgs = import <unstable> { overlays=[ (import ./neovim-overlay.nix) ]; };
  sources = import ./nix/sources.nix;
  rnixlsp = import sources.rnix-lsp {};
in
  pkgs.mkShell {
    name = "neovim-shell";
    buildInputs = with pkgs; [
      niv
      rnixlsp
      lazygit
      neovim
    ];
    shellHook = ''
      alias nvim="nvim -u $PWD/init.vim"
    '';
  }
