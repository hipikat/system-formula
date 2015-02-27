**************
System Formula
**************

A collection of system-level formulas for Salt.

`system.all`_
  Include all the following states.

`system.states.common`_
  Install git. (For now.)

`system.states.default_user_umask`_
  Change the default UMASK for login users in ``/etc/login.defs`` if
  a UMASK is provided in ``pillar['settings']['default_user_umask']``.

`system.states.packages`_
  Install system packages listed in ``pillar['system_packages']`` and
  system-Python packages listed in ``pillar['system_python_packages']``.

`system.states.pep8-linelength99`_
  Change the ``MAX_LINE_LENGTH`` for Python source defined in ``pep8.py``.

`system.states.timezone`_
  Set the system timezone to UTC and the named timezone in
  ``pillar['settings']['system_timezone']``.

.. _system.all: https://github.com/hipikat/system-formula/blob/master/system/all.sls
.. _system.states.common: https://github.com/hipikat/system-formula/blob/master/system/states/common.sls
.. _system.states.default_user_umask: https://github.com/hipikat/system-formula/blob/master/system/states/default_user_umask.sls
.. _system.states.packages: https://github.com/hipikat/system-formula/blob/master/system/states/packages.sls
.. _system.states.pep8-linelength99: https://github.com/hipikat/system-formula/blob/master/system/states/pep8-linelength99.sls
.. _system.states.timezone: https://github.com/hipikat/system-formula/blob/master/system/states/timezone.sls
