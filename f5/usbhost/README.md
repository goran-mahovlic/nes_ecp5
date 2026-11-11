# USB HID host za F5 (TASK-6072)

Ista kombinacija kao `litex-eth-ulx5m-gs-1g-sbc` @e4b4b4b `gateware/verilog/usbhost` (TASK-5047), koja na ULX5M-GS
radi s tipkovnicom na USB-C J5 (Goran, 11. 11. 2026.):

| datoteka | izvor |
|---|---|
| `usbh_sie.v` | emard/ulx3s-misc d0c6f15 (noviji od `usb/usbhost/usbh_sie.v`: ACK na sve osim NAK, bez ACK-a uz CRC grešku) |
| `usb_phy_ghdl.v` | OpenCores USB 1.1 PHY (VHDL) → Verilog `ghdl --synth` (generici: 6 MHz, 1,5 Mbit/s = low speed) |

`usbh_host_hid.v`, `usbh_crc5.v`, `usbh_crc16.v`, `usbh_setup_rom.mem` su bajt-jednaki u oba repoa, pa ih F5 uzima
iz `usb/usbhost/`. ECP5 tok (Makefile) i dalje koristi `usb/usbhost/usbh_sie.v` + `usb/usb11_phy_vhdl/`.
Full speed (48 MHz) ovaj PHY ne može: za FS uređaj treba `usb/usb11_phy_vhdl/` i `C_usb_speed=1`.
