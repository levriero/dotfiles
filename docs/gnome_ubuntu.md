# Gnome

Set up a sane repeat rate for keys without having to deal with the awful UI sliders:

```
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 30
gsettings set org.gnome.desktop.peripherals.keyboard delay 250
```

Swap Caps Lock to CTRL:

```
sudo nvim /etc/default/keyboard
```

add/modify `XKBOPTIONS="ctrl:nocaps"`

```
sudo dpkg-reconfigure keyboard-configuration
```

Hide trash and home desktop icons:

```
gsettings set org.gnome.shell.extensions.desktop-icons show-trash false
gsettings set org.gnome.shell.extensions.desktop-icons show-home false
```

# Ubuntu

Disable apport:

```
sudo sed -i 's/enabled=1/enabled=0/g' /etc/default/apport
```
