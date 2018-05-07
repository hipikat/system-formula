#!stateconf -o yaml . jinja
#
# System-wide packages to be installed. System packages without named
# arguments are installed in a single state via the `pkg.installed`
# state's `pkgs` argument. Arguments on a package are passed to the
# `pkg.installed` state verbatim. Python packages are installed with
# the system `pip` command, which is also installed if not present.
#
# Pillar examples... ::
#
#     system_packages:
#       - git
#       - curl
#       - zangband:
#           hold: True
#
#     system_python_packages:
#       - virtualenvwrapper
#
# Resulting states... ::
#
#     system.state.packages:Install system packages from pillar 'system_packages':
#       pkg.installed:
#         - pkgs:
#           - git
#           - curl
#
#     system.state.packages:Install system package 'zangband' from pillar 'system_packages':
#       pkg.installed:
#         - name: zangband
#         - hold: True
#
#     system.state.packages:Install system-Python 'python-pip' package:
#       pkg.installed:
#         - name: python-pip
#
#     system.state.packages:Install 'zangband' in system-Python:
#       pip.installed:
#         - name: virtualenvwrapper
#
########################################################################


# Personal Package Archives (PPAs)
{% if 'system' in pillar and 'package_repositories' in pillar['system'] %}

  {% for ppa_name, ppa_details in pillar['system']['package_repositories'].items() %}

.Install Personal Package Archive '{{ ppa_name }}':
  pkgrepo.managed:
    - humanname: {{ ppa_name }}
    #- name: {# ppa_details['name'] #}
    - ppa: {{ ppa_details['ppa'] }}
    - refresh: True

  {% endfor %}

{% endif %}


# Standard system packages
{% if 'system' in pillar and 'packages' in pillar['system'] %}

  # Work out if any system_packages come without special options
  {% set meta = {'has_vanilla_packages': False} %}
  {% for pkg in pillar['system']['packages'] %}
    {% if pkg is not mapping %}
      {% if meta.update({'has_vanilla_packages': True}) %}{% endif %}
    {% endif %}
  {% endfor %}

  # First install packages without special requirements, in one state
  {% if meta['has_vanilla_packages'] %}
.Install system packages from pillar 'system:packages':
  pkg.installed:
    - pkgs:
    {% for pkg in pillar['system']['packages'] %}
      {% if pkg is not mapping %}
      - {{ pkg }}
      {% endif %}
    {% endfor %}
  {% endif %}

  # Now loop through again, installing packages with options on pkg.installed
  {% for pkg in pillar['system']['packages'] %}
    {% if pkg is mapping %}
      {% for pkg_name, pkg_opt_dict in pkg.iteritems() %}

.Install system package '{{ pkg_name }}' from pillar 'system:packages':
  pkg.installed:
    - name: {{ pkg_name }}
        {% for opt_key, opt_val in pkg_opt_dict.items() %}
    - {{ opt_key }}: {{ opt_val }}
        {% endfor %}

      {% endfor %}
    {% endif %}
  {% endfor %}

{% endif %}


# System-Python packages
{% if 'system' in pillar and 'python_packages' in pillar['system'] %}

.Install system-Python 'python-pip' package:
  pkg.installed:
    - name: python-pip

.Install system-Python 'python3-pip' package:
  pkg.installed:
    - name: python3-pip

{% for py_pkg in pillar['system']['python_packages'] %}
.Install '{{ py_pkg }}' in system-Python: 
  pip.installed:
    - name: {{ py_pkg }}
{% endfor %}

{% endif %}   # End if 'system_python_packages' in pillar
