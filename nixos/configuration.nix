{ inputs, lib, config, pkgs, hostname, username, ... }: {
  imports = [
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

    nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      # substituters = [ "https://hyprland.cachix.org" ];
      # trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 3d";
    };
  };

  boot = {
    loader.systemd-boot.enable = true;
    plymouth.enable = true;
    };

   # Enable networking
  networking.networkmanager.enable = true;
  networking.hostName = hostname;
  networking.timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  users.users = {
    "${username}" = {
      isNormalUser = true;
      description = "helixoid";
      extraGroups = [
        "networkmanager"
        "input"
        "wheel"
        "video"
        "audio"
        "libvirtd"
      ];
      shell = pkgs.fish;
      ignoreShellProgramCheck = true;
      packages = with pkgs; [
      ];

  programs = {
    firefox.enable = true;
    starship = {
      enable = true;
      settings = {
        add_newline = false;
        buf = {
          symbol = " ";
        };
        c = {
          symbol = " ";
        };
        directory = {
          read_only = " 󰌾";
        };
        docker_context = {
          symbol = " ";
        };
        fossil_branch = {
          symbol = " ";
        };
        git_branch = {
          symbol = " ";
        };
        golang = {
          symbol = " ";
        };
        hg_branch = {
          symbol = " ";
        };
        hostname = {
          ssh_symbol = " ";
        };
        lua = {
          symbol = " ";
        };
        memory_usage = {
          symbol = "󰍛 ";
        };
        meson = {
          symbol = "󰔷 ";
        };
        nim = {
          symbol = "󰆥 ";
        };
        nix_shell = {
          symbol = " ";
        };
        nodejs = {
          symbol = " ";
        };
        ocaml = {
          symbol = " ";
        };
        package = {
          symbol = "󰏗 ";
        };
        python = {
          symbol = " ";
        };
        rust = {
          symbol = " ";
        };
        swift = {
          symbol = " ";
        };
        zig = {
          symbol = " ";
        };
      };
    };
    virt-manager.enable = true;
    # steam = {
    #   enable = true;
    #   gamescopeSession.enable = true;
    #   remotePlay.openFirewall = true;
    #   dedicatedServer.openFirewall = true;
    # };
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };

  users = {
    mutableUsers = true;
  };

  # Enable Hyprland
  programs.hyprland.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  # environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

 environment.systemPackages = with pkgs; [
    alacritty
    neovim
    wget
    killall
    eza
    git
    cmatrix
    lolcat
    bottom
    ncmpcpp
    libvirt
    polkit_gnome
    lm_sensors
    unzip
    unrar
    libnotify
    wl-clipboard
    ffmpeg
    socat
    cowsay
    ripgrep
    bat
    pkg-config
    brightnessctl
    virt-viewer
    swappy
    networkmanagerapplet
    yad
    inxi
    playerctl
    nh
    nixfmt-rfc-style
    discord
    libvirt
    swww
    grim
    slurp
    file-roller
    swaynotificationcenter
    imv
    mpv
    pwvucontrol
    greetd.tuigreet
    zathura
    hyprpicker
    hyprcursor
    hyprlock
    hypridle
    hyprpaper
  ];

  fonts = {
    packages = with pkgs; [
      noto-fonts-emoji
      noto-fonts-cjk
      font-awesome
      symbola
      material-icons
    ];
  };

# Services to start
  services = {
    xserver = {
      enable = false;
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    greetd = {
      enable = true;
      vt = 3;
      settings = {
        default_session = {
          # Wayland Desktop Manager is installed only for user ryan via home-manager!
          user = username;
          # .wayland-session is a script generated by home-manager, which links to the current wayland compositor(sway/hyprland or others).
          # with such a vendor-no-locking script, we can switch to another wayland compositor without modifying greetd's config here.
          # command = "$HOME/.wayland-session"; # start a wayland session directly without a login manager
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland"; # start Hyprland with a TUI login manager
        };
      };
    };
 # MPD
  services.mpd = {
  enable = true;
  musicDirectory = "/home/helix/Music";
  extraConfig = ''
  audio_output {
    type "pipewire"
    name "My PipeWire Output"
  }
  '';
    libinput.enable = true;
    fstrim.enable = true;
    gvfs.enable = true;
    openssh.enable = true;
    flatpak.enable = false;
    printing = {
      enable = true;
      drivers = [
        # pkgs.hplipWithPlugin
      ];
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
  };

  systemd.services.flatpak-repo = {
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # Bluetooth Support
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

# Enable sound with pipewire.
  hardware.pulseaudio.enable = false;

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver    # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver    # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
      mesa
      nvidia-vaapi-driver
      nv-codec-headers-12
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      intel-media-driver
      intel-vaapi-driver
      vaapiVdpau
      mesa
      libvdpau-va-gl
    ];
  };
  
    # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = true;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = true;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = true;

    # Enable the Nvidia settings menu,
  	# accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.production;

    # Nvidia Optimus PRIME. It is a technology developed by Nvidia to optimize
    # the power consumption and performance of laptops equipped with their GPUs.
    # It seamlessly switches between the integrated graphics,
    # usually from Intel, for lightweight tasks to save power,
    # and the discrete Nvidia GPU for performance-intensive tasks.

  #   prime = {
  # 		offload = {
  # 			enable = true;
  # 			enableOffloadCmd = true;
  # 		};
  #
  # 		# FIXME: Change the following values to the correct Bus ID values for your system!
  #     # More on "https://wiki.nixos.org/wiki/Nvidia#Configuring_Optimus_PRIME:_Bus_ID_Values_(Mandatory)"
  # 		nvidiaBusId = "PCI:0:0:0";
  # 		intelBusId = "PCI:0:0:0";
  # 	};
  # };

  # NixOS specialization named 'nvidia-sync'. Provides the ability
  # to switch the Nvidia Optimus Prime profile
  # to sync mode during the boot process, enhancing performance.
  specialisation = {
    nvidia-sync.configuration = {
      system.nixos.tags = [ "nvidia-sync" ];
      hardware.nvidia = {
        powerManagement.finegrained = lib.mkForce false;

        prime.offload.enable = lib.mkForce false;
        prime.offload.enableOffloadCmd = lib.mkForce false;

        prime.sync.enable = lib.mkForce true;
        # Dynamic Boost. It is a technology found in NVIDIA Max-Q design laptops with RTX GPUs.
        # It intelligently and automatically shifts power between
        # the CPU and GPU in real-time based on the workload of your game or application.
        dynamicBoost.enable = lib.mkForce true;
      };
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}
