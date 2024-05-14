# Check if secureboot is on

mokutil --sb-state:
  cmd.run

# Removes any Nvidia packages that could conflict

remove-nvidia:
  pkg.removed:
    - pkgs:
      - akmod-nvidia
      - xorg-x11-drv-nvidia
      - xorg-x11-drv-nvidia-libs
      - xorg-x11-drv-nvidia-libs.i686
      - xorg-x11-drv-nvidia-cuda
      
