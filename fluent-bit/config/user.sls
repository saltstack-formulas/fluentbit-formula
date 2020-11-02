{% from "fluent-bit/map.jinja" import bit with context %}

fluent_bit-create-user:
  user.present:
    - name: {{ bit.user }}
    - createhome: True
    - shell: /bin/bash

fluent_bit-create-group:
  group.present:
    - name: {{ bit.group }}
    - addusers:
        - {{ bit.user }}
    - system: True
