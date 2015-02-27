#!stateconf -o yaml . jinja
#
# Set a default UMASK for users on the machine. So, for example, If the
# server is a group development environment, consider setting
# pillars['settings']['default_user_umask'] = '002' (instead of '022').
########################################################################


# Set a default UMASK for the machine
{% if pillars.get('settings', {}).get('default_user_umask') %}
.Set default user UMASK to '{{ pillar['settings']['default_user_umask'] }}':
  file.replace:
    - name: /etc/login.defs
    - pattern: ^UMASK\s+[\dx]+
    - repl: UMASK\t\t{{ pillar['settings']['default_user_umask'] }}
    - flags: ['IGNORECASE']
    - backup: False
{% endif %}
