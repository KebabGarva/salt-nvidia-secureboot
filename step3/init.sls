signing-modules:
  pkg.installed:
    - pkgs:
      - kmodtool
      - akmods
      - mokutil
      - openssl

sudo kmodgenca -a -f:
  cmd.run

printf '1234wohoo\n1234wohoo\n' | sudo mokutil --import /etc/pki/akmods/certs/public_key.der:
  cmd.run
