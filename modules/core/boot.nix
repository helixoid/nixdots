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
          graphicalTerminal.font.scale = "2x2";
          wallpaperStyle = "centered";
          wallpapers = [
            "/home/${username}/nixdots/Wallpapers/Japan.jpg"
            "/home/${username}/nixdots/Wallpapers/Joyboy.png"
            "/home/${username}/nixdots/Wallpapers/KCD-2.jpg"
            "/home/${username}/nixdots/Wallpapers/Mandalorian.jpg"
            "/home/${username}/nixdots/Wallpapers/Specs_Woman.jpg"
            "/home/${username}/nixdots/Wallpapers/Witcher-3.jpg"
          ];
        };
        extraEntries = ''
          /Windows 11
              protocol: efi_chainload
              image_path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
        '';
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
