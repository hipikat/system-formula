****************************
System Formula (Salt States)
****************************

Salt state formulae affecting system-level (i.e. OS) configuration.

`system.all`_
  Include all the following states.

`system.states.default_user_umask`_
  Change the default UMASK for login users in ``/etc/login.defs`` if
  a UMASK is provided in ``pillar['settings']['default_user_umask']``.

`system.states.packages`_
  Install system packages listed in ``pillar['system_packages']`` and
  system-Python packages listed in ``pillar['system_python_packages']``.

`system.states.timezone`_
  Set the system timezone to UTC and the named timezone in
  ``pillar['settings']['system_timezone']``.

`system.patches.pep8-linelength99`_
  Change the ``MAX_LINE_LENGTH`` for Python source defined in ``pep8.py``.


.. _system.all: https://github.com/hipikat/system-formula/blob/master/system/all.sls
.. _system.states.default_user_umask: https://github.com/hipikat/system-formula/blob/master/system/states/default_user_umask.sls
.. _system.states.packages: https://github.com/hipikat/system-formula/blob/master/system/states/packages.sls
.. _system.states.timezone: https://github.com/hipikat/system-formula/blob/master/system/states/timezone.sls
.. _system.states.pep8-linelength99: https://github.com/hipikat/system-formula/blob/master/system/patches/pep8-linelength99.sls
