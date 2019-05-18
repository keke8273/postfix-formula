{% set ldap_uri = salt['pillar.get']('postfix:ldap:server_host', False) %}

{% if ldap_uri %}
postgrey:
  pkg.installed:
    - name: postfix-ldap
{% endif %}
