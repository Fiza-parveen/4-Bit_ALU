## =========================================
## PYNQ-Z2 4-BIT ALU
## FPGA: Zynq-7000
## I/O Standard: LVCMOS33
## =========================================

## -----------------------------------------
## INPUT A - PMOD JA
## -----------------------------------------

set_property -dict { PACKAGE_PIN Y18 IOSTANDARD LVCMOS33 } [get_ports { A[0] }]
set_property -dict { PACKAGE_PIN Y19 IOSTANDARD LVCMOS33 } [get_ports { A[1] }]
set_property -dict { PACKAGE_PIN Y16 IOSTANDARD LVCMOS33 } [get_ports { A[2] }]
set_property -dict { PACKAGE_PIN Y17 IOSTANDARD LVCMOS33 } [get_ports { A[3] }]

## -----------------------------------------
## INPUT B - PMOD JA
## -----------------------------------------

set_property -dict { PACKAGE_PIN U18 IOSTANDARD LVCMOS33 } [get_ports { B[0] }]
set_property -dict { PACKAGE_PIN U19 IOSTANDARD LVCMOS33 } [get_ports { B[1] }]
set_property -dict { PACKAGE_PIN W18 IOSTANDARD LVCMOS33 } [get_ports { B[2] }]
set_property -dict { PACKAGE_PIN W19 IOSTANDARD LVCMOS33 } [get_ports { B[3] }]

## -----------------------------------------
## OPERATION SELECTOR - PMOD JB
## -----------------------------------------

set_property -dict { PACKAGE_PIN W14 IOSTANDARD LVCMOS33 } [get_ports { op[0] }]
set_property -dict { PACKAGE_PIN Y14 IOSTANDARD LVCMOS33 } [get_ports { op[1] }]
set_property -dict { PACKAGE_PIN T11 IOSTANDARD LVCMOS33 } [get_ports { op[2] }]

## -----------------------------------------
## RESULT - ONBOARD LEDs
## -----------------------------------------

set_property -dict { PACKAGE_PIN R14 IOSTANDARD LVCMOS33 } [get_ports { result[0] }]
set_property -dict { PACKAGE_PIN P14 IOSTANDARD LVCMOS33 } [get_ports { result[1] }]
set_property -dict { PACKAGE_PIN N16 IOSTANDARD LVCMOS33 } [get_ports { result[2] }]
set_property -dict { PACKAGE_PIN M14 IOSTANDARD LVCMOS33 } [get_ports { result[3] }]

## -----------------------------------------
## STATUS FLAGS - RGB LED CHANNELS
## -----------------------------------------

set_property -dict { PACKAGE_PIN L15 IOSTANDARD LVCMOS33 } [get_ports { carry }]
set_property -dict { PACKAGE_PIN G17 IOSTANDARD LVCMOS33 } [get_ports { zero }]
set_property -dict { PACKAGE_PIN N15 IOSTANDARD LVCMOS33 } [get_ports { overflow }]