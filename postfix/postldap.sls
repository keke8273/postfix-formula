{% from "postfix/map.jinja" import postfix with context %}

{% set ldap_uri = salt['pillar.get']('postfix:ldap:server_host', False) %}

{% if ldap_uri %}
postldap:
  pkg.installed:
    - name: postfix-ldap
{% endif %}
