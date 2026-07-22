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
<img src="Images/UART_Architecture.png" width="80%">
</p>

------------------------------------------------------------------------

# 📑 Table of Contents

1.  [Project Intent]()
2.  [UART Protocol]()
3.  [UART Frame Format]()
4.  [Features]()
5.  [Baud Rate Generator]()
6.  [EDA Tools and Hardware]()
5.  [FPGA to FPGA Communication]()
6.  [Python to FPGA Communication]()
7.  [Simulation]()
8.  [FPGA Demonstration]()
9.  [References]()
10. [Conclusion]()

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

Frame

| Start | Data | Parity | Stop |

> [!NOTE]
> Both FPGAs must share commom ground.

------------------------------------------------------------------------

# UART Frame Format

The implemented UART frame follows the standard **8-N-1** configuration.

  Field       Bits
  ----------- ------
  Start Bit   1
  Data Bits   8
  Parity      None
  Stop Bit    1

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

-   Parameterizable baud rate
-   Shared by TX and RX
-   Easily configurable for different FPGA frequencies

------------------------------------------------------------------------

# EDA Tools and Hardware

## Software

-   AMD Vivado 2025.1
-   PySerial

## Hardware

-   Spartan-7 FPGA
-   Boolean Board

------------------------------------------------------------------------

# FPGA to FPGA Communication

``` text
| FPGA-1  |   <------>   | FPGA-2  |
| UART TX |              | UART TX |
| UART RX |              | UART RX |
```

### Operation

-   Data is loaded into the transmitter.
-   UART TX serializes the 8-bit data.
-   Data is transmitted bit-by-bit.
-   UART RX reconstructs the byte.
-   Received data is displayed on LEDs 

------------------------------------------------------------------------

# Python to FPGA Communication

``` text
Python Application ---> PySerial ---> USB-UART ---> FPGA UART Receiver
```

### Operation

-   Accepts 8-bit binary input in terminal or console
-   Validates binary format
-   Converts binary to decimal
-   Sends byte over serial port
-   Displays transmitted value in FPGA

------------------------------------------------------------------------

# Simulation

## FPGA to FPGA

## Python to FPGA
 
------------------------------------------------------------------------

# FPGA Demonstration

## FPGA to FPGA

## Python to FPGA

------------------------------------------------------------------------

# References

-   [UART Communication Protocol](https://www.analog.com/en/resources/analog-dialogue/articles/uart-a-hardware-communication-protocol.html)
-   [pySerial Documentation](https://pyserial.readthedocs.io/en/latest/pyserial.html)
