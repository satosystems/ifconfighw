# ifconfighw

This program is a wrapper for `ifconfig`.

If you want to find out the IP address of any network interface with `ifconfig`, you have to find the network interface after outputting the command, and then find the IP address from around it.
In many cases, that is done by eye.

This wrapper can be run as follows to find arbitrary information in a command.

```shell-session
$ ifconfighw | grep en0: | grep inet | grep -v inet6
en0:    inet 192.168.10.132 netmask 0xffffff00 broadcast 192.168.10.255
$
```

What this wrapper does is simple, it just gives the name of the network interface if it does not exist at the beginning of every output line.
