# Bluetooth on Cubietruck with mainline kernel

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

## bluetoothctl

TODO: Describe how to use bluetooth devices
