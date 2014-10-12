{%- from 'jboss-fuse/settings.sls' import jb with context %}

jboss-fuse:
  group.present:
    - name: {{ jb.user }}
  user.present:
    - name: {{ jb.user }}
    - home: {{ jb.install_path }}
    - system: True
    - createhome: False
    - gid_from_name: True
    - require:
      - group: {{ jb.user }}
  archive:
    - extracted
    - name: {{ jb.prefix }}
    - source: {{ jb.source_url }}
    - source_hash: {{ jb.source_hash }}
    - archive_format: zip
    - if_missing: {{ jb.install_path }}

# Fix file permissions
{{ jb.install_path }}:
  file.directory:
    - user: {{ jb.user }}
    - group: {{ jb.user }}
    - require:
      - jboss-fuse 
    - recurse:
      - user
      - group