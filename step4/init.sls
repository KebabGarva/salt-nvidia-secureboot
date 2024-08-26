# Installs Nvidia packages. This will take a while

nvidia-install:
  pkg.installed:
    - pkgs:
      - gcc
      - kernel-headers
      - kernel-devel
      - akmod-nvidia
      - xorg-x11-drv-nvidia
      - xorg-x11-drv-nvidia-libs
      - xorg-x11-drv-nvidia-libs.i686
      - xorg-x11-server-Xwayland
