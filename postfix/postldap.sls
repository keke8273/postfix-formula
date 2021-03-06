{% from "postfix/map.jinja" import postfix with context %}
include:
  - postfix

{% set ldap_uri = salt['pillar.get']('postfix:ldap:server_host', False) %}

{% if ldap_uri %}
postldap:
  pkg.installed:
    - name: postfix-ldap

{{ postfix.config_path }}/ldap:
  file.directory:
    - user: root
    - group: {{ postfix.root_grp }}
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True

{{ postfix.config_path }}/ldap/virtual_alias_domains:
  file.managed:
    - source: salt://postfix/files/virtual_alias_domains.cf
    - user: root
    - group: {{ postfix.root_grp }}
    - mode: 644
    - require:
      - pkg: postfix
      - file: {{ postfix.config_path }}/ldap
    - watch_in:
      - service: postfix
    - template: jinja

{{ postfix.config_path }}/ldap/virtual_alias_maps:
  file.managed:
    - source: salt://postfix/files/virtual_alias_maps.cf
    - user: root
    - group: {{ postfix.root_grp }}
    - mode: 644
    - require:
      - pkg: postfix
      - file: {{ postfix.config_path }}/ldap
    - watch_in:
      - service: postfix
    - template: jinja

{{ postfix.config_path }}/ldap/virtual_mailbox_maps:
  file.managed:
    - source: salt://postfix/files/virtual_mailbox_maps.cf
    - user: root
    - group: {{ postfix.root_grp }}
    - mode: 644
    - require:
      - pkg: postfix
      - file: {{ postfix.config_path }}/ldap
    - watch_in:
      - service: postfix
    - template: jinja

{{ postfix.config_path }}/ldap/virtual_uid_maps:
  file.managed:
    - source: salt://postfix/files/virtual_uid_maps.cf
    - user: root
    - group: {{ postfix.root_grp }}
    - mode: 644
    - require:
      - pkg: postfix
      - file: {{ postfix.config_path }}/ldap
    - watch_in:
      - service: postfix
    - template: jinja

{{ postfix.config_path }}/ldap/smtpd_sender_login_maps:
  file.managed:
    - source: salt://postfix/files/smtpd_sender_login_maps.cf
    - user: root
    - group: {{ postfix.root_grp }}
    - mode: 644
    - require:
      - pkg: postfix
      - file: {{ postfix.config_path }}/ldap
    - watch_in:
      - service: postfix
    - template: jinja


{% endif %}
