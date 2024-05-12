mokutil --sb-state:
  cmd.run

remove-nvidia:
  pkg.removed:
    - pkgs:
      - akmod-nvidia
      - xorg-x11-drv-nvidia
      - xorg-x11-drv-nvidia-libs
      - xorg-x11-drv-nvidia-libs.i686
      - xorg-x11-drv-nvidia-cuda
      
