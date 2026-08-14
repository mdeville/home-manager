{ pkgs, ... }:

{
  home = {
    username = "matthew_deville";
    homeDirectory = "/home/matthew_deville";
    stateVersion = "26.11";
    packages = with pkgs; [
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
    shell.enableZshIntegration = true;
  };

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
    lazygit.enable = true;
    nix-index.enable = true;
    nix-index-database.comma.enable = true;
    nh.enable = true;
    opencode.enable = true;
    parallel.enable = true;
    starship.enable = true;
    ripgrep.enable = true;
    tealdeer.enable = true;
    yazi.enable = true;
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

  xdg.enable = true;
}
