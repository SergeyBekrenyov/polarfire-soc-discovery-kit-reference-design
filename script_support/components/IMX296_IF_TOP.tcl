# Creating SmartDesign "IMX296_IF_TOP"
set sd_name {IMX296_IF_TOP}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Scalar Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {ACLK_I} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ARESETN_I} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {ARST_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {AXI4L_MIPI_ARVALID_I} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {AXI4L_MIPI_AWVALID_I} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {AXI4L_MIPI_BREADY_I} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {AXI4L_MIPI_RREADY_I} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {AXI4L_MIPI_WVALID_I} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {INIT_DONE} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RX_CLK_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RX_CLK_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {TRNG_RST_N} -port_direction {IN}

sd_create_scalar_port -sd_name ${sd_name} -port_name {AXI4L_MIPI_ARREADY_O} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {AXI4L_MIPI_AWREADY_O} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {AXI4L_MIPI_BVALID_O} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {AXI4L_MIPI_RVALID_O} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {AXI4L_MIPI_WREADY_O} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {FRAME_START_O} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {LINE_VALID_O} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {MIPI_INTERRUPT_O} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PARALLEL_CLK_RESET_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {PARALLEL_CLK} -port_direction {OUT}


# Create top level Bus Ports
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4L_MIPI_ARADDR_I} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4L_MIPI_AWADDR_I} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4L_MIPI_WDATA_I} -port_direction {IN} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {RXD_N} -port_direction {IN} -port_range {[0:0]} -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {RXD} -port_direction {IN} -port_range {[0:0]} -port_is_pad {1}

sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4L_MIPI_BRESP_O} -port_direction {OUT} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4L_MIPI_RDATA_O} -port_direction {OUT} -port_range {[31:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {AXI4L_MIPI_RRESP_O} -port_direction {OUT} -port_range {[1:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {DATA_O} -port_direction {OUT} -port_range {[9:0]}


# Create top level Bus interface Ports
sd_create_bif_port -sd_name ${sd_name} -port_name {AXI4L_MIPI} -port_bif_vlnv {AMBA:AMBA4:AXI4:r0p0_0} -port_bif_role {slave} -port_bif_mapping {\
"AWADDR:AXI4L_MIPI_AWADDR_I" \
"AWVALID:AXI4L_MIPI_AWVALID_I" \
"AWREADY:AXI4L_MIPI_AWREADY_O" \
"WDATA:AXI4L_MIPI_WDATA_I" \
"WVALID:AXI4L_MIPI_WVALID_I" \
"WREADY:AXI4L_MIPI_WREADY_O" \
"BRESP:AXI4L_MIPI_BRESP_O" \
"BVALID:AXI4L_MIPI_BVALID_O" \
"BREADY:AXI4L_MIPI_BREADY_I" \
"ARADDR:AXI4L_MIPI_ARADDR_I" \
"ARVALID:AXI4L_MIPI_ARVALID_I" \
"ARREADY:AXI4L_MIPI_ARREADY_O" \
"RDATA:AXI4L_MIPI_RDATA_O" \
"RRESP:AXI4L_MIPI_RRESP_O" \
"RVALID:AXI4L_MIPI_RVALID_O" \
"RREADY:AXI4L_MIPI_RREADY_I" } 

# Add AND2_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND2} -instance_name {AND2_0}



# Add CORERESET_PF_C2_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CORERESET_PF_C2} -instance_name {CORERESET_PF_C2_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C2_0:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C2_0:BANK_y_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C2_0:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C2_0:FF_US_RESTORE} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C2_0:FPGA_POR_N} -value {VCC}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CORERESET_PF_C2_0:PLL_POWERDOWN_B}



# Add CORERESET_PF_C3_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CORERESET_PF_C3} -instance_name {CORERESET_PF_C3_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C3_0:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C3_0:BANK_y_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C3_0:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C3_0:FF_US_RESTORE} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_PF_C3_0:FPGA_POR_N} -value {VCC}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CORERESET_PF_C3_0:PLL_POWERDOWN_B}



# Add DFN1_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {DFN1} -instance_name {DFN1_0}



# Add DFN1_0_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {DFN1} -instance_name {DFN1_0_0}



# Add DFN1_0_1 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {DFN1} -instance_name {DFN1_0_1}



# Add MIPI_RX_SUBSYS_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {MIPI_RX_SUBSYS} -instance_name {MIPI_RX_SUBSYS_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {MIPI_RX_SUBSYS_0:HS_IO_CLK_PAUSE} -value {GND}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {MIPI_RX_SUBSYS_0:CLK_TRAIN_DONE}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {MIPI_RX_SUBSYS_0:CLK_TRAIN_ERROR}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {MIPI_RX_SUBSYS_0:HS_SEL} -value {VCC}



# Add mipicsi2rxdecoderPF_C0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {mipicsi2rxdecoderPF_C0} -instance_name {mipicsi2rxdecoderPF_C0_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {mipicsi2rxdecoderPF_C0_0:DATA_O} -pin_slices {[1:0]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {mipicsi2rxdecoderPF_C0_0:DATA_O[1:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {mipicsi2rxdecoderPF_C0_0:DATA_O} -pin_slices {[9:2]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {mipicsi2rxdecoderPF_C0_0:FRAME_VALID_O}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {mipicsi2rxdecoderPF_C0_0:FRAME_END_O}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {mipicsi2rxdecoderPF_C0_0:LINE_START_O}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {mipicsi2rxdecoderPF_C0_0:LINE_END_O}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {mipicsi2rxdecoderPF_C0_0:VIRTUAL_CHANNEL_O}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {mipicsi2rxdecoderPF_C0_0:DATA_TYPE_O}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {mipicsi2rxdecoderPF_C0_0:ECC_ERROR_O}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {mipicsi2rxdecoderPF_C0_0:CRC_ERROR_O}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {mipicsi2rxdecoderPF_C0_0:WORD_COUNT_O}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {mipicsi2rxdecoderPF_C0_0:EBD_VALID_O}



# Add PF_CCC_C1_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PF_CCC_C1} -instance_name {PF_CCC_C1_0}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"ACLK_I" "mipicsi2rxdecoderPF_C0_0:ACLK_I" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:A" "DFN1_0_0:Q" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:B" "CORERESET_PF_C2_0:PLL_LOCK" "CORERESET_PF_C3_0:PLL_LOCK" "DFN1_0:Q" "mipicsi2rxdecoderPF_C0_0:CAM_PLL_LOCK_I" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:Y" "MIPI_RX_SUBSYS_0:TRAINING_RST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ARESETN_I" "mipicsi2rxdecoderPF_C0_0:ARESETN_I" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ARST_N" "MIPI_RX_SUBSYS_0:ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_PF_C2_0:CLK" "DFN1_0_1:CLK" "MIPI_RX_SUBSYS_0:RX_CLK_G" "PF_CCC_C1_0:REF_CLK_0" "mipicsi2rxdecoderPF_C0_0:CAM_CLOCK_I" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_PF_C2_0:EXT_RST_N" "CORERESET_PF_C3_0:EXT_RST_N" "DFN1_0_1:Q" "mipicsi2rxdecoderPF_C0_0:TRAINING_DONE_I" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_PF_C2_0:FABRIC_RESET_N" "mipicsi2rxdecoderPF_C0_0:RESET_N_I" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_PF_C2_0:INIT_DONE" "CORERESET_PF_C3_0:INIT_DONE" "INIT_DONE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_PF_C3_0:CLK" "DFN1_0:CLK" "DFN1_0_0:CLK" "PARALLEL_CLK" "PF_CCC_C1_0:OUT0_FABCLK_0" "mipicsi2rxdecoderPF_C0_0:PARALLEL_CLOCK_I" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_PF_C3_0:FABRIC_RESET_N" "PARALLEL_CLK_RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DFN1_0:D" "PF_CCC_C1_0:PLL_LOCK_0" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DFN1_0_0:D" "TRNG_RST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DFN1_0_1:D" "MIPI_RX_SUBSYS_0:TRAINING_DONE_O" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FRAME_START_O" "mipicsi2rxdecoderPF_C0_0:FRAME_START_O" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"LINE_VALID_O" "mipicsi2rxdecoderPF_C0_0:LINE_VALID_O" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIPI_INTERRUPT_O" "mipicsi2rxdecoderPF_C0_0:MIPI_INTERRUPT_O" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIPI_RX_SUBSYS_0:L0_LP_DATA" "mipicsi2rxdecoderPF_C0_0:L0_LP_DATA_I" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIPI_RX_SUBSYS_0:L0_LP_DATA_N" "mipicsi2rxdecoderPF_C0_0:L0_LP_DATA_N_I" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIPI_RX_SUBSYS_0:RXD" "RXD" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIPI_RX_SUBSYS_0:RXD_N" "RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIPI_RX_SUBSYS_0:RX_CLK_N" "RX_CLK_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIPI_RX_SUBSYS_0:RX_CLK_P" "RX_CLK_P" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"DATA_O" "mipicsi2rxdecoderPF_C0_0:DATA_O" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIPI_RX_SUBSYS_0:L0_RXD_DATA" "mipicsi2rxdecoderPF_C0_0:L0_HS_DATA_I" }

# Add bus interface net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"AXI4L_MIPI" "mipicsi2rxdecoderPF_C0_0:AXI4Lite_Target_IF" }

# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the SmartDesign 
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign "IMX296_IF_TOP"
generate_component -component_name ${sd_name}
