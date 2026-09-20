{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./1password.nix
      #./niri.nix
     # ./cosmic.nix
      #./gnome.nix
      ./kde.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
 
 networking.hostName = "StinkPadX13"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Set your time zone.
  time.timeZone = "America/New_York";

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


  
 # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  
    # Enable CUPS to print documents an avahi for IPP Everywhere.
  services.avahi = {
  enable = true;
  nssmdns4 = true;
  openFirewall = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # Use the WirePlumber session manager
    #wireplumber.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."parker" = {
    isNormalUser = true;
    description = "parker";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    	distrobox
	distroshelf
	mpv
	yt-dlp
	proton-vpn
	qbittorrent
	pkgs.ktailctl
	tealdeer	
	ncdu
	pkgs.prismlauncher
	htop
	bat
	ns-usbloader
    ];
  };

  hardware.steam-hardware.enable = true;
  # Hardened Firefox config
  programs.firefox = {
  enable = true;

  languagePacks = [ "en-US" "de" "fr" ];

  preferences = {
    "browser.startup.homepage"      = "https://google.com";
    "privacy.resistFingerprinting"  = true;
  };

  policies = {
    DisableTelemetry = true;
  };
};

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
   environment.systemPackages = with pkgs; [
    vim
    wget
    git
    php
    ffmpeg
    fastfetch
    dnsmasq
    pkgs.gnome-disk-utility
    gnome-tweaks
    btop
    alacritty 
    fuzzel
    swaylock
    mako
    swayidle
    keepassxc
    pkgs.xwayland-satellite
  ];

  # 3. Optimization: Prevent systemd from waiting for network online
  # (Optional but recommended for faster boot with VPNs)
  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;

  # This enables virtualization for distrobox
virtualisation.podman = {
  enable = true;
  dockerCompat = true;
 };

  #Enable flatpak (dont forget to add the flathub repo)
  services.flatpak.enable = true;

  # This enables Virt-Manager/QEMU
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
   programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # Open ports in the firewall.
   #networking.firewall.allowedTCPPorts = [ 80 443 ];
  #networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
   networking.firewall.enable = false;


  system.stateVersion = "26.05"; # Did you read the comment?

}
