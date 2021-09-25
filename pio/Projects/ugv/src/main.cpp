#include <Arduino.h>

#include <WiFi.h>
#include <esp32PWMUtilities.h>

#include <DabbleESP32.h>
Motor Motor1;

Motor Motor2;
void _setup() {
  Motor1.attach(14, 16, 17);

  Motor2.attach(15, 18, 19);

  Dabble.begin("MyEsp32");
}

void _loop() {
  Dabble.processInput();
}

void setup() {
  _setup();
}

void loop() {
  _loop();
  if (GamePad.isPressed(0)) {
    Motor1.moveMotor(2.55 * 100);
    Motor2.moveMotor(2.55 * 100);
  }
  else {
    if (GamePad.isPressed(1)) {
      Motor1.moveMotor(-2.55 * 100);
      Motor2.moveMotor(-2.55 * 100);
    }
    else {
      if (GamePad.isPressed(3)) {
        Motor1.moveMotor(2.55 * 100);
        Motor2.moveMotor(-2.55 * 100);
      }
      else {
        if (GamePad.isPressed(2)) {
          Motor1.moveMotor(-2.55 * 100);
          Motor2.moveMotor(2.55 * 100);
        }
        else {
          Motor1.lockMotor();
          Motor2.lockMotor();
        }
      }
    }
  }
}
