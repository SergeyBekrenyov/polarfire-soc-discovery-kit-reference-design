# Creating SmartDesign "Video_Pipeline"
set sd_name {Video_Pipeline}
create_smartdesign -sd_name ${sd_name}

# Disable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 0

# Create top level Scalar Ports
sd_create_scalar_port -sd_name ${sd_name} -port_name {ARST_N} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {INIT_DONE} -port_direction {IN}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RX_CLK_N} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {RX_CLK_P} -port_direction {IN} -port_is_pad {1}
sd_create_scalar_port -sd_name ${sd_name} -port_name {TRNG_RST_N} -port_direction {IN}

sd_create_scalar_port -sd_name ${sd_name} -port_name {DATA_VALID_O} -port_direction {OUT}
sd_create_scalar_port -sd_name ${sd_name} -port_name {FRAME_START_O} -port_direction {OUT}


# Create top level Bus Ports
sd_create_bus_port -sd_name ${sd_name} -port_name {RXD_N} -port_direction {IN} -port_range {[0:0]} -port_is_pad {1}
sd_create_bus_port -sd_name ${sd_name} -port_name {RXD} -port_direction {IN} -port_range {[0:0]} -port_is_pad {1}

sd_create_bus_port -sd_name ${sd_name} -port_name {C_OUT} -port_direction {OUT} -port_range {[7:0]}
sd_create_bus_port -sd_name ${sd_name} -port_name {Y_OUT} -port_direction {OUT} -port_range {[7:0]}


# Add Bayer_Interpolation_C0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {Bayer_Interpolation_C0} -instance_name {Bayer_Interpolation_C0_0}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {Bayer_Interpolation_C0_0:R_O} -pin_slices {[1:0]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Bayer_Interpolation_C0_0:R_O[1:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {Bayer_Interpolation_C0_0:R_O} -pin_slices {[9:2]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {Bayer_Interpolation_C0_0:G_O} -pin_slices {[1:0]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Bayer_Interpolation_C0_0:G_O[1:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {Bayer_Interpolation_C0_0:G_O} -pin_slices {[9:2]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {Bayer_Interpolation_C0_0:B_O} -pin_slices {[1:0]}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Bayer_Interpolation_C0_0:B_O[1:0]}
sd_create_pin_slices -sd_name ${sd_name} -pin_name {Bayer_Interpolation_C0_0:B_O} -pin_slices {[9:2]}
sd_connect_pins_to_constant -sd_name ${sd_name} -pin_names {Bayer_Interpolation_C0_0:BAYER_FORMAT} -value {00}
sd_mark_pins_unused -sd_name ${sd_name} -pin_names {Bayer_Interpolation_C0_0:EOF_O}



# Add IMX296_IF_TOP_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {IMX296_IF_TOP} -instance_name {IMX296_IF_TOP_0}



# Add RGBtoYCbCr_C0_0 instance
sd_instantiate_component -sd_name ${sd_name} -component_name {RGBtoYCbCr_C0} -instance_name {RGBtoYCbCr_C0_0}



# Add scalar net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"ARST_N" "IMX296_IF_TOP_0:ARST_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Bayer_Interpolation_C0_0:DATA_VALID_I" "IMX296_IF_TOP_0:LINE_VALID_O" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Bayer_Interpolation_C0_0:EOF_I" "IMX296_IF_TOP_0:FRAME_END_O" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Bayer_Interpolation_C0_0:RESETN_I" "IMX296_IF_TOP_0:PARALLEL_CLK_RESET_N" "RGBtoYCbCr_C0_0:RESET_N_I" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Bayer_Interpolation_C0_0:RGB_VALID_O" "RGBtoYCbCr_C0_0:DATA_VALID_I" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Bayer_Interpolation_C0_0:SYS_CLK_I" "IMX296_IF_TOP_0:RX_CLK_G" "RGBtoYCbCr_C0_0:CLOCK_I" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"DATA_VALID_O" "RGBtoYCbCr_C0_0:DATA_VALID_O" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"FRAME_START_O" "IMX296_IF_TOP_0:FRAME_START_O" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"IMX296_IF_TOP_0:INIT_DONE" "INIT_DONE" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"IMX296_IF_TOP_0:RXD" "RXD" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"IMX296_IF_TOP_0:RXD_N" "RXD_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"IMX296_IF_TOP_0:RX_CLK_N" "RX_CLK_N" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"IMX296_IF_TOP_0:RX_CLK_P" "RX_CLK_P" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"IMX296_IF_TOP_0:TRNG_RST_N" "TRNG_RST_N" }

# Add bus net connections
sd_connect_pins -sd_name ${sd_name} -pin_names {"Bayer_Interpolation_C0_0:B_O[9:2]" "RGBtoYCbCr_C0_0:BLUE_I" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Bayer_Interpolation_C0_0:DATA_I" "IMX296_IF_TOP_0:DATA_O" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Bayer_Interpolation_C0_0:G_O[9:2]" "RGBtoYCbCr_C0_0:GREEN_I" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"Bayer_Interpolation_C0_0:R_O[9:2]" "RGBtoYCbCr_C0_0:RED_I" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"C_OUT" "RGBtoYCbCr_C0_0:C_OUT" }
sd_connect_pins -sd_name ${sd_name} -pin_names {"RGBtoYCbCr_C0_0:Y_OUT" "Y_OUT" }


# Re-enable auto promotion of pins of type 'pad'
auto_promote_pad_pins -promote_all 1
# Save the SmartDesign 
save_smartdesign -sd_name ${sd_name}
# Generate SmartDesign "Video_Pipeline"
generate_component -component_name ${sd_name}
