{ config, pkgs, ... }: {
  home.stateVersion = "26.05"; # matches system.stateVersion; don't change this later

  programs.zsh.enable = true; # home-manager writes ~/.zshrc, including the mise and PATH setup
  programs.git = {
    enable = true;
    settings.user = {
      name = "quinn";
      email = "qns@fastmail.com";
    };
  };
  programs.mise.enable = true; # language runtimes per project (.mise.toml)
  programs.nix-index.enable = true; # nix-locate: find which package has a missing .so
  programs.nix-index-database.comma.enable = true; # `, cowsay hi` runs a program without installing it
  programs.bat.enable = true; # syntax-highlighting cat (the command is `bat`; Debian calls it `batcat`)
  programs.starship.enable = true; # prompt; hooks itself into zsh. Customize via programs.starship.settings

  # Symlink straight to the repo (not a store copy) so edits apply live; niri reloads on save
  xdg.configFile."niri/config.kdl".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/src/nix-pinky/niri/config.kdl";

  # Built into the store and checked by ghostty at build time; applies on rebuild (then ctrl+shift+, to reload)
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "Dank Mono"; # from fonts.packages in configuration.nix
      font-size = 13;
    };
  };

  # SSH keys live in 1Password; its agent serves them (enable it in the app:
  # Settings -> Developer -> "Use the SSH agent"). gcr's agent is off in configuration.nix.
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks."*".identityAgent = "~/.1password/agent.sock";
  };
  home.sessionVariables.SSH_AUTH_SOCK = "$HOME/.1password/agent.sock"; # for ssh-add and other agent clients

  home.packages = with pkgs; [
    spotify
    wiremix # TUI mixer for PipeWire: volumes, streams, default output
    claude-code # updates come with `nix flake update`, not Claude's own updater
  ];

  home.sessionPath = [ "$HOME/.local/bin" ];
}
