# Install the signing modules

signing-modules:
  pkg.installed:
    - pkgs:
      - kmodtool
      - akmods
      - mokutil
      - openssl

# Generates a new key

sudo kmodgenca -a:
  cmd.run

# The output of printf is piped as an input to the mokutil key import that asks user's password twice

# CHANGE THE PASSWORD TO MAKE THE KEY MORE SECURE

printf '1234wohoo\n1234wohoo\n' | sudo mokutil --import /etc/pki/akmods/certs/public_key.der:
  cmd.run
