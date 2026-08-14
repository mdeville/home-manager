{
  xdg.enable = true;

  programs = {
    atuin.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    eza.enable = true;
    fzf = {
      enable = true;
      historyWidget.command = "";
    };
    starship.enable = true;
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
