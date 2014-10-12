{%- from 'jboss-fuse/settings.sls' import jb with context %}

jboss-fuse-service:
  file.managed:
    - name: /etc/init.d/{{ jb.service }}
    - source: salt://jboss-fuse/files/ubuntu.service
    - user: root
    - group: root
    - mode: 755
  service.running:
    - name: {{ jb.service }}
    - enable: true
    - require:
      - sls: jboss-fuse
      - file: /etc/init.d/{{ jb.service }}
