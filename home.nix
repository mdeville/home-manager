{
  imports = [
    ./modules/shell.nix
    ./modules/git.nix
    ./modules/ssh.nix
    ./modules/cli.nix
  ];

  home = {
    username = "matthew_deville";
    homeDirectory = "/home/matthew_deville";
    stateVersion = "26.11";
    shell.enableZshIntegration = true;
  };

  programs.home-manager.enable = true;
}
