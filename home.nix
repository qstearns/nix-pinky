{ config, pkgs, ... }: {
  home.stateVersion = "26.05"; # matches system.stateVersion; don't change this later

  programs.zsh.enable = true; # home-manager writes ~/.zshrc, including the mise and PATH setup
  programs.git.enable = true;
  programs.mise.enable = true; # language runtimes per project (.mise.toml)
  programs.nix-index.enable = true; # nix-locate: find which package has a missing .so
  programs.bat.enable = true; # syntax-highlighting cat (the command is `bat`; Debian calls it `batcat`)

  # Symlink straight to the repo (not a store copy) so edits apply live; niri reloads on save
  xdg.configFile."niri/config.kdl".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/src/nix-pinky/niri/config.kdl";

  home.packages = with pkgs; [
    spotify
    claude-code # updates come with `nix flake update`, not Claude's own updater
  ];

  home.sessionPath = [ "$HOME/.local/bin" ];
}
