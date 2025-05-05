# Copyright 2024 ETH Zurich and University of Bologna.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0
#
# Abdelkadir Chantar <abdelkadir.chantar@tuni.fi>
# OpenOCD script for Cheshire on zcu104.

adapter driver ftdi
adapter serial FT5X1XMQ; # either comment out or modify to match adapter

adapter speed 1000
ftdi vid_pid 0x0403 0x6010
ftdi layout_init 0x0088 0x008b
ftdi channel 1
set irlen 5

source [file dirname [info script]]/openocd.common.tcl



