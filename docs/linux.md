# Gnome (Ubuntu)

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
