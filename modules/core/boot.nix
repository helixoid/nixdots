{
  pkgs,
  username,
  ...
}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      limine = {
        enable = true;
        secureBoot = {
          enable = true;
          autoGenerateKeys = true;
          autoEnrollKeys.enable = true;
        };
        style = {
          wallpapers = [
            "/home/${username}/nixdots/Wallpapers/Japan.jpg"
          ];
        };
      };
    };
    plymouth = {
      enable = true;
      theme = "bgrt";
    };
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];
    blacklistedKernelModules = ["nouveau"];
    # Remove this when this becomes the default.
    kernelModules = ["ntsync"];
  };
}
