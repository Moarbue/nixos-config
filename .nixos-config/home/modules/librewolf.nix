{ config, pkgs, ... }:

{
  programs.librewolf = {
    enable = true;

    globalExtensions = with pkgs.nur.repos.rycee.firefox-addons; [
      ublock-origin
      clearurls
      privacy-badger
      bitwarden
      auth-helper
      tablissng
    ];

    profiles.default = {
      id = 0;
      isDefault = true;

      settings = {
        "privacy.resistFingerprinting" = true;
        "privacy.fingerprintingProtection" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "privacy.trackingprotection.emailtracking.enabled" = true;
        "privacy.donottrackheader.enabled" = true;

        "privacy.clearOnShutdown.history" = true;
        "privacy.clearOnShutdown.cookies" = true;
        "privacy.clearOnShutdown.downloads" = true;
        "privacy.clearOnShutdown.formdata" = true;
        "privacy.clearOnShutdown.sessions" = true;
        "privacy.clearOnShutdown.offlineApps" = true;
        "privacy.clearOnShutdown.siteSettings" = false; # Keep per-site exceptions

        "network.cookie.lifetimePolicy" = 2;
        "webgl.disabled" = true;
        "media.peerconnection.enabled" = false;
        "network.http.referer.XOriginPolicy" = 2;
        "network.http.referer.XOriginTrimmingPolicy" = 2;

        "cookiebanners.service.mode" = 2;
        "cookiebanners.service.mode.privateBrowsing" = 2;
        "browser.tabs.groups.enabled" = false;
        "extensions.autoDisableScopes" = 0;

        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.startup.homepage" = "about:home";
        "browser.startup.page" = 3;
        "browser.ctrlTab.sortByRecentlyUsed" = true;
      };

      search = {
        default = "ddg-no-ai";
        force = true;
        engines = {
          "ddg-no-ai" = {
            name = "DuckDuckGo No-AI";
            urls = [{ template = "https://noai.duckduckgo.com/?q={searchTerms}&noai"; }];
          };
          "ddg" = {
            name = "DuckDuckGo";
            urls = [{ template = "https://duckduckgo.com/?q={searchTerms}"; }];
          };
          "nix-packages" = {
            name = "Nix Packages";
            urls = [{ template = "https://search.nixos.org/packages?query={searchTerms}"; }];
          };
          "nix-options" = {
            name = "NixOS Options";
            urls = [{ template = "https://search.nixos.org/options?query={searchTerms}"; }];
          };
        };
      };
    };

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      Homepage = { StartPage = "previous-session"; };
    };
  };
}
