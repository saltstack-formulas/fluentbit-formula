# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "fluent-bit/map.jinja" import bit with context %}

{{ bit.pkg }}-config:
  file.managed:
    - name: /etc/{{ bit.pkg }}/{{ bit.pkg }}.conf
    - source: salt://fluent-bit/files/bit.conf.j2
    - mode: 644
    - makedirs: True
    - user: root
    - group: root
    - template: jinja
    - context:
      parsers: False

{{ bit.pkg }}-parsers:
  file.managed:
    - name: /etc/{{ bit.pkg }}/parsers.conf
    - source: salt://fluent-bit/files/bit.conf.j2
    - mode: 644
    - makedirs: True
    - user: root
    - group: root
    - template: jinja
    - context:
      parsers: True
