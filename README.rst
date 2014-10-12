==========
jboss-fuse
==========

Formula to set up and configure a single-node JBoss Fuse server.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Formula Dependencies
====================

This formula requires a compatible JRE to be installed.

Standard system package management or the following salt formulas may be used for provisioning of a suitable Java runtime.

* sun-java
* java

Available states
================

.. contents::
    :local:

``jboss-fuse``
--------------

Downloads the JBoss Fuse zip distribution from jboss_fuse:source_url (either pillar or grain), and installs the package.


``jboss-fuse.service``
----------------------

Installs JBoss Fuse as an automatic startup service.

Downloads the JBoss Fuse zip distribution from jboss_fuse:source_url (either pillar or grain), and installs the package.

Tested on Ubuntu LTS 12.04.
