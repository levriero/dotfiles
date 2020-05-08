## Keyboard

Set up a sane repeat rate for keys:

```bash
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 30
gsettings set org.gnome.desktop.peripherals.keyboard delay 250
```

Swap Caps Lock to CTRL:

```bash
# /etc/default/keyboard
XKBOPTIONS="ctrl:nocaps"

sudo dpkg-reconfigure keyboard-configuration
```

Hide trash and home desktop icons:

```bash
gsettings set org.gnome.shell.extensions.desktop-icons show-trash false
gsettings set org.gnome.shell.extensions.desktop-icons show-home false
```

# Apport

Disable it

```
sudo sed -i 's/enabled=1/enabled=0/g' /etc/default/apport
```
