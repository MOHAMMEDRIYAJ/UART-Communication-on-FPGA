# Run this script from the terminal to send UART data.
import serial

# Change the COM port and baud rate according to your PC and FPGA receiver. 
ser = serial.Serial("COM5", 9600)

print("UART Binary Sender")
print("Type 'exit' to quit.\n")

# Continuously request 8-bit binary input until the user enters "exit".
while True:
    data = input("Enter 8-bit binary: ").strip()

    if data.lower() == "exit":
        print("Exiting...")
        break

    # Validate input
    if len(data) != 8 or any(bit not in "01" for bit in data):
        print("❌ Invalid input! Please enter exactly 8 binary bits.\n")
        continue

    value = int(data, 2)
    ser.write(bytes([value]))

    print(f"✅ Sent: {data} (Decimal: {value}, Hex: 0x{value:02X})\n")

# Close the serial port before exiting.
ser.close()
print("Serial port closed.")
