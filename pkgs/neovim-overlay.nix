let
  sources = import ../nix/sources.nix;
in
  self: super: {
    neovim-unwrapped = super.neovim-unwrapped.overrideAttrs ( old: rec {
      version = "0.5.0pre.${sources.neovim.rev}";
      src = sources.neovim;
    });
  }
