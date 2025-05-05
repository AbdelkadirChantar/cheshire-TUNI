# Copyright 2024 ETH Zurich and University of Bologna.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0
#
# Abdelkadir Chantar <abdelkadir.chantar@tuni.fi>
# Common OpenOCD script for Cheshire.
#
# !!!: Must use exactly OpenOCD 0.12

transport select jtag
#gdb port 3333
#telnet port disabled
#tcl port disabled
reset_config none

set _CHIPNAME riscv
jtag newtap $_CHIPNAME cpu -irlen ${irlen} -expected-id 0x1c5e5db3

set _TARGETNAME $_CHIPNAME.cpu
target create $_TARGETNAME riscv -chain-position $_TARGETNAME 


#gdb report_data_abort enable
#gdb report_register_access_error enable

riscv set_command_timeout_sec 2
#riscv set_vlenb 0
#riscv set_mem_access progbuf

riscv set_mem_access sysbus

# Exit when debugger detaches
$_TARGETNAME configure -event gdb-detach {
    echo "GDB detached; ending debugging session."
    shutdown
}

# Try enabling address translation (only works for newer versions)
if { [catch { riscv set_enable_virtual on } ] } {
    echo "Warning: This version of OpenOCD does not support address translation.\
        To debug on virtual addresses, please update to the latest version."
}

# dump jtag chain
scan_chain
targets

init
halt