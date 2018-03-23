#!stateconf -o yaml . jinja
#
# Ensure a minion has (or doesn't have) a swap disk, from pillar data.
# The 'swapfile' pillar key should be a file size understood by the
# `fallocate` command, or `0` to remove an existing swapfile.
########################################################################

{% if 'swapfile' in pillar %}

  {% if pillar['swapfile'] != '0' %}
.Create {{ pillar['swapfile'] }} swap file at /.swapfile:
  cmd.run:
    - name: |
        [ -f /.swapfile ] || fallocate -l {{ pillar['swapfile'] }} /.swapfile
        chmod 0600 /.swapfile
        mkswap /.swapfile
        echo '/.swapfile      none      swap     sw       0       0' >> /etc/fstab
        swapon /.swapfile
    - unless: file /.swapfile 2>&1 | grep -q "Linux/i386 swap"

  {% else %}
.Remove swap file at /.swapfile:
  cmd.run:
    - name: |
        swapoff /.swapfile
        sed -i '|^/.swapfile |d' /etc/fstab
        rm /.swapfile
    - unless: test ! -f /.swapfile
  {% endif %}

{% endif %}
