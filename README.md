# intel-7265-bt-fix
Intel 7265 WiFi adapter udev rules and script to fix BT audio chopping issues.

I've got HP ProBook 470G4 laptop with Bluetooth earbuds Honor AM61.
Every time I've transfer lot of data over 5G WiFi connection Bluetooth sound is chopping
and pulseaudio complains about skipped audio samples.

After long investigation I've found, that chopping sound is caused by lot of long PCI-E transaction
by WiFi adapter. This long transaction times are caused by incorrect implementations of ASPM in
Intel 7265 WiFi. Changing ASPM setting of WiFi adapter to the L0 or L0s solves chopping issues.

Another issue is lot of following error messages in kernel log:
```
pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
pcieport 0000:00:1c.5: AER: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Transmitter ID)
pcieport 0000:00:1c.5: AER:   device [8086:9d15] error status/mask=00001041/00002041
pcieport 0000:00:1c.5: AER:    [12] Timeout               
pcieport 0000:00:1c.5: AER: Corrected error received: 0000:00:1c.5
pcieport 0000:00:1c.5: AER: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
pcieport 0000:00:1c.5: AER:   device [8086:9d15] error status/mask=000000c1/00002041
pcieport 0000:00:1c.5: AER:    [ 7] BadDLLP
```

I think this error messages are regarded to incorrectly implemented AER in the Intel chipset of
my laptop. So included script disables AER for the root port, used to connect Intel WiFi adapter.
This solves AER issues.

## Requirements

Configuration script uses **setpci** tool from pciutils package. So if you are using Debian you 
should install it with the following command:
```
sudo apt install pciutils
```

## Installation

Run ./install.sh script with root privileges and reboot.

