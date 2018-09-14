# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "fluent-bit/map.jinja" import bit with context %}

{{ bit.pkg }}-pkg:
  pkg.installed:
    - name: {{ bit.pkg }}
