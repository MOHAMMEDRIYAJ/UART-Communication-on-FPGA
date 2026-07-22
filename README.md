# 📌 Project Overview

This project demonstrates the implementation of the **Universal Asynchronous Receiver Transmitter (UART)** protocol using **Verilog HDL** on FPGA. The repository contains two independent UART communication applications designed to demonstrate both hardware-to-hardware and software-to-hardware serial communication.

The first application establishes bidirectional communication between two FPGA boards using custom UART Transmitter and Receiver modules. The second application demonstrates communication between a computer and an FPGA using **Python** and the **PySerial** library, enabling users to transmit binary data directly from software to FPGA hardware.

This project provides a practical understanding of UART protocol implementation, baud-rate generation, serial data framing, FPGA verification, and software-to-hardware interfacing.

---

# Project Intent

The objective of this project is to design and implement a complete UART communication system entirely in **Verilog HDL** and validate its functionality on FPGA hardware.

The project focuses on understanding the complete UART communication flow—from serial transmission and reception to practical FPGA implementation and software interfacing.

The project aims to:

- Design a synthesizable UART Transmitter.
- Design a synthesizable UART Receiver.
- Implement a parameterizable baud-rate generator.
- Verify UART functionality through simulation.
- Establish communication between two FPGA boards.
- Interface a PC with an FPGA using Python and PySerial.
- Understand asynchronous serial communication.
- Develop reusable UART modules for future FPGA projects.

---

# UART Protocol

UART (**Universal Asynchronous Receiver Transmitter**) is one of the most widely used asynchronous serial communication protocols.

Unlike SPI or I²C, UART does **not** require a shared clock signal between communicating devices. Instead, both the transmitter and receiver operate independently using the same configured baud rate.

UART communication requires only two signal lines:

- **TX (Transmit)**
- **RX (Receive)**

For reliable communication, both devices must be configured with identical:

- Baud Rate
- Data Bits
- Parity Configuration
- Stop Bits

> **Note**
>
> Both communicating devices must share a common ground.

---

# UART Frame Format

The UART implementation in this project follows the standard **8-N-1** configuration.

| Start Bit | Data Bits | Parity | Stop Bit |
|-----------|-----------|---------|----------|
| 1 | 8 | None | 1 |

### In this Project

Each UART frame consists of:

- 1 Start Bit
- 8 Data Bits (LSB First)
- No Parity Bit
- 1 Stop Bit

---

# Features

## FPGA to FPGA

- Fully synthesizable UART Transmitter
- Fully synthesizable UART Receiver
- Bidirectional communication between two FPGA boards
- Parameterizable baud-rate generator
- FPGA implementation and validation
- Verilog simulation support
- Modular and reusable RTL design

## Python to FPGA

- Sends binary data directly from a computer
- Uses Python and PySerial
- Binary input validation
- Automatic binary-to-byte conversion
- Compatible with standard USB-UART bridges
- Displays received data on FPGA LEDs
- Simple terminal-based interface

---

# Baud Rate Generator

UART timing is generated using a dedicated baud-rate generator shared by both the transmitter and receiver.

The generator divides the FPGA system clock to generate timing pulses corresponding to the selected baud rate.

Features include:

- Parameterizable system clock frequency
- Configurable baud rate
- Shared timing source for TX and RX
- Easily portable across FPGA platforms

Current configuration:

- **System Clock:** 100 MHz
- **Baud Rate:** 9600 bps

---

# EDA Tools and Hardware

### Software

- AMD Vivado 2025.1
- Python 3
- PySerial

### Hardware

- AMD Spartan-7 FPGA (Boolean Board)
- USB-UART Bridge
- Micro-USB Cable
- Personal Computer

---

# FPGA to FPGA Communication

This application demonstrates bidirectional UART communication between two FPGA boards.

Each FPGA contains:

- UART Transmitter
- UART Receiver

The transmitter of one FPGA is connected to the receiver of the other FPGA while both boards share a common ground.

## Operation

1. Load 8-bit parallel data into the UART transmitter.
2. UART TX serializes the byte.
3. Serial data is transmitted over the TX line.
4. UART RX samples the incoming bits.
5. The received byte is reconstructed.
6. The received data is displayed on the FPGA LEDs.

> **Note**
>
> Both FPGA boards use the same RTL implementation. Only the FPGA pin constraints differ.

---

## Simulation

The provided testbench verifies:

- UART transmission
- UART reception
- Start-bit detection
- Byte reconstruction
- Receiver completion signal

---

## Schematic

The synthesized RTL schematic illustrates the hardware implementation of the UART transmitter, UART receiver, baud-rate generator, counters, shift registers, and control logic.

---

## Timing Summary

Timing analysis confirms that the synthesized design satisfies the required setup and hold timing constraints for the target FPGA device.

---

# Python to FPGA Communication

This application demonstrates software-to-hardware communication using Python and the PySerial library.

The Python application accepts an 8-bit binary value from the user, validates the input, converts it into a byte, and transmits it through a USB-UART bridge to the FPGA UART Receiver.

## Operation

1. User enters an 8-bit binary value.
2. Input is validated.
3. Binary value is converted into a byte.
4. PySerial sends the byte through the selected COM port.
5. The USB-UART bridge converts USB packets into UART signals.
6. The FPGA UART Receiver reconstructs the received byte.
7. The received value is displayed on the FPGA LEDs.

---

## Simulation

The Verilog testbench verifies:

- UART reception
- Start-bit detection
- Data reconstruction
- Receiver completion signal
- Parallel output generation

---

## Schematic

The synthesized hardware schematic illustrates the UART Receiver architecture used for software-to-hardware communication.

---

## Timing Summary

Timing analysis verifies that the UART Receiver meets all timing constraints after synthesis and implementation.

---

# FPGA Demonstration

## FPGA to FPGA

This demonstration validates successful bidirectional communication between two FPGA boards using the custom UART transmitter and receiver modules.

Each transmitted byte is correctly reconstructed by the receiving FPGA and displayed on its LEDs.

---

## Python to FPGA

This demonstration validates communication between a computer and an FPGA using a USB-UART interface.

Binary values entered from the Python application are transmitted over the serial port, received by the FPGA UART Receiver, and displayed on the FPGA LEDs in real time.

---

# References

- UART Communication Protocol
- PySerial Documentation
- AMD Vivado Design Suite Documentation
- AMD Spartan-7 FPGA Documentation