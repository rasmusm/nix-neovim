{ stdenv, vscode-utils, fetchgit
, ninja, lua5_3, clang, runtimeShell
, srcFromJson ? (builtins.fromJSON (builtins.readFile ../nix/sumneko-lua.json))
}:
  let
    srcSLL = fetchgit {inherit (srcFromJson) url rev sha256 fetchSubmodules;};
    version = srcSLL.rev;

  in
    stdenv.mkDerivation {
      name = "sumneko-lua-${version}";

      src = srcSLL;

      buildInputs = [ lua5_3 ninja clang ];


      buildPhase = ''
        ( cd 3rd/luamake && ninja -f ninja/linux.ninja )

        3rd/luamake/luamake rebuild

      '';

      # see  https://github.com/sumneko/vscode-lua/blob/master/publish.lua onder server for files to install
      installPhase = ''
        mkdir -p $out/share/sumneko-lua-language-server/
        cp -R bin $out/share/sumneko-lua-language-server/
        cp -R libs $out/share/sumneko-lua-language-server/
        cp -R log $out/share/sumneko-lua-language-server/
        cp -R locale $out/share/sumneko-lua-language-server/
        cp -R script $out/share/sumneko-lua-language-server/
        cp -R script-beta $out/share/sumneko-lua-language-server/
        cp -R test $out/share/sumneko-lua-language-server/

        cp main.lua main-beta.lua platform.lua test.lua debugger.lua $out/share/sumneko-lua-language-server/

        mkdir -p $out/bin
        echo -e '#!${runtimeShell}\n"'"$out/share/sumneko-lua-language-server/bin/Linux/lua-language-server"'" "-E" "'"$out/share/sumneko-lua-language-server/main.lua"'"' > "$out/bin/lua-lsp"
        chmod a+x "$out/bin/lua-lsp"
      '';


      meta = with stdenv.lib; {
        license = licenses.mit;
      };
    }
