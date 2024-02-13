# waydroid-hacks

Custom shell scripts and configuration files for patching various issues that may appear when using [waydroid](https://github.com/waydroid/waydroid).
The currently uploaded scripts may help with the following issues;

## LXC bridge issues
LXC bridge interface (`lxcbr0`) binds to port 53 on boot. This may interfere if you have a DNS server running. The files provided under `LXC-net` folder have example settings that fix this problem by disabling the bind and using certain DNS public servers. You may further configure them to your preferences.

> [!NOTE]
> After changing these files, don't forget to run `sudo systemctl restart lxc-net`, in order for changes to take place!

## Waydroid container issues

> [!NOTE]
> In order for changes to take place, you have to restart waydroid. A way to do that is the following;
> ```bash
> $ waydroid session stop
> $ sudo systemctl restart waydroid-container
> ```

### Port 53 binding
If you read the default [`waydroid-net.sh`](waydroid-net/waydroid-net-original.sh), usually located under `/usr/lib/waydroid/data/scripts`, you may see that
`dnsmasq` binds again port 53 in order to run the local DNS resolver, which may interfere if you already have a DNS server running. The [`waydroid-net-without-dns-port-bind.sh`](waydroid-net/waydroid-net-without-dns-port-bind.sh) script, solves exactly this issue by disable port binding and setting custom DNS servers.

### Firewall problems
In addition it updates and creates the required the firewall rules using the following precedence order;
1. `nftables`
2. `iptables-legacy`
3. `iptables`

If you use `iptables` primarily (e.g. running other containerization software) and have the other programs installed as well, this will mess up your firewall tables, ending up to more networking problems. The [`waydroid-net-force-iptables-and-without-dns-port-bind.sh`](waydroid-net/waydroid-net-force-iptables-and-without-dns-port-bind.sh) script forces the uses of `iptables` and again disable port binding by setting custom DNS.

## Start up waydroid on full screen when WM is not Wayland
In this case, a Wayland compositor is required. I used and recommend [Weston](https://gitlab.freedesktop.org/wayland/weston) for this job. You may find example weston config file, startup script and desktop entry unter `weston-fullscreen` folder.

> [!NOTE]
> `weston.ini` must be placed under ~/.config in order for weston to read it. You may find more configuration option in `weston.ini` manpage.
