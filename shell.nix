{  }:
let
  pkgs = import <unstable> { overlays=[ (import ./neovim-overlay.nix) ]; };
  sources = import ./nix/sources.nix;
  rnixlsp = import sources.rnix-lsp {};

  # for updateing the shell.nix's nix/sources.json with what neovim src to use
  metaNixShellStuff = [ pkgs.niv ];

  lspNix = [ rnixlsp ];
  # bear for generating compile_commands.json for ccls, see https://github.com/MaskRay/ccls/wiki/Project-Setup#build-ear
  lspC = with pkgs; [ bear ccls ];
  rootDir = toString ./.;

in
  pkgs.mkShell {
    name = "neovim-shell";
    buildInputs =
      metaNixShellStuff ++
      lspNix ++
      lspC ++
      [
        pkgs.lazygit
        pkgs.neovim
      ];
    shellHook = ''
      alias nvim="nvim -u ${rootDir}/init.vim"
    '';
  }
