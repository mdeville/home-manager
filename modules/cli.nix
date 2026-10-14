{
  pkgs,
  lib,
  llm-agents,
  ...
}:

let
  mimoModel = "mimo-v2.6-pro";

  # Same Claude Code binary, pointed at Xiaomi MiMo's Token Plan endpoint
  # (https://mimo.mi.com/docs/en-US/tokenplan/integration/claudecode).
  # The key is read at launch, from $MIMO_API_KEY or else a 0600 file outside
  # the repo, so it never lands in the world-readable Nix store nor in the
  # environment of every other process.
  claude-mimo = pkgs.writeShellApplication {
    name = "claude-mimo";
    text = ''
      key_file="''${XDG_CONFIG_HOME:-$HOME/.config}/claude-mimo/api-key"
      ANTHROPIC_AUTH_TOKEN="''${MIMO_API_KEY:-$(<"$key_file")}"
      export ANTHROPIC_AUTH_TOKEN
      export ANTHROPIC_BASE_URL=https://token-plan-ams.xiaomimimo.com/anthropic
      export ANTHROPIC_MODEL="${mimoModel}"
      export ANTHROPIC_DEFAULT_SONNET_MODEL="${mimoModel}"
      export ANTHROPIC_DEFAULT_OPUS_MODEL="${mimoModel}"
      export ANTHROPIC_DEFAULT_HAIKU_MODEL="${mimoModel}"
      export CLAUDE_CODE_MAX_CONTEXT_TOKENS=1000000
      # Keep an Anthropic key from the shell from being sent to MiMo.
      unset ANTHROPIC_API_KEY
      exec ${lib.getExe llm-agents.claude-code} "$@"
    '';
  };
in
{
  home.packages = with pkgs; [
    _1password-cli
    ast-grep
    dua
    duckdb
    llm-agents.claude-code
    claude-mimo
    hyperfine
    jq
    ouch
    rsync
    yq-go
  ];

  programs = {
    bat.enable = true;
    btop.enable = true;
    fastfetch.enable = true;
    fd.enable = true;
    nix-index.enable = true;
    nix-index-database.comma.enable = true;
    nh.enable = true;
    parallel.enable = true;
    ripgrep.enable = true;
    tealdeer.enable = true;
    yazi.enable = true;
    zellij.enable = true;
  };
}
