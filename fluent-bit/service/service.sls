{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot+"/map.jinja" import bit with context -%}


fluent_bit-log_directory:
  file.directory:
    - name: '/var/log/{{ bit.pkg }}/'
    - makedirs: True
    - user: {{ bit.user }}
    - group: {{ bit.group }}
    - recurse:
      - user
      - group

fluent_bit-init-file:
  file.managed:
    {%- if salt['test.provider']('service').startswith('systemd') %}
    - source: salt://fluent-bit/files/templates/service.systemd.jinja
    - name: /etc/systemd/system/td-agent-bit.service
    {%- elif salt['test.provider']('service') == 'upstart' %}
    - source: salt://fluent-bit/files/templates/service.upstart.jinja
    - name: /etc/init/fluentd.conf
    {%- endif %}
    - mode: '0644'
    - user: {{ bit.user }}
    - group: {{ bit.group }}
    - template: jinja
    - context:
        user: {{ bit.user }}
        group: {{ bit.group }}



{%- if bit.service %}
fluent_bit-service:
  service.running:
    - name: {{ bit.process_name}}
    - enable: True
    - user: {{ bit.user }}
    - group: {{ bit.group }}
    - watch:
      - file: fluent_bit-init-file
      - file: fluent_bit-config*
{%- endif %}