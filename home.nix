{ pkgs, ... }:

{
  home.username = "matthew_deville";
  home.homeDirectory = "/home/matthew_deville";

  home.stateVersion = "26.11";

  home.packages = with pkgs; [
    ast-grep
    duckdb
    llvm
    ncdu
    rust-bin.stable.latest.default
  ];

  programs = {
    atuin = {
      enable = true;
      enableZshIntegration = true;
    };
    bat.enable = true;
    btop.enable = true;
    eza = {
      enable = true;
      enableZshIntegration = true;
    };
    home-manager.enable = true;
    parallel.enable = true;
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    starship.enable = true;
    ripgrep.enable = true;
    uv.enable = true;
    zsh = {
      enable = true;
      antidote = {
        enable = true;
        plugins = [
          "https://github.com/nix-community/nix-zsh-completions"
          "https://github.com/zsh-users/zsh-completions"
          "https://github.com/zsh-users/zsh-autosuggestions"
          "https://github.com/zsh-users/zsh-syntax-highlighting"
        ];
      };
    };
  };
}
