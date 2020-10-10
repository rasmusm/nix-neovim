{  }:
let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs { overlays=[ (import ./pkgs/neovim-overlay.nix) ]; };
  rnixlsp = import sources.rnix-lsp {};
  sum-lua-lsp = pkgs.callPackage ./pkgs/sumneko-lua-language-server.nix {};
  tree_nvim = import ./pkgs/tree_nvim.nix {};

  # for updateing the shell.nix's nix/sources.json with what neovim src to use
  metaNixShellStuff = [ pkgs.niv ];

  lspNix = [ rnixlsp ];

  lspLua = [ sum-lua-lsp ];

  # bear for generating compile_commands.json for ccls,
  #  see https://github.com/MaskRay/ccls/wiki/Project-Setup#build-ear
  lspC = [
    pkgs.bear
    pkgs.ccls
  ];
  plugDep = [
        pkgs.lazygit
      ];
  rootDir = toString ./.;

in
  pkgs.mkShell {
    name = "neovim-shell";
    buildInputs =
      metaNixShellStuff ++
      lspNix ++
      lspLua ++
      lspC ++
      plugDep ++
      [
        pkgs.neovim
        pkgs.neovim-qt
        pkgs.neovim-remote
      ];
    shellHook = ''
    '';
  }
