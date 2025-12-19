#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# RPM Fusion
dnf5 install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# NVIDIA
dnf5 install -y                       \
    akmod-nvidia                      \
    rpmfusion-nonfree-release-tainted \
    xorg-x11-drv-nvidia-cuda          \
    xorg-x11-drv-nvidia-cuda-libs     \
    vulkan                            \
    libva-nvidia-driver               \
    libva-utils                       \
    vdpauinfo                         \
    ffmpeg-free                       \
    libavcodec-freeworld
    
dnf5 swap -y akmod-nvidia akmod-nvidia-open

# NVIDIA Secureboot
dnf5 install -y     \
    kmodtool        \
    akmods          \
    mokutil         \
    openssl

# remove image packages
dnf5 remove -y      \
    plasma-*        \
    kde-*           \
    sddm*           \
    gnome-*         \
    gdm             \
    firefox         \
    nheko           \
    nwg-*

# remove message of the day
rm -f /etc/profile.d/user-motd.sh

# this installs a package from fedora repos
dnf5 install -y             \
    tmux                    \
    chsh                    \
    chezmoi                 \
    neovim                  \
    btop                    \
    zsh                     \
    zsh-autosuggestions     \
    zsh-syntax-highlighting \
    steam                   \
    mangohud                \
    gamescope

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

# install cosmic-desktop
# dnf5 group install -y cosmic-desktop-environment --exclude=libreoffice*,thunderbird,firefox,pipewire*

# install nwg-look
dnf5 copr enable -y njkevlani/nwg-look
dnf5 install -y nwg-look
dnf5 copr disable -y njkevlani/nwg-look

# install noisetorch
dnf5 copr enable -y lochnair/NoiseTorch
dnf5 install -y noisetorch
dnf5 copr disable -y lochnair/NoiseTorch

# install hyprland
dnf5 copr enable -y solopasha/hyprland
dnf5 install -y         \
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
dnf5 copr disable -y solopasha/hyprland

# install windows manager utils
dnf5 install -y             \
    waybar                  \
    kitty                   \
    pipewire                \
    pavucontrol             \
    nm-connection-editor    \
    rofi                    \
    brightnessctl           \
    blueman                 \
    network-manager-applet  \
    wl-gammactl             \
    breeze-cursor-theme     \
    gtk-murrine-engine      \
    gnome-themes-extra

#### Example for enabling a System Unit File

systemctl enable podman.socket

