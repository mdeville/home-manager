{ pkgs, ... }:

{
  home.packages = with pkgs; [
    _1password-cli
    ast-grep
    dua
    duckdb
    hyperfine
    jq
    ouch
    rsync
    yq-go
  ];

  programs = {
    bat.enable = true;
    btop.enable = true;
    fd.enable = true;
    nix-index.enable = true;
    nix-index-database.comma.enable = true;
    nh.enable = true;
    opencode.enable = true;
    parallel.enable = true;
    ripgrep.enable = true;
    tealdeer.enable = true;
    yazi.enable = true;
    zellij.enable = true;
  };
}
