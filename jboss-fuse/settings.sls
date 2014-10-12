{% set p  = salt['pillar.get']('jboss_fuse', {}) %}
{% set pc = p.get('config', {}) %}
{% set g  = salt['grains.get']('jboss_fuse', {}) %}
{% set gc = g.get('config', {}) %}

# these are global - hence pillar-only
{%- set user         = p.get('user', 'jboss') %}
{%- set service      = p.get('service', 'jboss-fuse') %}
{%- set home         = p.get('home', 'jboss-fuse') %}
{%- set prefix       = p.get('prefix', '/srv') %}
{%- set install_path = prefix + '/' + home %}
{%- set java_home    = salt['pillar.get']('java_home', '/usr/lib/java') %}

{%- set version           = g.get('version', p.get('version', '6.1.0.GA')) %}
{%- set build             = g.get('build', p.get('build', {})) %}
{%- set package           = g.get('package', p.get('package', 'full')) %}
{%- set version_name      = 'jboss-fuse-' + package + '-' + version %}
{%- set startup_profile   = g.get('package', p.get('package', 'full')) %}
{%- set default_url       = 'salt://' + version_name + '.zip' %}
{%- set source_url        = g.get('source_url', p.get('source_url', default_url)) %}
{%- set source_hash       = g.get('source_hash', p.get('source_hash', None)) %}
# bind_address is only supported as a grain, because it has to be host-specific
{%- set bind_address      = gc.get('bind_address', '0.0.0.0') %}

#
# JVM options - just follow grains/pillar settings for now
#
# set in - jboss_fuse:
#          - config:
#            - max_perm_size:
#            - max_heap_size:
#            - initial_heap_size:
#            - jvm_opts:
#
{%- set max_perm_size     = gc.get('max_perm_size', pc.get('max_perm_size', 128)) %}
{%- set max_heap_size     = gc.get('max_heap_size', pc.get('max_heap_size', 2048)) %}
{%- set initial_heap_size = gc.get('initial_heap_size', pc.get('initial_heap_size', 256)) %}
{%- set jvm_opts          = gc.get('jvm_opts', pc.get('jvm_opts', None)) %}  

{%- set jb = {} %}
{%- do jb.update( { 'version': version,
                    'build': build,
                    'package': package,
                    'version_name': version_name,
                    'startup_profile': startup_profile,
                    'user': user,
                    'home': home,
                    'service': service,
                    'prefix': prefix,
                    'install_path': install_path,
                    'source_url': source_url,
                    'source_hash': source_hash,
                    'java_home': java_home,
                    'bind_address': bind_address,
                    'initial_heap_size': initial_heap_size,
                    'max_heap_size': max_heap_size,
                    'max_perm_size': max_perm_size,
                    'jvm_opts': jvm_opts
                  }) %}
