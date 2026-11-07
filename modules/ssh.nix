{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        AddKeysToAgent = "yes";
        ControlMaster = "auto";
        ControlPath = "~/.ssh/cm-%r@%h:%p";
        ControlPersist = "10m";
      };
      "github.com" = {
        IdentityFile = "~/.ssh/id_ed25519";
        IdentitiesOnly = "yes";
      };
      "forgejo.mdeville.fr" = {
        HostName = "forgejo.mdeville.fr";
        Port = "22222";
        User = "git";
        IdentityFile = "~/.ssh/id_ed25519";
      };
    };
  };
}
