# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "fluent-bit/map.jinja" import bit with context %}

fluent_bit-config:
  file.managed:
    - name: /etc/{{ bit.pkg }}/{{ bit.pkg }}.conf
    - source: salt://fluent-bit/files/td-agent-bit.conf.jinja
    - mode: 644
    - makedirs: True
    - user: {{ bit.user }}
    - group: {{ bit.group }}
    - template: jinja

{%- for config_name,values in salt.pillar.get('fluent_bit:configs', {}).items()  %}
fluent_bit-config-add-{{ config_name }}:
  file.managed:
    - name: /etc/{{ bit.pkg }}/conf.d/lable-{{ config_name }}.conf
    - source: salt://fluent-bit/files/templates/fluent-config-template.conf
    - user: {{ bit.user }}
    - group: {{ bit.group }}
    - template: jinja
    - makedirs: True  
    - context:
        settings: {{ values.settings }}
{% endfor %}


fluent_bit-config-parsers:
  file.managed:
    - name: /etc/{{ bit.pkg }}/parsers.conf
    - source: salt://fluent-bit/files/parsers.conf.jinja
    - mode: 644
    - makedirs: True
    - user: {{ bit.user }}
    - group: {{ bit.group }}
    - template: jinja

fluent_bit-config-parsers-default-file:
  file.managed:
    - name: /etc/{{ bit.pkg }}/parsers.d/default_parsers.conf
    - source: salt://fluent-bit/files/templates/default_parsers.conf
    - mode: 644
    - makedirs: True
    - user: {{ bit.user }}
    - group: {{ bit.group }}
    - template: jinja

{%- for parser_name,values in salt.pillar.get('fluent_bit:parsers', {}).items()  %}
fluent_bit-config-parser-add-{{ parser_name }}:
  file.managed:
    - name: /etc/{{ bit.pkg }}/parsers.d/lable-{{ parser_name }}.conf
    - source: salt://fluent-bit/files/templates/fluent-config-template.conf
    - user: {{ bit.user }}
    - group: {{ bit.group }}
    - template: jinja
    - makedirs: True  
    - context:
        settings: {{ values.settings }}
{% endfor %}