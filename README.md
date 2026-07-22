# UART Communication using Verilog HDL

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
![Verilog](https://img.shields.io/badge/Language-Verilog%20HDL-blue)
![Python](https://img.shields.io/badge/Language-Python-3776AB?logo=python&logoColor=white)
![FPGA](https://img.shields.io/badge/FPGA-Xilinx%20Spartan--7-orange)
![Board](https://img.shields.io/badge/Board-Boolean%20Board-9cf)
![Protocol](https://img.shields.io/badge/Protocol-UART-purple)
![Frame](https://img.shields.io/badge/Frame-8--N--1-informational)
![Baud Rate](https://img.shields.io/badge/Baud%20Rate-9600-brightgreen)
![Vivado](https://img.shields.io/badge/Toolchain-Vivado%202025.1-red)
![PySerial](https://img.shields.io/badge/Library-PySerial-005571)
![RTL](https://img.shields.io/badge/Design-RTL-lightgrey)
![Simulation](https://img.shields.io/badge/Verified-Testbench-success)
![Status](https://img.shields.io/badge/Status-Active%20Development-brightgreen)
![Platform](https://img.shields.io/badge/Platform-FPGA%20to%20FPGA%20%7C%20PC%20to%20FPGA-blueviolet)
![Contributions](https://img.shields.io/badge/Contributions-Welcome-ff69b4)
![Last Commit](https://img.shields.io/github/last-commit/MOHAMMEDRIYAJ/UART-Communication-on-FPGA)
![Repo Size](https://img.shields.io/github/repo-size/MOHAMMEDRIYAJ/UART-Communication-on-FPGA)
![Stars](https://img.shields.io/github/stars/MOHAMMEDRIYAJ/UART-Communication-on-FPGA?style=social)

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
7.  [FPGA to FPGA Communication](#fpga-to-fpga-communication)
8.  [Python to FPGA Communication](#python-to-fpga-communication)
9.  [FPGA Demonstration](#fpga-demonstration)
10. [References](#references)

------------------------------------------------------------------------

# Project Intent

The objective of this project is to understand and implement
asynchronous serial communication completely in hardware using Verilog
HDL, while also demonstrating hardware-software communication through
Python.

The project aims to

-   Design a synthesizable UART Transmitter
-   Design a synthesizable UART Receiver
-   Verify UART communication through simulation
-   Interface two FPGA boards
-   Interface a PC with an FPGA using PySerial
-   Understand asynchronous communication and baud rate generation
-   Build a reusable UART module for future FPGA projects

------------------------------------------------------------------------

# UART Protocol

UART (Universal Asynchronous Receiver Transmitter) is one of the most
widely used serial communication protocols.

Unlike SPI or I²C, UART does not require a clock signal between the
transmitter and receiver. Both devices communicate only using

-   TX
-   RX

Both devices must be configured with the same

-   Baud Rate
-   Number of Data Bits
-   Parity
-   Stop Bits

> [!NOTE]
> Both communicating devices must share a common ground.

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

-   Fully synthesizable UART Transmitter and Receiver written from
    scratch in Verilog, with no vendor IP dependency
-   Shared `baud_gen` module generates independent transmit and
    oversampling enable ticks (`tx_en`, `rx_en`) from a single system
    clock
-   4-state Transmitter FSM (`idle → start → send → stop`) that shifts
    out the 8-bit data frame LSB-first once `wr_en` is asserted
-   3-state Receiver FSM (`idle → receive → stop`) with 16x
    oversampling and mid-bit sampling for reliable data recovery
-   Double flip-flop synchronizer (`rx1`, `rx2`) on the incoming RX line
    to guard against metastability
-   Identical RTL deployed on both FPGA boards, differentiated only by
    board-specific pin constraints (XDC)
-   Received byte exposed on `prl_data` with a `rx_done` strobe,
    displayed directly on onboard LEDs
-   Verified end-to-end with a self-checking testbench that drives the
    RX line bit by bit at the correct baud tick and confirms
    `rx_done`/`prl_data` against the transmitted reference byte

## Python to FPGA

-   Lightweight `pySerial`-based terminal application (`send.py`) for
    manually issuing UART frames to the FPGA
-   Continuous input loop that accepts an 8-bit binary string from the
    console and exits cleanly when the user types `exit`
-   Input validation that rejects any string that is not exactly 8
    characters of `0`/`1` before transmission
-   Automatic binary-to-decimal conversion (`int(data, 2)`), with the
    sent value echoed back to the user in binary, decimal, and hex
-   FPGA-side design reuses the same `uart_rx` core and `baud_gen`
    timing block as the FPGA-to-FPGA application, so only a receiver
    (no transmitter) is instantiated in `uart_top`
-   Received byte is immediately available on `prl_data` and latched
    with a `rx_done` pulse, driven out to the onboard LEDs
-   Testbench reuses the same `Send_byte` task pattern to shift in
    known reference bytes over `rx_channel` and confirm correct
    reception before hardware bring-up

------------------------------------------------------------------------

# Baud Rate Generator

The UART communication speed is controlled using a baud-rate generator.

-   Parameterizable baud rate (Current: 9600)
-   Shared by TX and RX
-   Easily configurable for different FPGA frequencies

------------------------------------------------------------------------

# EDA Tools and Hardware

#### Software: [AMD Vivado 2025.1](https://www.amd.com/en/support/downloads/adaptive-socs-and-fpgas/development-tools/2025-1.html), [pySerial](https://pypi.org/project/pyserial/)
#### Hardware: AMD Spartan-7 FPGA [(Boolean Board)](https://www.realdigital.org/doc/02013cd17602c8af749f00561f88ae21)

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
-   Data is transmitted bit by bit.
-   UART RX reconstructs the byte.
-   Received data is displayed on LEDs.

> [!NOTE]
> Both FPGAs use the same RTL but different constraints in this project.

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

-   Accepts 8-bit binary input in the terminal or console.
-   Validates the binary format.
-   Converts binary to decimal.
-   Sends the byte over the serial port.
-   Displays the transmitted value on the FPGA.

## Simulation [[Testbench]](https://github.com/MOHAMMEDRIYAJ/UART-Communication-on-FPGA/blob/main/Python_to_FPGA/tb.v)

<img src="https://github.com/MOHAMMEDRIYAJ/UART-Communication-on-FPGA/blob/main/Python_to_FPGA/Waveform.png" width="80%">

> [!NOTE]
> Brown-coloured signals represent parameters.

## Schematic

<img src="https://github.com/MOHAMMEDRIYAJ/UART-Communication-on-FPGA/blob/main/Python_to_FPGA/Schematic.png" width="80%">

## Timing Summary

<img src="https://github.com/MOHAMMEDRIYAJ/UART-Communication-on-FPGA/blob/main/Python_to_FPGA/Timing%20Summary.png" width="80%">

------------------------------------------------------------------------

# FPGA Demonstration

## FPGA to FPGA

<img src="https://github.com/MOHAMMEDRIYAJ/UART-Communication-on-FPGA/blob/main/FPGA_to_FPGA/FPGA_1/Block_Diagram.png" width="80%">

### 🔹 [Demonstration Video Link]()

## Python to FPGA

<img src="https://github.com/MOHAMMEDRIYAJ/UART-Communication-on-FPGA/blob/main/Python_to_FPGA/Block_Diagram.png" width="80%">

### 🔹 [Demonstration Video Link]()

------------------------------------------------------------------------

# References

-   [UART Communication Protocol](https://www.analog.com/en/resources/analog-dialogue/articles/uart-a-hardware-communication-protocol.html)
-   [pySerial Documentation](https://pyserial.readthedocs.io/en/latest/pyserial.html)
