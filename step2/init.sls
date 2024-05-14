# Adds the script that is located in the same folder as this file.

salt://step2/script/add-rpm.sh:
  cmd.script

# Updates the whole system.

update_pkg:
  pkg.uptodate:
    - refresh: True
