#include <SoftwareSerial.h> // 소프트웨어 시리얼
SoftwareSerial mySerial(4, 5); // RX, TX
int speedPinA= 3;
int speedPinB= 9;
int dir1PinA = 6;
int dir2PinA = 7;
int dir1PinB = 10;
int dir2PinB = 11;
//int speed_value_motorA = 0;
//int speed_value_motorB = 0;
byte some;
byte vl;
byte vr;
//byte degree2;
void setup() {
 mySerial.begin(9600);
// set digital i/o pins as outputs:
pinMode(speedPinA, OUTPUT);
pinMode(speedPinB, OUTPUT);
pinMode(dir1PinA, OUTPUT);
pinMode(dir2PinA, OUTPUT);
pinMode(dir1PinB, OUTPUT);
pinMode(dir2PinB, OUTPUT);
//Initial status
//
//digitalWrite(dir1PinA, LOW);
//digitalWrite(dir2PinA, LOW);
//digitalWrite(dir1PinB, LOW);
//digitalWrite(dir2PinB, LOW);
}
void loop() {  
if(mySerial.available() > 2){   
   some = mySerial.read();
   vl = mySerial.read();
   vr = mySerial.read();
   //degree2 = mySerial.read();
   //speed_value_motorB = mySerial.read();
   
   //analogWrite(speedPinB, speed_value_motorA);
   if(some == 'R'){
   analogWrite(speedPinA, vl);
   analogWrite(speedPinB, vr);
   analogWrite(dir1PinA, 0);
   analogWrite(dir2PinA, vl);  
   analogWrite(dir1PinB, vr);
   analogWrite(dir2PinB, 0);  
   }
   else if(some == 'V'){
   analogWrite(speedPinA, vl);
   analogWrite(speedPinB, vr);
   analogWrite(dir1PinA, vl);
   analogWrite(dir2PinA, 0);  
   analogWrite(dir1PinB, vr);
   analogWrite(dir2PinB, 0);  
   }
 }
} 

