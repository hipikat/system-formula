#!stateconf -o yaml . jinja
#
# Set system timezone to Australia/Perth
########################################################################


{% if 'system' in pillar and 'timezone' in pillar['system'] %}
.Set hardware clock to UTC and system clock to {{ pillar['system']['timezone'] }}:
  timezone.system:
    - name: {{ pillar['system']['timezone'] }}
    - utc: True
{% endif %}
