{
  username,
  stateVersion,
  ...
}: {
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    extra-substituters = [
      "https://helix.cachix.org"
      "https://noctalia.cachix.org"
    ];
    extra-trusted-public-keys = [
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };

  nixpkgs.config.allowUnfree = true;

  programs.nh = {
    enable = true;
    flake = "/home/${username}/nixdots";
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep-since 3d --optimise";
    };
  };

  zramSwap = {
    enable = true;
    priority = 100;
    algorithm = "zstd";
    memoryPercent = 100;
  };

  services = {
    fstrim.enable = true;
    fwupd.enable = true;
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;
    btrfs.autoScrub = {
      enable = true;
      interval = "weekly";
    };
  };

  # This settings is only required when dual booting NixOS and Windows 11
  time.hardwareClockInLocalTime = true;

  system.stateVersion = stateVersion; # Did you read the comment?
}
