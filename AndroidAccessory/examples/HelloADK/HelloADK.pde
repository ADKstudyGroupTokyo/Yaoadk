/*
 * HelloADK ADK sample sketch
 * Copyright (C) 2012 Yuuichi Akagawa
 *
 * Original copyright
 *  Copyright (C) 2011 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
#include <Usb.h>
#include <AndroidAccessory.h>

#define  LED1          3
#define  BUTTON1       4

AndroidAccessory acc("ammlab.org",
		     "HelloADK",
		     "DemoKit Arduino Board",
		     "1.0",
		     "https://play.google.com/store/apps/details?id=org.ammlab.android.helloadk",
		     "0000000012345678");
void setup();
void loop();

void setup()
{
  Serial.begin(115200);
  Serial.print("\r\nStart");
  pinMode(LED1, OUTPUT);
  pinMode(BUTTON1, INPUT);

  acc.powerOn();
}

void loop()
{
  byte msg[2];
  int val = 0;

  if (acc.isConnected()) {
    int len = acc.read(msg, sizeof(msg), 1);
    if (len > 0) {
      // assumes only one command per packet
      if (msg[0] == 0x1) {
        if( msg[1] == 0x01){
          digitalWrite(LED1, HIGH);
        } else  {
          digitalWrite(LED1, LOW);
        }
      }
      if(msg[0] == 0x02) {
        if( msg[1] != 0){
          digitalWrite(LED1, 0);
          analogWrite(LED1, msg[1]);
        }
      }
    }
    val = digitalRead(BUTTON1);
    msg[0] = 0x1;
    if( val == 0 ){
      msg[1] = 0x1;
    }else{
      msg[1] = 0x0;
    }
    acc.write(msg, 2);
  } else {
    // reset outputs to default values on disconnect
    analogWrite(LED1, LOW);
  }
  delay(10);
}

