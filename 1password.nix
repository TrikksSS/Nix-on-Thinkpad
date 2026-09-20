{ pkgs, lib, config, ... }:

{
  #This is for 1Password since its a special little princess
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = [ "parker" ];
  };
}
