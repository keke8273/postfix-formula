{% from "postfix/map.jinja" import postfix with context %}
include:
  - postfix

sasl:
  pkg.installed:
    - name: {{ postfix.sasl_pkg }}
    - watch_in:
      - service: postfix
