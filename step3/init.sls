signing-modules:
  pkg.installed:
    - pkgs:
      - kmodtool
      - akmods
      - mokutil
      - openssl

printf '1234wohoo\n1234wohoo\n' | sudo mokutil --import /etc/pki/akmods/certs/public_key.der:
  cmd.run
