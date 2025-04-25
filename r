//blink
Connections:
• Connect the positive leg (longer) of the LED to GPIO 17 (pin 11).
• Connect the negative leg (shorter) of the LED to a 330Ω resistor, then to GND.
Program:
import RPi.GPIO as GPIO
import time
# Pin Configuration
LED_PIN = 17 # GPIO17 (Pin 11)
# Setup
GPIO.setmode(GPIO.BCM) # Use Broadcom pin numbering
GPIO.setup(LED_PIN, GPIO.OUT)
try:
while True:
GPIO.output(LED_PIN, GPIO.HIGH) # Turn ON LED
time.sleep(1) # Wait 1 second
GPIO.output(LED_PIN, GPIO.LOW) # Turn OFF LED
time.sleep(1) # Wait 1 second
except KeyboardInterrupt:
GPIO.cleanup() # Cleanup GPIO on Ctrl+C exit

#obstacle detection
Connections:
IR Sensor Pin Connect to Raspberry Pi
VCC 5V
GND GND
OUT GPIO 18 (Pin 12)
Program:
import RPi.GPIO as GPIO
import time
# Pin Configuration
IR_SENSOR_PIN = 18 # GPIO pin where IR sensor is connected
# Setup
GPIO.setmode(GPIO.BCM) # Use Broadcom pin numbering
GPIO.setup(IR_SENSOR_PIN, GPIO.IN) # Set IR sensor pin as input
try:
while True:
if GPIO.input(IR_SENSOR_PIN) == 0: # If sensor detects an obstacle
print("Obstacle Detected!")
else:
print("No Obstacle")
time.sleep(0.5) # Small delay for stability
except KeyboardInterrupt:
GPIO.cleanup() # Cleanup GPIO on Ctrl+C exi

#communication
Connect Arduino to Raspberry Pi
• Plug your Arduino into the Raspberry Pi using a USB cable.
• The Raspberry Pi should detect it as a serial device (/dev/ttyUSB0 or /dev/ttyACM0).
Upload Code to Arduino
Open Arduino IDE on your PC.
Copy and paste this code:
void setup() {
Serial.begin(9600); // Set baud rate
}
void loop() {
Serial.println("Hello from Arduino!"); // Send message every second
delay(1000);
}
Select the correct port (Tools > Port).
Upload the code (Sketch > Upload).
Open Thonny on Raspberry Pi
1. Click the Raspberry Pi menu
2. Go to Programming > Thonny Python IDE
3. Make sure Python 3 is selected as the interpreter
Find Arduino Serial Port
Open Thonny's Shell
Run this command to find the correct port:
import serial.tools.list_ports
ports = serial.tools.list_ports.comports()
for port in ports:
print(port.device, port.description)
You should see something like:
/dev/ttyUSB0 Arduino Uno
or
/dev/ttyACM0 Arduino Uno
Or
/dev/ttyACM0 ttyACM0
(based on the USB port it may ACM1 also)
Write and Run Python Code in Thonny
In Thonny, click File > New
Copy and paste this Python code:
import serial
import time
# Replace '/dev/ttyUSB0' with your actual port
ser = serial.Serial('/dev/ttyUSB0', 9600, timeout=1)
time.sleep(2) # Give some time for the connection to establish
while True:
data = ser.readline().decode('utf-8').strip() # Read and decode data
if data:
print("Received from Arduino:", data)
1. Save the file (File > Save As) → Name it serial_read.py
2. Click Run
