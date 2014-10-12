{%- from 'jboss-fuse/settings.sls' import jb with context %}

jboss-fuse-dist:
  archive:
    - extracted
    - name: {{ jb.prefix }}
    - source: {{ jb.source_url }}
    - source_hash: {{ jb.source_hash }}
    - archive_format: zip
    - if_missing: {{ jb.install_path }}
  file.directory:
    - name: {{ jb.install_path }}
    - user: {{ jb.user }}
    - group: {{ jb.user }}
    - require:
      - user: {{ jb.user }}
      - group: {{ jb.user }}
    - recurse:
      - user
      - group  

service-account:
  group.present:
    - name: {{ jb.user }}
  user.present:
    - name: {{ jb.user }}
    - home: {{ jb.install_path }}
    - system: true
    - createhome: false
    - gid_from_name: true
    - require:
      - group: {{ jb.user }}
  
config-files:
  file.managed:
    - name: {{ jb.install_path }}/bin/setenv
    - source: salt://jboss-fuse/files/setenv
    - user: {{ jb.user }}
    - group: {{ jb.user }}
    - mode: 755
    - require:
        - archive: jboss-fuse-dist
        - user: {{ jb.user }}
