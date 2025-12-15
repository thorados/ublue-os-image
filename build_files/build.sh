#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y tmux chezmoi neovim btop zsh steam mangohud gamescope

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

# remove kde plasma
dnf5 remove -y plasma-* kde-* sddm gnome-* gdm
#dnf5 group remove -y workstation-product-environment kde-desktop-environment gnome-desktop

# install cosmic-desktop
dnf5 group install -y cosmic-desktop-environment

# install hyprland
dnf5 -y copr enable solopasha/hyprland
dnf5 -y install         \
    hyprland            \
    hyprpaper           \
    hyprpicker          \
    hypridle            \
    hyprlock            \
    hyprsunset          \
    hyprpolkitagent     \
    hyprsysteminfo      \
    qt6ct-kde           \
    hyprland-qt-support \
    hyprland-qtutils
dnf5 -y copr disable solopasha/hyprland

# more desktop-environment utils
dnf5 -y install     \
    waybar          \
    kitty           \
    pipewire        \
    rofi            \
    brightnessctl

#### Example for enabling a System Unit File

systemctl enable podman.socket











