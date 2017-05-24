#!/bin/sh
doas -C /etc/doas.conf intel_reg write 0x00061254 0x60016001
doas -n intel_reg write 0x00061254 0x60006000
