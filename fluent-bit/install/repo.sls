{% from "fluent-bit/map.jinja" import bit with context %}

fluent_bit-repo:
  pkgrepo.managed:
    - humanname: Fluentbit Official
    - name: deb https://packages.fluentbit.io/debian/{{ bit.repo.version }} {{ bit.repo.version }} main
    - file: /etc/apt/sources.list.d/fluentbit.list
    - key_url: https://packages.fluentbit.io/fluentbit.key
    - clean_file: True
    