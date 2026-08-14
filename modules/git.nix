{
  programs = {
    delta = {
      enable = true;
      enableGitIntegration = true;
    };
    gh = {
      enable = true;
      settings.git_protocol = "ssh";
    };
    git = {
      enable = true;
      settings = {
        user = {
          name = "Matthew Deville";
          email = "matthew@stockly.ai";
        };
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
        pull.rebase = true;
        rebase.autostash = true;
        alias = {
          st = "status";
          co = "checkout";
          br = "branch";
          lg = "log --oneline --graph --decorate";
        };
      };
    };
    lazygit.enable = true;
  };
}
