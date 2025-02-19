# Copyright 2024 ETH Zurich and University of Bologna.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0
#
# Common OpenOCD script for Cheshire.

transport select jtag
gdb port 3333
telnet port disabled
tcl port disabled
reset_config none

set _CHIPNAME riscv
jtag newtap $_CHIPNAME cpu -irlen ${irlen} -expected-id 0x1c5e5db3

set _TARGETNAME $_CHIPNAME.cpu
target create $_TARGETNAME riscv -chain-position $_TARGETNAME 

# gdb report_data_abort enable
# gdb report_register_access_error enable

gdb report_data_abort enable
gdb report_register_access_error enable

riscv set_command_timeout_sec 120

# riscv set_prefer_sba off

# Try enabling address translation (only works for newer versions)
if { [catch { riscv virt2phys_mode on } ] } {
    echo "Warning: This version of OpenOCD does not support address translation.\
        To debug on virtual addresses, please update to the latest version."
}
# dump jtag chain
scan_chain
targets

init
halt
echo "Ready for Remote Connections"
