{% from "openntpd/map.jinja" import openntpd with context %}

include:
  - openntpd

openntpd-config:
  file.managed:
    - name: {{ openntpd.conffile }}
    - source: salt://openntpd/files/ntpd.conf
    - template: jinja
    - check_cmd: {{ openntpd.binary }} -n -f
    - watch_in:
      - service: openntpd
    - require_in:
      - service: openntpd

{%- if grains['os_family'] in ['Debian'] %}
/etc/default/openntpd:
  file.managed:
    - source: salt://openntpd/files/defaults.openntpd.jinja
    - template: jinja
    - watch_in:
      - service: openntpd
    - require_in:
      - service: openntpd
{%  endif %}
