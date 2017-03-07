#include <L9110S.h>
#include <Wire.h>
#include "pitches.h"
#include "RTClib.h"

DateTime Now;
DateTime Previous;
L9110S motor(6, 5, 13, 13);
RTC_DS1307 rtc;

void setup()
{
  Serial.begin(57600);
  if (!rtc.begin())
  {
    Serial.println("Couldn't find RTC");
    while (1);
  }

  if (! rtc.isrunning())
  {
    Serial.println("RTC is NOT running!");
    // following line sets the RTC to the date & time this sketch was compiled
    rtc.adjust(DateTime(F(__DATE__), F(__TIME__)));
    // This line sets the RTC with an explicit date & time, for example to set
    // January 21, 2014 at 3am you would call:
    // rtc.adjust(DateTime(2014, 1, 21, 3, 0, 0));
  }
}

void loop()
{
  motor.backward(0);

  Previous = Now;
  Now = rtc.now();

  if (Now.hour() != Previous.hour())
  {
    uint8_t hour;
    hour = Now.hour() % 12;

    if (hour == 0)
    {
      hour = 12;
    }

    for (uint8_t i = 0; i < hour; i++)
    {
      triggerCuckoo();
    }

    motor.backward(0);

    for (uint8_t i = 0; i < 255; i++)
    {
      motor.update();
    }
  }

  Serial.print(Now.year(), DEC);
  Serial.print('/');
  Serial.print(Now.month(), DEC);
  Serial.print('/');
  Serial.print(Now.day(), DEC);
  Serial.print(" ");
  Serial.print(Now.hour(), DEC);
  Serial.print(':');
  Serial.print(Now.minute(), DEC);
  Serial.print(':');
  Serial.print(Now.second(), DEC);
  Serial.println();

  delay(1000);
}

void triggerCuckoo()
{
  tone(11, NOTE_E4, 500);
  motor.backward(255);
  for (uint8_t i = 0; i <= 150; i++)
  {
    motor.update();

    delayMicroseconds(1961);
  }

  delay(400);
  noTone(11);

  motor.forward(255);
  for (uint8_t i = 0; i <= 150; i++)
  {
    motor.update();

    delayMicroseconds(1961);
  }

  delay(400);
}

