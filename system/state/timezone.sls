#!stateconf -o yaml . jinja
#
# Set system timezone to Australia/Perth
########################################################################


{% if pillar.get('timezone') %}
.Set hardware clock to UTC and system clock to {{ pillar['timezone'] }}:
  timezone.system:
    - name: {{ pillar['timezone'] }}
    - utc: True
{% endif %}
