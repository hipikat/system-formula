#!stateconf -o yaml . jinja
#
# Set a default UMASK for users on the machine. So, for example,
# if the server is a group development environment, consider setting
# pillar['default_user_umask'] = '002' (instead of '022').
########################################################################


# Set a default UMASK for the machine
{% if pillar.get('default_user_umask') %}
.Set default user UMASK to '{{ pillar['default_user_umask'] }}':
  file.replace:
    - name: /etc/login.defs
    - pattern: ^UMASK\s+[\dx]+
    - repl: UMASK\t\t{{ pillar['default_user_umask'] }}
    - flags: ['IGNORECASE']
    - backup: False
{% endif %}
