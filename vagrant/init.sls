
{#
{% from "vagrant/map.jinja" import vagrant with context %}

vagrant:
  pkg:
    - installed
    - name: {{ vagrant.pkg }}
  service:
    - running
    - name: {{ vagrant.service }}
    - enable: True
#}
