# Creating SmartDesign "MIPI_RX_SUBSYS"
set sd_name {MIPI_RX_SUBSYS}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Scalar Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {ARST_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HS_IO_CLK_PAUSE} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {HS_SEL} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RX_CLK_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RX_CLK_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {TRAINING_RST_N} -port_direction {IN}

sd_create_scalar_port -sd_name ${sd_name} -port_name {CLK_TRAIN_DONE} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {CLK_TRAIN_ERROR} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {L0_LP_DATA_N} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {L0_LP_DATA} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RX_CLK_G} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {TRAINING_DONE_O} -port_direction {OUT}


# Create top level Bus Ports
sd_create_bus_port -sd_name ${sd_name} -port_name {RXD_N} -port_direction {IN} -port_range {[0:0]} -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {RXD} -port_direction {IN} -port_range {[0:0]} -port_is_pad {1}

sd_create_bus_port -sd_name ${sd_name} -port_name {L0_RXD_DATA} -port_direction {OUT} -port_range {[7:0]}


# Add AND2_0 instance
sd_instantiate_macro -sd_name ${sd_name} -macro_name {AND2} -instance_name {AND2_0}



# Add CORERESET_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {CORERESET} -instance_name {CORERESET_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_0:BANK_x_VDDI_STATUS} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_0:BANK_y_VDDI_STATUS} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_0:PLL_LOCK} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_0:SS_BUSY} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_0:INIT_DONE} -value {VCC}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_0:FF_US_RESTORE} -value {GND}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {CORERESET_0:FPGA_POR_N} -value {VCC}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {CORERESET_0:PLL_POWERDOWN_B}



# Add MIPI_TRAINING_LITE_C0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {MIPI_TRAINING_LITE_C0} -instance_name {MIPI_TRAINING_LITE_C0_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {MIPI_TRAINING_LITE_C0_0:PLL_LOCK_I} -value {VCC}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {MIPI_TRAINING_LITE_C0_0:TRAINING_ACTIVE_O}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {MIPI_TRAINING_LITE_C0_0:TAP_DELAYS_I} -value {00001010}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {MIPI_TRAINING_LITE_C0_0:VALID_WIN_LEN_I} -value {00000111}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {MIPI_TRAINING_LITE_C0_0:FALSE_FLG_THRESHOLD_I} -value {1010}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {MIPI_TRAINING_LITE_C0_0:TAP_CNT_FINAL_O}



# Add PF_IOD_GENERIC_MIPI_RX0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {PF_IOD_GENERIC_MIPI_RX0} -instance_name {PF_IOD_GENERIC_MIPI_RX0_0}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {PF_IOD_GENERIC_MIPI_RX0_0:EYE_MONITOR_WIDTH} -value {001}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:A" "CLK_TRAIN_DONE" "PF_IOD_GENERIC_MIPI_RX0_0:CLK_TRAIN_DONE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:B" "CORERESET_0:FABRIC_RESET_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"AND2_0:Y" "MIPI_TRAINING_LITE_C0_0:RESET_N_I" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"ARST_N" "PF_IOD_GENERIC_MIPI_RX0_0:ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CLK_TRAIN_ERROR" "PF_IOD_GENERIC_MIPI_RX0_0:CLK_TRAIN_ERROR" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_0:CLK" "MIPI_TRAINING_LITE_C0_0:CLK_I" "PF_IOD_GENERIC_MIPI_RX0_0:RX_CLK_G" "RX_CLK_G" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"CORERESET_0:EXT_RST_N" "TRAINING_RST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HS_IO_CLK_PAUSE" "PF_IOD_GENERIC_MIPI_RX0_0:HS_IO_CLK_PAUSE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"HS_SEL" "PF_IOD_GENERIC_MIPI_RX0_0:HS_SEL" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"L0_LP_DATA" "PF_IOD_GENERIC_MIPI_RX0_0:L0_LP_DATA" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"L0_LP_DATA_N" "MIPI_TRAINING_LITE_C0_0:LP_DATA_N_I" "PF_IOD_GENERIC_MIPI_RX0_0:L0_LP_DATA_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIPI_TRAINING_LITE_C0_0:BIT_ALGN_CLR_FLAGS_O" "PF_IOD_GENERIC_MIPI_RX0_0:EYE_MONITOR_CLEAR_FLAGS" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIPI_TRAINING_LITE_C0_0:BIT_ALGN_DIRECTION_O" "PF_IOD_GENERIC_MIPI_RX0_0:DELAY_LINE_DIRECTION" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIPI_TRAINING_LITE_C0_0:BIT_ALGN_LOAD_O" "PF_IOD_GENERIC_MIPI_RX0_0:DELAY_LINE_LOAD" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIPI_TRAINING_LITE_C0_0:BIT_ALGN_MOVE_O" "PF_IOD_GENERIC_MIPI_RX0_0:DELAY_LINE_MOVE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIPI_TRAINING_LITE_C0_0:IOD_EARLY_I" "PF_IOD_GENERIC_MIPI_RX0_0:EYE_MONITOR_EARLY" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIPI_TRAINING_LITE_C0_0:IOD_LATE_I" "PF_IOD_GENERIC_MIPI_RX0_0:EYE_MONITOR_LATE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIPI_TRAINING_LITE_C0_0:IOD_OOR_I" "PF_IOD_GENERIC_MIPI_RX0_0:DELAY_LINE_OUT_OF_RANGE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"MIPI_TRAINING_LITE_C0_0:TRAINING_DONE_O" "TRAINING_DONE_O" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_IOD_GENERIC_MIPI_RX0_0:RXD" "RXD" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_IOD_GENERIC_MIPI_RX0_0:RXD_N" "RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_IOD_GENERIC_MIPI_RX0_0:RX_CLK_N" "RX_CLK_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"PF_IOD_GENERIC_MIPI_RX0_0:RX_CLK_P" "RX_CLK_P" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"L0_RXD_DATA" "PF_IOD_GENERIC_MIPI_RX0_0:L0_RXD_DATA" }


# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the SmartDesign 
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign "MIPI_RX_SUBSYS"
generate_component -component_name ${sd_name}
