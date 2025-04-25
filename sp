//blynk

#define BLYNK_PRINT Serial
/* Fill in information from Blynk Device Info here */
#define BLYNK_TEMPLATE_ID "TMPL3-1h2bOTe"
#define BLYNK_TEMPLATE_NAME "mech demo 1"
#define BLYNK_AUTH_TOKEN "hVbDSFSCLCZPqGERPFAnxGYGvrgDJPiC"
#include <WiFi.h>
#include <WiFiClient.h>
#include <BlynkSimpleEsp32.h>
// Your WiFi credentials.
// Set password to "" for open networks.

char ssid[] = "Jessie";
char pass[] = "";
const int ledPin = 2; // LED pin for ESP32
// Function to handle button pressz
BLYNK_WRITE(V0) { // V0 is the virtual pin for the button
int pinValue = param.asInt(); // Get the state of the button
digitalWrite(ledPin, pinValue); // Set LED state
}
void setup()
{ Serial.begin(9600);
pinMode(ledPin,OUTPUT);
Blynk.begin(BLYNK_AUTH_TOKEN, ssid, pass);
}
void loop()
{
Blynk.run();
}





#thingspeak
First we need to create an account on Thingspeak. Follow the below given steps-
• Open the Thingspeak website then click on “sign in” in top right corner.
• Click on “create one”.
• Fill all the credentials and click on “continue”. Then you will get a verification link on your
registered email ID . Click on that link. Set your password and your account will be
created. Then you just login to Thingspeak.

After you logged in you will see this page. Click on “new channel”
• Give your channel a name, description, and Field1 name. As we are using only one field
for temperature.
• New channel is now created. You will also see a blank chart displayed in private view.
Click on API keys.
• Under API requests copy this URL. Through this URL we publish data to the channel
field.
• Paste this URL in the address bar and assign the field parameter, any number or you
can keep it zero. Then hit “enter”.

#include <WiFi.h>
#include <ThingSpeak.h>
WiFiClient client;
const char* ssid="Jessie";
const char* pass="";
const char* api="20EKDNYMTXU21I4J";
unsigned int cid=2707772;
#define PIR 12
#define LED 2 void
setup(){ pinMode(PIR,
INPUT);
pinMode(LED, OUTPUT);
digitalWrite(LED,LOW);
Serial.begin(9600);
Serial.println("Wifi Connection");
WiFi.begin(ssid,pass);
while(WiFi.status()!=WL_CONNECTED){
delay(500);
Serial.print("...");
}
Serial.println("Connected");
Serial.println(WiFi.localIP());
ThingSpeak.begin(client);
}
int f,status;
void loop(){
f=digitalRead(PIR);
Serial.println(f);
if(f == 1){
digitalWrite(LED, HIGH);
delay(2000);
} else{
digitalWrite(LED,LOW);
delay(2000);
} ThingSpeak.setField(2,f);
status=ThingSpeak.writeFields(cid,api);
if(status==200){
Serial.println("Uploaded");
}
else{
Serial.println("Not Uploaded");
}
delay(7000); // thi
}

