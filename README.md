# UART Communication using Verilog HDL

## 📌 Project Overview

This project demonstrates the implementation of the Universal
Asynchronous Receiver Transmitter (UART) protocol using Verilog HDL on
FPGA. The repository contains two independent UART communication
applications designed for learning, verification, and practical FPGA
interfacing.

The first application establishes serial communication between two FPGA
boards using dedicated UART Transmitter and Receiver modules. The second
application demonstrates communication between a computer and an FPGA
using Python and the PySerial library, enabling users to manually
transmit binary data from software directly to FPGA hardware.

The project provides a complete understanding of UART protocol
implementation, baud-rate generation, serial data framing, FPGA hardware
validation, and software-to-hardware communication.

<p align="center">
<img src="https://github.com/MOHAMMEDRIYAJ/UART-Communication-on-FPGA/blob/main/FPGA_to_FPGA/FPGA_1/Block_Diagram.png" width="80%">
<img src="https://github.com/MOHAMMEDRIYAJ/UART-Communication-on-FPGA/blob/main/Python_to_FPGA/Block_Diagram.png" width="80%">
</p>

------------------------------------------------------------------------

# 📑 Table of Contents

1.  [Project Intent](#project-intent)
2.  [UART Protocol](#uart-protocol)
3.  [UART Frame Format](#uart-frame-format)
4.  [Features](#features)
5.  [Baud Rate Generator](#baud-rate-generator)
6.  [EDA Tools and Hardware](#eda-tools-and-hardware)
5.  [FPGA to FPGA Communication](#fpga-to-fpga-communication)
6.  [Python to FPGA Communication](#python-to-fpga-communication)
7.  [FPGA Demonstration](#fpga-demonstration)
8.  [References](#references)

------------------------------------------------------------------------

# Project Intent

The objective of this project is to understand and implement
asynchronous serial communication completely in hardware using Verilog
HDL while also demonstrating hardware-software communication through
Python.

The project aims to

-   Design a synthesizable UART Transmitter
-   Design a synthesizable UART Receiver
-   Verify UART communication through simulation
-   Interface two FPGA boards
-   Interface a PC with FPGA using PySerial
-   Understand asynchronous communication and baud rate generation
-   Build a reusable UART module for future FPGA projects

------------------------------------------------------------------------

# UART Protocol

UART (Universal Asynchronous Receiver Transmitter) is one of the most
widely used serial communication protocols.

Unlike SPI or I²C, UART does not require a clock signal between
transmitter and receiver. Both devices communicate only using

-   TX
-   RX

Both devices must be configured with the same

-   Baud Rate
-   Number of Data Bits
-   Parity
-   Stop Bits

> [!NOTE]
> Both FPGAs must share commom ground.

------------------------------------------------------------------------

# UART Frame Format

The implemented UART frame follows the standard **8-N-1** configuration.

| Start | Data | Parity | Stop |
| ----- | ---- | ------ | ---- |
| 1 | 5 to 9 | 1 (optional) | 1 or 2 |

### In this Project

| Start | Data | Parity | Stop |
| ----- | ---- | ------ | ---- |
| 1 | 8 | 0 | 1 |

------------------------------------------------------------------------

# Features

## FPGA to FPGA

## Python to FPGA

------------------------------------------------------------------------

# Baud Rate Generator

The UART communication speed is controlled using a baud-rate generator.

-   Parameterizable baud rate (Current: 9600)
-   Shared by TX and RX
-   Easily configurable for different FPGA frequencies

------------------------------------------------------------------------

# EDA Tools and Hardware

#### Software : [AMD Vivado 2025.1](https://www.amd.com/en/support/downloads/adaptive-socs-and-fpgas/development-tools/2025-1.html) , [pySerial](https://pypi.org/project/pyserial/)
#### Hardware : AMD Spartan-7 FPGA [(Boolean Board)](https://www.realdigital.org/doc/02013cd17602c8af749f00561f88ae21)

------------------------------------------------------------------------

# FPGA to FPGA Communication

``` text
| FPGA-1  |           | FPGA-2  |
| UART TX |  ------>  | UART RX |
| UART RX |  <------  | UART TX |
| GND     |  <----->  | GND     |
```

## Operation

-   Data is loaded into the transmitter.
-   UART TX serializes the 8-bit data.
-   Data is transmitted bit-by-bit.
-   UART RX reconstructs the byte.
-   Received data is displayed on LEDs

> [!NOTE]
> Both FPGAs have same RTL but different constraints in this project.


## Simulation [[Testbench]](https://github.com/MOHAMMEDRIYAJ/UART-Communication-on-FPGA/blob/main/FPGA_to_FPGA/FPGA_1/tb.v)

<img src="https://github.com/MOHAMMEDRIYAJ/UART-Communication-on-FPGA/blob/main/FPGA_to_FPGA/FPGA_1/Waveform.png" width="80%">

## Schematic

<img src="https://github.com/MOHAMMEDRIYAJ/UART-Communication-on-FPGA/blob/main/FPGA_to_FPGA/FPGA_1/Schematic.png" width="80%">

## Timing Summary

<img src="https://github.com/MOHAMMEDRIYAJ/UART-Communication-on-FPGA/blob/main/FPGA_to_FPGA/FPGA_1/Timing_Summary.png" width="80%">

------------------------------------------------------------------------

# Python to FPGA Communication

``` text
Python Application ---> PySerial ---> USB-UART ---> FPGA UART Receiver
```

## Operation

-   Accepts 8-bit binary input in terminal or console
-   Validates binary format
-   Converts binary to decimal
-   Sends byte over serial port
-   Displays transmitted value in FPGA

## Simulation [[Testbench]](https://github.com/MOHAMMEDRIYAJ/UART-Communication-on-FPGA/blob/main/Python_to_FPGA/tb.v)

<img src="https://github.com/MOHAMMEDRIYAJ/UART-Communication-on-FPGA/blob/main/Python_to_FPGA/Waveform.png" width="80%">

> [!NOTE]
> Brown coloured signals are Parameter.

## Schematic

<img src="https://github.com/MOHAMMEDRIYAJ/UART-Communication-on-FPGA/blob/main/Python_to_FPGA/Schematic.png" width="80%">

## Timing Summary

<img src="https://github.com/MOHAMMEDRIYAJ/UART-Communication-on-FPGA/blob/main/Python_to_FPGA/Timing%20Summary.png" width="80%">
 
------------------------------------------------------------------------

# FPGA Demonstration

## FPGA to FPGA

<img src="https://github.com/MOHAMMEDRIYAJ/UART-Communication-on-FPGA/blob/main/Python_to_FPGA/Timing%20Summary.png" width="80%">

### 🔹 [Demonstration Video Link]()

## Python to FPGA

<img src="https://github.com/MOHAMMEDRIYAJ/UART-Communication-on-FPGA/blob/main/Python_to_FPGA/Timing%20Summary.png" width="80%">

### 🔹 [Demonstration Video Link]()

------------------------------------------------------------------------

# References

-   [UART Communication Protocol](https://www.analog.com/en/resources/analog-dialogue/articles/uart-a-hardware-communication-protocol.html)
-   [pySerial Documentation](https://pyserial.readthedocs.io/en/latest/pyserial.html)
