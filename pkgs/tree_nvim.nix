{
  pkgs ? import <unstable> { overlays=[ (import ../neovim-overlay.nix) ]; },
  sources ? import ../nix/sources.nix
}:


pkgs.stdenv.mkDerivation rec {
  pname = "tree_nvim";
  version = "1.17git";

  src = sources.tree_nvim;

  nativeBuildInputs = [
  ];

  buildInputs = [
    pkgs.pkgconfig
    pkgs.doxygen
    (pkgs.boost.override { enableShared = false; enabledStatic = true; })
    pkgs.pkgconfig
    pkgs.doxygen
    pkgs.cmake
    pkgs.msgpack
    pkgs.zlib
    pkgs.gtest
    pkgs.python3
  ];

  configurePhase = ''
    cmake -DUSE_SYSTEM_MSGPACK=on \
        -DCMAKE_INSTALL_PREFIX=$out/share/vim-plugins/tree.nvim \
        -DBoost_USE_STATIC_LIBS=ON \
        -DCMAKE_BUILD_TYPE=Release \
        -S $src \
        -B ./build
  '';

  buildPhase = ''
    cd ./build
    make
  '';

  installPhase = ''
    mkdir -p $out/share/vim-plugins/tree.nvim
    make install
  '';

  outputsToInstall = [ "share" ];
}
