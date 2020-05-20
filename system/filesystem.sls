#!stateconf -o yaml . jinja
#

# Create symlinks
{% if 'system' in pillar and 'symlinks' in pillar['system'] %}

  {% for symlink_name, symlink_target in pillar['system']['symlinks'].items() %}

.Create symlink {{ symlink_name }} pointing to {{ symlink_target }}:
  file.symlink:
    - name: {{ symlink_name }}
    - target: {{ symlink_target }}
    - makedirs: True

  {% endfor %}

{% endif %}



