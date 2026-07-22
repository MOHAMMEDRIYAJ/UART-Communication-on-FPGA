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

```{=html}
<p align="center">
```
`<img src="Images/UART_Architecture.png" width="80%">`{=html}
```{=html}
</p>
```

------------------------------------------------------------------------

# 📑 Table of Contents

1.  Project Intent
2.  UART Protocol
3.  Repository Contents
4.  Features
5.  UART Frame Format
6.  FPGA to FPGA Communication
7.  Python to FPGA Communication
8.  Design Hierarchy
9.  Baud Rate Generator
10. Python Sender Application
11. EDA Tools and Hardware
12. File Structure
13. Simulation
14. FPGA Demonstration
15. Future Improvements
16. References

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
-   GND

Both devices must be configured with the same

-   Baud Rate
-   Number of Data Bits
-   Parity
-   Stop Bits

------------------------------------------------------------------------

# Repository Contents

``` text
UART Communication
│
├── FPGA_to_FPGA
│     ├── uart_tx.v
│     ├── uart_rx.v
│     ├── baud_generator.v
│     ├── top.v
│     └── testbench.v
│
├── Python_to_FPGA
│     ├── uart_tx.v
│     ├── uart_rx.v
│     ├── top.v
│     ├── sender.py
│     └── testbench.v
│
├── Constraints
├── Images
└── README.md
```

------------------------------------------------------------------------

# Features

## FPGA to FPGA

-   Complete UART Transmitter
-   Complete UART Receiver
-   Fully synthesizable RTL
-   Configurable baud rate
-   8-bit data transmission
-   Start and Stop bit detection
-   FPGA hardware verified
-   Simulation verified

## Python to FPGA

-   PySerial based UART communication
-   Manual binary input
-   Real-time transmission
-   FPGA receives serial data
-   Terminal-based interface
-   Easy debugging

------------------------------------------------------------------------

# UART Frame Format

The implemented UART frame follows the standard **8-N-1** configuration.

  Field       Bits
  ----------- ------
  Start Bit   1
  Data Bits   8
  Parity      None
  Stop Bit    1

``` text
Idle → Start → D0 D1 D2 D3 D4 D5 D6 D7 → Stop
  1       0        8 Data Bits             1
```

------------------------------------------------------------------------

# FPGA to FPGA Communication

``` text
FPGA-1
UART TX
   │
   ▼
UART RX
FPGA-2
```

### Operation

-   Data is loaded into the transmitter.
-   UART TX serializes the 8-bit data.
-   Data is transmitted bit-by-bit.
-   UART RX reconstructs the byte.
-   Received data is displayed on LEDs or Seven Segment Display.

------------------------------------------------------------------------

# Python to FPGA Communication

``` text
Python Application
        │
     PySerial
        │
    USB-UART
        │
        ▼
FPGA UART Receiver
```

> Note : Users can manually enter binary data through the terminal.

Example

``` text
Enter 8-bit binary:

10101010

↓

UART Transmission

↓

FPGA Receives

↓

LED Output = 10101010
```

------------------------------------------------------------------------

# Python Sender Application

The Python application is developed using the **PySerial** library.

Features

-   Accepts 8-bit binary input
-   Validates binary format
-   Converts binary to decimal
-   Sends byte over serial port
-   Displays transmitted value

Example

``` text
UART Binary Sender

Enter 8-bit binary

11001010

Sent

Binary : 11001010
Decimal : 202
Hex : 0xCA
```

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

# File Structure

``` text
Sources/
Simulation/
Constraints/
Python/
Images/
```

------------------------------------------------------------------------

# Simulation

Simulation verifies:

-   Start bit detection
-   Bit timing
-   Serial transmission
-   Receiver sampling
-   Stop bit validation
-   Complete byte reception

> Add waveform screenshots here.

------------------------------------------------------------------------

# FPGA Demonstration

## FPGA to FPGA

-   Add hardware photographs
-   Add demonstration GIF

## Python to FPGA

-   Add terminal screenshot
-   Add FPGA output image

------------------------------------------------------------------------

# References

-   [UART Communication Protocol](https://www.analog.com/en/resources/analog-dialogue/articles/uart-a-hardware-communication-protocol.html)
-   [pySerial Documentation](https://pyserial.readthedocs.io/en/latest/pyserial.html)
