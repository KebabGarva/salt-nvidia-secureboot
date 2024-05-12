salt://step2/script/add-rpm.sh:
  cmd.script

update_pkg:
  pkg.uptodate:
    - refresh : True
