## dnf

Enable [`fastestmirror`](https://dnf.readthedocs.io/en/latest/conf_ref.html).

```bash
echo "fastestmirror=True" | sudo tee -a /etc/dnf/dnf.conf
```

## Nvidia drivers

https://rpmfusion.org/Howto/NVIDIA

Note: Gnome with Wayland and NVIDIA doesn't work by default at this point.

1. Open `/etc/gdm/custom.conf` and uncomment `WaylandEnable=false`.
2. Add the following line to the [daemon] section:

```
DefaultSession=gnome-xorg.desktop
```

3.  Save the custom.conf file.

## Gnome

Fedora sets a sane repeat interval but the delay is too high: 500ms as of 32. Change it to half of that:

```
gsettings set org.gnome.desktop.peripherals.keyboard delay 250
```
