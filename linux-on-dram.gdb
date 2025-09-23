# Load OpenSBI
restore sw/deps/cva6-sdk/install64/fw_payload.bin binary 0x80000000

# Load device tree
restore sw/boot/cheshire.zcu104.dtb binary 0x83000000

# Load Image.gz at 0x82000000
restore sw/deps/cva6-sdk/install64/Image.gz binary 0x84000000

# Set pc
set $pc = 0x80000000

# run
continue
