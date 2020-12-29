#include <Arduino.h>

//The following line is not needed
//platformio automatically knows this
//LED_BUILTIN = 13;
void setup() {
pinMode(LED_BUILTIN,OUTPUT);

}

void loop() {
digitalWrite(LED_BUILTIN,LOW);
delay(500);
digitalWrite(LED_BUILTIN,HIGH);
delay(500);

}
