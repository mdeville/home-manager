{ pkgs, ... }:

{
  home.username = "matthew_deville";
  home.homeDirectory = "/home/matthew_deville";

  home.stateVersion = "26.11";

  home.packages = with pkgs; [
    ast-grep
    dua
    duckdb
    jaq
    hyperfine
    xh
    llvm
    sd
  ];

  home.shell.enableZshIntegration = true;

  programs = {
    atuin.enable = true;
    bat.enable = true;
    btop.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    delta = {
      enable = true;
      enableGitIntegration = true;
    };
    eza.enable = true;
    fd.enable = true;
    fzf = {
      enable = true;
      historyWidget.command = "";
    };
    gh.enable = true;
    git = {
      enable = true;
      settings.user = {
        name = "Matthew Deville";
        email = "matthew@stockly.ai";
      };
    };
    home-manager.enable = true;
    parallel.enable = true;
    starship.enable = true;
    ripgrep.enable = true;
    zellij.enable = true;
    zoxide.enable = true;
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
