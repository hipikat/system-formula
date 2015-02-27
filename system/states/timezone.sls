#!stateconf -o yaml . jinja
#
# Set system timezone to Australia/Perth
########################################################################


{% if pillar.get('settings', {}).get('system_timezone') %}
.Set hardware clock to UTC and system clock to {{ pillar['settings']['system_timezone'] }}:
  timezone.system:
    - name: {{ pillar['settings']['system_timezone'] }}
    - utc: True
{% endif %}
