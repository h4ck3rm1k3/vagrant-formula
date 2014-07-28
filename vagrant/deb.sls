
{# vagrant.deb.sls

| Docs: http://www.packer.io/downloads.html
| Download: https://dl.bintray.com/mitchellh/vagrant

To upgrade to a new VAGRANT_VER:

  wget https://dl.bintray.com/mitchellh/vagrant/1.6.2_SHA256SUMS
  # wget {{ VAGRANT_SHA_URL }}

#}

{% set VAGRANT_VER  = "1.6.2" %}
{% set VAGRANT_ARCH = grains['osarch'] %}  # i686 or x86_64
{% set VAGRANT_URL = "https://dl.bintray.com/mitchellh/vagrant" %}

{% set VAGRANT_SHA = "%s_SHA256SUMS" % VAGRANT_VER %}
{% set VAGRANT_SHA_URL  = "%s/%s?direct" % (VAGRANT_URL, VAGRANT_SHA) %}

{% set VAGRANT_DEB = "vagrant_%s_%s.deb" % (VAGRANT_VER, VAGRANT_ARCH) %}
{% set VAGRANT_DEB_URL  = "%s/%s" % (VAGRANT_URL, VAGRANT_DEB) %}
{% set VAGRANT_DEB_PATH = "/opt/%s" % VAGRANT_DEB %}

{% set VAGRANT_SHA_PATH = "/opt/%s-%s" % (VAGRANT_DEB, VAGRANT_SHA) %}

vagrant_checksums:
  file.managed:
    - name: {{ VAGRANT_SHA_PATH }}
    - source: salt://vagrant/files/{{ VAGRANT_SHA }}

#vagrant_package:
#  file.managed:
#    - name: {{ VAGRANT_DEB_PATH }}
#    - source: {{ VAGRANT_DEB_URL }}

vagrant:
  pkg.installed:
    - source: {{ VAGRANT_DEB_URL }}
    - source_hash: salt://vagrant/files/{{ VAGRANT_SHA }}
    - require:
      - file: vagrant_checksums
      #- pkg: virtualbox
