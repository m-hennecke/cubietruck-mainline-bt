# Bluetooth on Cubietruck with mainline kernel

This is written with a gentoo installation on the cubietruck as my test
system using openrc. I cleaned up the original git archive to not include
binaries that can be build on the system and added init.d scripts to suit
gentoo's init system.

To build the required programs issue `make`.
To install the programs/scripts issue `make install` with root privileges.

To install the firmware issue `make firmware_install` with root privileges.

The init.d script has to be copied by hand to `/etc/init.d/`.

## Kernel modules

- hci_uart
- btbcm
- bnep
- bluetooth

## Changes in dts

On the cubietruck the bluetooth device is accessed via the uart2
serial port. This port is not enabled in the mainline dts, so this
patch needs to be applied to the dts (the diff was made against
the 4.19 kernel tree):

```
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -352,6 +352,12 @@
        status = "okay";
 };
 
+&uart2 {
+       pinctrl-names = "default";
+       pinctrl-0 = <&uart2_pins_a>;
+       status = "okay";
+};
+
```

## Newer bluez versions and startup

Most descriptions on how to enable bluetooth on the cubietruck refer
to hciattach, which is deprecated in the newer bluez versions. The
method described here uses the btattach utility.

The init script in the sub directory etc/init.d/btattach tries to
load the ap6210 firmware into the module and start btattach in the
background.

If btattach has been started rfkill should output an entry for the
bluetooth device:

```
# rfkill
ID TYPE      DEVICE      SOFT      HARD
0 wlan      phy0   unblocked unblocked
4 bluetooth hci0   unblocked unblocked
```

Restarting btattach will result in different IDs displayed.

## bluetoothctl

TODO: Describe how to use bluetooth devices
