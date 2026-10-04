{ pkgs, ... }: {
  home.stateVersion = "26.05"; # matches system.stateVersion; don't change this later

  programs.zsh.enable = true; # home-manager writes ~/.zshrc, including the mise and PATH setup
  programs.git.enable = true;
  programs.mise.enable = true; # language runtimes per project (.mise.toml)
  programs.nix-index.enable = true; # nix-locate: find which package has a missing .so

  home.sessionPath = [ "$HOME/.local/bin" ]; # Claude Code's native installer puts `claude` here
}
