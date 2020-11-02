# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "fluent-bit/map.jinja" import bit with context %}

fluent_bit-pkg:
  pkg.installed:
    - name: {{ bit.pkg }}
